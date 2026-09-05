import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/features/requests/models/prerequisite_model.dart';
import 'package:edu_advisor/features/requests/widgets/prerequisite_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrerequisitesSection extends StatelessWidget {
  final List<PrerequisiteCourseModel> prerequisites;
  final Map<String, double> bestGpaPerCourse;

  const PrerequisitesSection({
    super.key,
    required this.prerequisites,
    required this.bestGpaPerCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: context.themeColors.warningContainer,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.prerequisites,
            style: TextStyle(
              color: context.themeColors.warning,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 6.w),
          ...prerequisites.map(
            (prereq) => PrerequisiteItemTile(
              prerequisite: prereq,
              studentGpa: bestGpaPerCourse[prereq.id],
            ),
          ),
        ],
      ),
    );
  }
}
