import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/departments_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/departments_state.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/signup_filed_label.dart';
import 'package:edu_advisor/features/auth/data/models/department_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class DepartmentDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final String? facultyId;

  const DepartmentDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
    this.facultyId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(text: context.l10n.department),
        SizedBox(height: 8.w),
        BlocBuilder<DepartmentsCubit, DepartmentsState>(
          builder: (context, state) {
            final departments = state is DepartmentsSuccess
                ? state.departments
                      .where(
                        (department) =>
                            facultyId == null ||
                            department.facultyId == facultyId,
                      )
                      .toList()
                : const <DepartmentModel>[];

            final hasFaculty = facultyId != null;
            final isEnabled =
                hasFaculty &&
                state is DepartmentsSuccess &&
                departments.isNotEmpty;
            final failureMessage = state is DepartmentsFailure && hasFaculty
                ? state.failure.message
                : null;

            final hintText = !hasFaculty
                ? context.l10n.selectFacultyFirst
                : state is DepartmentsLoading
                ? context.l10n.loading
                : context.l10n.selectDepartment;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: value,
                  isExpanded: true,
                  hint: Text(
                    hintText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.themeColors.mutedSurface.withValues(
                      alpha: isEnabled ? 1 : 0.55,
                    ),
                    prefixIcon: Icon(
                      Icons.business,
                      size: 20.r,
                      color: context.themeColors.textMuted,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.w,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: context.themeColors.textMuted,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: context.themeColors.mutedSurface,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: context.themeColors.mutedSurface,
                      ),
                    ),
                  ),
                  items: departments.map((department) {
                    return DropdownMenuItem<String>(
                      value: department.id,
                      child: Text(
                        AppLocalizations.supportedLocales.contains(Locale('ar'))
                            ? department.nameAR
                            : department.nameEN,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: isEnabled ? onChanged : null,
                  validator: hasFaculty
                      ? validator ??
                            (value) => value == null
                                ? context.l10n.departmentRequired
                                : null
                      : null,
                ),
                if (failureMessage != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    failureMessage,
                    style: TextStyle(
                      color: context.colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
