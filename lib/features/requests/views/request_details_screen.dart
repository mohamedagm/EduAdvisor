import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/advisor_decision.dart';
import 'package:edu_advisor/features/requests/widgets/course_request_card.dart';
import 'package:edu_advisor/features/requests/widgets/rejection_dialog.dart';
import 'package:edu_advisor/features/requests/widgets/student_info_card.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class RequestDetailsScreen extends StatefulWidget {
  final StudentRequest request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  void _showRejectionDialog() {
    showDialog(
      context: context,
      builder: (context) => RejectionDialog(
        onConfirm: (reason) {
          _updateRequestStatus('rejected');
        },
      ),
    );
  }

  void _updateRequestStatus(String newStatus) {
    setState(() {
      widget.request.status = newStatus;
    });

    if (newStatus == 'approved') {
      _showSuccessToast(
        "Request Approved",
        "The student's courses have been accepted.",
      );
    } else {
      _showErrorToast(
        "Request Rejected",
        "The request has been moved to the rejected list.",
      );
    }
  }

  void _showSuccessToast(String title, String desc) {
    AppToast.success(context, title: title, description: desc);
  }

  void _showErrorToast(String title, String desc) {
    AppToast.error(context, title: title, description: desc);
  }

  @override
  Widget build(BuildContext context) {
    bool isPending = widget.request.status.toLowerCase() == 'pending';

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const AdvisorHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StudentInfoCard(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Spring 2025 Requests",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "STATUS: ${widget.request.status.toUpperCase()}",
                          style: TextStyle(
                            color: isPending
                                ? context.themeColors.warning
                                : (widget.request.status == 'approved'
                                      ? context.themeColors.success
                                      : context.colorScheme.error),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    CourseRequestCard(
                      code: "MATH 301",
                      name: "Math 3",
                      credits: 3,
                      date: "Feb 18, 2026",
                      missingPrereq: "Math 2",
                    ),
                    CourseRequestCard(
                      code: "CS 310",
                      name: "Operating Systems",
                      credits: 4,
                      date: "Feb 18, 2026",
                    ),
                    CourseRequestCard(
                      code: "IS312",
                      name: "Database Management System",
                      credits: 3,
                      date: "Feb 18, 2026",
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: isPending
          ? RequestActionButtons(
              onAccept: () => _updateRequestStatus('approved'),
              onReject: () => _showRejectionDialog(),
            )
          : null,
    );
  }
}
