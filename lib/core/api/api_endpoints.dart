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
  static const String me = '/api/Account/me';
  static const String validateToken = '/api/Auth/validate-token';
  static const String getFaculty = '/api/Faculty';
  static const String getDepartments = '/api/Department';

  static const String courses = '/api/Course';
  static const String myCourses = '/api/v1/Students/my-courses';
  static const String availableCourses = '/api/v1/Students/available-courses';
  static const String registrationRequests =
      '/api/v1/Students/registration-requests';

  static const String aiAdvisorChat = 'https://advisor.flowlogichub.space/chat';
  static const String getMyStudents = '/api/v1/Advisors/my-students';

  static const String getPendingRequests = '/api/v1/Advisors/pending';
  static const String getApprovedRequests = '/api/v1/Advisors/approved';

  // 📌 الـ Endpoint الجديدة المضبوطة بالـ Swagger لمنع الـ 404
  static const String getProcessedRequests =
      '/api/v1/Advisors/RegistrationRequests/Processed';

  static String approveRequest(String id) => '/api/v1/Advisors/approve/$id';
  static String rejectRequest(String id) => '/api/v1/Advisors/reject/$id';
  static String assignStudents(String advisorId) =>
      '/api/v1/Advisors/$advisorId/assign-students';
  static String getRegistrationRequestDetails(String id) =>
      '/api/v1/Advisors/RegistrationRequest/$id';
}
