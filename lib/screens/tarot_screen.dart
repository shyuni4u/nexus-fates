
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class TarotScreen extends StatefulWidget {
  final String arcana;

  const TarotScreen({super.key, required this.arcana});

  @override
  State<TarotScreen> createState() => _TarotScreenState();
}

class _TarotScreenState extends State<TarotScreen> {
  List<dynamic> _allCards = [];
  List<Map<String, dynamic>> _positionedCards = [];
  final Random _random = Random();
  bool _cardsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to ensure context is available for MediaQuery
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCards();
    });
  }

  Future<void> _loadCards() async {
    final String data = await rootBundle.loadString('lib/assets/data/tarot_data.json');
    final jsonResult = json.decode(data);
    List<dynamic> loadedCards;

    if (widget.arcana == 'major') {
      loadedCards = jsonResult['major_arcana'];
    } else {
      loadedCards = [
        ...jsonResult['minor_arcana']['wands'],
        ...jsonResult['minor_arcana']['cups'],
        ...jsonResult['minor_arcana']['swords'],
        ...jsonResult['minor_arcana']['pentacles'],
      ];
    }

    setState(() {
      _allCards = loadedCards;
      _generateCardPositions();
      _cardsLoaded = true;
    });
  }

  void _generateCardPositions() {
    if (_allCards.isEmpty || !mounted) return;

    final Size screenSize = MediaQuery.of(context).size;
    const double cardWidth = 100.0;
    const double cardHeight = 170.0; // Adjusted for text

    _positionedCards = _allCards.map((cardData) {
      return {
        'data': cardData,
        'top': _random.nextDouble() * (screenSize.height - cardHeight - kToolbarHeight),
        'left': _random.nextDouble() * (screenSize.width - cardWidth),
        'angle': (_random.nextDouble() * 0.6) - 0.3, // -0.3 to 0.3 radians
      };
    }).toList();
    
    // Shuffle the list to randomize z-index
    _positionedCards.shuffle(_random);
  }

  void _shuffleCards() {
    setState(() {
      _generateCardPositions();
    });
  }

  Widget _buildCard(Map<String, dynamic> cardData) {
    String imageName = cardData['name'].toLowerCase().replaceAll(' ', '_') + '.png';
    String imagePath = 'lib/assets/image/$imageName';

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8.0,
      child: FutureBuilder(
        future: rootBundle.load(imagePath).then((value) => value).catchError((_) {
          if (mounted) { // Check if the widget is still in the tree
            print('Image not found: $imagePath');
          }
          return null;
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            return Ink.image(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            );
          } else {
            return Container(
              color: Colors.blueGrey[800],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cardData['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.arcana.toUpperCase()} Arcana'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: _shuffleCards,
            tooltip: 'Shuffle Cards',
          ),
        ],
      ),
      body: _cardsLoaded
          ? Stack(
              children: _positionedCards.map((card) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOut,
                  top: card['top'],
                  left: card['left'],
                  child: Transform.rotate(
                    angle: card['angle'],
                    child: SizedBox(
                      width: 100.0,
                      height: 170.0,
                      child: _buildCard(card['data']),
                    ),
                  ),
                );
              }).toList(),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
