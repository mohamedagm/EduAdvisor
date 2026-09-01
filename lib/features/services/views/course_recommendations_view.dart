import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/services/data/models/recommendation_data_model.dart';
import 'package:edu_advisor/features/services/data/models/suggested_course_model.dart';
import 'package:edu_advisor/features/services/data/repo/recommendation_repo.dart';
import 'package:edu_advisor/features/services/manager/recommendation_cubit/recommendation_cubit.dart';
import 'package:edu_advisor/features/services/manager/recommendation_cubit/recommendation_state.dart';
import 'package:edu_advisor/features/services/views/widgets/service_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseRecommendationsView extends StatelessWidget {
  const CourseRecommendationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RecommendationCubit(repo: getIt<RecommendationRepo>())
            ..getRecommendations(),
      child: const _RecommendationsBody(),
    );
  }
}

class _RecommendationsBody extends StatelessWidget {
  const _RecommendationsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: ServiceAppBar(
        title: context.l10n.courseRecommendationsTitle,
        subtitle: context.l10n.aiPoweredSuggestionsForYou,
      ),
      body: BlocBuilder<RecommendationCubit, RecommendationState>(
        builder: (context, state) {
          if (state is RecommendationLoading ||
              state is RecommendationInitial) {
            return const _RecommendationsShimmer();
          }

          if (state is RecommendationFailure) {
            return _RecommendationsError(message: state.failure.message);
          }

          if (state is RecommendationLoaded) {
            return _RecommendationsContent(data: state.data);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _RecommendationsContent extends StatelessWidget {
  const _RecommendationsContent({required this.data});

  final RecommendationDataModel data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AiHeroHeader(),
          SizedBox(height: 20.w),
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  icon: Icons.schedule,
                  color: context.themeColors.info,
                  bgColor: context.themeColors.infoContainer,
                  value: '${data.totalCreditHours}',
                  label: context.l10n.totalSelectedHours,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _SummaryCard(
                  icon: Icons.balance,
                  color: context.themeColors.warning,
                  bgColor: context.themeColors.warningContainer,
                  value: '${data.maxAllowedHours}',
                  label: context.l10n.maxAllowedHoursLabel,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.recommendedCourses,
                style: AppTextStyles.heading1_20b.copyWith(
                  fontSize: 16.sp,
                  color: context.themeColors.textPrimary,
                ),
              ),
              Text(
                context.l10n.recommendedCoursesCount(
                  data.suggestedCourses.length,
                ),
                style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                  color: context.themeColors.textMuted,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          if (data.suggestedCourses.isEmpty)
            const _EmptyRecommendations()
          else
            ...data.suggestedCourses.map(
              (course) => Padding(
                padding: EdgeInsets.only(bottom: 16.w),
                child: _RecommendedCourseCard(course: course),
              ),
            ),
          SizedBox(height: 16.w),
        ],
      ),
    );
  }
}

class _AiHeroHeader extends StatelessWidget {
  const _AiHeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.aiPurple,
            AppColors.purplePrimary,
            AppColors.bluePrimary,
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.aiPurple.withValues(alpha: 0.25),
            blurRadius: 18.r,
            offset: Offset(0, 6.r),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: AppColors.white,
                  size: 26.r,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.aiRecommendationHeaderTitle,
                      style: AppTextStyles.heading3PoppinsReg16.responsive
                          .copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      context.l10n.basedOnAcademicProfile,
                      style: AppTextStyles.bodyInterRegular12.responsive
                          .copyWith(color: AppColors.white.withValues(alpha: 0.9)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          Text(
            context.l10n.aiRecommendationHeaderSubtitle,
            style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
              color: AppColors.white.withValues(alpha: 0.92),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final Color bgColor;
  final String value;
  final String label;

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
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20.r),
          ),
          SizedBox(height: 12.w),
          Text(
            value,
            style: AppTextStyles.heading2PoppinsSb18.responsive.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.w),
          Text(
            label,
            style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
              color: context.themeColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendedCourseCard extends StatelessWidget {
  const _RecommendedCourseCard({required this.course});

  final SuggestedCourseModel course;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46.r,
                height: 46.r,
                decoration: BoxDecoration(
                  color: context.themeColors.purpleContainer,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.menu_book_outlined,
                  color: AppColors.aiPurple,
                  size: 26.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.code,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading1_20b.copyWith(
                        fontSize: 16.sp,
                        color: context.themeColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      course.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.poppinsRegular14.responsive
                          .copyWith(color: context.themeColors.textMuted),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              _AdvisorScoreBadge(score: course.advisorScore),
            ],
          ),
          SizedBox(height: 16.w),
          Divider(height: 1.w, color: context.themeColors.border),
          SizedBox(height: 12.w),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16.r,
                color: context.themeColors.textMuted,
              ),
              SizedBox(width: 6.w),
              Text(
                '${course.hours} ${context.l10n.creditHoursLabel}',
                style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdvisorScoreBadge extends StatelessWidget {
  const _AdvisorScoreBadge({required this.score});

  final num score;

  int get _percent {
    if (score <= 1) {
      return (score * 100).round();
    }
    return score.round();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
      decoration: BoxDecoration(
        color: context.themeColors.purpleContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rounded, color: AppColors.aiPurple, size: 16.r),
              SizedBox(width: 2.w),
              Text(
                '$_percent%',
                style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                  color: AppColors.aiPurple,
                ),
              ),
            ],
          ),
          Text(
            context.l10n.advisorScore,
            style: AppTextStyles.bodyInterRegular12.copyWith(
              fontSize: 10.sp,
              color: context.themeColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyRecommendations extends StatelessWidget {
  const _EmptyRecommendations();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        children: [
          Icon(
            Icons.sentiment_satisfied_alt_outlined,
            size: 40.r,
            color: context.themeColors.textMuted,
          ),
          SizedBox(height: 12.w),
          Text(
            context.l10n.noRecommendationsTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.w),
          Text(
            context.l10n.noRecommendationsDescription,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
              color: context.themeColors.textMuted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendationsShimmer extends StatelessWidget {
  const _RecommendationsShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      physics: const NeverScrollableScrollPhysics(),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppShimmerBox(height: 132.w, borderRadius: 20.r),
            SizedBox(height: 20.w),
            Row(
              children: [
                Expanded(
                  child: AppShimmerBox(height: 110.w, borderRadius: 16.r),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppShimmerBox(height: 110.w, borderRadius: 16.r),
                ),
              ],
            ),
            SizedBox(height: 24.w),
            AppShimmerBox(width: 140.w, height: 18.w),
            SizedBox(height: 16.w),
            const _SkeletonCard(),
            SizedBox(height: 16.w),
            const _SkeletonCard(),
          ],
        ),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

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
              AppShimmerBox(width: 46.r, height: 46.r, borderRadius: 12.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBox(width: 96.w, height: 16.w),
                    SizedBox(height: 8.w),
                    AppShimmerBox(width: 180.w, height: 14.w),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          Divider(height: 1.w, color: context.themeColors.border),
          SizedBox(height: 12.w),
          AppShimmerBox(width: 100.w, height: 14.w),
        ],
      ),
    );
  }
}

class _RecommendationsError extends StatelessWidget {
  const _RecommendationsError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 40.r,
              color: context.colorScheme.error,
            ),
            SizedBox(height: 12.w),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
            SizedBox(height: 12.w),
            TextButton(
              onPressed: context
                  .read<RecommendationCubit>()
                  .getRecommendations,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
