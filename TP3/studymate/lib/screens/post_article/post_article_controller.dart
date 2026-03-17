import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../core/repositories/neighbordrop_repository.dart';
import 'package:flutter/material.dart';

class PostArticleController extends GetxController {
  final NeighbordropRepository repository = NeighbordropRepository();

  final nameController = TextEditingController();
  final sizeController = TextEditingController();
  final descriptionController = TextEditingController();
  final postalCodeController = TextEditingController(text: '75012');

  final selectedCategory = 'Vetements'.obs;
  final selectedCondition = 'Bon etat'.obs;
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
      final article = Article(
        id: DateTime.now().toString(),
        name: nameController.text,
        category: selectedCategory.value,
        size: sizeController.text,
        weight: sizeController.text,
        description: descriptionController.text,
        condition: selectedCondition.value,
        photoUrl:
            'https://images.unsplash.com/photo-1595508149631-5ea98db5ae5b?w=400',
        donorId: 'current-user',
        donorName: 'Mon Profil',
        donorPhotoUrl: 'https://i.pravatar.cc/150?img=2',
        postalCode: postalCodeController.text,
        neighborhood: 'Bercy',
        createdAt: DateTime.now(),
      );

      await repository.createArticle(article);
      Get.snackbar('Succes', 'Article poste avec succes!');
      Get.back();
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de poster l\'article');
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
