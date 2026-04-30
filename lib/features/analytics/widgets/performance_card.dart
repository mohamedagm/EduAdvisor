import 'package:flutter/material.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Student Performance Overview',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 16),

          _gpaRow(
            label: 'GPA ≥ 3.5',
            count: 15,
            total: 45,
            color: const Color(0xFF4CAF50),
            bg: const Color(0xFFE9F8EE),
          ),

          const SizedBox(height: 10),

          _gpaRow(
            label: 'GPA 2.0 - 3.5',
            count: 25,
            total: 45,
            color: const Color(0xFFFFA726),
            bg: const Color(0xFFFFF4E5),
          ),

          const SizedBox(height: 10),

          _gpaRow(
            label: 'GPA < 2.0',
            count: 5,
            total: 45,
            color: const Color(0xFFEF5350),
            bg: const Color(0xFFFFEEEE),
          ),
        ],
      ),
    );
  }

  Widget _gpaRow({
    required String label,
    required int count,
    required int total,
    required Color color,
    required Color bg,
  }) {
    final percent = (count / total * 100).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2D2D3A),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              '$count students ($percent%)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardWrapper({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}