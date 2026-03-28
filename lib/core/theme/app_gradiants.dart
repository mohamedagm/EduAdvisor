import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  AppGradients._();

  /// Main gradient for all users
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.bluePrimary, AppColors.purplePrimary],
  );

  /// AI features gradient
  static const LinearGradient ai = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.aiPurple, AppColors.aiPink],
  );
}
