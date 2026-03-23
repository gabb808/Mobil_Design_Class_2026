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
      final convId = await repository.getOrCreateConversation(
        userSessionService.currentUserId,
        article.value!.donorId,
      );
      Get.toNamed('/messages', arguments: {'conversationId': convId});
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de démarrer la conversation');
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
