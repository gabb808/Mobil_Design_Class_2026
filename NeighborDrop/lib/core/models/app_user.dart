class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String photoUrl;
  final String postalCode;
  final double latitude;
  final double longitude;
  final String bio;
  final double memberRating;
  final int memberSince; // Nombre d'années
  final int articlesPosted;
  final int exchangesCompleted;

  AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photoUrl,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.bio,
    required this.memberRating,
    required this.memberSince,
    required this.articlesPosted,
    required this.exchangesCompleted,
  });

  String get fullName => '$firstName $lastName';

  AppUser copyWith({
    String? firstName,
    String? lastName,
    String? photoUrl,
    String? postalCode,
    double? latitude,
    double? longitude,
    String? bio,
  }) {
    return AppUser(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photoUrl: photoUrl ?? this.photoUrl,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      bio: bio ?? this.bio,
      memberRating: memberRating,
      memberSince: memberSince,
      articlesPosted: articlesPosted,
      exchangesCompleted: exchangesCompleted,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      postalCode: json['postalCode'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      bio: json['bio'] ?? '',
      memberRating: (json['memberRating'] ?? 0.0).toDouble(),
      memberSince: json['memberSince'] ?? 0,
      articlesPosted: json['articlesPosted'] ?? 0,
      exchangesCompleted: json['exchangesCompleted'] ?? 0,
    );
  }

  /// Crée un AppUser depuis un DocumentSnapshot Firestore
  factory AppUser.fromFirestore(dynamic doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser(
      id: doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      postalCode: data['postalCode'] ?? '',
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      bio: data['bio'] ?? '',
      memberRating: (data['memberRating'] ?? 0.0).toDouble(),
      memberSince: data['memberSince'] ?? 0,
      articlesPosted: data['articlesPosted'] ?? 0,
      exchangesCompleted: data['exchangesCompleted'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'bio': bio,
      'memberRating': memberRating,
      'memberSince': memberSince,
      'articlesPosted': articlesPosted,
      'exchangesCompleted': exchangesCompleted,
    };
  }

  /// Convertit l'AppUser en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'bio': bio,
      'memberRating': memberRating,
      'memberSince': memberSince,
      'articlesPosted': articlesPosted,
      'exchangesCompleted': exchangesCompleted,
      'favorites': [],
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    };
  }
}
