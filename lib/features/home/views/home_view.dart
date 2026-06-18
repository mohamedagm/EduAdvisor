import 'package:edu_advisor/features/home/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final String fullName;

  const HomeView({super.key, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return HomeViewBody(fullName: fullName);
  }
}
