import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import 'user_profile_controller.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  final String? tagOverride;
  const UserProfileScreen({super.key, this.tagOverride});

  @override
  String? get tag => tagOverride;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Obx(() => Text(
              controller.isCurrentUser.value ? 'Mon Profil' : 'Profil Voisin',
              style: AppTextStyles.heading2.copyWith(color: Colors.white),
            )),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          final user = controller.user.value;
          if (user == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: AppDimens.paddingM),
                  Text('Impossible de charger le profil'),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header profile card
                Container(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  padding: const EdgeInsets.all(AppDimens.paddingM),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      const SizedBox(height: AppDimens.paddingM),
                      Text(
                        user.fullName,
                        style: AppTextStyles.heading1,
                      ),
                      const SizedBox(height: AppDimens.paddingS),
                      Text(
                        user.bio,
                        style: AppTextStyles.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimens.paddingM),

                // Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingM),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard(
                        'Articles',
                        '${user.articlesPosted}',
                      ),
                      _buildStatCard(
                        'Echanges',
                        '${user.exchangesCompleted}',
                      ),
                      _buildStatCard(
                        'Note',
                        '${user.memberRating}',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimens.paddingL),

                // Buttons
                if (controller.isCurrentUser.value)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppDimens.paddingM),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppDimens.paddingM),
                            ),
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: const Text(
                              'Editer profil',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => controller.editProfile(),
                          ),
                        ),
                        const SizedBox(height: AppDimens.paddingS),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppDimens.paddingM),
                            ),
                            icon: const Icon(Icons.shopping_bag,
                                color: AppColors.primary),
                            label: const Text(
                              'Mes articles',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => controller.goToMyArticles(),
                          ),
                        ),
                        const SizedBox(height: AppDimens.paddingS),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppDimens.paddingM),
                            ),
                            icon: const Icon(Icons.favorite,
                                color: AppColors.primary),
                            label: const Text(
                              'Mes favoris',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => Get.toNamed('/my-favorites'),
                          ),
                        ),
                        const SizedBox(height: AppDimens.paddingL),
                      ],
                    ),
                  ),

                const SizedBox(height: AppDimens.paddingL),

                // Info card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingM),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.paddingM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informations',
                            style: AppTextStyles.heading2,
                          ),
                          const SizedBox(height: AppDimens.paddingM),
                          _buildInfoRow(
                            'Code postal',
                            user.postalCode,
                          ),
                          _buildInfoRow(
                            'Membre depuis',
                            '${user.memberSince} an(s)',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppDimens.paddingL),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppDimens.paddingXS),
        Text(
          label,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.paddingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

