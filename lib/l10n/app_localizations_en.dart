// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'EduAdvisor';

  @override
  String get splashTagline => 'Your AI-Powered Academic Companion';

  @override
  String get smartPlanning => 'Smart Planning';

  @override
  String get aiPowered => 'AI Powered';

  @override
  String get skip => 'Skip';

  @override
  String get aiPoweredRecommendations => 'AI-Powered Recommendations';

  @override
  String get personalizedCourseSuggestions =>
      'Get personalized course suggestions to boost your GPA and achieve your goals';

  @override
  String get next => 'Next';

  @override
  String get trackYourProgress => 'Track Your Progress';

  @override
  String get trackProgressDescription =>
      'Monitor your GPA, simulate grades, and plan your path to academic success';

  @override
  String get getStarted => 'Get Started';

  @override
  String get skipForNow => 'Skip for now';

  @override
  String get academicSuccessPartner => 'Your Academic Success Partner';

  @override
  String get chooseYourRole => 'Choose Your Role';

  @override
  String get continueToApp => 'to continue to EduAdvisor';

  @override
  String get student => 'Student';

  @override
  String get studentRoleDescription => 'Access courses, grades & schedule';

  @override
  String get advisor => 'Advisor';

  @override
  String get advisorRoleDescription => 'Manage students & academic advising';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'email@university.edu';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get validEmailRequired => 'Enter a valid email';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordSixCharacters => 'Password must be at least 6 characters';

  @override
  String get loginAsStudent => 'Login as student';

  @override
  String get loginAsAdvisor => 'Login as advisor';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get loggingIn => 'Logging in...';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign up';

  @override
  String get loginSuccessful => 'Login successful';

  @override
  String welcomeBackName(String name) {
    return 'Welcome back, $name';
  }

  @override
  String get loginFailed => 'Login failed';

  @override
  String wrongRoleAccount(String role) {
    return 'This account is not a $role account';
  }

  @override
  String get verificationCodeSent => 'Verification code sent';

  @override
  String get couldNotSendCode => 'Could not send code';

  @override
  String get forgotPasswordHelp => 'Don\'t worry! We\'ll help you reset it.';

  @override
  String get emailAddressHint => 'your.email@university.edu.eg';

  @override
  String get emailVerificationHelp =>
      'We\'ll send a 6-digit verification code to this email';

  @override
  String get sending => 'Sending...';

  @override
  String get sendVerificationCode => 'Send verification code';

  @override
  String get rememberPassword => 'Remember your password?';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get passwordUpdated => 'Password updated';

  @override
  String get passwordResetFailed => 'Password reset failed';

  @override
  String get newPassword => 'New password';

  @override
  String get strongPasswordHelp => 'Create a strong password for your account';

  @override
  String get enterNewPassword => 'Enter your new password';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String get loading => 'Loading...';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get incompleteCode => 'Incomplete code';

  @override
  String get completeVerificationCode =>
      'Please enter the complete 6-digit verification code.';

  @override
  String get codeVerified => 'Code verified';

  @override
  String get verificationCodeAccepted =>
      'Your verification code was accepted successfully.';

  @override
  String get verificationFailed => 'Verification failed';

  @override
  String get codeSent => 'Code sent';

  @override
  String get newVerificationCodeSent =>
      'A new verification code was sent to your email.';

  @override
  String get couldNotResendCode => 'Could not resend code';

  @override
  String get verifyCode => 'Verify code';

  @override
  String get checkEmailForCode => 'Check your email for the code';

  @override
  String resendIn(int seconds) {
    return 'Resend in $seconds';
  }

  @override
  String get resendCode => 'Resend code';

  @override
  String get verify => 'Verify';

  @override
  String get failedToLoadDepartments => 'Failed to load departments';

  @override
  String failedToLoadDepartmentsMessage(String message) {
    return 'Failed to load departments: $message';
  }

  @override
  String get retry => 'Retry';

  @override
  String get firstName => 'First name';

  @override
  String get enterFirstName => 'Enter your first name';

  @override
  String get lastName => 'Last name';

  @override
  String get enterLastName => 'Enter your last name';

  @override
  String get studentCode => 'Student code';

  @override
  String get gpa => 'GPA';

  @override
  String get creditsLabel => 'Credits';

  @override
  String get level => 'Level';

  @override
  String get recommendedCourses => 'Recommended Courses';

  @override
  String get viewAll => 'View All';

  @override
  String get registrationAlert => 'Registration Alert';

  @override
  String get registrationAlertMessage =>
      'Spring 2025 course registration opens in 3 days. Check your saved schedule.';

  @override
  String get degreeProgress => 'Degree Progress';

  @override
  String get degreeProgramName => 'Bachelor of Computer Science';

  @override
  String creditsRatio(String completed, String required) {
    return '$completed / $required';
  }

  @override
  String onTrackToGraduate(String semester) {
    return 'You are on track to graduate in $semester.';
  }

  @override
  String get spring2026 => 'Spring 2026';

  @override
  String courseCredits(String credits) {
    return '$credits Credits';
  }

  @override
  String get homeTab => 'Home';

  @override
  String get coursesTab => 'Courses';

  @override
  String get aiChatTab => 'AI Chat';

  @override
  String get servicesTab => 'Services';

  @override
  String get profileTab => 'Profile';

  @override
  String get courseCatalogTitle => 'Course Catalog';

  @override
  String get searchCoursesHint => 'Search courses...';

  @override
  String courseLevel(String level) {
    return 'Level $level';
  }

  @override
  String courseSemester(String semester) {
    return 'Semester $semester';
  }

  @override
  String get courseDescription => 'Description';

  @override
  String get academicPlacement => 'Academic Placement';

  @override
  String get specializations => 'Specializations';

  @override
  String get semester => 'Semester';

  @override
  String courseAcademicPlacement(String level, String semester) {
    return 'Level $level, semester $semester.';
  }

  @override
  String get courseCatalogEmptyMessage => 'No courses found';

  @override
  String get aiChatUserDataUnavailableTitle => 'User data unavailable';

  @override
  String get aiChatUserDataLoadingDescription =>
      'Please wait for your profile data to load.';

  @override
  String get aiChatStudentIdUnavailableTitle => 'Student ID unavailable';

  @override
  String get aiChatStudentIdMissingDescription =>
      'Your student code is missing from your profile.';

  @override
  String get aiChatAssistantTitle => 'AI Assistant';

  @override
  String get aiChatStatusOnline => 'Online';

  @override
  String get aiChatAskAnythingHint => 'Ask me anything...';

  @override
  String get aiChatQuickActionRecommendCourses => 'Recommend Courses';

  @override
  String get aiChatQuickActionGpaSimulator => 'GPA Simulator';

  @override
  String get aiChatQuickActionBoostMyGpa => 'Boost My GPA';

  @override
  String get aiChatQuickActionStudyPlan => 'Study Plan';

  @override
  String get nationalId => 'National ID';

  @override
  String get enterNationalId => 'Enter your national ID';

  @override
  String get signingUp => 'Signing up...';

  @override
  String get registrationSuccessful => 'Registration successful';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String get phone => 'Phone';

  @override
  String get department => 'Department';

  @override
  String get selectDepartment => 'Select your department';

  @override
  String get departmentRequired => 'Please select your department';

  @override
  String get createAccount => 'Create account';

  @override
  String get completeYourProfile => 'Complete your profile';

  @override
  String get addProfilePhoto =>
      'Add a profile photo to personalize your account.';

  @override
  String get whyAddPhoto => 'Why add a photo?';

  @override
  String get photoExplanation =>
      'A profile photo helps you establish and present yourself. You can always change or remove it later in your profile settings.';

  @override
  String get continueAction => 'Continue';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get nameMinLength => 'Name must be at least 3 characters';

  @override
  String get codeRequired => 'Code is required';

  @override
  String get codeSixDigits => 'Code must be 6 digits';

  @override
  String get codeDigitsOnly => 'Code must contain only digits';
}
