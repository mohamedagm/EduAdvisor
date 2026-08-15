import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/faculties_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/faculties_state.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/signup_filed_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class FacultyDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const FacultyDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  InputDecoration _buildDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: context.themeColors.mutedSurface,
      prefixIcon: Icon(
        Icons.school,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(text: context.l10n.faculty),
        SizedBox(height: 8.w),
        BlocBuilder<FacultiesCubit, FacultiesState>(
          builder: (context, state) {
            if (state is FacultiesSuccess) {
              return DropdownButtonFormField<String>(
                initialValue: value,
                isExpanded: true,
                hint: Text(
                  context.l10n.selectFaculty,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                decoration: _buildDecoration(context),
                items: state.faculties.map((faculty) {
                  return DropdownMenuItem<String>(
                    value: faculty.id,
                    child: Text(
                      AppLocalizations.supportedLocales.contains(
                            Locale('ar'),
                          )
                          ? faculty.nameAR
                          : faculty.nameEN,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
                validator:
                    validator ??
                    (value) =>
                        value == null ? context.l10n.facultyRequired : null,
              );
            }

            final isLoading = state is FacultiesLoading;
            final failureMessage = state is FacultiesFailure
                ? state.failure.message
                : null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () => context.read<FacultiesCubit>().fetchFaculties(),
                  child: InputDecorator(
                    decoration: _buildDecoration(context),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.l10n.selectFaculty,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: context.themeColors.textMuted,
                            ),
                          ),
                        ),
                        if (isLoading)
                          SizedBox(
                            width: 20.r,
                            height: 20.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        else
                          const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
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
