class Article {
  final String id;
  final String name;
  final String category;
  final String size;
  final String description;
  final String condition; // Neuf, Bon etat, Occasion
  final String photoUrl;
  final String donorId;
  final String donorName;
  final String donorPhotoUrl;
  final String postalCode;
  final double latitude;
  final double longitude;
  final DateTime createdAt;

  Article({
    required this.id,
    required this.name,
    required this.category,
    required this.size,
    required this.description,
    required this.condition,
    required this.photoUrl,
    required this.donorId,
    required this.donorName,
    required this.donorPhotoUrl,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      size: json['size'] ?? '',
      description: json['description'] ?? '',
      condition: json['condition'] ?? 'Bon etat',
      photoUrl: json['photoUrl'] ?? '',
      donorId: json['donorId'] ?? '',
      donorName: json['donorName'] ?? '',
      donorPhotoUrl: json['donorPhotoUrl'] ?? '',
      postalCode: json['postalCode'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'size': size,
      'description': description,
      'condition': condition,
      'photoUrl': photoUrl,
      'donorId': donorId,
      'donorName': donorName,
      'donorPhotoUrl': donorPhotoUrl,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
