import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/repositories/neighbordrop_repository_firestore.dart';
import '../../core/services/user_session_service.dart';
import '../../shared/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserProfile();
  }

  Future<void> _checkUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final userSessionService = Get.find<UserSessionService>();
      final repository = Get.find<NeighbordropRepository>();

      // Vérifier si l'utilisateur existe dans Firestore
      final user = await repository.getUserById(userSessionService.currentUserId);

      if (user == null) {
        // Profil n'existe pas → Inscription
        Get.offAllNamed('/registration');
      } else {
        // Profil existe → Accueil
        Get.offAllNamed('/');
      }
    } catch (e) {
      // En cas d'erreur, aller à l'inscription
      Get.offAllNamed('/registration');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 80, color: Colors.white),
            const SizedBox(height: 16),
            const Text(
              'NeighborDrop',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
