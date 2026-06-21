import 'package:edu_advisor/features/requests/manager/cubit/request_cubit.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/advisor_decision.dart';
import 'package:edu_advisor/features/requests/widgets/course_request_card.dart';
import 'package:edu_advisor/features/requests/widgets/rejection_dialog.dart';
import 'package:edu_advisor/features/requests/widgets/student_info_card.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestDetailsScreen extends StatefulWidget {
  final StudentRequest request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  bool _isProcessing = false;

  void _showRejectionDialog() {
    showDialog(
      context: context,
      builder: (context) => RejectionDialog(
        onConfirm: (reason) async {
          Navigator.pop(context);
          await _rejectRequest(reason);
        },
      ),
    );
  }

  Future<void> _rejectRequest(String reason) async {
    setState(() => _isProcessing = true);

    final failure = await context.read<RequestsCubit>().rejectRequest(
          widget.request.id,
          reason: reason,
        );

    if (!mounted) return;
    setState(() => _isProcessing = false);

    if (failure != null) {
      _showErrorToast("Rejection Failed", failure.apiResponse.message);
      return;
    }

    _showErrorToast(
      "Request Rejected",
      "The request has been moved to the rejected list.",
    );
    Navigator.pop(context);
  }

  Future<void> _approveRequest() async {
    setState(() => _isProcessing = true);

    final failure = await context
        .read<RequestsCubit>()
        .approveRequest(widget.request.id);

    if (!mounted) return;
    setState(() => _isProcessing = false);

    if (failure != null) {
      _showErrorToast("Approval Failed", failure.apiResponse.message);
      return;
    }

    _showSuccessToast(
      "Request Approved",
      "The student's courses have been accepted.",
    );
    Navigator.pop(context);
  }

  void _showSuccessToast(String title, String desc) {
    AppToast.success(context, title: title, description: desc);
  }

  void _showErrorToast(String title, String desc) {
    AppToast.error(context, title: title, description: desc);
  }

  @override
  Widget build(BuildContext context) {
    final String currentStatus = widget.request.status.toLowerCase();
    final bool isPending = currentStatus == 'pending';

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            AdvisorHeader(studentCount: 0),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StudentInfoCard(
                      studentName: widget.request.studentName,
                      studentCode: widget.request.studentCode,
                      department: widget.request.department,
                      academicYear: widget.request.academicYear,
                      photoUrl: widget.request.studentPhotoUrl,
                    ),
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.request.coursesCount == 0
                          ? 3
                          : widget.request.coursesCount,
                      itemBuilder: (context, index) {
                        return CourseRequestCard(
                          code: index == 0
                              ? "MATH 301"
                              : (index == 1 ? "CS 310" : "IS 312"),
                          name: index == 0
                              ? "Math 3"
                              : (index == 1
                                  ? "Operating Systems"
                                  : "Database System"),
                          credits: index == 1 ? 4 : 3,
                          date: "Feb 18, 2026",
                        );
                      },
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
              onAccept: () {
                if (!_isProcessing) _approveRequest();
              },
              onReject: () {
                if (!_isProcessing) _showRejectionDialog();
              },
            )
          : null,
    );
  }
}