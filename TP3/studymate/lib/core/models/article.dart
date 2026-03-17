class Article {
  final String id;
  final String name;
  final String category;
  final String size;
  final String weight;
  final String description;
  final String condition; // Neuf, Bon etat, Occasion
  final String photoUrl;
  final String donorId;
  final String donorName;
  final String donorPhotoUrl;
  final String postalCode;
  final String neighborhood;
  final DateTime createdAt;

  Article({
    required this.id,
    required this.name,
    required this.category,
    required this.size,
    required this.weight,
    required this.description,
    required this.condition,
    required this.photoUrl,
    required this.donorId,
    required this.donorName,
    required this.donorPhotoUrl,
    required this.postalCode,
    required this.neighborhood,
    required this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      size: json['size'] ?? '',
      weight: json['weight'] ?? '',
      description: json['description'] ?? '',
      condition: json['condition'] ?? 'Bon etat',
      photoUrl: json['photoUrl'] ?? '',
      donorId: json['donorId'] ?? '',
      donorName: json['donorName'] ?? '',
      donorPhotoUrl: json['donorPhotoUrl'] ?? '',
      postalCode: json['postalCode'] ?? '',
      neighborhood: json['neighborhood'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'size': size,
      'weight': weight,
      'description': description,
      'condition': condition,
      'photoUrl': photoUrl,
      'donorId': donorId,
      'donorName': donorName,
      'donorPhotoUrl': donorPhotoUrl,
      'postalCode': postalCode,
      'neighborhood': neighborhood,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
