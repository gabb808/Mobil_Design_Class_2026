import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';

class MyArticlesController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  final articles = <Article>[].obs;
  final isLoading = false.obs;

  // ID fixe pour les articles postés dans la session app
  static const String _sessionContributorId = 'session-contributor';

  @override
  void onInit() {
    super.onInit();
    loadMyArticles();
  }

  Future<void> loadMyArticles() async {
    isLoading.value = true;
    try {
      final result = await repository.getArticlesByUser(_sessionContributorId);
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
