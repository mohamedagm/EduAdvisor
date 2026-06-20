import 'package:edu_advisor/features/advisor_nav/advisor_navigation_bar.dart';
import 'package:edu_advisor/features/analytics/advisor_analytics.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/views/advisor_requests.dart';
import 'package:edu_advisor/features/students/advisor_student_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  final List<Widget> _screens = [
    AdvisorRequests(allRequests: dummyRequests),
    const StudentsScreen(),
    const AdvisorAnalytics(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedTab, children: _screens),
      bottomNavigationBar: BottomNav(
        selected: _selectedTab,
        onTap: (i) => setState(() => _selectedTab = i),
      ),
    );
  }
}
