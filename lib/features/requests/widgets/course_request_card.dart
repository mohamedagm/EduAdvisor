import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class CourseRequestCard extends StatelessWidget {
  final String code, name, date;
  final int credits;
  final String? missingPrereq; //

  const CourseRequestCard({
    super.key,
    required this.code,
    required this.name,
    required this.credits,
    required this.date,
    this.missingPrereq,
  });

  @override
  Widget build(BuildContext context) {
    bool hasWarning = missingPrereq != null;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hasWarning
            ? context.themeColors.warningContainer
            : context.themeColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasWarning
              ? context.themeColors.warning.withValues(alpha: 0.35)
              : context.themeColors.mutedSurface,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    color: context.colorScheme.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    code,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              Text(
                date,
                style: TextStyle(
                  color: context.themeColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.stars_rounded,
                size: 16,
                color: context.themeColors.textMuted,
              ),
              const SizedBox(width: 4),
              Text(
                "$credits Credits",
                style: TextStyle(
                  color: context.themeColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              if (hasWarning) ...[
                const SizedBox(width: 16),
                Icon(
                  Icons.warning_amber_rounded,
                  color: context.themeColors.warning,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "Prereqs Missing",
                  style: TextStyle(
                    color: context.themeColors.warning,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          if (hasWarning) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: context.themeColors.warningContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: context.themeColors.warning,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Missing: $missingPrereq",
                      style: TextStyle(
                        color: context.themeColors.warning,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
