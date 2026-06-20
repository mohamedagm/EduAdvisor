import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/AIChat/views/ai_chat_view.dart';
import 'package:edu_advisor/features/CourseCatalog/views/course_catalog_view.dart';
import 'package:edu_advisor/features/home/views/home_view.dart';
import 'package:edu_advisor/features/profile/views/profile_view.dart';
import 'package:edu_advisor/features/services/views/services_view.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeView(),
    CourseCatalogView(),
    AIChatView(),
    ServicesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CurrentUserCubit(userRepo: UserRepo(apiConsumer: DioConsumer()))
            ..getMe(),
      child: Scaffold(
        body: IndexedStack(index: currentIndex, children: pages),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: context.themeColors.card,
            boxShadow: [
              BoxShadow(
                color: context.themeColors.border.withValues(alpha: 0.5),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: context.themeColors.info,
            unselectedItemColor: context.themeColors.textSecondary,
            unselectedLabelStyle: AppTextStyles.bodyInterRegular12.copyWith(
              color: context.themeColors.textSecondary,
            ),
            selectedLabelStyle: AppTextStyles.bodyInterRegular12.copyWith(
              color: context.themeColors.info,
              fontWeight: FontWeight.w600,
            ),
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  currentIndex == 0 ? Icons.home : Icons.home_outlined,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentIndex == 1 ? Icons.book : Icons.book_outlined,
                ),
                label: "Courses",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentIndex == 2
                      ? Icons.chat_bubble
                      : Icons.chat_bubble_outline,
                ),
                label: "AI Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentIndex == 3
                      ? Icons.miscellaneous_services
                      : Icons.miscellaneous_services_outlined,
                ),
                label: "Services",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentIndex == 4 ? Icons.person : Icons.person_outline,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
