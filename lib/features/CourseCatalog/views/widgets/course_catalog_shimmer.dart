import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class CourseCatalogShimmer extends StatelessWidget {
  const CourseCatalogShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => const _CourseCatalogSkeletonCard(),
      ),
    );
  }
}

class CourseCatalogLoadMoreShimmer extends StatelessWidget {
  const CourseCatalogLoadMoreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: AppShimmer(child: _CourseCatalogSkeletonCard()),
    );
  }
}

class _CourseCatalogSkeletonCard extends StatelessWidget {
  const _CourseCatalogSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.themeColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppShimmerBox(width: 72, height: 18),
              SizedBox(width: 24),
              AppShimmerBox(width: 58, height: 22, borderRadius: 12),
            ],
          ),
          SizedBox(height: 10),
          AppShimmerBox(width: 190, height: 14),
          SizedBox(height: 16),
          Row(
            children: [
              AppShimmerBox(width: 92, height: 14),
              SizedBox(width: 20),
              AppShimmerBox(width: 72, height: 14),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              AppShimmerBox(width: 88, height: 24, borderRadius: 12),
              SizedBox(width: 8),
              AppShimmerBox(width: 96, height: 24, borderRadius: 12),
            ],
          ),
        ],
      ),
    );
  }
}
