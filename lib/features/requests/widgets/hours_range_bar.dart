import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HoursRangeBar extends StatelessWidget {
  const HoursRangeBar({
    super.key,
    required this.withinRange,
    required this.minHours,
    required this.maxHours,
  });

  final bool withinRange;
  final int minHours;
  final int maxHours;

  @override
  Widget build(BuildContext context) {
    final Color color = withinRange
        ? context.themeColors.success
        : context.colorScheme.error;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            withinRange
                ? Icons.check_circle_outline_rounded
                : Icons.warning_amber_rounded,
            size: 15.r,
            color: color,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              withinRange
                  ? context.l10n.withinAllowedRange(minHours, maxHours)
                  : context.l10n.hoursExceedRange(minHours, maxHours),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
