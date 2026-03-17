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

          return SingleChildScrollView(
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
                  padding: EdgeInsets.all(AppDimens.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and category
                      Text(
                        article.name,
                        style: AppTextStyles.heading1,
                      ),
                      SizedBox(height: AppDimens.paddingS),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimens.paddingS,
                              vertical: AppDimens.paddingXS,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              article.category,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                          SizedBox(width: AppDimens.paddingS),
                          Chip(label: Text(article.weight)),
                          SizedBox(width: AppDimens.paddingS),
                          Chip(label: Text(article.condition)),
                        ],
                      ),

                      SizedBox(height: AppDimens.paddingM),

                      // Description
                      Text(
                        'Description',
                        style: AppTextStyles.heading2,
                      ),
                      SizedBox(height: AppDimens.paddingS),
                      Text(
                        article.description,
                        style: AppTextStyles.bodyMedium,
                      ),

                      SizedBox(height: AppDimens.paddingL),

                      // Donor card
                      Text(
                        'Donateur',
                        style: AppTextStyles.heading2,
                      ),
                      SizedBox(height: AppDimens.paddingM),

                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(AppDimens.paddingM),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  article.donorPhotoUrl,
                                ),
                              ),
                              SizedBox(width: AppDimens.paddingM),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.donorName,
                                      style: AppTextStyles.bodyLarge,
                                    ),
                                    Text(
                                      'Quartier: ${article.neighborhood}',
                                      style: AppTextStyles.bodySmall,
                                    ),
                                    SizedBox(height: AppDimens.paddingXS),
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

                      SizedBox(height: AppDimens.paddingL),

                      // Buttons
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(
                              vertical: AppDimens.paddingM,
                            ),
                          ),
                          onPressed: () => _showPropositionDialog(context),
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
                      SizedBox(height: AppDimens.paddingS),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            padding: EdgeInsets.symmetric(
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
          );
        },
      ),
    );
  }

  void _showPropositionDialog(BuildContext context) {
    final messageController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Proposer un echange'),
        content: TextField(
          controller: messageController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Votre message...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            onPressed: () {
              if (messageController.text.isNotEmpty) {
                controller.sendProposition(messageController.text);
                Get.back();
              }
            },
            child: const Text(
              'Envoyer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
