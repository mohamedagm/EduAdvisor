import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/academic_history_tab.dart';
import 'package:edu_advisor/features/requests/widgets/current_requests_tab.dart';

class RequestDetailsBody extends StatelessWidget {
  final StudentRequest request;
  final TabController tabController;

  const RequestDetailsBody({
    super.key,
    required this.request,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: context.colorScheme.surface,
          child: TabBar(
            controller: tabController,
            indicatorColor: context.colorScheme.primary,
            labelColor: context.colorScheme.primary,
            unselectedLabelColor: context.themeColors.textMuted,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            tabs: [
              Tab(text: context.l10n.currentRequests),
              Tab(text: context.l10n.academicHistory),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              CurrentRequestsTab(request: request),
              const AcademicHistoryTab(),
            ],
          ),
        ),
      ],
    );
  }
}
