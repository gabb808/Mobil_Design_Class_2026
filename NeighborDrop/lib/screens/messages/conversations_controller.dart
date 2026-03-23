import 'package:get/get.dart';
import '../../core/models/conversation.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';
import '../../core/services/user_session_service.dart';

class ConversationsController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();
  final UserSessionService userSessionService = Get.find<UserSessionService>();

  final conversations = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final totalUnread = 0.obs;  // Observable instead of getter

  @override
  void onInit() {
    super.onInit();
    loadConversations();
  }

  Future<void> loadConversations() async {
    isLoading.value = true;
    try {
      final convs = await repository.getConversations();
      conversations.value = convs
          .map((c) => {
            'id': c.id,
            'otherUserId': c.otherUserId,
            'otherUserName': c.otherUserName,
            'otherUserPhotoUrl': c.otherUserPhotoUrl,
            'articleId': c.articleId,
            'articleName': c.articleName,
            'articlePhotoUrl': c.articlePhotoUrl,
            'updatedAt': c.updatedAt,
          })
          .toList();
      // Update totalUnread count
      totalUnread.value = 0; // In future, calculate from conversations
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les messages');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openConversation(Map<String, dynamic> conversation) async {
    await Get.toNamed('/messages', arguments: conversation);
    loadConversations();
  }
}
