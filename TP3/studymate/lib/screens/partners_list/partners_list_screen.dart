import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';
import '../widgets/partner_card.dart';
import '../widgets/subject_chip.dart';
import 'partners_list_controller.dart';

class PartnersListScreen extends StatelessWidget {
  const PartnersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PartnersListController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('StudyMate', style: AppTextStyles.screenTitle.copyWith(color: AppColors.surface)),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Barre de recherche
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(
              AppDimens.paddingStandard,
              0,
              AppDimens.paddingStandard,
              AppDimens.paddingStandard,
            ),
            child: TextField(
              onChanged: controller.search,
              style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Rechercher une matiere ou un nom...',
                hintStyle: AppTextStyles.body,
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimens.borderRadiusCards),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filtres par matiere
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Obx(() => ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingStandard),
              itemCount: controller.subjects.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final subject = controller.subjects[index];
                return SubjectChip(
                  label: subject,
                  isSelected: controller.selectedSubject.value == subject,
                  onTap: () => controller.filterBySubject(subject),
                );
              },
            )),
          ),

          // Liste des partenaires
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: AppColors.primary),
                      SizedBox(height: 16),
                      Text('Chargement des profils...'),
                    ],
                  ),
                );
              }

              if (controller.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                      const SizedBox(height: 16),
                      Text('Erreur lors du chargement', style: AppTextStyles.body),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: controller.fetchPartners,
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                        child: const Text('Reessayer'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.filteredList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person_search, size: 48, color: AppColors.textSecondary),
                      const SizedBox(height: 16),
                      Text(
                        'Aucun partenaire disponible\npour cette matiere',
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => controller.filterBySubject('Tous'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                        child: const Text('Voir toutes les matieres'),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.fetchPartners,
                color: AppColors.primary,
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppDimens.paddingStandard),
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) {
                    final partner = controller.filteredList[index];
                    return PartnerCard(
                      partner: partner,
                      onTap: () => Get.toNamed('/detail', arguments: partner.id),
                      onFavoriteTap: () => controller.toggleFavorite(partner.id),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
