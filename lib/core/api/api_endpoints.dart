class ApiEndpoints {
  const ApiEndpoints._();

  static const String login = '/api/Auth/login';
  static const String refreshToken = '/api/Auth/refresh-token';
  static const String logout = '/api/Auth/logout';
  static const String confirmEmail = '/api/Auth/confirm-email';
  static const String resendVerification = '/api/Auth/resend-verification';
  static const String forgotPassword = '/api/Auth/forgot-password';
  static const String verifyResetOtp = '/api/Auth/verify-reset-otp';
  static const String resetPassword = '/api/Auth/reset-password';
  static const String changePassword = '/api/Auth/change-password';
  static const String registerStudent = '/api/Auth/register/student';
  static const String registerAdvisor = '/api/Auth/register/advisor';
  static const String myPermissions = '/api/Auth/me/permissions';
  static const String me = '/api/Auth/me';
  static const String validateToken = '/api/Auth/validate-token';

  static const String courses = '/api/v1/Courses';
  static const String myCourses = '/api/v1/Students/my-courses';
  static const String availableCourses = '/api/v1/Students/available-courses';

  static const String aiAdvisorChat = 'https://advisor.flowlogichub.space/chat';
}
