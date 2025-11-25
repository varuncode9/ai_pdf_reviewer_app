import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';

class AiService {
  static final AiService _instance = AiService._internal();
  factory AiService() => _instance;
  AiService._internal();

  final String _systemPrompt = '''You are an expert document analysis assistant. Provide clear, professional analysis in three sections:
1. SUMMARY: 7-10 sentences covering the main content
2. KEY POINTS: Important bullet points (5-7 items)
3. ACTIONABLE INSIGHTS: Practical recommendations and takeaways''';

  Future<Map<String, dynamic>> analyzePdf(String pdfText) async {
    if (!AppConfig.isApiKeyConfigured) {
      throw Exception('API Key not configured. Please paste your API key in lib/config/config.dart');
    }

    try {
      print('[AI] Starting PDF analysis...');

      final userPrompt = '''$_systemPrompt

Analyze this PDF text and provide a comprehensive review:

$pdfText

Format your response EXACTLY like this:
SUMMARY: [Your 7-10 sentence summary here]

KEY POINTS:
- [Point 1]
- [Point 2]
- [Point 3]
- [Point 4]
- [Point 5]

ACTIONABLE INSIGHTS: [Your recommendations and practical insights here]''';

      final response = await _makeApiRequest(userPrompt);
      print('[AI] Analysis received, parsing response...');

      final parsedResponse = _parseResponse(response);
      print('[AI] Response parsed successfully');

      return parsedResponse;
    } catch (e) {
      print('[AI] Analysis error: $e');
      throw Exception('AI Analysis failed: ${e.toString()}');
    }
  }

  Future<String> askQuestion(String pdfText, String question) async {
    if (!AppConfig.isApiKeyConfigured) {
      throw Exception('API Key not configured. Please paste your API key in lib/config/config.dart');
    }

    try {
      print('[AI] Asking question: $question');

      final prompt = '''Based on this PDF document, answer the user's question concisely and directly.

PDF Content:
$pdfText

User Question: $question

Provide a clear, accurate answer based solely on the document content. If the answer cannot be found in the document, say so clearly.''';

      final response = await _makeApiRequest(prompt);
      print('[AI] Question answered');
      return response;
    } catch (e) {
      print('[AI] Question error: $e');
      throw Exception('${e.toString()}');
    }
  }

  Future<String> _makeApiRequest(String prompt) async {
    try {
      final url = '${AppConfig.geminiApiUrl}?key=${AppConfig.apiKey}';

      final requestBody = {
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.7,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 2048,
        }
      };

      print('[API] Sending request to Gemini API...');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout. Please check your internet connection.');
        },
      );

      print('[API] Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('[API] Response decoded successfully');

        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final content = data['candidates'][0]['content'];
          if (content['parts'] != null && content['parts'].isNotEmpty) {
            final text = content['parts'][0]['text'];
            print('[API] Text extracted: ${text.length} characters');
            return text;
          }
        }
        throw Exception('Invalid response format from API');
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        final errorMsg = errorData['error']?['message'] ?? 'Bad request';
        throw Exception('Invalid API request: $errorMsg');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API Key. Please verify your key is correct.');
      } else if (response.statusCode == 403) {
        throw Exception('API Key does not have permission. Check your Gemini API setup.');
      } else if (response.statusCode == 429) {
        throw Exception('Too many requests. Please wait a moment and try again.');
      } else if (response.statusCode == 500) {
        throw Exception('Gemini API server error. Please try again later.');
      } else {
        final errorBody = response.body;
        print('[API] Error: $errorBody');
        throw Exception('API Error (${response.statusCode}): $errorBody');
      }
    } catch (e) {
      print('[API] Exception: $e');
      if (e.toString().contains('SocketException')) {
        throw Exception('No internet connection. Please check your connection.');
      }
      rethrow;
    }
  }

  Map<String, dynamic> _parseResponse(String response) {
    try {
      String summary = '';
      String keyPoints = '';
      String actionableInsights = '';

      final summaryMatch = RegExp(
        r'SUMMARY:\s*(.*?)(?=KEY POINTS:|ACTIONABLE INSIGHTS:|$)',
        dotAll: true,
      ).firstMatch(response);
      if (summaryMatch != null) {
        summary = summaryMatch.group(1)?.trim() ?? '';
      }

      final keyPointsMatch = RegExp(
        r'KEY POINTS:\s*(.*?)(?=ACTIONABLE INSIGHTS:|$)',
        dotAll: true,
      ).firstMatch(response);
      if (keyPointsMatch != null) {
        keyPoints = keyPointsMatch.group(1)?.trim() ?? '';
      }

      final insightsMatch = RegExp(
        r'ACTIONABLE INSIGHTS:\s*(.*?)$',
        dotAll: true,
      ).firstMatch(response);
      if (insightsMatch != null) {
        actionableInsights = insightsMatch.group(1)?.trim() ?? '';
      }

      if (summary.isEmpty && keyPoints.isEmpty && actionableInsights.isEmpty) {
        summary = response;
      }

      print('[Parse] Summary: ${summary.length} chars, KeyPoints: ${keyPoints.length} chars, Insights: ${actionableInsights.length} chars');

      return {
        'summary': summary,
        'keyPoints': keyPoints,
        'actionableInsights': actionableInsights,
        'fullResponse': response,
      };
    } catch (e) {
      print('[Parse] Parsing error: $e');
      return {
        'summary': response,
        'keyPoints': '',
        'actionableInsights': '',
        'fullResponse': response,
      };
    }
  }
}
