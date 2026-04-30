import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StudentInfoCard extends StatelessWidget {
  const StudentInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Stack(
              //   children: [
              //     const CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/student.png')),
              //     Positioned(bottom: 0, right: 0, child: Icon(Icons.check_circle, color: Colors.green, size: 20)),
              //   ],
              // ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Aliaa Mohamed", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Info. System • ID: 2020345", style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                      child: const Text("Year 4", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(label: "CGPA", value: "3.4"),
              _StatItem(label: "CREDITS", value: "85/120"),
              _StatItem(label: "FAILED", value: "1", isCritical: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label, value;
  final bool isCritical;
  const _StatItem({required this.label, required this.value, this.isCritical = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isCritical ? Colors.red : Colors.black)),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
      ],
    );
  }
}