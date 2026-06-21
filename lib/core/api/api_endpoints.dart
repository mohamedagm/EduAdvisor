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
  static const String getDepartments = '/api/Departments/select-menu';
  static const String  getMyStudents = '/api/v1/Advisors/my-students';

  static const String getPendingRequests = '/api/v1/Advisors/pending';
  static const String getApprovedRequests = '/api/v1/Advisors/approved';
  static String approveRequest(String id) => '/api/v1/Advisors/approve/$id';
  static String rejectRequest(String id) => '/api/v1/Advisors/reject/$id';
  static String assignStudents(String advisorId) =>
      '/api/v1/Advisors/$advisorId/assign-students';

}