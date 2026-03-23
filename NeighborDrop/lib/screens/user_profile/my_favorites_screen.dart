import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import '../articles_list/articles_list_screen.dart'; // Pour rÃ©utiliser ArticleCard
import 'my_favorites_controller.dart';

class MyFavoritesScreen extends GetView<MyFavoritesController> {
  const MyFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => controller.goBack(),
        ),
        title: Text(
          'Mes favoris',
          style: AppTextStyles.heading2.copyWith(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (controller.articles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 72,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: AppDimens.paddingM),
                Text(
                  'Aucun favori',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppDimens.paddingS),
                Text(
                  'Vos articles likés \napparaîtront ici',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimens.paddingL),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: AppDimens.paddingM),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimens.borderRadiusButtons),
                    ),
                  ),
                  icon: const Icon(Icons.search, color: Colors.white),
                  label: const Text(
                    'Parcourir les annonces',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Get.offAllNamed('/'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async => controller.loadMyFavorites(),
          child: ListView.builder(
            padding: const EdgeInsets.all(AppDimens.paddingM),
            itemCount: controller.articles.length,
            itemBuilder: (context, index) {
              final article = controller.articles[index];
              return ArticleCard(
                article: article,
                onTap: () => controller.goToArticleDetail(article),
              );
            },
          ),
        );
      }),
    );
  }
}


