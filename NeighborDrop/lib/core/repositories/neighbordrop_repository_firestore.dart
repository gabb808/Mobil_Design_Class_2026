import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/article.dart';
import '../models/app_user.dart';
import '../models/proposition.dart';
import '../models/conversation.dart';
import '../models/message.dart';

class NeighbordropRepository {
  static final NeighbordropRepository _instance = NeighbordropRepository._internal();
  
  factory NeighbordropRepository() {
    return _instance;
  }
  
  NeighbordropRepository._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Favoris (en local pour le moment)
  final RxSet<String> favoriteArticleIds = <String>{}.obs;
  
  final categories = <String>[
    'Tous',
    'Vêtements',
    'Meuble',
    'Electromenager',
    'Livres',
    'Jouets',
    'Sports',
    'Autres',
  ];
  
  final conditions = <String>[
    'Neuf',
    'Bon état',
    'Occasion',
  ];
  
  void toggleFavorite(String articleId) {
    if (favoriteArticleIds.contains(articleId)) {
      favoriteArticleIds.remove(articleId);
    } else {
      favoriteArticleIds.add(articleId);
    }
  }

  bool isFavorite(String articleId) {
    return favoriteArticleIds.contains(articleId);
  }

  List<Article> getFavoriteArticles() {
    return [];
  }
  
  Future<AppUser?> getCurrentUser() async {
    // Utilisateur par défaut pour la démo (Marie Martin id=2)
    return getUserById('2');
  }

  // ============ ARTICLES ============
  
