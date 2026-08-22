import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/requests/manager/cubit/request_cubit.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/advisor_decision.dart';
import 'package:edu_advisor/features/requests/widgets/rejection_dialog.dart';
import 'package:edu_advisor/features/requests/widgets/request_details_body.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';
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
    _setProcessing(true);

    final failure = await context.read<RequestsCubit>().rejectRequest(
          widget.request.id,
          reason: reason,
        );

    if (!mounted) return;
    _setProcessing(false);

    if (failure != null) {
      _showToast(title: "Rejection Failed", desc: failure.apiResponse.message, isError: true);
      return;
    }

    _showToast(
      title: "Request Rejected",
      desc: "The request has been moved to the rejected list.",
      isError: true,
    );
    Navigator.pop(context);
  }

  Future<void> _approveRequest() async {
    _setProcessing(true);

    final failure = await context.read<RequestsCubit>().approveRequest(widget.request.id);

    if (!mounted) return;
    _setProcessing(false);

    if (failure != null) {
      _showToast(title: "Approval Failed", desc: failure.apiResponse.message, isError: true);
      return;
    }

    _showToast(
      title: "Request Approved",
      desc: "The student's courses have been accepted.",
    );
    Navigator.pop(context);
  }

  void _setProcessing(bool value) {
    setState(() => _isProcessing = value);
  }

  void _showToast({required String title, required String desc, bool isError = false}) {
    if (isError) {
      AppToast.error(context, title: title, description: desc);
    } else {
      AppToast.success(context, title: title, description: desc);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPending = widget.request.status == 1;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const AdvisorHeader(studentCount: 0),
            Expanded(
              child: RequestDetailsBody(request: widget.request),
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