import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/AIChat/ai_chat_view.dart';
import 'package:edu_advisor/features/CourseCatalog/course_catalog_view.dart';
import 'package:edu_advisor/features/home/views/home_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeView(),
    CourseCatalogView(),
    AIChatView(),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.infoBlue,
        unselectedItemColor: AppColors.gray600,
        unselectedLabelStyle: AppTextStyles.bodyInterRegular12.copyWith(
          color: AppColors.gray600,
        ),
        selectedLabelStyle: AppTextStyles.bodyInterRegular12.copyWith(
          color: AppColors.infoBlue,
        ),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Ai Chat"),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services),
            label: "Services",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
