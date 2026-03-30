import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    'https://thumbs.dreamstime.com/b/golf-course-golf-bag-idyllic-forest-cart-summer-landscape-park-69200010.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_border_rounded,
                        size: 13,
                        color: AppColors.purplePrimary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '75%',
                        style: AppTextStyles.bodyInterMedium14.copyWith(
                          color: AppColors.purplePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Is 311', style: AppTextStyles.poppinsRegular14),
                Text(
                  'DATABASE SYSTEMS',
                  style: AppTextStyles.interRegular16.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.gray200),
                      ),
                      child: Text(
                        '3 Credits',
                        style: AppTextStyles.interRegular16.copyWith(
                          color: AppColors.gray900,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.chevron_right_rounded,
                      size: 22,
                      color: AppColors.gray600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
