import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';

class RequestFilterBar extends StatefulWidget {
  final ValueChanged<String> onFilterChanged;

  const RequestFilterBar({super.key, required this.onFilterChanged});

  @override
  State<RequestFilterBar> createState() => _RequestFilterBarState();
}

class _RequestFilterBarState extends State<RequestFilterBar> {
  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    final filters = [
      context.l10n.newRequests,
      context.l10n.approved,
      context.l10n.rejected,
    ];
    final selected = selectedFilter ?? context.l10n.newRequests;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
        child: Row(
          children: filters.map((filter) {
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ChoiceChip(
                label: Text(filter),

                selected: selected == filter,

                selectedColor: context.colorScheme.primary.withValues(
                  alpha: 0.1,
                ),
                labelStyle: TextStyle(
                  color: selected == filter
                      ? context.colorScheme.primary
                      : context.themeColors.textPrimary,
                  fontWeight: selected == filter
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),

                backgroundColor: context.themeColors.mutedSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  side: BorderSide(
                    color: selected == filter
                        ? context.colorScheme.primary
                        : Colors.transparent,
                  ),
                ),

                onSelected: (bool selected) {
                  if (selected) {
                    setState(() {
                      selectedFilter = filter;
                    });

                    widget.onFilterChanged(filter);
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
