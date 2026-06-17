import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentRequestCard extends StatelessWidget {
  final StudentRequest request;

  const StudentRequestCard({super.key, required this.request});

  Color _getStatusColor() {
    switch (request.status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return AppColors.warningAmberDark;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return LayoutBuilder(
      builder: (context, constraints) {
        final avatarSize = constraints.maxWidth * 0.12; // 👈 responsive

        return GestureDetector(
          onTap: () {
            context.push(AppRoutes.requestDetails, extra: request);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.gray200),
            ),
            child: Row(
              children: [
                /// 👤 Avatar (Responsive)
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(avatarSize * 0.25),
                  ),
                  child: Icon(
                    Icons.person,
                    size: avatarSize * 0.6,
                    color: Colors.grey,
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
                          color: AppColors.gray800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${request.semester} • ${request.major}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyInterRegular12.copyWith(
                          color: AppColors.gray600,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: avatarSize * 0.25,
                          vertical: avatarSize * 0.08,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          request.status,
                          style: AppTextStyles.bodyInterRegular12.copyWith(
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
                  color: AppColors.gray600,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
