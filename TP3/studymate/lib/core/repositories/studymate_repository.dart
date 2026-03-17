import 'package:shared_preferences/shared_preferences.dart';
import '../models/study_partner.dart';
import '../models/review.dart';
import '../models/session_request.dart';

class StudymateRepository {
  List<String> _favoriteIds = [];

  // --- Donnees mockees ---

  final List<StudyPartner> _mockPartners = [
    StudyPartner(
      id: 'partner_001',
      firstName: 'Marie',
      lastName: 'Dupont',
      photoUrl: 'https://i.pravatar.cc/150?img=1',
      bio:
          'Etudiante en L3 Mathematiques a Paris-Saclay. J\'adore expliquer les concepts complexes de maniere simple. Specialisee en analyse et algebre lineaire.',
      mainSubject: 'Mathematiques',
      subjects: ['Mathematiques', 'Statistiques', 'Algorithmique'],
      averageRating: 4.5,
      reviewCount: 12,
      nextAvailability: 'Lun 14h',
      availabilities: [
        Availability(day: 'Lundi', start: '14:00', end: '16:00'),
        Availability(day: 'Mercredi', start: '10:00', end: '12:00'),
        Availability(day: 'Vendredi', start: '09:00', end: '11:00'),
      ],
    ),
    StudyPartner(
      id: 'partner_002',
      firstName: 'Thomas',
      lastName: 'Martin',
      photoUrl: 'https://i.pravatar.cc/150?img=3',
      bio:
          'En M1 Informatique, passionne de dev mobile et d\'IA. Je peux aider en Python, Java et Flutter.',
      mainSubject: 'Informatique',
      subjects: ['Informatique', 'Python', 'Intelligence Artificielle'],
      averageRating: 4.8,
      reviewCount: 8,
      nextAvailability: 'Mar 10h',
      availabilities: [
        Availability(day: 'Mardi', start: '10:00', end: '12:00'),
        Availability(day: 'Jeudi', start: '14:00', end: '16:00'),
      ],
    ),
    StudyPartner(
      id: 'partner_003',
      firstName: 'Lea',
      lastName: 'Bernard',
      photoUrl: 'https://i.pravatar.cc/150?img=5',
      bio:
          'L2 Physique-Chimie. La mecanique quantique n\'a (presque) plus de secrets pour moi !',
      mainSubject: 'Physique',
      subjects: ['Physique', 'Chimie', 'Mathematiques'],
      averageRating: 4.2,
      reviewCount: 6,
      nextAvailability: 'Mer 14h',
      availabilities: [
        Availability(day: 'Mercredi', start: '14:00', end: '16:00'),
        Availability(day: 'Vendredi', start: '14:00', end: '17:00'),
      ],
    ),
    StudyPartner(
      id: 'partner_004',
      firstName: 'Hugo',
      lastName: 'Petit',
      photoUrl: 'https://i.pravatar.cc/150?img=8',
      bio:
          'Etudiant en L3 LEA anglais-espagnol. Je donne des coups de main en langues et en traduction.',
      mainSubject: 'Langues',
      subjects: ['Anglais', 'Espagnol', 'Traduction'],
      averageRating: 4.6,
      reviewCount: 15,
      nextAvailability: 'Lun 10h',
      availabilities: [
        Availability(day: 'Lundi', start: '10:00', end: '12:00'),
        Availability(day: 'Mardi', start: '16:00', end: '18:00'),
        Availability(day: 'Jeudi', start: '10:00', end: '12:00'),
      ],
    ),
    StudyPartner(
      id: 'partner_005',
      firstName: 'Camille',
      lastName: 'Roux',
      photoUrl: 'https://i.pravatar.cc/150?img=9',
      bio:
          'M1 Data Science. Stats, probabilites et machine learning sont mon quotidien. Toujours prete a expliquer !',
      mainSubject: 'Mathematiques',
      subjects: ['Statistiques', 'Probabilites', 'Machine Learning', 'Python'],
      averageRating: 4.9,
      reviewCount: 20,
      nextAvailability: 'Mar 14h',
      availabilities: [
        Availability(day: 'Mardi', start: '14:00', end: '16:00'),
        Availability(day: 'Mercredi', start: '09:00', end: '11:00'),
        Availability(day: 'Vendredi', start: '10:00', end: '12:00'),
      ],
    ),
    StudyPartner(
      id: 'partner_006',
      firstName: 'Antoine',
      lastName: 'Garcia',
      photoUrl: 'https://i.pravatar.cc/150?img=11',
      bio:
          'L2 Informatique. Fan de web dev et de bases de donnees. Je maitrise SQL, JavaScript et React.',
      mainSubject: 'Informatique',
      subjects: ['JavaScript', 'SQL', 'React', 'Web Development'],
      averageRating: 4.3,
      reviewCount: 5,
      nextAvailability: 'Jeu 10h',
      availabilities: [
        Availability(day: 'Jeudi', start: '10:00', end: '12:00'),
        Availability(day: 'Vendredi', start: '14:00', end: '16:00'),
      ],
    ),
    StudyPartner(
      id: 'partner_007',
      firstName: 'Sarah',
      lastName: 'Moreau',
      photoUrl: 'https://i.pravatar.cc/150?img=16',
      bio:
          'Etudiante en M2 Physique fondamentale. Je peux aider en mecanique, electromagnetisme et thermodynamique.',
      mainSubject: 'Physique',
      subjects: ['Physique', 'Mecanique', 'Electromagnetisme'],
      averageRating: 4.7,
      reviewCount: 11,
      nextAvailability: 'Lun 16h',
      availabilities: [
        Availability(day: 'Lundi', start: '16:00', end: '18:00'),
        Availability(day: 'Mercredi', start: '14:00', end: '16:00'),
      ],
    ),
  ];

