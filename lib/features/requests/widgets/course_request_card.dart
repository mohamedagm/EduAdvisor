import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CourseRequestCard extends StatelessWidget {
  final String code, name, date;
  final int credits;
  final String? missingPrereq; //

  const CourseRequestCard({super.key, required this.code, required this.name, required this.credits, required this.date, this.missingPrereq});

  @override
  Widget build(BuildContext context) {
    bool hasWarning = missingPrereq != null;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hasWarning ? const Color(0xFFFFFBEB) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: hasWarning ? Colors.orange.shade200 : Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book_rounded, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(child: Text("$code:", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: Text(name, style: TextStyle(color: Colors.grey[600])),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("• $credits Credits", style: TextStyle(color: Colors.grey[500])),
              Text("• Requested $date", style: TextStyle(color: Colors.grey[500])),
              if (hasWarning)
                const Row(children: [Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 16), Text(" Prereqs Missing", style: TextStyle(color: Colors.orange, fontSize: 12))]),
            ],
          ),
          if (hasWarning) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
              child: Text("Missing: $missingPrereq", style: const TextStyle(color: AppColors.warningAmberDark , fontWeight: FontWeight.w500)),
            ),
          ],
        ],
      ),
    );
  }
}