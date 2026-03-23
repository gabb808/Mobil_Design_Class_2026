import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import 'registration_controller.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Bienvenue dans\nNeighborDrop',
                style: AppTextStyles.heading1,
              ),
              const SizedBox(height: AppDimens.paddingM),
              
              // Subtitle
              Text(
                'Entrez votre pseudo pour\ncommencer à échanger avec\nvos voisins',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimens.paddingXL),
              
              // Pseudo input
              TextField(
                controller: controller.pseudoController,
                decoration: InputDecoration(
                  hintText: 'Votre pseudo',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.person, color: AppColors.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimens.borderRadius),
                    borderSide: const BorderSide(color: AppColors.divider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimens.borderRadius),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingM,
                    vertical: AppDimens.paddingM,
                  ),
                ),
                style: AppTextStyles.bodyLarge,
              ),
              
              const SizedBox(height: AppDimens.paddingL),
              
              // Create profile button
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: AppDimens.buttonHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimens.borderRadius),
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.createProfile,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Créer mon profil',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                );
              }),
              
              const SizedBox(height: AppDimens.paddingM),
              
              // Info text
              Text(
                'Vous pourrez modifier votre profil\nà tout moment',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
