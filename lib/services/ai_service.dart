import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';

class AiService {
  static final AiService _instance = AiService._internal();
  factory AiService() => _instance;
  AiService._internal();

  final String _systemPrompt = '''You are an expert document analysis assistant. Provide:
1. Summary (7-10 sentences)
2. Key points (bullet list)
3. Actionable insights
4. Clear formatting and easy readability.''';

  Future<Map<String, dynamic>> analyzePdf(String pdfText) async {
    if (!AppConfig.isApiKeyConfigured) {
      throw Exception('API Key not configured. Please add your API key in lib/config/config.dart');
    }

    try {
      final userPrompt = '''$_systemPrompt

Analyze this PDF text and provide a comprehensive review:

$pdfText

Please structure your response with the following sections:
1. SUMMARY: A comprehensive 7-10 sentence summary
2. KEY POINTS: Important points in bullet format
3. ACTIONABLE INSIGHTS: Practical takeaways and recommendations''';

      final response = await _makeApiRequest(userPrompt);

      final parsedResponse = _parseResponse(response);

      return parsedResponse;
    } catch (e) {
      throw Exception('AI Analysis failed: ${e.toString()}');
    }
  }

  Future<String> askQuestion(String pdfText, String question) async {
    if (!AppConfig.isApiKeyConfigured) {
      throw Exception('API Key not configured. Please add your API key in lib/config/config.dart');
    }

    try {
      final prompt = '''Based on this PDF content, answer the following question:

PDF Content:
$pdfText

Question: $question

Provide a clear, concise, and helpful answer based on the document content.''';

      final response = await _makeApiRequest(prompt);
      return response;
    } catch (e) {
      throw Exception('Question answering failed: ${e.toString()}');
    }
  }

  Future<String> _makeApiRequest(String prompt) async {
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
        'maxOutputTokens': 2048,
      }
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['candidates'] != null && data['candidates'].isNotEmpty) {
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        return text;
      } else {
        throw Exception('No response from AI');
      }
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception('API Error: ${errorData['error']['message'] ?? 'Unknown error'}');
    }
  }

  Map<String, dynamic> _parseResponse(String response) {
    String summary = '';
    String keyPoints = '';
    String actionableInsights = '';

    final summaryMatch = RegExp(r'SUMMARY:(.*?)(?=KEY POINTS:|$)', dotAll: true).firstMatch(response);
    if (summaryMatch != null) {
      summary = summaryMatch.group(1)!.trim();
    }

    final keyPointsMatch = RegExp(r'KEY POINTS:(.*?)(?=ACTIONABLE INSIGHTS:|$)', dotAll: true).firstMatch(response);
    if (keyPointsMatch != null) {
      keyPoints = keyPointsMatch.group(1)!.trim();
    }

    final insightsMatch = RegExp(r'ACTIONABLE INSIGHTS:(.*?)$', dotAll: true).firstMatch(response);
    if (insightsMatch != null) {
      actionableInsights = insightsMatch.group(1)!.trim();
    }

    if (summary.isEmpty && keyPoints.isEmpty && actionableInsights.isEmpty) {
      summary = response;
    }

    return {
      'summary': summary,
      'keyPoints': keyPoints,
      'actionableInsights': actionableInsights,
      'fullResponse': response,
    };
  }
}
