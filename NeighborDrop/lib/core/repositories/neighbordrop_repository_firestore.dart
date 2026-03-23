import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/article.dart';
import '../models/app_user.dart';

class NeighbordropRepository {
  static final NeighbordropRepository _instance = NeighbordropRepository._internal();
  
  factory NeighbordropRepository() {
    return _instance;
  }
  
  NeighbordropRepository._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // ============ ARTICLES ============
  
  /// Récupère tous les articles disponibles
  Future<List<Article>> getAllArticles() async {
    try {
      final snapshot = await _firestore
          .collection('articles')
          .where('status', isEqualTo: 'available')
          .get();
      
      return snapshot.docs
          .map((doc) => Article.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Erreur lors de la récupération des articles: $e');
      return [];
    }
  }

  /// Récupère un article par son ID
  Future<Article?> getArticleById(String articleId) async {
    try {
      final doc = await _firestore.collection('articles').doc(articleId).get();
      if (doc.exists) {
        return Article.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Erreur lors de la récupération de l\'article: $e');
      return null;
    }
  }

  /// Crée un nouvel article
  Future<String> createArticle(Article article) async {
    try {
      final docRef = await _firestore.collection('articles').add(article.toFirestore());
      return docRef.id;
    } catch (e) {
      print('Erreur lors de la création de l\'article: $e');
      throw e;
    }
  }

  /// Filtre les articles par catégorie
  Future<List<Article>> filterByCategory(String category) async {
    try {
      final snapshot = await _firestore
          .collection('articles')
          .where('category', isEqualTo: category)
          .where('status', isEqualTo: 'available')
          .get();
      
      return snapshot.docs
          .map((doc) => Article.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Erreur lors du filtrage par catégorie: $e');
      return [];
    }
  }

  /// Filtre les articles par code postal
  Future<List<Article>> filterByPostalCode(String postalCode) async {
    try {
      final snapshot = await _firestore
          .collection('articles')
          .where('postalCode', isEqualTo: postalCode)
          .where('status', isEqualTo: 'available')
          .get();
      
      return snapshot.docs
          .map((doc) => Article.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Erreur lors du filtrage par code postal: $e');
      return [];
    }
  }

  /// Récupère les articles d'un utilisateur
  Future<List<Article>> getUserArticles(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('articles')
          .where('ownerId', isEqualTo: userId)
          .get();
      
      return snapshot.docs
          .map((doc) => Article.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Erreur lors de la récupération des articles utilisateur: $e');
      return [];
    }
  }

  /// Met à jour le statut d'un article
  Future<void> updateArticleStatus(String articleId, String status) async {
    try {
      await _firestore
          .collection('articles')
          .doc(articleId)
          .update({'status': status});
    } catch (e) {
      print('Erreur lors de la mise à jour du statut: $e');
      throw e;
    }
  }

  // ============ UTILISATEURS ============
  
  /// Récupère un utilisateur par son ID
  Future<AppUser?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return AppUser.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Erreur lors de la récupération de l\'utilisateur: $e');
      return null;
    }
  }

  /// Crée un nouvel utilisateur
  Future<void> createUser(String userId, AppUser user) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .set(user.toFirestore());
    } catch (e) {
      print('Erreur lors de la création de l\'utilisateur: $e');
      throw e;
    }
  }

  /// Met à jour le profil utilisateur
  Future<void> updateUserProfile(String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update(updates);
    } catch (e) {
      print('Erreur lors de la mise à jour du profil: $e');
      throw e;
    }
  }

  /// Ajoute un article aux favoris
  Future<void> addToFavorites(String userId, String articleId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
            'favorites': FieldValue.arrayUnion([articleId])
          });
    } catch (e) {
      print('Erreur lors de l\'ajout aux favoris: $e');
      throw e;
    }
  }

  /// Retire un article des favoris
  Future<void> removeFromFavorites(String userId, String articleId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
            'favorites': FieldValue.arrayRemove([articleId])
          });
    } catch (e) {
      print('Erreur lors du retrait des favoris: $e');
      throw e;
    }
  }

  /// Récupère les favoris d'un utilisateur
  Future<List<Article>> getUserFavorites(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final favorites = List<String>.from(userDoc['favorites'] ?? []);
      
      if (favorites.isEmpty) return [];
      
      final articles = <Article>[];
      for (String articleId in favorites) {
        final article = await getArticleById(articleId);
        if (article != null) {
          articles.add(article);
        }
      }
      return articles;
    } catch (e) {
      print('Erreur lors de la récupération des favoris: $e');
      return [];
    }
  }

  // ============ MESSAGERIE ============
  
  /// Envoie un message
  Future<void> sendMessage(
      String conversationId,
      String senderId,
      String content) async {
    try {
      await _firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .add({
            'senderId': senderId,
            'content': content,
            'timestamp': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      print('Erreur lors de l\'envoi du message: $e');
      throw e;
    }
  }

  /// Récupère les messages d'une conversation
  Future<List<Map<String, dynamic>>> getConversationMessages(
      String conversationId) async {
    try {
      final snapshot = await _firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .get();
      
      return snapshot.docs
          .map((doc) => doc.data())
          .toList();
    } catch (e) {
      print('Erreur lors de la récupération des messages: $e');
      return [];
    }
  }

  /// Crée ou récupère une conversation
  Future<String> getOrCreateConversation(
      String userId1, 
      String userId2) async {
    try {
      final conversationId = _generateConversationId(userId1, userId2);
      final doc = await _firestore.collection('conversations').doc(conversationId).get();
      
      if (!doc.exists) {
        await _firestore
            .collection('conversations')
            .doc(conversationId)
            .set({
              'participants': [userId1, userId2],
              'createdAt': FieldValue.serverTimestamp(),
              'lastMessage': null,
            });
      }
      
      return conversationId;
    } catch (e) {
      print('Erreur lors de la création de la conversation: $e');
      throw e;
    }
  }

  /// Récupère les conversations d'un utilisateur
  Future<List<Map<String, dynamic>>> getUserConversations(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('conversations')
          .where('participants', arrayContains: userId)
          .get();
      
      return snapshot.docs
          .map((doc) => doc.data())
          .toList();
    } catch (e) {
      print('Erreur lors de la récupération des conversations: $e');
      return [];
    }
  }

  // ============ UTILITAIRES ============
  
  String _generateConversationId(String userId1, String userId2) {
    final ids = [userId1, userId2]..sort();
    return '${ids[0]}_${ids[1]}';
  }
}
