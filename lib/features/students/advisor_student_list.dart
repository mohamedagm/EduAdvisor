import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/features/advisor_nav/manger/cubit/my_students_cubit.dart';
import 'package:edu_advisor/features/advisor_nav/manger/cubit/my_students_state.dart';
import 'package:edu_advisor/features/students/widgets/search_row.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MyStudentsCubit>().fetchMyStudents();

    _searchController.addListener(() {
      context.read<MyStudentsCubit>().fetchMyStudents(
        searchText: _searchController.text,
      );
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
            BlocBuilder<MyStudentsCubit, MyStudentsState>(
              builder: (context, state) {
                final count = state is MyStudentsSuccess ? state.totalCount : 0;
                return AdvisorHeader(studentCount: count);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    SearchRow(controller: _searchController),
                    const SizedBox(height: 14),
                    Expanded(
                      child: BlocBuilder<MyStudentsCubit, MyStudentsState>(
                        builder: (context, state) {
                          if (state is MyStudentsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.gray100,
                              ),
                            );
                          } else if (state is MyStudentsSuccess) {
                            final liveStudents = state.students;

                            if (liveStudents.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No students found.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }

                            return StudentList(students: liveStudents);
                          } else if (state is MyStudentsFailure) {
                            return Center(
                              child: Text(
                                'Error: ${state.failure.apiResponse.message}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
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
