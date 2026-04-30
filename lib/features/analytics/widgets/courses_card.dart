import 'package:flutter/material.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _cardWrapper(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Courses',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 14),
          _CourseRow(code: 'CS201', name: 'Data Structures', enrolled: 32),
        ],
      ),
    );
  }

  Widget _cardWrapper({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class _CourseRow extends StatelessWidget {
  final String code;
  final String name;
  final int enrolled;

  const _CourseRow({
    required this.code,
    required this.name,
    required this.enrolled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$code - $name'),
        Text('$enrolled'),
      ],
    );
  }
}