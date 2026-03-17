class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String photoUrl;
  final String postalCode;
  final String neighborhood;
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
    required this.neighborhood,
    required this.bio,
    required this.memberRating,
    required this.memberSince,
    required this.articlesPosted,
    required this.exchangesCompleted,
  });

  String get fullName => '$firstName $lastName';

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      postalCode: json['postalCode'] ?? '',
      neighborhood: json['neighborhood'] ?? '',
      bio: json['bio'] ?? '',
      memberRating: (json['memberRating'] ?? 0.0).toDouble(),
      memberSince: json['memberSince'] ?? 0,
      articlesPosted: json['articlesPosted'] ?? 0,
      exchangesCompleted: json['exchangesCompleted'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'postalCode': postalCode,
      'neighborhood': neighborhood,
      'bio': bio,
      'memberRating': memberRating,
      'memberSince': memberSince,
      'articlesPosted': articlesPosted,
      'exchangesCompleted': exchangesCompleted,
    };
  }
}
