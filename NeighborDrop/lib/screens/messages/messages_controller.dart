import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';
import '../../core/services/user_session_service.dart';

class MessagesController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();
  final UserSessionService userSessionService = Get.find<UserSessionService>();

  final conversationId = Rxn<String>();
  final messages = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final isSending = false.obs;
  final messageText = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    
    final arg = Get.arguments;
    if (arg is Map && arg.containsKey('conversationId')) {
      conversationId.value = arg['conversationId'];
      _loadMessages();
    } else if (arg is Article) {
      _initFromArticle(arg);
    }
  }

  Future<void> _loadMessages() async {
    if (conversationId.value == null) return;
    
    try {
      isLoading.value = true;
      // Messages are loaded from getConversations()
      final convs = await repository.getConversations();
      var messages_data = <Map<String, dynamic>>[];
      for (var conv in convs) {
        if (conv.id == conversationId.value) {
          messages_data = conv.messages?.map((m) => {'content': m.content, 'senderId': m.senderId}).toList() ?? [];
          break;
        }
      }
      messages.value = messages_data;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les messages');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _initFromArticle(Article article) async {
    isLoading.value = true;
    try {
      final conv = await repository.getOrCreateConversation(
        otherUserId: article.donorId,
        otherUserName: 'Voisin',
        otherUserPhotoUrl: '',
        articleId: article.id,
        articleName: article.name,
        articlePhotoUrl: article.photoUrl ?? '',
      );
      conversationId.value = conv.id;
      await _loadMessages();
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible d\'ouvrir la conversation');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    if (messageText.text.trim().isEmpty || conversationId.value == null) return;

    isSending.value = true;
    try {
      await repository.sendMessage(
        conversationId: conversationId.value!,
        content: messageText.text.trim(),
      );
      messageText.clear();
      await _loadMessages();
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible d\'envoyer le message');
    } finally {
      isSending.value = false;
    }
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    messageText.dispose();
    super.onClose();
  }
}
