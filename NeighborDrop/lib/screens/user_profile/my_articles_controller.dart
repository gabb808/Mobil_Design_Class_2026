import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/repositories/neighbordrop_repository.dart';
import '../../core/services/user_session_service.dart';

class MyArticlesController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  final articles = <Article>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMyArticles();
  }

  Future<void> loadMyArticles() async {
    isLoading.value = true;
    try {
      final userSessionService = Get.find<UserSessionService>();
      final currentUserId = userSessionService.currentUserId;
      final result = await repository.getArticlesByUser(currentUserId);
      articles.value = result;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger vos articles: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void goToArticleDetail(Article article) {
    Get.toNamed('/article-detail', arguments: article);
  }

  void goBack() => Get.back();
}
