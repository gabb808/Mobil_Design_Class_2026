import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import '../widgets/review_tile.dart';
import '../widgets/availability_slot.dart';
import 'partner_detail_controller.dart';

class PartnerDetailScreen extends StatelessWidget {
  const PartnerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PartnerDetailController>();
    final String partnerId = Get.arguments as String;

    // Charger les donnees au premier build
    controller.loadPartnerDetail(partnerId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (controller.hasError.value || controller.partner.value == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                const SizedBox(height: 16),
                Text('Impossible de charger le profil', style: AppTextStyles.body),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => controller.loadPartnerDetail(partnerId),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  child: const Text('Reessayer'),
                ),
              ],
            ),
          );
        }

        final partner = controller.partner.value!;

        return CustomScrollView(
          slivers: [
            // App Bar avec photo
            SliverAppBar(
              expandedHeight: 260,
              pinned: true,
              backgroundColor: AppColors.primary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.surface),
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    partner.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: partner.isFavorite ? AppColors.error : AppColors.surface,
                  ),
                  onPressed: controller.toggleFavorite,
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.primary, AppColors.primaryLight],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      CircleAvatar(
                        radius: AppDimens.photoSizeDetail / 2,
                        backgroundImage: NetworkImage(partner.photoUrl),
                        backgroundColor: AppColors.divider,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        partner.fullName,
                        style: AppTextStyles.screenTitle.copyWith(color: AppColors.surface),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBarIndicator(
                            rating: partner.averageRating,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColors.secondary,
                            ),
                            itemCount: 5,
                            itemSize: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${partner.averageRating}) ${partner.reviewCount} avis',
                            style: AppTextStyles.body.copyWith(color: AppColors.surface.withValues(alpha: 0.8)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Contenu
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.paddingStandard),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bio
                    Text('Bio', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),
                    Text(partner.bio, style: AppTextStyles.body),
                    const SizedBox(height: AppDimens.sectionSpacing),

                    // Matieres
                    Text('Matieres maitrisees', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: partner.subjects.map((subject) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(AppDimens.borderRadiusChips),
                          ),
                          child: Text(
                            subject,
                            style: AppTextStyles.chipText.copyWith(color: AppColors.surface),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppDimens.sectionSpacing),

                    // Disponibilites
                    Text('Disponibilites cette semaine', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),
                    ...partner.availabilities.map(
                      (a) => AvailabilitySlot(availability: a),
                    ),
                    const SizedBox(height: AppDimens.sectionSpacing),

                    // Avis
                    Text(
                      'Avis (${controller.reviews.length})',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 8),
                    if (controller.reviews.isEmpty)
                      Text('Pas encore d\'avis', style: AppTextStyles.body)
                    else
                      ...controller.reviews.map((r) => ReviewTile(review: r)),

                    const SizedBox(height: 80), // Espace pour le bouton sticky
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      // Bouton sticky en bas
      bottomNavigationBar: Obx(() {
        if (controller.partner.value == null) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.all(AppDimens.paddingStandard),
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            height: AppDimens.buttonHeight,
            child: ElevatedButton(
              onPressed: () => Get.toNamed('/session-request', arguments: controller.partner.value),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.borderRadiusButtons),
                ),
              ),
              child: Text('Demander une session', style: AppTextStyles.buttonText),
            ),
          ),
        );
      }),
    );
  }
}

