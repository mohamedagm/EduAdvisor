import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/features/requests/models/prerequisite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrerequisiteItemTile extends StatelessWidget {
  final PrerequisiteCourseModel prerequisite;
  final double? studentGpa;

  const PrerequisiteItemTile({
    super.key,
    required this.prerequisite,
    required this.studentGpa,
  });

  @override
  Widget build(BuildContext context) {
    final String name = prerequisite.displayCourseName(
      Localizations.localeOf(context),
    );

    final bool wasTaken = studentGpa != null;

    return Padding(
      padding: EdgeInsets.only(bottom: 4.w),
      child: Row(
        children: [
          Icon(Icons.circle, size: 5.r, color: context.themeColors.warning),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              "${prerequisite.courseCode}: $name",
              style: TextStyle(
                color: context.themeColors.textSecondary,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _GpaBadge(gpa: studentGpa, wasTaken: wasTaken),
        ],
      ),
    );
  }
}

class _GpaBadge extends StatelessWidget {
  final double? gpa;
  final bool wasTaken;

  const _GpaBadge({required this.gpa, required this.wasTaken});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
      decoration: BoxDecoration(
        color: wasTaken
            ? context.colorScheme.surface
            : context.themeColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        wasTaken
            ? context.l10n.gpaValue(gpa.toString())
            : context.l10n.notTaken,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: wasTaken
              ? context.themeColors.textPrimary
              : context.themeColors.warning,
        ),
      ),
    );
  }
}
