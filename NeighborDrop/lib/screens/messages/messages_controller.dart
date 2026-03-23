import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/models/conversation.dart';
import '../../core/models/message.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';

class MessagesController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  final conversation = Rxn<Conversation>();
  final messages = <Message>[].obs;
  final isLoading = false.obs;
  final isSending = false.obs;

  @override
  void onInit() {
    super.onInit();

    final arg = Get.arguments;
    if (arg is Conversation) {
      // Ouvert depuis l'inbox
      conversation.value = arg;
      repository.markConversationAsRead(arg.id);
      messages.value = List<Message>.from(arg.messages);
    } else if (arg is Article) {
      // Ouvert depuis "Contacter le voisin" sur une annonce
      _initFromArticle(arg);
    }
  }

  Future<void> showExchangeProposals(dynamic context) async {
    final myUser = await repository.getCurrentUser();
    if (myUser == null) return;
    
    final myArticles = await repository.getArticlesByUser(myUser.id);
    if (myArticles.isEmpty) {
      Get.snackbar('Oups', "Vous n'avez pas encore d'articles à échanger.");
      return;
    }

    // Since we don't import material.dart here directly, 
    // it's better to show a Get bottomsheet with basic widgets or just standard Get dialog
    Get.bottomSheet(
      Container(
        color: const Color(0xFFFFFFFF),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Proposer un échange',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: myArticles.length,
                itemBuilder: (ctx, idx) {
                  final article = myArticles[idx];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        article.photoUrl ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                      ),
                    ),
                    title: Text(article.name),
                    subtitle: Text(article.category),
                    onTap: () {
                      Get.back();
                      _sendExchangeProposal(article);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendExchangeProposal(Article article) async {
    isSending.value = true;
    try {
      const text = 'Je vous propose cet article en échange. Êtes-vous intéressé(e) ?';
      final msg = await repository.sendMessage(
        conversationId: conversation.value!.id,
        content: text,
        isExchangeProposal: true,
        exchangeArticleId: article.id,
        exchangeArticleName: article.name,
        exchangeArticlePhotoUrl: article.photoUrl ?? '',
      );
      messages.add(msg);
    } catch (e) {
      Get.snackbar('Erreur', "Impossible d'envoyer la proposition");
    } finally {
      isSending.value = false;
    }
  }

  Future<void> _initFromArticle(Article article) async {
    isLoading.value = true;
    try {
      final conv = await repository.getOrCreateConversation(
        otherUserId: article.donorId,
        otherUserName: article.donorName,
        otherUserPhotoUrl: article.donorPhotoUrl,
        articleId: article.id,
        articleName: article.name,
        articlePhotoUrl: article.photoUrl ?? '',
      );
      conversation.value = conv;
      messages.value = List<Message>.from(conv.messages);
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible d\'ouvrir la conversation');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty || conversation.value == null) return;

    isSending.value = true;
    try {
      final msg = await repository.sendMessage(
        conversationId: conversation.value!.id,
        content: content.trim(),
      );
      messages.add(msg);
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible d\'envoyer le message');
    } finally {
      isSending.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
