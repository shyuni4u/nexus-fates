class TarotCard {
  final int? id;
  final String name;
  final String? description;
  final String? imageUrl;
  final bool isReversed;
  final String meaning;
  final String reversedMeaning;
  final String? suit;
  final String? position;

  const TarotCard({
    this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.isReversed = false,
    required this.meaning,
    required this.reversedMeaning,
    this.suit,
    this.position,
  });

  factory TarotCard.fromJson(Map<String, dynamic> json) {
    return TarotCard(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      isReversed: json['is_reversed'] ?? false,
      meaning: json['meaning'] ?? json['upright_meaning'] ?? '',
      reversedMeaning: json['reversed_meaning'] ?? '',
      suit: json['suit'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'is_reversed': isReversed,
      'meaning': meaning,
      'reversed_meaning': reversedMeaning,
      'suit': suit,
      'position': position,
    };
  }

  TarotCard copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isReversed,
    String? meaning,
    String? reversedMeaning,
    String? suit,
    String? position,
  }) {
    return TarotCard(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isReversed: isReversed ?? this.isReversed,
      meaning: meaning ?? this.meaning,
      reversedMeaning: reversedMeaning ?? this.reversedMeaning,
      suit: suit ?? this.suit,
      position: position ?? this.position,
    );
  }
}