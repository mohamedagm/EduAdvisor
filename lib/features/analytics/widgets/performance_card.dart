import 'package:edu_advisor/features/analytics/data/models/advisor_dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({super.key, required this.distribution});

  final GpaDistributionModel distribution;

  @override
  Widget build(BuildContext context) {
    return _cardWrapper(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.studentPerformanceOverview,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: context.themeColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          _gpaRow(
            context: context,
            label: context.l10n.gpaAtLeast('3.5'),
            count: distribution.highGpaCount,
            percentage: distribution.highGpaPercentage,
            color: context.themeColors.success,
            bg: context.themeColors.successContainer,
          ),

          const SizedBox(height: 10),

          _gpaRow(
            context: context,
            label: context.l10n.gpaRange('2.0', '3.5'),
            count: distribution.midGpaCount,
            percentage: distribution.midGpaPercentage,
            color: context.themeColors.warning,
            bg: context.themeColors.warningContainer,
          ),

          const SizedBox(height: 10),

          _gpaRow(
            context: context,
            label: context.l10n.gpaBelow('2.0'),
            count: distribution.lowGpaCount,
            percentage: distribution.lowGpaPercentage,
            color: context.colorScheme.error,
            bg: context.themeColors.dangerContainer,
          ),
        ],
      ),
    );
  }

  Widget _gpaRow({
    required BuildContext context,
    required String label,
    required int count,
    required num percentage,
    required Color color,
    required Color bg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: context.themeColors.textPrimary,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: context.themeColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              context.l10n.studentsPercentage(
                count,
                percentage.toStringAsFixed(0),
              ),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardWrapper({required BuildContext context, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.themeColors.textPrimary.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
