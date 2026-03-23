class Availability {
  final String day;
  final String start;
  final String end;

  Availability({
    required this.day,
    required this.start,
    required this.end,
  });

  String get formatted => '$day $start-$end';
}

class StudyPartner {
  final String id;
  final String firstName;
  final String lastName;
  final String photoUrl;
  final String bio;
  final String mainSubject;
  final List<String> subjects;
  final double averageRating;
  final int reviewCount;
  final String nextAvailability;
  final List<Availability> availabilities;
  bool isFavorite;

  StudyPartner({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photoUrl,
    required this.bio,
    required this.mainSubject,
    required this.subjects,
    required this.averageRating,
    required this.reviewCount,
    required this.nextAvailability,
    required this.availabilities,
    this.isFavorite = false,
  });

  String get fullName => '$firstName ${lastName[0]}.';
}
