import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CourseCatalogItem extends StatelessWidget {
  const CourseCatalogItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 24,
                          children: [
                            Text(
                              'IS312',
                              style: AppTextStyles.heading3PoppinsReg16
                                  .copyWith(color: AppColors.gray800),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF8E1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Medium',
                                style: AppTextStyles.bodyInterRegular12
                                    .copyWith(color: Color(0xFFD4A017)),
                              ),
                            ),
                          ],
                        ),

                        Text(
                          'Database Management System',
                          style: AppTextStyles.interRegular16.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),

                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.gray400,
                    ),
                  ],
                ),

                Row(
                  children: const [
                    Icon(
                      Icons.menu_book_outlined,
                      size: 16,
                      color: Color(0xFF9E9E9E),
                    ),
                    SizedBox(width: 4),
                    Text('3 Credits', style: AppTextStyles.bodyInterMedium14),
                    SizedBox(width: 16),
                    Icon(
                      Icons.star_border_rounded,
                      size: 16,
                      color: Color(0xFFD4A017),
                    ),
                    SizedBox(width: 4),
                    Text('Recommended', style: AppTextStyles.bodyInterMedium14),
                  ],
                ),

                Wrap(
                  spacing: 8,
                  children: List.generate(
                    2,
                    (index) => index == 0
                        ? _Tag(label: 'Data Science')
                        : _Tag(label: 'SoftWare'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodyInterRegular12.copyWith(
          color: AppColors.gray900,
        ),
      ),
    );
  }
}
