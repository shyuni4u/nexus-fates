import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'card_selection_screen.dart';

class QuestionInputScreen extends StatefulWidget {
  const QuestionInputScreen({super.key});

  @override
  State<QuestionInputScreen> createState() => _QuestionInputScreenState();
}

class _QuestionInputScreenState extends State<QuestionInputScreen> {
  final TextEditingController _questionController = TextEditingController();
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    _questionController.addListener(() {
      setState(() {
        _characterCount = _questionController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Your Question'),
        backgroundColor: const Color(0xFF2D1B69),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D1B69),
              Color(0xFF6C5CE7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What would you like guidance on?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Focus your mind and ask a specific question. The cards will provide insight and guidance.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _questionController,
                    maxLines: 5,
                    maxLength: AppConstants.maxQuestionLength,
                    decoration: const InputDecoration(
                      hintText: 'Enter your question here...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                      counterText: '',
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Examples: "What should I focus on in my career?" or "How can I improve my relationships?"',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      '$_characterCount/${AppConstants.maxQuestionLength}',
                      style: TextStyle(
                        fontSize: 12,
                        color: _characterCount > AppConstants.maxQuestionLength * 0.9
                            ? Colors.orange
                            : Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _questionController.text.trim().isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardSelectionScreen(
                                  question: _questionController.text.trim(),
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      foregroundColor: const Color(0xFF2D1B69),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 8,
                    ),
                    child: const Text(
                      'Draw Cards',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}