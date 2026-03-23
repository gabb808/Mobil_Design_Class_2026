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
      // Chercher si l'utilisateur existe déjà
      final existingUser = await repository.getUserByFirstName(pseudo);

      if (existingUser != null) {
        // Utilisateur existe → charger ses infos
        userSessionService.setCurrentUserId(existingUser.id);
        Get.snackbar('Succès', 'Bienvenue de retour ${existingUser.firstName}!');
        Get.offAllNamed('/');
        return;
      }

      // Nouvel utilisateur → créer avec un ID unique basé sur le pseudo
      final newUserId = pseudo.toLowerCase().replaceAll(' ', '_') + '_' + DateTime.now().millisecondsSinceEpoch.toString();
      
      final newUser = AppUser(
        id: newUserId,
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
      await repository.createUser(newUserId, newUser);
      
      // Mettre à jour la session
      userSessionService.setCurrentUserId(newUserId);

      // Rediriger vers l'accueil
      Get.snackbar('Succès', 'Profil créé avec succès!');
      Get.offAllNamed('/');
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de créer/charger le profil: $e');
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