  Future<RxList<Article>> getArticles({String? category, String? postalCode, String? searchQuery}) async {
    try {
      Query query = _firestore.collection('articles');
      
      if (category != null && category != 'Tous') {
        query = query.where('category', isEqualTo: category);
      }
      
      if (postalCode != null) {
        query = query.where('postalCode', isEqualTo: postalCode);
      }
      
      final snapshot = await query.get();
      var articles = snapshot.docs.map((doc) => Article.fromFirestore(doc)).toList();
      
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        articles = articles.where((a) => 
          a.name.toLowerCase().contains(q) || 
          a.description.toLowerCase().contains(q)
        ).toList();
      }
      
      return articles.obs;
    } catch (e) {
      print('Erreur lors de la récupération des articles: $e');
      return <Article>[].obs;
    }
  }

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

  Future<List<Article>> getArticlesByUser(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('articles')
          .where('donorId', isEqualTo: userId)
          .get();
      
      return snapshot.docs
          .map((doc) => Article.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Erreur lors de la récupération des articles utilisateur: $e');
      return [];
    }
  }

  Future<bool> createArticle(Article article) async {
    try {
      final articleData = article.toFirestore();
      await _firestore.collection('articles').add(articleData);
      return true;
    } catch (e) {
      print('Erreur lors de la création de l\'article: $e');
      return false;
    }
  }

  // ============ UTILISATEURS ============
  
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

  Future<bool> updateUser(AppUser user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .update(user.toFirestore());
      return true;
    } catch (e) {
      print('Erreur lors de la mise à jour de l\'utilisateur: $e');
      return false;
    }
  }

  // ============ PROPOSITIONS ============

  Future<List<Proposition>> getPropositionsForArticle(String articleId) async {
    try {
      final snapshot = await _firestore
          .collection('propositions')
          .where('articleId', isEqualTo: articleId)
          .get();
      
      return snapshot.docs
          .map((doc) => Proposition.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
          .toList();
    } catch (e) {
      print('Erreur lors de la récupération des propositions: $e');
      return [];
    }
  }

  // ============ MESSAGERIE ============
  
  Future<List<Conversation>> getConversations() async {
    try {
      final userId = '2'; 
      final snapshot = await _firestore
          .collection('conversations')
          .where('participants', arrayContains: userId)
          .get();
      
      List<Conversation> convs = [];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        
        final msgSnapshot = await doc.reference
            .collection('messages')
            .orderBy('createdAt')
            .get();
        
        final messages = msgSnapshot.docs
            .map((m) => Message.fromJson({...m.data(), 'id': m.id}))
            .toList();

        convs.add(Conversation(
          id: doc.id,
          otherUserId: data['otherUserId'] ?? '',
          otherUserName: data['otherUserName'] ?? '',
          otherUserPhotoUrl: data['otherUserPhotoUrl'] ?? '',
          articleId: data['articleId'] ?? '',
          articleName: data['articleName'] ?? '',
          articlePhotoUrl: data['articlePhotoUrl'] ?? '',
          messages: messages,
          updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        ));
      }
      return convs;
    } catch (e) {
      print('Erreur lors de la récupération des conversations: $e');
      return [];
    }
  }

  Future<Conversation> getOrCreateConversation({
    required String otherUserId,
    required String otherUserName,
    required String otherUserPhotoUrl,
    required String articleId,
    required String articleName,
    required String articlePhotoUrl,
  }) async {
    try {
      final userId = '2'; 
      final conversationId = _generateConversationId(userId, otherUserId, articleId);
      final docRef = _firestore.collection('conversations').doc(conversationId);
      final doc = await docRef.get();
      
      if (!doc.exists) {
        final convData = {
          'participants': [userId, otherUserId],
          'otherUserId': otherUserId,
          'otherUserName': otherUserName,
          'otherUserPhotoUrl': otherUserPhotoUrl,
          'articleId': articleId,
          'articleName': articleName,
          'articlePhotoUrl': articlePhotoUrl,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        };
        await docRef.set(convData);
        
        return Conversation(
          id: conversationId,
          otherUserId: otherUserId,
          otherUserName: otherUserName,
          otherUserPhotoUrl: otherUserPhotoUrl,
          articleId: articleId,
          articleName: articleName,
          articlePhotoUrl: articlePhotoUrl,
          messages: [],
          updatedAt: DateTime.now(),
        );
      } else {
        final data = doc.data()!;
        return Conversation(
          id: doc.id,
          otherUserId: data['otherUserId'] ?? '',
          otherUserName: data['otherUserName'] ?? '',
          otherUserPhotoUrl: data['otherUserPhotoUrl'] ?? '',
          articleId: data['articleId'] ?? '',
          articleName: data['articleName'] ?? '',
          articlePhotoUrl: data['articlePhotoUrl'] ?? '',
          messages: [], 
          updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }
    } catch (e) {
      print('Erreur lors de la création de la conversation: $e');
      throw e;
    }
  }

  Future<Message> sendMessage({
    required String conversationId,
    required String content,
    bool isExchangeProposal = false,
    String? exchangeArticleId,
    String? exchangeArticleName,
    String? exchangeArticlePhotoUrl,
  }) async {
    try {
      final userId = '2'; 
      final msgData = {
        'conversationId': conversationId,
        'senderId': userId,
        'senderName': 'Marie Martin',
        'senderPhotoUrl': 'https://i.pravatar.cc/150?img=5',
        'content': content,
        'createdAt': DateTime.now().toIso8601String(),
        'isRead': false,
        'isExchangeProposal': isExchangeProposal,
        'exchangeArticleId': exchangeArticleId,
        'exchangeArticleName': exchangeArticleName,
        'exchangeArticlePhotoUrl': exchangeArticlePhotoUrl,
      };
      
      final docRef = await _firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .add(msgData);
      
      await _firestore.collection('conversations').doc(conversationId).update({
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return Message.fromJson({...msgData, 'id': docRef.id});
    } catch (e) {
      print('Erreur lors de l\'envoi du message: $e');
      throw e;
    }
  }

  Future<void> markConversationAsRead(String conversationId) async {
    print('Conversation $conversationId marquée comme lue');
  }

  String _generateConversationId(String u1, String u2, String artId) {
    final ids = [u1, u2]..sort();
    return '${ids[0]}_${ids[1]}_$artId';
  }
}
