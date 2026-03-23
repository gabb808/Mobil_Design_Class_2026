import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';

class MyFavoritesController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  final articles = <Article>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMyFavorites();
    ever(repository.favoriteArticleIds, (_) => loadMyFavorites());
  }

  void loadMyFavorites() {
    isLoading.value = true;
    try {
      final result = repository.getFavoriteArticles();
      articles.value = result;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger vos favoris');
    } finally {
      isLoading.value = false;
    }
  }

  void goToArticleDetail(Article article) {
    Get.toNamed('/article-detail', arguments: article);
  }

  void goBack() => Get.back();
}
