class TarotCard {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isReversed;
  final String uprightMeaning;
  final String reversedMeaning;

  const TarotCard({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isReversed = false,
    required this.uprightMeaning,
    required this.reversedMeaning,
  });

  factory TarotCard.fromJson(Map<String, dynamic> json) {
    return TarotCard(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      isReversed: json['is_reversed'] ?? false,
      uprightMeaning: json['upright_meaning'],
      reversedMeaning: json['reversed_meaning'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'is_reversed': isReversed,
      'upright_meaning': uprightMeaning,
      'reversed_meaning': reversedMeaning,
    };
  }

  TarotCard copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isReversed,
    String? uprightMeaning,
    String? reversedMeaning,
  }) {
    return TarotCard(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isReversed: isReversed ?? this.isReversed,
      uprightMeaning: uprightMeaning ?? this.uprightMeaning,
      reversedMeaning: reversedMeaning ?? this.reversedMeaning,
    );
  }
}