  final Map<String, List<Review>> _mockReviews = {
    'partner_001': [
      Review(
        id: 'rev_001',
        authorName: 'Thomas',
        rating: 5.0,
        comment: 'Super claire dans ses explications ! J\'ai enfin compris les integrales.',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Review(
        id: 'rev_002',
        authorName: 'Lea',
        rating: 4.0,
        comment: 'Tres patiente et pedagogique. Je recommande.',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      Review(
        id: 'rev_003',
        authorName: 'Hugo',
        rating: 4.5,
        comment: 'Bonne session sur l\'algebre lineaire. Merci !',
        createdAt: DateTime.now().subtract(const Duration(days: 14)),
      ),
    ],
    'partner_002': [
      Review(
        id: 'rev_004',
        authorName: 'Marie',
        rating: 5.0,
        comment: 'Excellent pour Python et les structures de donnees.',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Review(
        id: 'rev_005',
        authorName: 'Camille',
        rating: 4.5,
        comment: 'Bons conseils en Flutter, merci Thomas !',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ],
    'partner_003': [
      Review(
        id: 'rev_006',
        authorName: 'Sarah',
        rating: 4.0,
        comment: 'Session productive en physique quantique.',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ],
    'partner_004': [
      Review(
        id: 'rev_007',
        authorName: 'Camille',
        rating: 5.0,
        comment: 'Hugo m\'a aide a preparer mon TOEFL, top !',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Review(
        id: 'rev_008',
        authorName: 'Antoine',
        rating: 4.5,
        comment: 'Tres bon en espagnol, prononciation impeccable.',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
      ),
    ],
    'partner_005': [
      Review(
        id: 'rev_009',
        authorName: 'Thomas',
        rating: 5.0,
        comment: 'La meilleure pour les stats ! Explications au top.',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Review(
        id: 'rev_010',
        authorName: 'Marie',
        rating: 5.0,
        comment: 'Session parfaite sur les probas conditionnelles.',
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
      ),
    ],
    'partner_006': [
      Review(
        id: 'rev_011',
        authorName: 'Thomas',
        rating: 4.0,
        comment: 'Bonne maitrise de SQL, session utile.',
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
    ],
    'partner_007': [
      Review(
        id: 'rev_012',
        authorName: 'Lea',
        rating: 5.0,
        comment: 'Incroyable en electromagnetisme, super pedagogique.',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Review(
        id: 'rev_013',
        authorName: 'Marie',
        rating: 4.5,
        comment: 'Merci pour la session de mecanique !',
        createdAt: DateTime.now().subtract(const Duration(days: 9)),
      ),
    ],
  };

  // --- Methodes publiques ---

  Future<List<StudyPartner>> fetchPartners({String? subjectFilter}) async {
    // Simuler un delai reseau
    await Future.delayed(const Duration(milliseconds: 800));

    await _loadFavorites();

    var partners = List<StudyPartner>.from(_mockPartners);

    // Marquer les favoris
    for (var p in partners) {
      p.isFavorite = _favoriteIds.contains(p.id);
    }

    // Filtrer par matiere si necessaire
    if (subjectFilter != null && subjectFilter != 'Tous') {
      partners = partners
          .where((p) =>
              p.mainSubject.toLowerCase() == subjectFilter.toLowerCase() ||
              p.subjects.any((s) =>
                  s.toLowerCase().contains(subjectFilter.toLowerCase())))
          .toList();
    }

    return partners;
  }

  Future<StudyPartner?> getPartnerDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _loadFavorites();

    try {
      final partner = _mockPartners.firstWhere((p) => p.id == id);
      partner.isFavorite = _favoriteIds.contains(partner.id);
      return partner;
    } catch (e) {
      return null;
    }
  }

  Future<List<Review>> getReviews(String partnerId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockReviews[partnerId] ?? [];
  }

  Future<bool> sendSessionRequest(SessionRequest request) async {
    // Simuler l'envoi
    await Future.delayed(const Duration(milliseconds: 1000));
    // En vrai, on enverrait a une API ou Firebase
    return true;
  }

  Future<void> toggleFavorite(String partnerId) async {
    await _loadFavorites();
    if (_favoriteIds.contains(partnerId)) {
      _favoriteIds.remove(partnerId);
    } else {
      _favoriteIds.add(partnerId);
    }
    await _saveFavorites();
  }

  Future<bool> isFavorite(String partnerId) async {
    await _loadFavorites();
    return _favoriteIds.contains(partnerId);
  }

  // --- Favoris (SharedPreferences) ---

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList('favorites') ?? [];
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteIds);
  }
}
