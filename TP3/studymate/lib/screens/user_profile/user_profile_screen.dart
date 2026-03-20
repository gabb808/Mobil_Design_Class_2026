import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import 'user_profile_controller.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({super.key});

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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: AppDimens.paddingM),
                  const Text('Impossible de charger le profil'),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header profile card
                Container(
                  color: AppColors.primary.withOpacity(0.1),
                  padding: EdgeInsets.all(AppDimens.paddingM),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      SizedBox(height: AppDimens.paddingM),
                      Text(
                        user.fullName,
                        style: AppTextStyles.heading1,
                      ),
                      SizedBox(height: AppDimens.paddingXS),
                      Text(
                        'Quartier: ${user.neighborhood}',
                        style: AppTextStyles.bodyMedium,
                      ),
                      SizedBox(height: AppDimens.paddingS),
                      Text(
                        user.bio,
                        style: AppTextStyles.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppDimens.paddingM),

                // Stats
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingM),
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

                SizedBox(height: AppDimens.paddingL),

                // Buttons
                if (controller.isCurrentUser.value)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingM),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
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
                        SizedBox(height: AppDimens.paddingS),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              padding: EdgeInsets.symmetric(
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
                        SizedBox(height: AppDimens.paddingL),
                      ],
                    ),
                  ),

                SizedBox(height: AppDimens.paddingL),

                // Info card
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingM),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(AppDimens.paddingM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informations',
                            style: AppTextStyles.heading2,
                          ),
                          SizedBox(height: AppDimens.paddingM),
                          _buildInfoRow(
                            'Code postal',
                            user.postalCode,
                          ),
                          _buildInfoRow(
                            'Quartier',
                            user.neighborhood,
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

                SizedBox(height: AppDimens.paddingL),
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
        SizedBox(height: AppDimens.paddingXS),
        Text(
          label,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.paddingS),
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
