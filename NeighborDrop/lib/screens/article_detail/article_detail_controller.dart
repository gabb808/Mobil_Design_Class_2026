import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';
import '../../core/services/user_session_service.dart';

class ArticleDetailController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();
  final UserSessionService userSessionService = Get.find<UserSessionService>();
  
  final article = Rxn<Article>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final Article? arg = Get.arguments;
    if (arg != null) {
      article.value = arg;
    }
  }

  Future<void> contactVoisin() async {
    if (article.value == null) return;
    
    try {
      isLoading.value = true;
      final conv = await repository.getOrCreateConversation(
        otherUserId: article.value!.donorId,
        otherUserName: 'Voisin',
        otherUserPhotoUrl: '',
        articleId: article.value!.id,
        articleName: article.value!.name,
        articlePhotoUrl: article.value!.photoUrl ?? '',
      );
      Get.toNamed('/messages', arguments: {'conversationId': conv.id});
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de démarrer la conversation');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> proposeExchange() async {
    if (article.value == null) return;
    
    try {
      isLoading.value = true;
      final conv = await repository.getOrCreateConversation(
        otherUserId: article.value!.donorId,
        otherUserName: 'Voisin',
        otherUserPhotoUrl: '',
        articleId: article.value!.id,
        articleName: article.value!.name,
        articlePhotoUrl: article.value!.photoUrl ?? '',
      );
      // Go to messages and indicate it's for exchange
      Get.toNamed('/messages', arguments: {'conversationId': conv.id, 'isExchange': true});
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de créer la proposition');
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
