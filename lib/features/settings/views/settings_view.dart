import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_view_body.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(authRepo: getIt<AuthRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              CurrentUserCubit(userRepo: getIt<UserRepo>())..getMe(),
        ),
      ],
      child: const SettingsViewBody(),
    );
  }
}
