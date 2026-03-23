import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/app_user.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';
import '../../core/services/user_session_service.dart';

class RegistrationController extends GetxController {
  final NeighbordropRepository repository = Get.find<NeighbordropRepository>();
  final UserSessionService userSessionService = Get.find<UserSessionService>();

  final pseudoController = TextEditingController();
  final isLoading = false.obs;

  Future<void> createProfile() async {
    final pseudo = pseudoController.text.trim();

    if (pseudo.isEmpty) {
      Get.snackbar('Erreur', 'Veuillez entrer un pseudo');
      return;
    }

    if (pseudo.length < 2) {
      Get.snackbar('Erreur', 'Le pseudo doit contenir au moins 2 caractères');
      return;
    }

    isLoading.value = true;
    try {
      // Créer un nouvel utilisateur
      final newUser = AppUser(
        id: userSessionService.currentUserId,
        firstName: pseudo,
        lastName: '',
        photoUrl: 'https://via.placeholder.com/150',
        postalCode: '',
        latitude: 0.0,
        longitude: 0.0,
        bio: '',
        memberRating: 0.0,
        memberSince: DateTime.now().year,
        articlesPosted: 0,
        exchangesCompleted: 0,
      );

      // Sauvegarder dans Firestore
      await repository.createUser(userSessionService.currentUserId, newUser);

      // Rediriger vers l'accueil
      Get.offAllNamed('/');
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de créer le profil: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    pseudoController.dispose();
    super.onClose();
  }
}
