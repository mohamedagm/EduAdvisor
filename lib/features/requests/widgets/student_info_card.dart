import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StudentInfoCard extends StatelessWidget {
  final String studentName;
  final String studentCode;
  final String department;
  final int academicYear;
  final String? photoUrl;

  const StudentInfoCard({
    super.key,
    required this.studentName,
    required this.studentCode,
    required this.department,
    required this.academicYear,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoUrl != null && photoUrl!.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.gray100,
                backgroundImage: hasPhoto ? NetworkImage(photoUrl!) : null,
                onBackgroundImageError: hasPhoto ? (_, __) {} : null,
                child: !hasPhoto
                    ? Icon(Icons.person, size: 30, color: Colors.grey[400])
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$department • ID: $studentCode",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Year $academicYear",
                        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ⚠️ CGPA / Credits / Failed مش موجودين في الـ response الحالي
          // بتاع /pending، فمسيباهم مخفيين مؤقتًا لحد ما يتوفر مصدر
          // بيانات ليهم (زي endpoint تفاصيل الطالب الأكاديمية)
        ],
      ),
    );
  }
}