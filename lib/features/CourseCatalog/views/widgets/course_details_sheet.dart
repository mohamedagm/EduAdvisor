import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/tag.dart';
import 'package:flutter/material.dart';

class CourseDetailsSheet extends StatelessWidget {
  const CourseDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return SingleChildScrollView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 24,
                    children: [
                      Text(
                        'IS312',
                        style: AppTextStyles.heading3PoppinsReg16.copyWith(
                          color: AppColors.gray800,
                        ),
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
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: Color(0xFFD4A017),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gray100,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ),
                ],
              ),

              Text(
                'Database Management System',
                style: AppTextStyles.poppinsRegular14.copyWith(
                  color: AppColors.gray600,
                ),
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),

              _SectionTitle(
                icon: Icons.menu_book_outlined,
                label: 'Description',
              ),

              const SizedBox(height: 6),

              Text(
                'Database desing, SQL, and data management system.',
                style: AppTextStyles.interRegular16.copyWith(
                  color: AppColors.gray600,
                ),
              ),

              const SizedBox(height: 16),

              _SectionTitle(
                icon: Icons.star_border_rounded,
                label: 'Why It Matters',
                iconColor: Color(0xFFD4A017),
              ),

              const SizedBox(height: 6),

              Text(
                'Essential for backend development and data management.',
                style: AppTextStyles.interRegular16.copyWith(
                  color: AppColors.gray600,
                ),
              ),

              const SizedBox(height: 16),

              _SectionTitle(
                icon: Icons.trending_up,
                label: 'Career Opportunities',
                iconColor: Color(0xFF43A047),
              ),

              const SizedBox(height: 6),

              Text(
                'Database Administrator, Backend Developer And Data Engineer',
                style: AppTextStyles.interRegular16.copyWith(
                  color: AppColors.gray600,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Specializations',
                style: AppTextStyles.heading3PoppinsReg16.copyWith(
                  color: AppColors.gray800,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: const [
                  Tag(label: 'Data Science'),
                  Tag(label: 'Software Development'),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),

              Row(
                children: const [
                  Expanded(
                    child: _InfoTile(title: 'Credits', value: '3'),
                  ),
                  Expanded(
                    child: _InfoTile(title: 'Difficulty', value: 'Medium'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _SectionTitle({
    required this.icon,
    required this.label,
    this.iconColor = const Color(0xFF9E9E9E),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 24, color: iconColor),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.heading3PoppinsReg16.copyWith(
            color: AppColors.gray800,
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyInterMedium18.copyWith(
            color: AppColors.gray800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.interRegular16.copyWith(
            color: AppColors.gray600,
          ),
        ),
      ],
    );
  }
}
