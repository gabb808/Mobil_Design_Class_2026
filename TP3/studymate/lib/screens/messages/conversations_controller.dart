import 'package:get/get.dart';
import '../../core/models/conversation.dart';
import '../../core/repositories/neighbordrop_repository.dart';

class ConversationsController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  final conversations = <Conversation>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadConversations();
  }

  Future<void> loadConversations() async {
    isLoading.value = true;
    try {
      final convs = await repository.getConversations();
      conversations.value = convs;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les messages');
    } finally {
      isLoading.value = false;
    }
  }

  void openConversation(Conversation conversation) {
    Get.toNamed('/chat', arguments: conversation);
  }

  int get totalUnread =>
      conversations.fold(0, (sum, c) => sum + c.unreadCount);
}
