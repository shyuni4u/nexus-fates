import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class TarotScreen extends StatefulWidget {
  final String arcana;
  final String question;
  final int shuffleCount;

  const TarotScreen({
    super.key,
    required this.arcana,
    required this.question,
    required this.shuffleCount,
  });

  @override
  State<TarotScreen> createState() => _TarotScreenState();
}

class _TarotScreenState extends State<TarotScreen> {
  List<dynamic> _allCards = [];
  final Random _random = Random();
  bool _cardsLoaded = false;

  final List<dynamic> _selectedCards = [];
  final Set<String> _selectedCardNames = <String>{};
  final int _numberOfCardsToSelect = 10; // Will be initialized in initState
  bool _selectionComplete = false;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    final String data = await rootBundle.loadString(
      'lib/assets/data/tarot_data.json',
    );
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
      for (int i = 0; i < widget.shuffleCount; i++) {
        _allCards.shuffle(_random);
      }
      _cardsLoaded = true;
    });
  }

  void _shuffleCards() {
    setState(() {
      _allCards.shuffle(_random);
    });
  }

  void _resetSelection() {
    setState(() {
      _selectedCards.clear();
      _selectedCardNames.clear();
      _selectionComplete = false;
      _shuffleCards();
    });
  }

  void _handleCardTap(Map<String, dynamic> cardData) {
    if (_selectionComplete || _selectedCardNames.contains(cardData['name'])) {
      return;
    }

    setState(() {
      if (_selectedCards.length < _numberOfCardsToSelect) {
        _selectedCards.add(cardData);
        _selectedCardNames.add(cardData['name']);

        if (_selectedCards.length == _numberOfCardsToSelect) {
          _selectionComplete = true;
        }
      }
    });
  }

  Widget _buildCard(Map<String, dynamic> cardData, {bool isSelectable = true}) {
    String imageName =
        cardData['name'].toLowerCase().replaceAll(' ', '_') + '.png';
    String imagePath = 'lib/assets/image/$imageName';
    bool isSelected = _selectedCardNames.contains(cardData['name']);

    Widget cardContent = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white,
          width: 2.0,
        ), // Add a white border with 2.0 width
      ),
      child: FutureBuilder(
        future: rootBundle.load(imagePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return Ink.image(image: AssetImage(imagePath), fit: BoxFit.cover);
          } else if (snapshot.hasError) {
            if (mounted) print('Error loading image: $imagePath - ${snapshot.error}');
            return Container(
              color: Colors.red[800],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error loading ${cardData['name']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.blueGrey[800],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cardData['name'], textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            );
          }
        },
      ),
    );

    if (!isSelectable) return cardContent;

    return GestureDetector(
      onTap: () => _handleCardTap(cardData),
      child: Opacity(opacity: isSelected ? 0.4 : 1.0, child: cardContent),
    );
  }

  Widget _buildSelectedCardsArea() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      height: 150, // Reduced height for selected cards area
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_numberOfCardsToSelect, (index) {
          Widget placeholder = Container(
            width: 100,
            height: 160,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.blueGrey.shade300, width: 2),
            ),
          );

          if (index >= _selectedCards.length) return placeholder;

          Widget cardBack = Container(
            decoration: BoxDecoration(
              color: Colors.indigo[700],
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Icon(
                Icons.star_border_purple500_sharp,
                color: Colors.amber,
                size: 40,
              ),
            ),
          );

          return Container(
            width: 100,
            height: 160,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: _selectionComplete
                  ? _buildCard(_selectedCards[index], isSelectable: false)
                  : cardBack,
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 100.0;
    const double cardHeight = 160.0;
    const double overlap = cardWidth * 0.6;
    final double step = cardWidth - overlap;
    final int numCards = _allCards.length;
    final double totalWidth = (numCards - 1) * step + cardWidth;
    final double visualCount = max(_allCards.length.toDouble(), 7); // 최소 아치 기준
    final double centerIndex = (visualCount - 1) / 2;

    final Size screenSize = MediaQuery.of(context).size;
    final double containerHeight = screenSize.height * 0.4; // 높이의 40%

    final double minWidth = MediaQuery.of(context).size.width * 0.9;
    final double contentWidth = totalWidth < minWidth ? minWidth : totalWidth;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.arcana.toUpperCase()} Arcana'),
        actions: [
          if (_selectionComplete)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetSelection,
              tooltip: 'Start Over',
            )
          else
            IconButton(
              icon: const Icon(Icons.shuffle),
              onPressed: _shuffleCards,
              tooltip: 'Shuffle Cards',
            ),
        ],
      ),
      body: _cardsLoaded
          ? Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: contentWidth,
                        height: containerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: List.generate(numCards, (index) {
                            final double normalizedIndex =
                                (index - centerIndex) / centerIndex;
                            final double curveY =
                                pow(normalizedIndex, 2) *
                                (containerHeight - cardHeight);
                            final double angle = normalizedIndex * 0.3;
                            final double offsetX =
                                (index - (numCards - 1) / 2) * step;

                            return Positioned(
                              top: curveY,
                              left: contentWidth / 2 - cardWidth / 2 + offsetX,
                              child: Transform.rotate(
                                angle: angle,
                                child: SizedBox(
                                  width: cardWidth,
                                  height: cardHeight,
                                  child: _buildCard(_allCards[index]),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                _buildSelectedCardsArea(),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
