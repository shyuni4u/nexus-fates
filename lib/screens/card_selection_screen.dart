import 'package:flutter/material.dart';

class CardSelectionScreen extends StatefulWidget {
  final String question;

  const CardSelectionScreen({
    super.key,
    required this.question,
  });

  @override
  State<CardSelectionScreen> createState() => _CardSelectionScreenState();
}

class _CardSelectionScreenState extends State<CardSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _shuffleController;
  bool _isShuffling = false;
  bool _cardsDrawn = false;

  @override
  void initState() {
    super.initState();
    _shuffleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _shuffleController.dispose();
    super.dispose();
  }

  void _shuffleCards() {
    setState(() {
      _isShuffling = true;
    });

    _shuffleController.forward().then((_) {
      setState(() {
        _isShuffling = false;
        _cardsDrawn = true;
      });
      _shuffleController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Celtic Cross Spread'),
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
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Your Question:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.question,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (!_cardsDrawn) ...[
                  AnimatedBuilder(
                    animation: _shuffleController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _shuffleController.value * 4 * 3.14159,
                        child: Container(
                          width: 120,
                          height: 180,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D1B69),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFFD700),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'TAROT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  Text(
                    _isShuffling ? 'Shuffling the cards...' : 'Focus on your question',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ] else ...[
                  _buildCelticCrossLayout(),
                ],
                const Spacer(),
                if (!_cardsDrawn)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isShuffling ? null : _shuffleCards,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        foregroundColor: const Color(0xFF2D1B69),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 8,
                      ),
                      child: Text(
                        _isShuffling ? 'Shuffling...' : 'Shuffle & Draw Cards',
                        style: const TextStyle(
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

  Widget _buildCelticCrossLayout() {
    return Column(
      children: [
        const Text(
          'Your Celtic Cross Spread',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        // Simplified Celtic Cross layout
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              // Center cards (0, 1)
              Positioned(
                left: 100,
                top: 100,
                child: _buildCard(0, 'Present'),
              ),
              Positioned(
                left: 120,
                top: 120,
                child: _buildCard(1, 'Challenge'),
              ),
              // Surrounding cards
              Positioned(
                left: 100,
                top: 50,
                child: _buildCard(2, 'Past'),
              ),
              Positioned(
                left: 100,
                top: 150,
                child: _buildCard(3, 'Future'),
              ),
              Positioned(
                left: 50,
                top: 100,
                child: _buildCard(4, 'Below'),
              ),
              Positioned(
                left: 150,
                top: 100,
                child: _buildCard(5, 'Above'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // TODO: Navigate to interpretation screen
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFD700),
            foregroundColor: const Color(0xFF2D1B69),
          ),
          child: const Text('Get AI Interpretation'),
        ),
      ],
    );
  }

  Widget _buildCard(int index, String position) {
    return Container(
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: const TextStyle(
            color: Color(0xFF2D1B69),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}