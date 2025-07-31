import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/tarot_card.dart';
import '../utils/i18n_helper.dart';

class TarotService {
  static List<TarotCard>? _allCards;
  static const List<String> _celticCrossPositions = [
    'Present Situation',
    'Challenge/Cross',
    'Distant Past/Foundation',
    'Recent Past',
    'Possible Outcome',
    'Immediate Future',
    'Your Approach',
    'External Influences',
    'Hopes and Fears',
    'Final Outcome'
  ];

  /// Load all tarot cards from JSON file
  static Future<List<TarotCard>> _loadTarotCards() async {
    if (_allCards != null) return _allCards!;

    final String jsonString = await rootBundle.loadString('assets/data/tarot.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    
    List<TarotCard> cards = [];
    
    // Load Major Arcana
    for (var card in data['major_arcana']) {
      cards.add(TarotCard(
        name: card['name'],
        meaning: card['meaning'],
        reversedMeaning: card['reversed_meaning'],
        suit: 'Major Arcana',
        isReversed: false,
      ));
    }
    
    // Load Minor Arcana
    final minorArcana = data['minor_arcana'];
    for (String suit in ['wands', 'cups', 'swords', 'pentacles']) {
      for (var card in minorArcana[suit]) {
        cards.add(TarotCard(
          name: card['name'],
          meaning: card['meaning'],
          reversedMeaning: card['reversed_meaning'],
          suit: suit.capitalize(),
          isReversed: false,
        ));
      }
    }
    
    _allCards = cards;
    return cards;
  }

  /// Generate a Celtic Cross spread (10 cards)
  static Future<List<TarotCard>> generateCelticCrossSpread([BuildContext? context]) async {
    // Precompute positions before any async operations
    final positions = context != null 
        ? I18nHelper.getCelticCrossPositions(context)
        : _celticCrossPositions;
        
    final allCards = await _loadTarotCards();
    final random = Random();
    final selectedCards = <TarotCard>[];
    final usedIndices = <int>{};
    
    // Select 10 unique cards
    while (selectedCards.length < 10) {
      final index = random.nextInt(allCards.length);
      if (!usedIndices.contains(index)) {
        usedIndices.add(index);
        
        final card = allCards[index].copyWith(
          isReversed: random.nextBool(), // 50% chance of being reversed
          position: positions[selectedCards.length],
        );
        selectedCards.add(card);
      }
    }
    
    return selectedCards;
  }

  /// Generate Gemini AI prompt based on user question and selected cards
  static String generateGeminiPrompt(String userQuestion, List<TarotCard> cards) {
    final StringBuffer prompt = StringBuffer();
    
    prompt.writeln('You are an experienced and insightful tarot reader. Please provide a comprehensive Celtic Cross tarot reading based on the following:');
    prompt.writeln();
    prompt.writeln('USER QUESTION: "$userQuestion"');
    prompt.writeln();
    prompt.writeln('CARDS DRAWN IN CELTIC CROSS SPREAD:');
    
    for (int i = 0; i < cards.length; i++) {
      final card = cards[i];
      final meaning = card.isReversed ? card.reversedMeaning : card.meaning;
      prompt.writeln('${i + 1}. ${card.position}: ${card.name}${card.isReversed ? ' (Reversed)' : ''}');
      prompt.writeln('   Meaning: $meaning');
      prompt.writeln();
    }
    
    prompt.writeln('Please provide a detailed reading that:');
    prompt.writeln('1. Addresses the user\'s specific question');
    prompt.writeln('2. Interprets each card in its position within the Celtic Cross spread');
    prompt.writeln('3. Explains how the cards relate to each other and form a cohesive narrative');
    prompt.writeln('4. Offers meaningful insights and guidance');
    prompt.writeln('5. Maintains a supportive and empathetic tone');
    prompt.writeln('6. Includes practical advice where appropriate');
    prompt.writeln();
    prompt.writeln('Structure your response with clear sections for each position and a summary conclusion.');
    
    return prompt.toString();
  }

  /// Mock Gemini API response for development
  static Future<String> getMockGeminiResponse(String userQuestion, List<TarotCard> cards) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    final response = StringBuffer();
    response.writeln('# Celtic Cross Tarot Reading\n');
    response.writeln('## Your Question: "$userQuestion"\n');
    
    response.writeln('## Card Interpretations:\n');
    
    for (int i = 0; i < cards.length; i++) {
      final card = cards[i];
      final meaning = card.isReversed ? card.reversedMeaning : card.meaning;
      
      response.writeln('### ${i + 1}. ${card.position}');
      response.writeln('**${card.name}${card.isReversed ? ' (Reversed)' : ''}**\n');
      response.writeln('*$meaning*\n');
      
      // Generate contextual interpretation based on position
      response.writeln(_getPositionInterpretation(card.position ?? 'Unknown Position', card, userQuestion));
      response.writeln();
    }
    
    response.writeln('## Overall Reading Summary:\n');
    response.writeln('Based on the cards drawn, your reading suggests a journey of personal growth and transformation. ');
    response.writeln('The cards indicate that while you may face some challenges, you have the inner strength and ');
    response.writeln('resources needed to overcome them. Trust in your intuition and remain open to new possibilities.\n');
    
    response.writeln('Remember, tarot is a tool for self-reflection and guidance. The future is not set in stone, ');
    response.writeln('and you have the power to shape your own destiny through your choices and actions.');
    
    return response.toString();
  }

  static String _getPositionInterpretation(String position, TarotCard card, String question) {
    switch (position) {
      case 'Present Situation':
        return 'This card represents your current circumstances and the energy surrounding your question. ${card.name} suggests that you are currently experiencing ${card.isReversed ? 'challenges related to' : 'a phase of'} ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()}.';
      
      case 'Challenge/Cross':
        return 'This card represents the main challenge or obstacle you\'re facing. ${card.name} indicates that the primary challenge involves ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()}. This is something you need to work through or overcome.';
      
      case 'Distant Past/Foundation':
        return 'This card represents the foundation or root cause of your current situation. ${card.name} suggests that past experiences involving ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()} have shaped your current circumstances.';
      
      case 'Recent Past':
        return 'This card represents recent events that have influenced your current situation. ${card.name} indicates that recent experiences with ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()} are still affecting you.';
      
      case 'Possible Outcome':
        return 'This card represents one possible outcome if current trends continue. ${card.name} suggests that you may experience ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()} if you maintain your current path.';
      
      case 'Immediate Future':
        return 'This card represents what you can expect in the near future. ${card.name} indicates that the immediate future holds ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()}.';
      
      case 'Your Approach':
        return 'This card represents your current approach or attitude toward the situation. ${card.name} suggests that you are approaching this situation with ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()}.';
      
      case 'External Influences':
        return 'This card represents external factors affecting your situation. ${card.name} indicates that outside influences involving ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()} are impacting your circumstances.';
      
      case 'Hopes and Fears':
        return 'This card represents your inner hopes and fears about the situation. ${card.name} suggests that deep down, you ${card.isReversed ? 'fear' : 'hope for'} ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()}.';
      
      case 'Final Outcome':
        return 'This card represents the likely final outcome based on current energies. ${card.name} suggests that the ultimate result will involve ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()}.';
      
      default:
        return 'This card brings the energy of ${card.isReversed ? card.reversedMeaning.toLowerCase() : card.meaning.toLowerCase()} to your reading.';
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}