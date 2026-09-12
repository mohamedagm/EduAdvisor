import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/AIChat/Manager/cubit/ai_chat_cubit.dart';
import 'package:edu_advisor/features/AIChat/data/repo/ai_chat_repo.dart';
import 'package:edu_advisor/features/AIChat/views/ai_chat_view.dart';
import 'package:edu_advisor/features/CourseCatalog/views/course_catalog_view.dart';
import 'package:edu_advisor/features/profile/views/profile_view.dart';
import 'package:edu_advisor/features/services/views/registration_view.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/widgets/chat_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  bool _chatOpen = false;

  final List<Widget> pages = const [
    CourseCatalogView(),
    RegistrationView(),
    ProfileView(),
  ];

  void _openChat() {
    setState(() {
      _chatOpen = true;
    });
  }

  void _closeChat() {
    setState(() {
      _chatOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CurrentUserCubit(userRepo: getIt<UserRepo>())..getMe(),
      child: BlocProvider(
        create: (context) => AiChatCubit(aiChatRepo: getIt<AiChatRepo>()),
        child: Stack(
          children: [
            Scaffold(
              body: IndexedStack(index: currentIndex, children: pages),
              floatingActionButton: _chatOpen
                  ? null
                  : ChatFab(onTap: _openChat),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: context.themeColors.card,
                  boxShadow: [
                    BoxShadow(
                      color: context.themeColors.border.withValues(alpha: 0.5),
                      blurRadius: 16.r,
                      offset: Offset(0, -4.w),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: context.themeColors.info,
                  unselectedItemColor: context.themeColors.textSecondary,
                  unselectedLabelStyle: AppTextStyles.bodyInterRegular12
                      .responsive
                      .copyWith(color: context.themeColors.textSecondary),
                  selectedLabelStyle: AppTextStyles.bodyInterRegular12
                      .responsive
                      .copyWith(
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
                        currentIndex == 0 ? Icons.book : Icons.book_outlined,
                        size: 24.r,
                      ),
                      label: context.l10n.coursesTab,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        currentIndex == 1
                            ? Icons.assignment_turned_in
                            : Icons.assignment_outlined,
                        size: 24.r,
                      ),
                      label: context.l10n.courseRegistrationTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        currentIndex == 2 ? Icons.person : Icons.person_outline,
                        size: 24.r,
                      ),
                      label: context.l10n.profileTab,
                    ),
                  ],
                ),
              ),
            ),
            if (_chatOpen)
              PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) {
                  if (!didPop) _closeChat();
                },
                child: AIChatView(onClose: _closeChat),
              ),
          ],
        ),
      ),
    );
  }
}