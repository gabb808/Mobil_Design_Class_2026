import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import 'article_detail_controller.dart';

class ArticleDetailScreen extends GetView<ArticleDetailController> {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => controller.goBack(),
        ),
        title: Text(
          'Article',
          style: AppTextStyles.heading2.copyWith(color: Colors.white),
        ),
      ),
      body: Obx(
        () {
          if (controller.article.value == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          final article = controller.article.value!;

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main image
                Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.grey[300],
                  child: Image.network(
                    article.photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported,
                        size: 64,
                        color: Colors.grey[600],
                      );
                    },
                  ),
                ),

                // Article details
                Padding(
                  padding: const EdgeInsets.all(AppDimens.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and category
                      Text(
                        article.name,
                        style: AppTextStyles.heading1,
                      ),
                      const SizedBox(height: AppDimens.paddingS),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.paddingS,
                              vertical: AppDimens.paddingXS,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              article.category,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppDimens.paddingS),
                          Chip(label: Text(article.condition)),
                        ],
                      ),

                      const SizedBox(height: AppDimens.paddingM),

                      // Description
                      Text(
                        'Description',
                        style: AppTextStyles.heading2,
                      ),
                      const SizedBox(height: AppDimens.paddingS),
                      Text(
                        article.description,
                        style: AppTextStyles.bodyMedium,
                      ),

                      const SizedBox(height: AppDimens.paddingL),

                      // Donor card
                      Text(
                        'Annonceur',
                        style: AppTextStyles.heading2,
                      ),
                      const SizedBox(height: AppDimens.paddingM),

                      GestureDetector(
                        onTap: () => Get.toNamed('/profile', arguments: article.donorId),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AppDimens.paddingM),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    article.donorPhotoUrl,
                                  ),
                                ),
                                const SizedBox(width: AppDimens.paddingM),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.donorName,
                                        style: AppTextStyles.bodyLarge,
                                      ),
                                      const SizedBox(height: AppDimens.paddingXS),
                                      Text(
                                        'Membre depuis 2 ans',
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppDimens.paddingL),

                      // Buttons
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppDimens.paddingM,
                            ),
                          ),
                          onPressed: () => controller.showExchangeProposals(context),
                          child: const Text(
                            'Proposer un echange',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.paddingS),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(
                              vertical: AppDimens.paddingM,
                            ),
                          ),
                          onPressed: () => controller.contactVoisin(),
                          child: const Text(
                            'Contacter le voisin',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
