import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/departments_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/departments_state.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/signup_filed_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class DepartmentDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const DepartmentDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
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
            if (state is DepartmentsLoading) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is DepartmentsSuccess) {
              return DropdownButtonFormField<String>(
                initialValue: value,
                hint: Text(context.l10n.selectDepartment),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.themeColors.mutedSurface,
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
                ),
                items: state.departments.map((department) {
                  return DropdownMenuItem<String>(
                    value: department.id,
                    child: Text(department.name),
                  );
                }).toList(),
                onChanged: onChanged,
                validator:
                    validator ??
                    (value) =>
                        value == null ? context.l10n.departmentRequired : null,
              );
            } else if (state is DepartmentsFailure) {
              return Text(
                context.l10n.failedToLoadDepartmentsMessage(
                  state.failure.message,
                ),
                style: TextStyle(color: context.colorScheme.error),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
