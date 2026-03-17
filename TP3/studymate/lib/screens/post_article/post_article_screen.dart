import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import 'post_article_controller.dart';

class PostArticleScreen extends GetView<PostArticleController> {
  const PostArticleScreen({super.key});

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
          'Poster un article',
          style: AppTextStyles.heading2.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              _buildLabel('Nom'),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  hintText: 'Ex: VTT Orange',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: AppDimens.paddingM),

              // Category dropdown
              _buildLabel('Categorie'),
              Obx(
                () => DropdownButtonFormField(
                  value: controller.selectedCategory.value,
                  items: controller.categories.map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) controller.selectedCategory.value = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimens.paddingM),

              // Size field
              _buildLabel('Taille/Poids'),
              TextField(
                controller: controller.sizeController,
                decoration: InputDecoration(
                  hintText: 'Ex: 25kg, Taille M',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: AppDimens.paddingM),

              // Condition dropdown
              _buildLabel('Etat'),
              Obx(
                () => DropdownButtonFormField(
                  value: controller.selectedCondition.value,
                  items: controller.conditions.map((cond) {
                    return DropdownMenuItem(value: cond, child: Text(cond));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) controller.selectedCondition.value = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimens.paddingM),

              // Description field
              _buildLabel('Description'),
              TextField(
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Decrivez votre article...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: AppDimens.paddingM),

              // Photo button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                ),
                icon: const Icon(Icons.image, color: Colors.black),
                label: const Text(
                  'Ajouter une photo',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Get.snackbar('Info', 'Fonctionnalite non implementee (MVP)');
                },
              ),
              SizedBox(height: AppDimens.paddingM),

              // Postal code field
              _buildLabel('Code postal'),
              TextField(
                controller: controller.postalCodeController,
                decoration: InputDecoration(
                  hintText: '75012',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: AppDimens.paddingL),

              // Post button
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimens.paddingM,
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.postArticle(),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Poster',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.paddingS),
      child: Text(
        label,
        style: AppTextStyles.bodyLarge,
      ),
    );
  }
}
