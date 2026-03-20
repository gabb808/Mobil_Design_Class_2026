import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../core/models/study_partner.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_dimens.dart';
import '../../shared/theme/app_text_styles.dart';

class PartnerCard extends StatelessWidget {
  final StudyPartner partner;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const PartnerCard({
    super.key,
    required this.partner,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimens.spaceBetweenCards),
        padding: const EdgeInsets.all(AppDimens.paddingStandard),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusCards),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Photo de profil
            CircleAvatar(
              radius: AppDimens.photoSizeList / 2,
              backgroundImage: NetworkImage(partner.photoUrl),
              backgroundColor: AppColors.divider,
            ),
            const SizedBox(width: 12),
            // Infos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(partner.fullName, style: AppTextStyles.cardTitle),
                  const SizedBox(height: 2),
                  Text(partner.mainSubject, style: AppTextStyles.body),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: partner.averageRating,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColors.secondary,
                        ),
                        itemCount: 5,
                        itemSize: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${partner.averageRating}) ${partner.reviewCount} avis',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Dispo: ${partner.nextAvailability}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Favoris
            GestureDetector(
              onTap: onFavoriteTap,
              child: Icon(
                partner.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: partner.isFavorite ? AppColors.error : AppColors.textSecondary,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

