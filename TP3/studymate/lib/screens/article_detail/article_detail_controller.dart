import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/models/proposition.dart';
import '../../core/repositories/neighbordrop_repository.dart';

class ArticleDetailController extends GetxController {
  final NeighbordropRepository repository = NeighbordropRepository();
  
  final article = Rxn<Article>();
  final propositions = <Proposition>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final Article? arg = Get.arguments;
    if (arg != null) {
      article.value = arg;
      loadPropositions();
    }
  }

  Future<void> loadPropositions() async {
    if (article.value == null) return;
    
    isLoading.value = true;
    try {
      final props = await repository.getPropositionsForArticle(article.value!.id);
      propositions.value = props;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les propositions');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> showExchangeProposals(BuildContext context) async {
    final myUser = await repository.getCurrentUser();
    if (myUser == null) return;
    
    final myArticles = await repository.getArticlesByUser(myUser.id);
    if (myArticles.isEmpty) {
      Get.snackbar('Oups', "Vous n'avez pas d'articles à échanger.");
      return;
    }

    Get.bottomSheet(
      Container(
        color: const Color(0xFFFFFFFF),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Proposer un échange', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: myArticles.length,
                itemBuilder: (ctx, idx) {
                  final myArticle = myArticles[idx];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(myArticle.photoUrl, width: 50, height: 50, fit: BoxFit.cover),
                    ),
                    title: Text(myArticle.name),
                    subtitle: Text(myArticle.category),
                    onTap: () {
                      Get.back();
                      _sendExchangeProposal(myArticle);
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

  Future<void> _sendExchangeProposal(Article myArticle) async {
    if (article.value == null) return;
    
    isLoading.value = true;
    try {
      final conv = await repository.getOrCreateConversation(
        otherUserId: article.value!.donorId,
        otherUserName: article.value!.donorName,
        otherUserPhotoUrl: article.value!.donorPhotoUrl,
        articleId: article.value!.id,
        articleName: article.value!.name,
        articlePhotoUrl: article.value!.photoUrl,
      );

      await repository.sendMessage(
        conversationId: conv.id,
        content: "Je vous propose cet article en échange. Êtes-vous intéressé(e) ?",
        isExchangeProposal: true,
        exchangeArticleId: myArticle.id,
        exchangeArticleName: myArticle.name,
        exchangeArticlePhotoUrl: myArticle.photoUrl,
      );

      Get.snackbar('Succès', 'Proposition envoyée avec succès !');
      // Redirect to conversation screen to view it
      Get.toNamed('/messages', arguments: conv);
    } catch (e) {
      Get.snackbar('Erreur', "Impossible d'envoyer la proposition");
    } finally {
      isLoading.value = false;
    }
  }

  void contactVoisin() {
    Get.toNamed('/messages', arguments: article.value);
  }

  void goBack() {
    Get.back();
  }
}
