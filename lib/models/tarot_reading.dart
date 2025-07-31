import 'tarot_card.dart';

class TarotReading {
  final String? id;
  final String? userId;
  final String question;
  final List<TarotCard> cards;
  final String interpretation;
  final DateTime? createdAt;
  final String spreadType;

  const TarotReading({
    this.id,
    this.userId,
    required this.question,
    required this.cards,
    required this.interpretation,
    this.createdAt,
    this.spreadType = 'Celtic Cross',
  });

  factory TarotReading.fromJson(Map<String, dynamic> json) {
    return TarotReading(
      id: json['id'],
      userId: json['user_id'],
      question: json['question'],
      cards: (json['cards'] as List)
          .map((card) => TarotCard.fromJson(card))
          .toList(),
      interpretation: json['interpretation'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      spreadType: json['spread_type'] ?? 'Celtic Cross',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'question': question,
      'cards': cards.map((card) => card.toJson()).toList(),
      'interpretation': interpretation,
      'created_at': createdAt?.toIso8601String(),
      'spread_type': spreadType,
    };
  }

  TarotReading copyWith({
    String? id,
    String? userId,
    String? question,
    List<TarotCard>? cards,
    String? interpretation,
    DateTime? createdAt,
    String? spreadType,
  }) {
    return TarotReading(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      question: question ?? this.question,
      cards: cards ?? this.cards,
      interpretation: interpretation ?? this.interpretation,
      createdAt: createdAt ?? this.createdAt,
      spreadType: spreadType ?? this.spreadType,
    );
  }
}