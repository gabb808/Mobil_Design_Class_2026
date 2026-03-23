import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/repositories/neighbordrop_repository.dart';
import '../../core/services/user_session_service.dart';
import 'package:flutter/material.dart';

class PostArticleController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();

  final nameController = TextEditingController();
  final sizeController = TextEditingController();
  final descriptionController = TextEditingController();
  final postalCodeController = TextEditingController(text: '75012');

  final selectedCategory = 'Vêtements'.obs;
  final selectedCondition = 'Bon état'.obs;
  final isLoading = false.obs;

  final categories = <String>[].obs;
  final conditions = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    categories.value = repository.categories;
    conditions.value = repository.conditions;
  }

  @override
  void onClose() {
    nameController.dispose();
    sizeController.dispose();
    descriptionController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }

  bool get isFormValid =>
      nameController.text.isNotEmpty &&
      sizeController.text.isNotEmpty &&
      descriptionController.text.isNotEmpty;

  Future<void> postArticle() async {
    if (!isFormValid) {
      Get.snackbar('Erreur', 'Veuillez remplir tous les champs');
      return;
    }

    isLoading.value = true;
    try {
      // Récupérer l'ID utilisateur depuis le service de session
      final userSessionService = Get.find<UserSessionService>();
      final userId = userSessionService.currentUserId;
      
      final article = Article(
        id: DateTime.now().toString(),
        name: nameController.text,
        category: selectedCategory.value,
        size: sizeController.text,
        description: descriptionController.text,
        condition: selectedCondition.value,
        photoUrl: null, // Photo optionnelle - pas obligatoire
        donorId: userId, // ID utilisateur cohérent
        donorName: 'Mon Profil',
        donorPhotoUrl: 'https://i.pravatar.cc/150?img=2',
        postalCode: postalCodeController.text,
        latitude: 48.8566,
        longitude: 2.3522,
        createdAt: DateTime.now(),
      );

      await repository.createArticle(article);
      Get.snackbar('Succès', 'Article posté avec succès!');
      // Nettoyer les champs
      nameController.clear();
      sizeController.clear();
      descriptionController.clear();
      postalCodeController.text = '75012';
      selectedCategory.value = 'Vêtements';
      selectedCondition.value = 'Bon état';
      Get.back();
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de poster l\'article: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
