import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/models/conversation.dart';
import '../../core/models/message.dart';
import '../../core/repositories/neighbordrop_repository.dart';

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
      messages.value = List<Message>.from(arg.messages);
    } else if (arg is Article) {
      // Ouvert depuis "Contacter le voisin" sur une annonce
      _initFromArticle(arg);
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
        articlePhotoUrl: article.photoUrl,
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
