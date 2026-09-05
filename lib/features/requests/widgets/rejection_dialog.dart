import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';

class RejectionDialog extends StatefulWidget {
  final Function(String reason) onConfirm;

  const RejectionDialog({super.key, required this.onConfirm});

  @override
  State<RejectionDialog> createState() => _RejectionDialogState();
}

class _RejectionDialogState extends State<RejectionDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text(
        context.l10n.rejectRegistrationRequest,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.rejectionReasonPrompt,
            style: TextStyle(
              color: context.themeColors.textMuted,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 16.w),
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: context.l10n.rejectionReasonHint,
              hintStyle: TextStyle(
                fontSize: 13,
                color: context.themeColors.textMuted,
              ),
              filled: true,
              fillColor: context.themeColors.mutedSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(color: context.themeColors.border),
                ),
                child: Text(
                  context.l10n.cancel,
                  style: TextStyle(color: context.themeColors.textPrimary),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.trim().isNotEmpty) {
                    widget.onConfirm(_controller.text.trim());
                    context.pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  context.l10n.confirmRejection,
                  style: TextStyle(
                    color: context.colorScheme.onError,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
