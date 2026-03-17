import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/repositories/neighbordrop_repository.dart';

class MyArticlesController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  final articles = <Article>[].obs;
  final isLoading = false.obs;

  // L'utilisateur courant est Marie (id='2')
  static const String _currentUserId = '2';

  @override
  void onInit() {
    super.onInit();
    loadMyArticles();
  }

  Future<void> loadMyArticles() async {
    isLoading.value = true;
    try {
      final result = await repository.getArticlesByUser(_currentUserId);
      articles.value = result;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger vos articles');
    } finally {
      isLoading.value = false;
    }
  }

  void goToArticleDetail(Article article) {
    Get.toNamed('/article-detail', arguments: article);
  }

  void goBack() => Get.back();
}
