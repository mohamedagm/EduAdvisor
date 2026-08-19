import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/features/advisor_nav/advisor_home_screen.dart';
import 'package:edu_advisor/features/onbording/first_onbording_view.dart';
import 'package:edu_advisor/features/onbording/second_onbording_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onSkip() {
    context.go(AppRoutes.chooseUserRole);
  }

  void _onGetStarted() {
    context.go(AppRoutes.chooseUserRole);////////////////change
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  FirstOnBordaingView(onNext: _onNext, onSkip: _onSkip),
                  SecondOnBordaingView(onGetStarted: _onGetStarted),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 8.w,
                    width: _currentPage == index ? 24.w : 8.w,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? context.colorScheme.secondary
                          : context.colorScheme.secondary.withValues(
                              alpha: 0.2,
                            ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
