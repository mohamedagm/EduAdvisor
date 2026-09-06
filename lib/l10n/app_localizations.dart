import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Application name shown on the splash screen
  ///
  /// In en, this message translates to:
  /// **'EduAdvisor'**
  String get appTitle;

  /// Subtitle shown below the application name
  ///
  /// In en, this message translates to:
  /// **'Your AI-Powered Academic Companion'**
  String get splashTagline;

  /// Splash screen feature chip
  ///
  /// In en, this message translates to:
  /// **'Smart Planning'**
  String get smartPlanning;

  /// Splash screen feature chip
  ///
  /// In en, this message translates to:
  /// **'AI Powered'**
  String get aiPowered;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @aiPoweredRecommendations.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Recommendations'**
  String get aiPoweredRecommendations;

  /// No description provided for @personalizedCourseSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Get personalized course suggestions to boost your GPA and achieve your goals'**
  String get personalizedCourseSuggestions;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @trackYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Track Your Progress'**
  String get trackYourProgress;

  /// No description provided for @trackProgressDescription.
  ///
  /// In en, this message translates to:
  /// **'Monitor your GPA, simulate grades, and plan your path to academic success'**
  String get trackProgressDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get skipForNow;

  /// No description provided for @academicSuccessPartner.
  ///
  /// In en, this message translates to:
  /// **'Your Academic Success Partner'**
  String get academicSuccessPartner;

  /// No description provided for @chooseYourRole.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Role'**
  String get chooseYourRole;

  /// No description provided for @continueToApp.
  ///
  /// In en, this message translates to:
  /// **'to continue to EduAdvisor'**
  String get continueToApp;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @studentRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'Access courses, grades & schedule'**
  String get studentRoleDescription;

  /// No description provided for @advisor.
  ///
  /// In en, this message translates to:
  /// **'Advisor'**
  String get advisor;

  /// No description provided for @advisorRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage students & academic advising'**
  String get advisorRoleDescription;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'email@university.edu'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @validEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validEmailRequired;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordSixCharacters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordSixCharacters;

  /// No description provided for @loginAsStudent.
  ///
  /// In en, this message translates to:
  /// **'Login as student'**
  String get loginAsStudent;

  /// No description provided for @loginAsAdvisor.
  ///
  /// In en, this message translates to:
  /// **'Login as advisor'**
  String get loginAsAdvisor;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @loggingIn.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loggingIn;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessful;

  /// No description provided for @welcomeBackName.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}'**
  String welcomeBackName(String name);

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @wrongRoleAccount.
  ///
  /// In en, this message translates to:
  /// **'This account is not a {role} account'**
  String wrongRoleAccount(String role);

  /// No description provided for @verificationCodeSent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent'**
  String get verificationCodeSent;

  /// No description provided for @couldNotSendCode.
  ///
  /// In en, this message translates to:
  /// **'Could not send code'**
  String get couldNotSendCode;

  /// No description provided for @forgotPasswordHelp.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry! We\'ll help you reset it.'**
  String get forgotPasswordHelp;

  /// No description provided for @emailAddressHint.
  ///
  /// In en, this message translates to:
  /// **'your.email@university.edu.eg'**
  String get emailAddressHint;

  /// No description provided for @emailVerificationHelp.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a 6-digit verification code to this email'**
  String get emailVerificationHelp;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get sendVerificationCode;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get rememberPassword;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated'**
  String get passwordUpdated;

  /// No description provided for @passwordResetFailed.
  ///
  /// In en, this message translates to:
  /// **'Password reset failed'**
  String get passwordResetFailed;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @updatePasswordBtn.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePasswordBtn;

  /// No description provided for @strongPasswordHelp.
  ///
  /// In en, this message translates to:
  /// **'Create a strong password for your account'**
  String get strongPasswordHelp;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterNewPassword;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @incompleteCode.
  ///
  /// In en, this message translates to:
  /// **'Incomplete code'**
  String get incompleteCode;

  /// No description provided for @completeVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the complete 6-digit verification code.'**
  String get completeVerificationCode;

  /// No description provided for @codeVerified.
  ///
  /// In en, this message translates to:
  /// **'Code verified'**
  String get codeVerified;

  /// No description provided for @verificationCodeAccepted.
  ///
  /// In en, this message translates to:
  /// **'Your verification code was accepted successfully.'**
  String get verificationCodeAccepted;

  /// No description provided for @verificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification failed'**
  String get verificationFailed;

  /// No description provided for @codeSent.
  ///
  /// In en, this message translates to:
  /// **'Code sent'**
  String get codeSent;

  /// No description provided for @newVerificationCodeSent.
  ///
  /// In en, this message translates to:
  /// **'A new verification code was sent to your email.'**
  String get newVerificationCodeSent;

  /// No description provided for @couldNotResendCode.
  ///
  /// In en, this message translates to:
  /// **'Could not resend code'**
  String get couldNotResendCode;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get verifyCode;

  /// No description provided for @checkEmailForCode.
  ///
  /// In en, this message translates to:
  /// **'Check your email for the code'**
  String get checkEmailForCode;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}'**
  String resendIn(int seconds);

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @failedToLoadDepartments.
  ///
  /// In en, this message translates to:
  /// **'Failed to load departments'**
  String get failedToLoadDepartments;

  /// No description provided for @failedToLoadDepartmentsMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load departments: {message}'**
  String failedToLoadDepartmentsMessage(String message);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterFirstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enterLastName;

  /// No description provided for @studentCode.
  ///
  /// In en, this message translates to:
  /// **'Student code'**
  String get studentCode;

  /// Grade point average label
  ///
  /// In en, this message translates to:
  /// **'GPA'**
  String get gpa;

  /// Academic credits label
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get creditsLabel;

  /// Student academic level label
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// Section header label for recommended courses
  ///
  /// In en, this message translates to:
  /// **'Recommended Courses'**
  String get recommendedCourses;

  /// Button label to view all items
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// Title for registration alert card
  ///
  /// In en, this message translates to:
  /// **'Registration Alert'**
  String get registrationAlert;

  /// Description message for registration alert card
  ///
  /// In en, this message translates to:
  /// **'Spring 2025 course registration opens in 3 days. Check your saved schedule.'**
  String get registrationAlertMessage;

  /// Title for the course prerequisites map card
  ///
  /// In en, this message translates to:
  /// **'Course Prerequisites Map'**
  String get courseTreeTitle;

  /// Description message for the course prerequisites map card
  ///
  /// In en, this message translates to:
  /// **'Explore every course and check its prerequisites before registration.'**
  String get courseTreeMessage;

  /// Action label to open the course prerequisites map in a browser
  ///
  /// In en, this message translates to:
  /// **'Open Course Map'**
  String get courseTreeOpen;

  /// Tooltip for the course prerequisites helper button
  ///
  /// In en, this message translates to:
  /// **'View course prerequisites'**
  String get courseTreeTooltip;

  /// Title for the error shown when the course map link cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Can\'t open link'**
  String get courseTreeLaunchErrorTitle;

  /// Description for the error shown when the course map link cannot be opened
  ///
  /// In en, this message translates to:
  /// **'No browser is available to open the course map.'**
  String get courseTreeLaunchErrorMessage;

  /// Title for degree progress card
  ///
  /// In en, this message translates to:
  /// **'Degree Progress'**
  String get degreeProgress;

  /// Degree program name shown on degree progress card
  ///
  /// In en, this message translates to:
  /// **'Bachelor of Computer Science'**
  String get degreeProgramName;

  /// Progress ratio for completed vs required credits
  ///
  /// In en, this message translates to:
  /// **'{completed} / {required}'**
  String creditsRatio(String completed, String required);

  /// Text describing expected graduation semester
  ///
  /// In en, this message translates to:
  /// **'You are on track to graduate in {semester}.'**
  String onTrackToGraduate(String semester);

  /// Graduation semester label
  ///
  /// In en, this message translates to:
  /// **'Spring 2026'**
  String get spring2026;

  /// Course credits label
  ///
  /// In en, this message translates to:
  /// **'{credits} Credits'**
  String courseCredits(String credits);

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @coursesTab.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get coursesTab;

  /// No description provided for @aiChatTab.
  ///
  /// In en, this message translates to:
  /// **'AI Chat'**
  String get aiChatTab;

  /// No description provided for @servicesTab.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get servicesTab;

  /// No description provided for @profileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// No description provided for @courseCatalogTitle.
  ///
  /// In en, this message translates to:
  /// **'Course Catalog'**
  String get courseCatalogTitle;

  /// No description provided for @searchCoursesHint.
  ///
  /// In en, this message translates to:
  /// **'Search courses...'**
  String get searchCoursesHint;

  /// Course level label
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String courseLevel(String level);

  /// Course semester label
  ///
  /// In en, this message translates to:
  /// **'Semester {semester}'**
  String courseSemester(String semester);

  /// No description provided for @courseDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get courseDescription;

  /// No description provided for @academicPlacement.
  ///
  /// In en, this message translates to:
  /// **'Academic Placement'**
  String get academicPlacement;

  /// No description provided for @specializations.
  ///
  /// In en, this message translates to:
  /// **'Specializations'**
  String get specializations;

  /// No description provided for @semester.
  ///
  /// In en, this message translates to:
  /// **'Semester'**
  String get semester;

  /// Academic placement summary for course details
  ///
  /// In en, this message translates to:
  /// **'Level {level}, semester {semester}.'**
  String courseAcademicPlacement(String level, String semester);

  /// No description provided for @courseCatalogEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No courses found'**
  String get courseCatalogEmptyMessage;

  /// No description provided for @aiChatUserDataUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'User data unavailable'**
  String get aiChatUserDataUnavailableTitle;

  /// No description provided for @aiChatUserDataLoadingDescription.
  ///
  /// In en, this message translates to:
  /// **'Please wait for your profile data to load.'**
  String get aiChatUserDataLoadingDescription;

  /// No description provided for @aiChatStudentIdUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Student ID unavailable'**
  String get aiChatStudentIdUnavailableTitle;

  /// No description provided for @aiChatStudentIdMissingDescription.
  ///
  /// In en, this message translates to:
  /// **'Your student code is missing from your profile.'**
  String get aiChatStudentIdMissingDescription;

  /// No description provided for @aiChatAssistantTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiChatAssistantTitle;

  /// No description provided for @aiChatStatusOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get aiChatStatusOnline;

  /// No description provided for @aiChatAskAnythingHint.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything...'**
  String get aiChatAskAnythingHint;

  /// No description provided for @aiChatQuickActionRecommendCourses.
  ///
  /// In en, this message translates to:
  /// **'Recommend Courses'**
  String get aiChatQuickActionRecommendCourses;

  /// No description provided for @aiChatQuickActionGpaSimulator.
  ///
  /// In en, this message translates to:
  /// **'GPA Simulator'**
  String get aiChatQuickActionGpaSimulator;

  /// No description provided for @aiChatQuickActionBoostMyGpa.
  ///
  /// In en, this message translates to:
  /// **'Boost My GPA'**
  String get aiChatQuickActionBoostMyGpa;

  /// No description provided for @aiChatQuickActionStudyPlan.
  ///
  /// In en, this message translates to:
  /// **'Study Plan'**
  String get aiChatQuickActionStudyPlan;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @enterNationalId.
  ///
  /// In en, this message translates to:
  /// **'Enter your national ID'**
  String get enterNationalId;

  /// No description provided for @signingUp.
  ///
  /// In en, this message translates to:
  /// **'Signing up...'**
  String get signingUp;

  /// No description provided for @registrationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registrationSuccessful;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registrationFailed;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @selectDepartment.
  ///
  /// In en, this message translates to:
  /// **'Select your department'**
  String get selectDepartment;

  /// No description provided for @departmentRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select your department'**
  String get departmentRequired;

  /// No description provided for @faculty.
  ///
  /// In en, this message translates to:
  /// **'Faculty'**
  String get faculty;

  /// No description provided for @selectFaculty.
  ///
  /// In en, this message translates to:
  /// **'Select your faculty'**
  String get selectFaculty;

  /// No description provided for @facultyRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select your faculty'**
  String get facultyRequired;

  /// No description provided for @selectFacultyFirst.
  ///
  /// In en, this message translates to:
  /// **'Select your faculty first'**
  String get selectFacultyFirst;

  /// No description provided for @fullNameArabic.
  ///
  /// In en, this message translates to:
  /// **'Full name (Arabic)'**
  String get fullNameArabic;

  /// No description provided for @fullNameEnglish.
  ///
  /// In en, this message translates to:
  /// **'Full name (English)'**
  String get fullNameEnglish;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterFullName;

  /// No description provided for @studentId.
  ///
  /// In en, this message translates to:
  /// **'Student ID'**
  String get studentId;

  /// No description provided for @enterStudentId.
  ///
  /// In en, this message translates to:
  /// **'202012345'**
  String get enterStudentId;

  /// No description provided for @emailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'student@university.edu'**
  String get emailPlaceholder;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get completeYourProfile;

  /// No description provided for @addProfilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Add a profile photo to personalize your account.'**
  String get addProfilePhoto;

  /// No description provided for @whyAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Why add a photo?'**
  String get whyAddPhoto;

  /// No description provided for @photoExplanation.
  ///
  /// In en, this message translates to:
  /// **'A profile photo helps you establish and present yourself. You can always change or remove it later in your profile settings.'**
  String get photoExplanation;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @nameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 3 characters'**
  String get nameMinLength;

  /// No description provided for @codeRequired.
  ///
  /// In en, this message translates to:
  /// **'Code is required'**
  String get codeRequired;

  /// No description provided for @codeSixDigits.
  ///
  /// In en, this message translates to:
  /// **'Code must be 6 digits'**
  String get codeSixDigits;

  /// No description provided for @codeDigitsOnly.
  ///
  /// In en, this message translates to:
  /// **'Code must contain only digits'**
  String get codeDigitsOnly;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @profileStudentId.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String profileStudentId(String id);

  /// No description provided for @progressToGraduation.
  ///
  /// In en, this message translates to:
  /// **'Progress to Graduation'**
  String get progressToGraduation;

  /// No description provided for @creditsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Credits Completed'**
  String get creditsCompleted;

  /// No description provided for @creditsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No credits remaining} =1{1 credit remaining} other{{count} credits remaining}}'**
  String creditsRemaining(int count);

  /// No description provided for @myCourses.
  ///
  /// In en, this message translates to:
  /// **'My Courses'**
  String get myCourses;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @allFilter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allFilter;

  /// No description provided for @passed.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get passed;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @noProfileCourses.
  ///
  /// In en, this message translates to:
  /// **'No courses here yet.'**
  String get noProfileCourses;

  /// No description provided for @courseFallbackName.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get courseFallbackName;

  /// No description provided for @creditHoursShort.
  ///
  /// In en, this message translates to:
  /// **'{credits} cr'**
  String creditHoursShort(String credits);

  /// No description provided for @validSelectionString.
  ///
  /// In en, this message translates to:
  /// **'Selection is valid ({total} hours)'**
  String validSelectionString(int total);

  /// No description provided for @invalidSelectionString.
  ///
  /// In en, this message translates to:
  /// **'You selected {total} hours. Required is between {min} and {max} hours.'**
  String invalidSelectionString(int total, int min, int max);

  /// No description provided for @attemptNumber.
  ///
  /// In en, this message translates to:
  /// **'Attempt {number}'**
  String attemptNumber(int number);

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @unreadNotifications.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No unread notifications} =1{1 unread notification} other{{count} unread notifications}}'**
  String unreadNotifications(int count);

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @courseRegistrationApproved.
  ///
  /// In en, this message translates to:
  /// **'Course Registration Approved'**
  String get courseRegistrationApproved;

  /// No description provided for @courseRegistrationApprovedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your course registration request has been approved'**
  String get courseRegistrationApprovedMessage;

  /// No description provided for @courseRegistrationRejected.
  ///
  /// In en, this message translates to:
  /// **'Course Registration Rejected'**
  String get courseRegistrationRejected;

  /// No description provided for @courseRegistrationRejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your course registration request was rejected'**
  String get courseRegistrationRejectedMessage;

  /// No description provided for @newNotification.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newNotification;

  /// No description provided for @viewRejectionReason.
  ///
  /// In en, this message translates to:
  /// **'View rejection reason'**
  String get viewRejectionReason;

  /// No description provided for @newCourseAvailable.
  ///
  /// In en, this message translates to:
  /// **'New Course Available'**
  String get newCourseAvailable;

  /// No description provided for @courseAvailableForEnrollment.
  ///
  /// In en, this message translates to:
  /// **'{course} is now available for enrollment'**
  String courseAvailableForEnrollment(String course);

  /// No description provided for @registrationDeadline.
  ///
  /// In en, this message translates to:
  /// **'Registration Deadline'**
  String get registrationDeadline;

  /// No description provided for @registrationDeadlineMessage.
  ///
  /// In en, this message translates to:
  /// **'Course registration for {semester} ends in {days, plural, =1{1 day} other{{days} days}}'**
  String registrationDeadlineMessage(String semester, int days);

  /// No description provided for @spring2024.
  ///
  /// In en, this message translates to:
  /// **'Spring 2024'**
  String get spring2024;

  /// No description provided for @databaseSystems.
  ///
  /// In en, this message translates to:
  /// **'Database Systems'**
  String get databaseSystems;

  /// No description provided for @artificialIntelligence.
  ///
  /// In en, this message translates to:
  /// **'Artificial Intelligence'**
  String get artificialIntelligence;

  /// No description provided for @advancedAlgorithms.
  ///
  /// In en, this message translates to:
  /// **'Advanced Algorithms'**
  String get advancedAlgorithms;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Just now} =1{1 hour ago} other{{count} hours ago}}'**
  String hoursAgo(int count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Today} =1{1 day ago} other{{count} days ago}}'**
  String daysAgo(int count);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @profileInformation.
  ///
  /// In en, this message translates to:
  /// **'Profile Information'**
  String get profileInformation;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @englishLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  /// No description provided for @arabicLanguage.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabicLanguage;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @appearanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how EduAdvisor looks on this device'**
  String get appearanceDescription;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @themeOptionSemantics.
  ///
  /// In en, this message translates to:
  /// **'{theme} theme'**
  String themeOptionSemantics(String theme);

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @receivePushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Receive push notifications'**
  String get receivePushNotifications;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @receiveEmailUpdates.
  ///
  /// In en, this message translates to:
  /// **'Receive email updates'**
  String get receiveEmailUpdates;

  /// No description provided for @gradeAlerts.
  ///
  /// In en, this message translates to:
  /// **'Grade Alerts'**
  String get gradeAlerts;

  /// No description provided for @notifyWhenGradesPosted.
  ///
  /// In en, this message translates to:
  /// **'Notify when grades are posted'**
  String get notifyWhenGradesPosted;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @aboutEduAdvisor.
  ///
  /// In en, this message translates to:
  /// **'About EduAdvisor'**
  String get aboutEduAdvisor;

  /// No description provided for @settingOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingOn;

  /// No description provided for @settingOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingOff;

  /// No description provided for @loggingOut.
  ///
  /// In en, this message translates to:
  /// **'Logging out...'**
  String get loggingOut;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @loggedOut.
  ///
  /// In en, this message translates to:
  /// **'Logged out'**
  String get loggedOut;

  /// No description provided for @loggedOutDescription.
  ///
  /// In en, this message translates to:
  /// **'You have been logged out successfully.'**
  String get loggedOutDescription;

  /// No description provided for @loggedOutLocally.
  ///
  /// In en, this message translates to:
  /// **'Logged out locally'**
  String get loggedOutLocally;

  /// No description provided for @loggedOutLocallyDescription.
  ///
  /// In en, this message translates to:
  /// **'Your local session has been cleared.'**
  String get loggedOutLocallyDescription;

  /// No description provided for @servicesDescription.
  ///
  /// In en, this message translates to:
  /// **'Access academic tools and resources'**
  String get servicesDescription;

  /// No description provided for @academicTools.
  ///
  /// In en, this message translates to:
  /// **'Academic Tools'**
  String get academicTools;

  /// No description provided for @courseRecommendationService.
  ///
  /// In en, this message translates to:
  /// **'Course Recommendation'**
  String get courseRecommendationService;

  /// No description provided for @courseRecommendationServiceDescription.
  ///
  /// In en, this message translates to:
  /// **'Get AI-powered course suggestions based on your GPA, level, and academic history.'**
  String get courseRecommendationServiceDescription;

  /// No description provided for @smartRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Smart Recommendations'**
  String get smartRecommendations;

  /// No description provided for @courseRegistrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Course Registration'**
  String get courseRegistrationTitle;

  /// No description provided for @courseRegistrationServiceDescription.
  ///
  /// In en, this message translates to:
  /// **'Select and register for courses with details on code, name, credits, and prerequisites.'**
  String get courseRegistrationServiceDescription;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @registrationStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration Status'**
  String get registrationStatusTitle;

  /// No description provided for @registrationStatusServiceDescription.
  ///
  /// In en, this message translates to:
  /// **'Track your registration requests and view advisor approval status in real-time.'**
  String get registrationStatusServiceDescription;

  /// No description provided for @checkStatus.
  ///
  /// In en, this message translates to:
  /// **'Check Status'**
  String get checkStatus;

  /// No description provided for @courseRecommendationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Course Recommendations'**
  String get courseRecommendationsTitle;

  /// No description provided for @aiPoweredSuggestionsForYou.
  ///
  /// In en, this message translates to:
  /// **'AI-powered suggestions for you'**
  String get aiPoweredSuggestionsForYou;

  /// No description provided for @personalizedForYou.
  ///
  /// In en, this message translates to:
  /// **'Personalized for You'**
  String get personalizedForYou;

  /// No description provided for @basedOnAcademicProfile.
  ///
  /// In en, this message translates to:
  /// **'Based on your academic profile'**
  String get basedOnAcademicProfile;

  /// No description provided for @aiRecommendationHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Course Recommendations'**
  String get aiRecommendationHeaderTitle;

  /// No description provided for @aiRecommendationHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hand-picked courses based on your GPA, level, and academic history.'**
  String get aiRecommendationHeaderSubtitle;

  /// No description provided for @totalSelectedHours.
  ///
  /// In en, this message translates to:
  /// **'Total Hours'**
  String get totalSelectedHours;

  /// No description provided for @maxAllowedHoursLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Allowed'**
  String get maxAllowedHoursLabel;

  /// No description provided for @advisorScore.
  ///
  /// In en, this message translates to:
  /// **'Advisor Match'**
  String get advisorScore;

  /// No description provided for @creditHoursLabel.
  ///
  /// In en, this message translates to:
  /// **'Credit Hours'**
  String get creditHoursLabel;

  /// No description provided for @recommendedCoursesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} Recommended Course} other{{count} Recommended Courses}}'**
  String recommendedCoursesCount(int count);

  /// No description provided for @noRecommendationsTitle.
  ///
  /// In en, this message translates to:
  /// **'No recommendations yet'**
  String get noRecommendationsTitle;

  /// No description provided for @noRecommendationsDescription.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find suitable courses for you right now. Please check back later.'**
  String get noRecommendationsDescription;

  /// No description provided for @creditLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Credit limit reached'**
  String get creditLimitReached;

  /// No description provided for @creditLimitReachedDescription.
  ///
  /// In en, this message translates to:
  /// **'You cannot exceed the maximum credit limit.'**
  String get creditLimitReachedDescription;

  /// No description provided for @registrationSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Registration submitted'**
  String get registrationSubmitted;

  /// No description provided for @submissionFailed.
  ///
  /// In en, this message translates to:
  /// **'Submission failed'**
  String get submissionFailed;

  /// No description provided for @spring2024Semester.
  ///
  /// In en, this message translates to:
  /// **'Spring 2024 Semester'**
  String get spring2024Semester;

  /// No description provided for @selectedCoursesCount.
  ///
  /// In en, this message translates to:
  /// **'Selected Courses ({count})'**
  String selectedCoursesCount(int count);

  /// No description provided for @addCourse.
  ///
  /// In en, this message translates to:
  /// **'Add Course'**
  String get addCourse;

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submitting;

  /// No description provided for @submitForApproval.
  ///
  /// In en, this message translates to:
  /// **'Submit for Approval'**
  String get submitForApproval;

  /// No description provided for @availableCourses.
  ///
  /// In en, this message translates to:
  /// **'Available Courses'**
  String get availableCourses;

  /// No description provided for @noAvailableCourses.
  ///
  /// In en, this message translates to:
  /// **'No available courses.'**
  String get noAvailableCourses;

  /// No description provided for @retake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get retake;

  /// No description provided for @retakeCourseDescription.
  ///
  /// In en, this message translates to:
  /// **'This course is marked as a retake.'**
  String get retakeCourseDescription;

  /// No description provided for @totalCreditHours.
  ///
  /// In en, this message translates to:
  /// **'Total Credit Hours'**
  String get totalCreditHours;

  /// No description provided for @creditHoursRequired.
  ///
  /// In en, this message translates to:
  /// **'{min} - {max} hours required'**
  String creditHoursRequired(int min, int max);

  /// No description provided for @addMoreCreditHours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Add 1 more credit hour} other{Add {count} more credit hours}}'**
  String addMoreCreditHours(int count);

  /// No description provided for @minimumCreditRequirementMet.
  ///
  /// In en, this message translates to:
  /// **'Minimum credit requirement met'**
  String get minimumCreditRequirementMet;

  /// No description provided for @noCoursesSelected.
  ///
  /// In en, this message translates to:
  /// **'No courses selected'**
  String get noCoursesSelected;

  /// No description provided for @addCourseToStart.
  ///
  /// In en, this message translates to:
  /// **'Click \"Add Course\" to start'**
  String get addCourseToStart;

  /// No description provided for @trackCourseRequests.
  ///
  /// In en, this message translates to:
  /// **'Track your course requests'**
  String get trackCourseRequests;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @allRegistrations.
  ///
  /// In en, this message translates to:
  /// **'All Registrations'**
  String get allRegistrations;

  /// No description provided for @noRegistrationRequests.
  ///
  /// In en, this message translates to:
  /// **'No registration requests yet.'**
  String get noRegistrationRequests;

  /// No description provided for @coursesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No courses} =1{1 course} other{{count} courses}}'**
  String coursesCount(int count);

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @totalCourses.
  ///
  /// In en, this message translates to:
  /// **'Total Courses'**
  String get totalCourses;

  /// No description provided for @enrolledCourses.
  ///
  /// In en, this message translates to:
  /// **'Enrolled Courses'**
  String get enrolledCourses;

  /// No description provided for @academicAdvisor.
  ///
  /// In en, this message translates to:
  /// **'Academic Advisor'**
  String get academicAdvisor;

  /// No description provided for @rejectionReason.
  ///
  /// In en, this message translates to:
  /// **'Rejection Reason:'**
  String get rejectionReason;

  /// No description provided for @advisorNote.
  ///
  /// In en, this message translates to:
  /// **'Advisor Note:'**
  String get advisorNote;

  /// No description provided for @newRequests.
  ///
  /// In en, this message translates to:
  /// **'New Requests'**
  String get newRequests;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String statusLabel(String status);

  /// No description provided for @requested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get requested;

  /// No description provided for @hasPrerequisites.
  ///
  /// In en, this message translates to:
  /// **'Has Prerequisites'**
  String get hasPrerequisites;

  /// No description provided for @prerequisites.
  ///
  /// In en, this message translates to:
  /// **'Prerequisites:'**
  String get prerequisites;

  /// No description provided for @gpaValue.
  ///
  /// In en, this message translates to:
  /// **'GPA: {gpa}'**
  String gpaValue(String gpa);

  /// No description provided for @notTaken.
  ///
  /// In en, this message translates to:
  /// **'Not Taken'**
  String get notTaken;

  /// No description provided for @noAcademicHistory.
  ///
  /// In en, this message translates to:
  /// **'No previous academic history found.'**
  String get noAcademicHistory;

  /// No description provided for @coursesEnrolled.
  ///
  /// In en, this message translates to:
  /// **'{count} Courses Enrolled'**
  String coursesEnrolled(int count);

  /// No description provided for @creditHours.
  ///
  /// In en, this message translates to:
  /// **'{hours} Hours'**
  String creditHours(int hours);

  /// No description provided for @yearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year {year}'**
  String yearLabel(int year);

  /// No description provided for @noRequestsFound.
  ///
  /// In en, this message translates to:
  /// **'No requests found'**
  String get noRequestsFound;

  /// No description provided for @studentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get studentsLabel;

  /// No description provided for @currentRequests.
  ///
  /// In en, this message translates to:
  /// **'Current Requests'**
  String get currentRequests;

  /// No description provided for @academicHistory.
  ///
  /// In en, this message translates to:
  /// **'Academic History'**
  String get academicHistory;

  /// No description provided for @acceptRequest.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptRequest;

  /// No description provided for @rejectRequest.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rejectRequest;

  /// No description provided for @rejectRegistrationRequest.
  ///
  /// In en, this message translates to:
  /// **'Reject Registration Request'**
  String get rejectRegistrationRequest;

  /// No description provided for @rejectionReasonPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please provide a reason for rejecting this request. This will be shared with the student.'**
  String get rejectionReasonPrompt;

  /// No description provided for @rejectionReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Enter rejection reason (e.g., Prerequisites not met...)'**
  String get rejectionReasonHint;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirmRejection.
  ///
  /// In en, this message translates to:
  /// **'Confirm Rejection'**
  String get confirmRejection;

  /// No description provided for @rejectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Rejection Failed'**
  String get rejectionFailed;

  /// No description provided for @requestRejected.
  ///
  /// In en, this message translates to:
  /// **'Request Rejected'**
  String get requestRejected;

  /// No description provided for @requestRejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'The request has been moved to the rejected list.'**
  String get requestRejectedMessage;

  /// No description provided for @approvalFailed.
  ///
  /// In en, this message translates to:
  /// **'Approval Failed'**
  String get approvalFailed;

  /// No description provided for @requestApproved.
  ///
  /// In en, this message translates to:
  /// **'Request Approved'**
  String get requestApproved;

  /// No description provided for @requestApprovedMessage.
  ///
  /// In en, this message translates to:
  /// **'The student\'s courses have been accepted.'**
  String get requestApprovedMessage;

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorPrefix(String message);

  /// No description provided for @requestsTab.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsTab;

  /// No description provided for @analyticsTab.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analyticsTab;

  /// No description provided for @analyticsAndReports.
  ///
  /// In en, this message translates to:
  /// **'Analytics & Reports'**
  String get analyticsAndReports;

  /// No description provided for @totalStudents.
  ///
  /// In en, this message translates to:
  /// **'Total Students'**
  String get totalStudents;

  /// No description provided for @pendingRequests.
  ///
  /// In en, this message translates to:
  /// **'Pending Requests'**
  String get pendingRequests;

  /// No description provided for @popularCourses.
  ///
  /// In en, this message translates to:
  /// **'Popular Courses'**
  String get popularCourses;

  /// No description provided for @dataStructures.
  ///
  /// In en, this message translates to:
  /// **'Data Structures'**
  String get dataStructures;

  /// No description provided for @studentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} students'**
  String studentsCount(int count);

  /// No description provided for @studentPerformanceOverview.
  ///
  /// In en, this message translates to:
  /// **'Student Performance Overview'**
  String get studentPerformanceOverview;

  /// No description provided for @gpaAtLeast.
  ///
  /// In en, this message translates to:
  /// **'GPA >= {threshold}'**
  String gpaAtLeast(String threshold);

  /// No description provided for @gpaRange.
  ///
  /// In en, this message translates to:
  /// **'GPA {minimum} - {maximum}'**
  String gpaRange(String minimum, String maximum);

  /// No description provided for @gpaBelow.
  ///
  /// In en, this message translates to:
  /// **'GPA < {threshold}'**
  String gpaBelow(String threshold);

  /// No description provided for @studentsPercentage.
  ///
  /// In en, this message translates to:
  /// **'{count} students ({percentage}%)'**
  String studentsPercentage(int count, String percentage);

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
