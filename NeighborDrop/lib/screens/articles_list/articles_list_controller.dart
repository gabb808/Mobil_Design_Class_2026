import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';

class ArticlesListController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();
  
  final articles = <Article>[].obs;
  final isLoading = false.obs;
  final isSearchActive = false.obs;
  final searchQuery = ''.obs;
  final selectedCategory = 'Tous'.obs;
  final searchRadiusKm = 5.0.obs;
  final categories = [
    'Tous',
    'Vetements',
    'Livres',
    'Electromenager',
    'Meuble',
    'Jouets',
    'Sports',
    'Autres',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadArticles();
  }

  Future<void> loadArticles() async {
    isLoading.value = true;
    try {
      final List<Article> result;
      
      if (selectedCategory.value == 'Tous') {
        result = await repository.getAllArticles();
      } else {
        result = await repository.filterByCategory(selectedCategory.value);
      }
      
      // Filter by search query if present
      if (searchQuery.value.isNotEmpty) {
        articles.value = result
            .where((a) => a.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
                    a.description.toLowerCase().contains(searchQuery.value.toLowerCase()))
            .toList();
      } else {
        articles.value = result;
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les articles');
    } finally {
      isLoading.value = false;
    }
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    loadArticles();
  }

  void changeSearchRadius(double radius) {
    searchRadiusKm.value = radius;
    loadArticles();
  }

  void toggleSearch() {
    isSearchActive.value = !isSearchActive.value;
    if (!isSearchActive.value) {
      searchQuery.value = '';
      loadArticles();
    }
  }

  void onChangeSearch(String query) {
    searchQuery.value = query;
    loadArticles();
  }

  void goToArticleDetail(Article article) {
    Get.toNamed('/article-detail', arguments: article);
  }

  void goToPostArticle() {
    Get.toNamed('/post-article');
  }

  void goToProfile() {
    Get.toNamed('/profile');
  }
}
