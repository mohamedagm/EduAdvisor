import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCatalogShimmer extends StatelessWidget {
  const CourseCatalogShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(height: 12.w),
        itemBuilder: (context, index) => const _CourseCatalogSkeletonCard(),
      ),
    );
  }
}

class CourseCatalogLoadMoreShimmer extends StatelessWidget {
  const CourseCatalogLoadMoreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: const AppShimmer(child: _CourseCatalogSkeletonCard()),
    );
  }
}

class _CourseCatalogSkeletonCard extends StatelessWidget {
  const _CourseCatalogSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppShimmerBox(width: 72.w, height: 18.w),
              SizedBox(width: 24.w),
              AppShimmerBox(width: 58.w, height: 22.w, borderRadius: 12.r),
            ],
          ),
          SizedBox(height: 10.w),
          AppShimmerBox(width: 190.w, height: 14.w),
          SizedBox(height: 16.w),
          Row(
            children: [
              AppShimmerBox(width: 92.w, height: 14.w),
              SizedBox(width: 20.w),
              AppShimmerBox(width: 72.w, height: 14.w),
            ],
          ),
          SizedBox(height: 14.w),
          Row(
            children: [
              AppShimmerBox(width: 88.w, height: 24.w, borderRadius: 12.r),
              SizedBox(width: 8.w),
              AppShimmerBox(width: 96.w, height: 24.w, borderRadius: 12.r),
            ],
          ),
        ],
      ),
    );
  }
}
