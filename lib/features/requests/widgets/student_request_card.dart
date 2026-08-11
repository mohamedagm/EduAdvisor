import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/requests/manager/cubit/request_cubit.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/views/request_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class StudentRequestCard extends StatelessWidget {
  final StudentRequest request;

  const StudentRequestCard({super.key, required this.request});

  Color _getStatusColor(BuildContext context) {
    switch (request.status.toLowerCase()) {
      case 'approved':
        return context.themeColors.success;
      case 'pending':
        return context.themeColors.warning;
      case 'rejected':
        return context.colorScheme.error;
      default:
        return context.themeColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final avatarSize = constraints.maxWidth * 0.12; // 👈 responsive

        return GestureDetector(
          onTap: () {
            // 📌 بنمرر نفس instance بتاع RequestsCubit الموجودة فوق
            // (في AdvisorRequests) لشاشة التفاصيل، عشان لما نعمل approve
            // هناك، اللستة الرئيسية تتحدث تلقائيًا من غير ما نعمل fetch
            // تاني أو نرجع نضطر نـ refresh الشاشة يدويًا
            final requestsCubit = context.read<RequestsCubit>();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: requestsCubit,
                  child: RequestDetailsScreen(request: request),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.w),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: context.themeColors.card,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: context.themeColors.border),
            ),
            child: Row(
              children: [
                /// 👤 Avatar (Responsive)
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    color: context.themeColors.mutedSurface,
                    borderRadius: BorderRadius.circular(avatarSize * 0.25),
                  ),
                  child: Icon(
                    Icons.person,
                    size: avatarSize * 0.6,
                    color: context.themeColors.textMuted,
                  ),
                ),

                SizedBox(width: avatarSize * 0.3),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.studentName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.interRegular16.copyWith(
                          fontSize: 16.sp,
                          color: context.themeColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6.w),
                      Text(
                        '${request.semester} • ${request.major}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyInterRegular12.copyWith(
                          fontSize: 12.sp,
                          color: context.themeColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.w),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: avatarSize * 0.25,
                          vertical: avatarSize * 0.08,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          request.status,
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            fontSize: 12.sp,
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.chevron_right,
                  size: avatarSize * 0.6,
                  color: context.themeColors.textSecondary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
