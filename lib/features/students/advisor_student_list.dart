import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/features/students/models/student_model.dart';
import 'package:edu_advisor/features/students/widgets/search_row.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  List<Student> get _filteredStudents {
    if (_query.trim().isEmpty) return allStudents;
    final q = _query.toLowerCase();
    return allStudents
        .where(
          (s) =>
              s.fullName.toLowerCase().contains(q) ||
              s.email.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            AdvisorHeader(),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    SearchRow(controller: _searchController),
                    // const SizedBox(height: 14),
                    Expanded(child: StudentList(students: _filteredStudents)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatsRow extends StatelessWidget {
  final int studentCount;
  final int requestCount;

  const StatsRow({
    super.key,
    required this.studentCount,
    required this.requestCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatChip(
          icon: Icons.people_rounded,
          label: 'Students',
          value: studentCount.toString(),
        ),
        const SizedBox(width: 12),
        _StatChip(
          icon: Icons.inbox_rounded,
          label: 'Requests',
          value: requestCount.toString(),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
