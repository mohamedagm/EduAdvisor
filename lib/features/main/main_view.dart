import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/AIChat/views/ai_chat_view.dart';
import 'package:edu_advisor/features/CourseCatalog/views/course_catalog_view.dart';
import 'package:edu_advisor/features/home/views/home_view.dart';
import 'package:edu_advisor/features/profile/views/profile_view.dart';
import 'package:edu_advisor/features/services/views/services_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  final String fullName;
  const MainView({super.key, required this.fullName});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  List<Widget> get pages => [
        HomeView(fullName: widget.fullName), 
        const CourseCatalogView(),
        const AIChatView(),
        const ServicesView(),
        const ProfileView(), 
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.gray200.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.infoBlue,
          unselectedItemColor: AppColors.gray600,
          unselectedLabelStyle: AppTextStyles.bodyInterRegular12.copyWith(
            color: AppColors.gray600,
          ),
          selectedLabelStyle: AppTextStyles.bodyInterRegular12.copyWith(
            color: AppColors.infoBlue,
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
              icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(currentIndex == 1 ? Icons.book : Icons.book_outlined),
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
    );
  }
}
