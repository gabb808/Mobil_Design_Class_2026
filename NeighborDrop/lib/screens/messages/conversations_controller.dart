import 'package:get/get.dart';
import '../../core/models/conversation.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';

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

  Future<void> openConversation(Conversation conversation) async {
    await Get.toNamed('/chat', arguments: conversation);
    loadConversations();
  }

  int get totalUnread =>
      conversations.fold(0, (sum, c) => sum + c.unreadCount);
}
