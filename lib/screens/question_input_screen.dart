import 'package:flutter/material.dart';
import 'package:nexus_fates/screens/tarot_screen.dart';

class QuestionInputScreen extends StatefulWidget {
  const QuestionInputScreen({super.key});

  @override
  State<QuestionInputScreen> createState() => _QuestionInputScreenState();
}

class _QuestionInputScreenState extends State<QuestionInputScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _shuffleCountController = TextEditingController();
  String? _selectedArcana = 'major'; // Default to Major Arcana

  @override
  void dispose() {
    _questionController.dispose();
    _shuffleCountController.dispose();
    super.dispose();
  }

  void _navigateToTarotScreen() {
    final int? shuffleCount = int.tryParse(_shuffleCountController.text);

    if (_questionController.text.isNotEmpty && _selectedArcana != null && shuffleCount != null && shuffleCount > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TarotScreen(
            arcana: _selectedArcana!,
            question: _questionController.text,
            shuffleCount: shuffleCount,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a question, select an arcana, and provide a valid shuffle count.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Your Tarot Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Your Question',
                hintText: 'e.g., What should I focus on in my career?',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _shuffleCountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Shuffles',
                hintText: 'e.g., 3, 5, 10 (times to shuffle)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
              DropdownButtonFormField<String>(
              value: _selectedArcana,
              decoration: const InputDecoration(
                labelText: 'Select Arcana',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'major', child: Text('Major Arcana')),
                DropdownMenuItem(value: 'minor', child: Text('Minor Arcana')),
                DropdownMenuItem(value: 'all', child: Text('All Arcana')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedArcana = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToTarotScreen,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Draw Cards'),
            ),
          ],
        ),
      ),
    );
  }
}
