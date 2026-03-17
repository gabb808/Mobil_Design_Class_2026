import 'package:get/get.dart';
import '../models/article.dart';
import '../models/app_user.dart';
import '../models/proposition.dart';

class NeighbordropRepository {
  // Donnees mockees
  static final List<AppUser> _mockUsers = [
    AppUser(
      id: '1',
      firstName: 'Jean',
      lastName: 'Dupont',
      photoUrl: 'https://i.pravatar.cc/150?img=1',
      postalCode: '75012',
      neighborhood: 'Bercy',
      bio: 'Aime partager avec les voisins et donner une seconde vie aux objets!',
      memberRating: 4.5,
      memberSince: 2,
      articlesPosted: 8,
      exchangesCompleted: 5,
    ),
    AppUser(
      id: '2',
      firstName: 'Marie',
      lastName: 'Martin',
      photoUrl: 'https://i.pravatar.cc/150?img=2',
      postalCode: '75012',
      neighborhood: 'Bercy',
      bio: 'Passionnee de deco et de mode. Echange volontiers!',
      memberRating: 4.8,
      memberSince: 1,
      articlesPosted: 12,
      exchangesCompleted: 8,
    ),
    AppUser(
      id: '3',
      firstName: 'Thomas',
      lastName: 'Bernard',
      photoUrl: 'https://i.pravatar.cc/150?img=3',
      postalCode: '75012',
      neighborhood: 'Bercy',
      bio: 'Sportif qui se debarrasse de ses anciens equipements',
      memberRating: 4.2,
      memberSince: 3,
      articlesPosted: 6,
      exchangesCompleted: 4,
    ),
  ];

  static final List<Article> _mockArticles = [
    Article(
      id: 'a1',
      name: 'VTT Orange',
      category: 'Sports',
      size: '25kg',
      weight: '25kg',
      description: 'VTT enfant en bon etat, peu utilise. Idee pour faire du sport!',
      condition: 'Neuf',
      photoUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
      donorId: '1',
      donorName: 'Jean Dupont',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=1',
      postalCode: '75012',
      neighborhood: 'Bercy',
      createdAt: DateTime.now().subtract(Duration(days: 2)),
    ),
    Article(
      id: 'a2',
      name: 'Table basse design',
      category: 'Meuble',
      size: '120x60x40cm',
      weight: '15kg',
      description: 'Table basse en bois avec plateau verre. Tres bon etat. Petit defaut sur un pied.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      donorId: '2',
      donorName: 'Marie Martin',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=2',
      postalCode: '75012',
      neighborhood: 'Bercy',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    Article(
      id: 'a3',
      name: 'Set de cuisine 12 pieces',
      category: 'Electromenager',
      size: 'Petite taille',
      weight: '3kg',
      description: 'Casseroles, poeles et ustensiles. Marque de qualite. Utilises mais en bon etat.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-1578500494198-246f612d0b3d?w=400',
      donorId: '3',
      donorName: 'Thomas Bernard',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=3',
      postalCode: '75012',
      neighborhood: 'Bercy',
      createdAt: DateTime.now().subtract(Duration(hours: 3)),
    ),
    Article(
      id: 'a4',
      name: 'Livres de science-fiction (lot de 5)',
      category: 'Livres',
      size: 'Formats varies',
      weight: '2kg',
      description: 'Collection de livres SF en francais. Lectures interessantes et bonne condition.',
      condition: 'Bon etat',
      photoUrl: 'https://images.unsplash.com/photo-150784272343-583f20270319?w=400',
      donorId: '1',
      donorName: 'Jean Dupont',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=1',
      postalCode: '75012',
      neighborhood: 'Bercy',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
    ),
    Article(
      id: 'a5',
      name: 'Vetements d\'ete (taille M)',
      category: 'Vetements',
      size: 'Taille M',
      weight: '1kg',
      description: 'T-shirts, shorts et robes pour l\'ete. Parfait pour la saison! Jamais portes.',
      condition: 'Neuf',
      photoUrl: 'https://images.unsplash.com/photo-1595508149631-5ea98db5ae5b?w=400',
      donorId: '2',
      donorName: 'Marie Martin',
      donorPhotoUrl: 'https://i.pravatar.cc/150?img=2',
      postalCode: '75012',
      neighborhood: 'Bercy',
      createdAt: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  // Simule un delai reseau
  Future<void> _delay() => Future.delayed(Duration(milliseconds: 200));

  // Articles
  Future<RxList<Article>> getArticles({String? category, String? postalCode}) async {
    await _delay();
    
    List<Article> articles = _mockArticles;
    
    if (category != null && category != 'Tous') {
      articles = articles.where((a) => a.category == category).toList();
    }
    
    if (postalCode != null) {
      articles = articles.where((a) => a.postalCode == postalCode).toList();
    }
    
    return articles.obs;
  }

  Future<Article?> getArticleById(String id) async {
    await _delay();
    try {
      return _mockArticles.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> createArticle(Article article) async {
    await _delay();
    _mockArticles.add(article);
    return true;
  }

  // Users
  Future<AppUser?> getUserById(String id) async {
    await _delay();
    try {
      return _mockUsers.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<AppUser?> getCurrentUser() async {
    await _delay();
    // Simule lutilisateur connecte (id=2 = Marie)
    return _mockUsers.firstWhere((u) => u.id == '2');
  }

  Future<bool> updateUser(AppUser user) async {
    await _delay();
    return true;
  }

  // Propositions
  Future<List<Proposition>> getPropositionsForArticle(String articleId) async {
    await _delay();
    // Simule quelques propositions
    return [
      Proposition(
        id: 'p1',
        articleId: articleId,
        senderId: '1',
        senderName: 'Jean Dupont',
        senderPhotoUrl: 'https://i.pravatar.cc/150?img=1',
        message: 'Salut! Je serais interesse par cet article!',
        status: 'pending',
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
    ];
  }

  Future<bool> sendProposition(Proposition proposition) async {
    await _delay();
    return true;
  }

  List<String> get categories => [
    'Tous',
    'Vetements',
    'Livres',
    'Electromenager',
    'Meuble',
    'Jouets',
    'Sports',
    'Autres',
  ];

  List<String> get conditions => [
    'Neuf',
    'Bon etat',
    'Occasion',
  ];
}
