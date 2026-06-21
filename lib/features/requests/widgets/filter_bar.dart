import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class RequestFilterBar extends StatefulWidget {
  final ValueChanged<String> onFilterChanged;

  const RequestFilterBar({super.key, required this.onFilterChanged});

  @override
  State<RequestFilterBar> createState() => _RequestFilterBarState();
}

class _RequestFilterBarState extends State<RequestFilterBar> {
  String selectedFilter = 'New Requests';

  final List<String> filters = ['New Requests', 'Approved', 'Rejected'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: filters.map((filter) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(filter),

                selected: selectedFilter == filter,

                selectedColor: context.colorScheme.primary.withValues(
                  alpha: 0.1,
                ),
                labelStyle: TextStyle(
                  color: selectedFilter == filter
                      ? context.colorScheme.primary
                      : context.themeColors.textPrimary,
                  fontWeight: selectedFilter == filter
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),

                backgroundColor: context.themeColors.mutedSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: selectedFilter == filter
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

                    // print("Selected Filter Sent to Parent: $filter");
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
