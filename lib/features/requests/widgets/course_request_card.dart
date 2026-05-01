import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
        color: hasWarning ? const Color(0xFFFFFBEB) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasWarning ? Colors.orange.shade200 : Colors.grey.shade100,
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
                  const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.blue,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    code,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
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
              Icon(Icons.stars_rounded, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                "$credits Credits",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              if (hasWarning) ...[
                const SizedBox(width: 16),
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  "Prereqs Missing",
                  style: TextStyle(
                    color: Colors.orange,
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
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppColors.warningAmberDark,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Missing: $missingPrereq",
                      style: const TextStyle(
                        color: AppColors.warningAmberDark,
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
