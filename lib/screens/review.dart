import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../utils/theme.dart';

class ReviewScreen extends StatefulWidget {
  final Map<String, dynamic> analysisResult;
  final String pdfText;

  const ReviewScreen({
    super.key,
    required this.analysisResult,
    required this.pdfText,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _questionController = TextEditingController();
  final AiService _aiService = AiService();
  bool _isAskingQuestion = false;
  String? _questionAnswer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _askQuestion() async {
    if (_questionController.text.trim().isEmpty) return;

    setState(() {
      _isAskingQuestion = true;
      _questionAnswer = null;
    });

    try {
      final answer = await _aiService.askQuestion(
        widget.pdfText,
        _questionController.text.trim(),
      );

      setState(() {
        _questionAnswer = answer;
        _isAskingQuestion = false;
      });
    } catch (e) {
      setState(() {
        _questionAnswer = 'Error: ${e.toString()}';
        _isAskingQuestion = false;
      });
    }
  }

  Widget _buildAnimatedCard(Widget child, int index) {
    final delay = index * 150;
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            delay / 1200,
            (delay + 400) / 1200,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              delay / 1200,
              (delay + 400) / 1200,
              curve: Curves.easeOut,
            ),
          ),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Analysis'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (widget.analysisResult['summary']?.isNotEmpty ?? false)
              _buildAnimatedCard(
                _buildSectionCard(
                  'Summary',
                  widget.analysisResult['summary'],
                  Icons.summarize_rounded,
                  AppTheme.primaryColor,
                ),
                0,
              ),
            const SizedBox(height: 16),
            if (widget.analysisResult['keyPoints']?.isNotEmpty ?? false)
              _buildAnimatedCard(
                _buildSectionCard(
                  'Key Points',
                  widget.analysisResult['keyPoints'],
                  Icons.list_alt_rounded,
                  Colors.orange,
                ),
                1,
              ),
            const SizedBox(height: 16),
            if (widget.analysisResult['actionableInsights']?.isNotEmpty ?? false)
              _buildAnimatedCard(
                _buildSectionCard(
                  'Actionable Insights',
                  widget.analysisResult['actionableInsights'],
                  Icons.lightbulb_outline_rounded,
                  AppTheme.secondaryColor,
                ),
                2,
              ),
            const SizedBox(height: 16),
            if (widget.analysisResult['summary']?.isEmpty ?? true)
              _buildAnimatedCard(
                _buildSectionCard(
                  'Analysis Result',
                  widget.analysisResult['fullResponse'],
                  Icons.analytics_rounded,
                  AppTheme.primaryColor,
                ),
                0,
              ),
            const SizedBox(height: 16),
            _buildAnimatedCard(
              _buildAskQuestionCard(),
              3,
            ),
            if (_questionAnswer != null) ...[
              const SizedBox(height: 16),
              _buildAnswerCard(),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, String content, IconData icon, Color color) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAskQuestionCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.question_answer_rounded, color: Colors.blue, size: 28),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Ask AI Anything',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                hintText: 'Ask a question about this document...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppTheme.backgroundColor,
              ),
              maxLines: 3,
              enabled: !_isAskingQuestion,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isAskingQuestion ? null : _askQuestion,
                icon: _isAskingQuestion
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send_rounded),
                label: Text(_isAskingQuestion ? 'Processing...' : 'Ask Question'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                const Text(
                  'AI Answer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _questionAnswer!,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
