import 'package:edu_advisor/features/requests/manager/cubit/student_hestory_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/available_courses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/requests/manager/cubit/request_cubit.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/advisor_decision.dart';
import 'package:edu_advisor/features/requests/widgets/rejection_dialog.dart';
import 'package:edu_advisor/features/requests/widgets/request_details_body.dart';
import 'package:edu_advisor/features/requests/widgets/request_student_card.dart';

class RequestDetailsScreen extends StatefulWidget {
  final StudentRequest request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isProcessing = false;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 👈 3 بدل 2
    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _tabController.index != _selectedTabIndex) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      _showToast(
        title: context.l10n.rejectionFailed,
        desc: failure.apiResponse.message,
        isError: true,
      );
      return;
    }

    _showToast(
      title: context.l10n.requestRejected,
      desc: context.l10n.requestRejectedMessage,
      isError: true,
    );
    Navigator.pop(context);
  }

  Future<void> _approveRequest() async {
    _setProcessing(true);

    final failure = await context.read<RequestsCubit>().approveRequest(
      widget.request.id,
    );

    if (!mounted) return;
    _setProcessing(false);

    if (failure != null) {
      _showToast(
        title: context.l10n.approvalFailed,
        desc: failure.apiResponse.message,
        isError: true,
      );
      return;
    }

    _showToast(
      title: context.l10n.requestApproved,
      desc: context.l10n.requestApprovedMessage,
    );
    Navigator.pop(context);
  }

  void _setProcessing(bool value) {
    setState(() => _isProcessing = value);
  }

  void _showToast({
    required String title,
    required String desc,
    bool isError = false,
  }) {
    if (isError) {
      AppToast.error(context, title: title, description: desc);
    } else {
      AppToast.success(context, title: title, description: desc);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showActionButtons =
        widget.request.status == 1 && _selectedTabIndex == 0;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<StudentHistoryCubit>()
                ..fetchStudentHistory(widget.request.studentId),
        ),
        BlocProvider(
          create: (context) =>
              getIt<AvailableCoursesCubit>()
                ..fetchAvailableCourses(widget.request.studentId),
        ),
      ],
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: context.colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: context.themeColors.textPrimary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              RequestStudentCard(request: widget.request),
              Expanded(
                child: RequestDetailsBody(
                  request: widget.request,
                  tabController: _tabController,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: showActionButtons
            ? RequestActionButtons(
                onAccept: () {
                  if (!_isProcessing) _approveRequest();
                },
                onReject: () {
                  if (!_isProcessing) _showRejectionDialog();
                },
              )
            : null,
      ),
    );
  }
}
