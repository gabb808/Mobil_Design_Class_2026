import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/article.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import 'articles_list_controller.dart';

class ArticlesListScreen extends GetView<ArticlesListController> {
  const ArticlesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Obx(() => controller.isSearchActive.value
            ? TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Rechercher (ex: vélo, livre...)',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: controller.onChangeSearch,
              )
            : Text(
                'NeighborDrop',
                style: AppTextStyles.heading1.copyWith(color: Colors.white),
              )),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isSearchActive.value ? Icons.close : Icons.search,
                  color: Colors.white,
                ),
                onPressed: controller.toggleSearch,
              )),
        ],
      ),
      body: Column(
        children: [
          // Postal code selector
          Padding(
            padding: EdgeInsets.all(AppDimens.paddingM),
            child: DropdownButton<String>(
              isExpanded: true,
              value: controller.selectedPostalCode.value,
              items: ['75012', '75013', '75014', '75015'].map((code) {
                return DropdownMenuItem(
                  value: code,
                  child: Text('Mon quartier: $code'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.changePostalCode(value);
              },
            ),
          ),

          // Category filter chips
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingM),
                child: Wrap(
                  spacing: AppDimens.paddingS,
                  children: controller.categories.map((category) {
                    return FilterChip(
                      label: Text(category),
                      selected: controller.selectedCategory.value == category,
                      onSelected: (_) => controller.filterByCategory(category),
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: controller.selectedCategory.value == category
                            ? Colors.white
                            : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // Articles list
          Expanded(
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                        SizedBox(height: AppDimens.paddingM),
                        Text(
                          'Chargement des articles...',
                          style: AppTextStyles.bodyLarge,
                        ),
                      ],
                    ),
                  );
                }

                if (controller.articles.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: AppDimens.paddingM),
                        Text(
                          'Aucun article pour l\'instant',
                          style: AppTextStyles.bodyLarge,
                        ),
                        SizedBox(height: AppDimens.paddingS),
                        Text(
                          'Revenez bientot ou elargissez votre recherche',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(AppDimens.paddingM),
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    return ArticleCard(
                      article: article,
                      onTap: () => controller.goToArticleDetail(article),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: null,
    );
  }
}

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(bottom: AppDimens.paddingM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.borderRadius),
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimens.borderRadius),
                bottomLeft: Radius.circular(AppDimens.borderRadius),
              ),
              child: Image.network(
                article.photoUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppDimens.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.name,
                      style: AppTextStyles.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppDimens.paddingXS),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimens.paddingXS,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            article.category,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                        SizedBox(width: AppDimens.paddingXS),
                        Text(
                          article.weight,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimens.paddingXS),
                    GestureDetector(
                      onTap: () => Get.toNamed('/profile', arguments: article.donorId),
                      child: Text(
                        article.donorName,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
