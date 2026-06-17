class AppRoutes {
  const AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String chooseUserRole = '/choose-user-role';

  static const String studentLogin = '/auth/student-login';
  static const String advisorLogin = '/auth/advisor-login';
  static const String signup = '/auth/signup/:role';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyCode = '/auth/verify-code';
  static const String studentProfileSetup = '/auth/student-profile-setup';
  static const String advisorProfileSetup = '/auth/advisor-profile-setup';

  static const String studentMain = '/student';
  static const String advisorMain = '/advisor';

  static const String notifications = '/profile/notifications';
  static const String settings = '/profile/settings';

  static const String courseRecommendations = '/services/recommendations';
  static const String courseRegistration = '/services/registration';
  static const String registrationStatus = '/services/registration-status';

  static const String requestDetails = '/advisor/request-details';

  static String signupFor(String role) => '/auth/signup/$role';
}
