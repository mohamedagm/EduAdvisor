import 'package:edu_advisor/features/auth/data/models/auth_user_model.dart';

class LoginResponseModel {
  const LoginResponseModel({
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.refreshToken,
    required this.refreshTokenExpiresAt,
    required this.user,
  });

  final String accessToken;
  final String accessTokenExpiresAt;
  final String refreshToken;
  final String refreshTokenExpiresAt;
  final AuthUserModel user;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'] as String? ?? '',
      accessTokenExpiresAt: json['accessTokenExpiresAt'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      refreshTokenExpiresAt: json['refreshTokenExpiresAt'] as String? ?? '',
      user: AuthUserModel.fromJson(
        Map<String, dynamic>.from(json['user'] as Map? ?? {}),
      ),
    );
  }
}
