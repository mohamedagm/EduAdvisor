import 'package:edu_advisor/features/auth/Manager/cubit/departments_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/departments_state.dart';
import 'package:edu_advisor/features/auth/signup/widgets/signup_filed_label.dart';
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
        const FieldLabel(text: 'Department'),
        const SizedBox(height: 8),
        BlocBuilder<DepartmentsCubit, DepartmentsState>(
          builder: (context, state) {
            if (state is DepartmentsLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is DepartmentsSuccess) {
              return DropdownButtonFormField<String>(
                value: value,
                hint: const Text('Select your department'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.themeColors.mutedSurface,
                  prefixIcon: Icon(
                    Icons.business,
                    color: context.themeColors.textMuted,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: context.themeColors.textMuted,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
                        value == null ? 'Please select your department' : null,
              );
            } else if (state is DepartmentsFailure) {
              return Text(
                'Failed to load departments: ${state.failure.message}',
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
