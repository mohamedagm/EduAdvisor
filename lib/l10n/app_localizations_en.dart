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

  @override
  String get myProfile => 'My Profile';

  @override
  String profileStudentId(String id) {
    return 'ID: $id';
  }

  @override
  String get progressToGraduation => 'Progress to Graduation';

  @override
  String get creditsCompleted => 'Credits Completed';

  @override
  String creditsRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count credits remaining',
      one: '1 credit remaining',
      zero: 'No credits remaining',
    );
    return '$_temp0';
  }

  @override
  String get myCourses => 'My Courses';

  @override
  String get completed => 'Completed';

  @override
  String get inProgress => 'In Progress';

  @override
  String get remaining => 'Remaining';

  @override
  String get noProfileCourses => 'No courses here yet.';

  @override
  String get courseFallbackName => 'Course';

  @override
  String creditHoursShort(String credits) {
    return '$credits cr';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String unreadNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unread notifications',
      one: '1 unread notification',
      zero: 'No unread notifications',
    );
    return '$_temp0';
  }

  @override
  String get markAllAsRead => 'Mark all as read';

  @override
  String get courseRegistrationApproved => 'Course Registration Approved';

  @override
  String get courseRegistrationApprovedMessage =>
      'Your course registration request has been approved';

  @override
  String get courseRegistrationRejected => 'Course Registration Rejected';

  @override
  String get courseRegistrationRejectedMessage =>
      'Your course registration request was rejected';

  @override
  String get newNotification => 'New';

  @override
  String get viewRejectionReason => 'View rejection reason';

  @override
  String get newCourseAvailable => 'New Course Available';

  @override
  String courseAvailableForEnrollment(String course) {
    return '$course is now available for enrollment';
  }

  @override
  String get registrationDeadline => 'Registration Deadline';

  @override
  String registrationDeadlineMessage(String semester, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return 'Course registration for $semester ends in $_temp0';
  }

  @override
  String get spring2024 => 'Spring 2024';

  @override
  String get databaseSystems => 'Database Systems';

  @override
  String get artificialIntelligence => 'Artificial Intelligence';

  @override
  String get advancedAlgorithms => 'Advanced Algorithms';

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
      zero: 'Just now',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
      zero: 'Today',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get profileInformation => 'Profile Information';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get preferences => 'Preferences';

  @override
  String get language => 'Language';

  @override
  String get englishLanguage => 'English';

  @override
  String get arabicLanguage => 'Arabic';

  @override
  String get appearance => 'Appearance';

  @override
  String get appearanceDescription =>
      'Choose how EduAdvisor looks on this device';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String themeOptionSemantics(String theme) {
    return '$theme theme';
  }

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get receivePushNotifications => 'Receive push notifications';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get receiveEmailUpdates => 'Receive email updates';

  @override
  String get gradeAlerts => 'Grade Alerts';

  @override
  String get notifyWhenGradesPosted => 'Notify when grades are posted';

  @override
  String get security => 'Security';

  @override
  String get changePassword => 'Change Password';

  @override
  String get support => 'Support';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get aboutEduAdvisor => 'About EduAdvisor';

  @override
  String get settingOn => 'On';

  @override
  String get settingOff => 'Off';

  @override
  String get loggingOut => 'Logging out...';

  @override
  String get logOut => 'Log Out';

  @override
  String get loggedOut => 'Logged out';

  @override
  String get loggedOutDescription => 'You have been logged out successfully.';

  @override
  String get loggedOutLocally => 'Logged out locally';

  @override
  String get loggedOutLocallyDescription =>
      'Your local session has been cleared.';

  @override
  String get servicesDescription => 'Access academic tools and resources';

  @override
  String get academicTools => 'Academic Tools';

  @override
  String get courseRecommendationService => 'Course Recommendation';

  @override
  String get courseRecommendationServiceDescription =>
      'Get AI-powered course suggestions based on your GPA, level, and academic history.';

  @override
  String get smartRecommendations => 'Smart Recommendations';

  @override
  String get courseRegistrationTitle => 'Course Registration';

  @override
  String get courseRegistrationServiceDescription =>
      'Select and register for courses with details on code, name, credits, and prerequisites.';

  @override
  String get registerNow => 'Register Now';

  @override
  String get registrationStatusTitle => 'Registration Status';

  @override
  String get registrationStatusServiceDescription =>
      'Track your registration requests and view advisor approval status in real-time.';

  @override
  String get checkStatus => 'Check Status';

  @override
  String get courseRecommendationsTitle => 'Course Recommendations';

  @override
  String get aiPoweredSuggestionsForYou => 'AI-powered suggestions for you';

  @override
  String get personalizedForYou => 'Personalized for You';

  @override
  String get basedOnAcademicProfile => 'Based on your academic profile';

  @override
  String get machineLearning => 'Machine Learning';

  @override
  String get advancedLinearAlgebra => 'Advanced Linear Algebra';

  @override
  String get hardDifficulty => 'Hard';

  @override
  String get machineLearningRecommendationReason =>
      'Strong performance in Data Structures. High demand field.';

  @override
  String get programmingStrengthBenefit =>
      'Aligns with your strengths in programming';

  @override
  String get jobMarketDemandBenefit => 'High job market demand';

  @override
  String get gpaImprovementBenefit => 'Can improve GPA by +0.4';

  @override
  String get linearAlgebraRecommendationReason =>
      'Strong foundation for AI/ML specialization.';

  @override
  String get mlTrackBenefit => 'Essential for ML/AI track';

  @override
  String get mathBackgroundBenefit => 'Strong math background advantage';

  @override
  String get researchOpportunitiesBenefit => 'Research opportunities';

  @override
  String get mediumDifficulty => 'Medium';

  @override
  String get cloudComputing => 'Cloud Computing';

  @override
  String get cloudComputingRecommendationReason =>
      'Your strong results in Computer Networks and Operating Systems make this a natural next step.';

  @override
  String get networkingFoundationBenefit =>
      'Builds on your networking foundation';

  @override
  String get cloudSkillsBenefit => 'Develops practical AWS and Azure skills';

  @override
  String get cloudCareerBenefit => 'Prepares you for cloud engineering roles';

  @override
  String get mobileApplicationDevelopment => 'Mobile Application Development';

  @override
  String get mobileDevelopmentRecommendationReason =>
      'Your performance in OOP and Software Engineering indicates strong readiness for this project-based course.';

  @override
  String get portfolioProjectBenefit =>
      'Adds a production-ready app to your portfolio';

  @override
  String get mobileCareerBenefit => 'Opens mobile and full-stack career paths';

  @override
  String get teamworkExperienceBenefit =>
      'Provides hands-on team project experience';

  @override
  String get cybersecurityFundamentals => 'Cybersecurity Fundamentals';

  @override
  String get cybersecurityRecommendationReason =>
      'Your networking knowledge and analytical performance are a strong fit for introductory security work.';

  @override
  String get cybersecurityDemandBenefit =>
      'Fast-growing demand across industries';

  @override
  String get securityTrackBenefit => 'Unlocks advanced security electives';

  @override
  String get riskAssessmentBenefit => 'Builds practical risk assessment skills';

  @override
  String get appliedStatistics => 'Applied Statistics';

  @override
  String get statisticsRecommendationReason =>
      'Recommended to strengthen data analysis skills for AI electives and your graduation project.';

  @override
  String get dataInterpretationBenefit =>
      'Improves data interpretation and reporting';

  @override
  String get dataSciencePrerequisiteBenefit =>
      'Supports advanced data science electives';

  @override
  String get graduationProjectBenefit =>
      'Useful for research and graduation projects';

  @override
  String get recommendationsUpdatedDaily => 'Recommendations updated daily';

  @override
  String get recommendationsAiDescription =>
      'Our AI analyzes your performance, prerequisites, and career goals to suggest the best courses.';

  @override
  String get creditLimitReached => 'Credit limit reached';

  @override
  String get creditLimitReachedDescription =>
      'You cannot exceed the maximum credit limit.';

  @override
  String get registrationSubmitted => 'Registration submitted';

  @override
  String get submissionFailed => 'Submission failed';

  @override
  String get spring2024Semester => 'Spring 2024 Semester';

  @override
  String selectedCoursesCount(int count) {
    return 'Selected Courses ($count)';
  }

  @override
  String get addCourse => 'Add Course';

  @override
  String get submitting => 'Submitting...';

  @override
  String get submitForApproval => 'Submit for Approval';

  @override
  String get availableCourses => 'Available Courses';

  @override
  String get noAvailableCourses => 'No available courses.';

  @override
  String get retake => 'Retake';

  @override
  String get retakeCourseDescription => 'This course is marked as a retake.';

  @override
  String get totalCreditHours => 'Total Credit Hours';

  @override
  String creditHoursRequired(int min, int max) {
    return '$min - $max hours required';
  }

  @override
  String addMoreCreditHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Add $count more credit hours',
      one: 'Add 1 more credit hour',
    );
    return '$_temp0';
  }

  @override
  String get minimumCreditRequirementMet => 'Minimum credit requirement met';

  @override
  String get noCoursesSelected => 'No courses selected';

  @override
  String get addCourseToStart => 'Click \"Add Course\" to start';

  @override
  String get trackCourseRequests => 'Track your course requests';

  @override
  String get pending => 'Pending';

  @override
  String get approved => 'Approved';

  @override
  String get rejected => 'Rejected';

  @override
  String get allRegistrations => 'All Registrations';

  @override
  String get noRegistrationRequests => 'No registration requests yet.';

  @override
  String coursesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count courses',
      one: '1 course',
      zero: 'No courses',
    );
    return '$_temp0';
  }

  @override
  String get submitted => 'Submitted';

  @override
  String get totalCourses => 'Total Courses';

  @override
  String get academicAdvisor => 'Academic Advisor';

  @override
  String get rejectionReason => 'Rejection Reason:';

  @override
  String get advisorNote => 'Advisor Note:';
}
