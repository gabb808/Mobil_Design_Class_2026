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

  Future<void> sendProposition(String message) async {
    if (article.value == null) return;

    final prop = Proposition(
      id: DateTime.now().toString(),
      articleId: article.value!.id,
      senderId: 'current-user', // Mock user
      senderName: 'Mon Profil',
      senderPhotoUrl: 'https://i.pravatar.cc/150?img=2',
      message: message,
      status: 'pending',
      createdAt: DateTime.now(),
    );

    isLoading.value = true;
    try {
      await repository.sendProposition(prop);
      propositions.add(prop);
      Get.snackbar('Succes', 'Proposition envoyee!');
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible d\'envoyer la proposition');
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
