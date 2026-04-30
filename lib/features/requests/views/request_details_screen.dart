import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/advisor_decision.dart';
import 'package:edu_advisor/features/requests/widgets/course_request_card.dart';
import 'package:edu_advisor/features/requests/widgets/rejection_dialog.dart';
import 'package:edu_advisor/features/requests/widgets/student_info_card.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

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

    // Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
  }

  void _showSuccessToast(String title, String desc) {
    CherryToast.success(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(desc),
      animationType: AnimationType.fromTop,
      action: const Text("OK", style: TextStyle(color: Colors.green)),
    ).show(context);
  }

  void _showErrorToast(String title, String desc) {
    CherryToast.error(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(desc),
      animationType: AnimationType.fromTop,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isPending = widget.request.status.toLowerCase() == 'pending';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
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
                                ? Colors.orange
                                : (widget.request.status == 'approved'
                                      ? Colors.green
                                      : Colors.red),
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
