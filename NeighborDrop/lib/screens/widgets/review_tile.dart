import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../core/models/review.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_text_styles.dart';

class ReviewTile extends StatelessWidget {
  final Review review;

  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RatingBarIndicator(
                rating: review.rating,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColors.secondary,
                ),
                itemCount: 5,
                itemSize: 14,
              ),
              const SizedBox(width: 8),
              Text(review.authorName, style: AppTextStyles.label),
              const Spacer(),
              Text(review.timeAgo, style: AppTextStyles.bodySmall),
            ],
          ),
          const SizedBox(height: 4),
          Text(review.comment, style: AppTextStyles.body),
          const SizedBox(height: 8),
          const Divider(color: AppColors.divider, height: 1),
        ],
      ),
    );
  }
}
