// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'المرشد الأكاديمي';

  @override
  String get splashTagline => 'رفيقك الأكاديمي المدعوم بالذكاء الاصطناعي';

  @override
  String get smartPlanning => 'تخطيط ذكي';

  @override
  String get aiPowered => 'مدعوم بالذكاء الاصطناعي';

  @override
  String get skip => 'تخطي';

  @override
  String get aiPoweredRecommendations => 'توصيات مدعومة بالذكاء الاصطناعي';

  @override
  String get personalizedCourseSuggestions =>
      'احصل على اقتراحات مقررات مخصصة لتحسين معدلك وتحقيق أهدافك';

  @override
  String get next => 'التالي';

  @override
  String get trackYourProgress => 'تابع تقدمك';

  @override
  String get trackProgressDescription =>
      'تابع معدلك، وحاكي درجاتك، وخطط لمسارك نحو النجاح الأكاديمي';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get skipForNow => 'تخطي الآن';

  @override
  String get academicSuccessPartner => 'شريك نجاحك الأكاديمي';

  @override
  String get chooseYourRole => 'اختر دورك';

  @override
  String get continueToApp => 'للمتابعة إلى المرشد الأكاديمي';

  @override
  String get student => 'طالب';

  @override
  String get studentRoleDescription => 'الوصول إلى المقررات والدرجات والجدول';

  @override
  String get advisor => 'مرشد أكاديمي';

  @override
  String get advisorRoleDescription => 'إدارة الطلاب والإرشاد الأكاديمي';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailHint => 'email@university.edu';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get validEmailRequired => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordSixCharacters => 'يجب ألا تقل كلمة المرور عن 6 أحرف';

  @override
  String get loginAsStudent => 'تسجيل الدخول كطالب';

  @override
  String get loginAsAdvisor => 'تسجيل الدخول كمرشد';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get loggingIn => 'جارٍ تسجيل الدخول...';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get loginSuccessful => 'تم تسجيل الدخول';

  @override
  String welcomeBackName(String name) {
    return 'مرحبًا بعودتك، $name';
  }

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String wrongRoleAccount(String role) {
    return 'هذا الحساب ليس حساب $role';
  }

  @override
  String get verificationCodeSent => 'تم إرسال رمز التحقق';

  @override
  String get couldNotSendCode => 'تعذر إرسال الرمز';

  @override
  String get forgotPasswordHelp => 'لا تقلق! سنساعدك على إعادة تعيينها.';

  @override
  String get emailAddressHint => 'your.email@university.edu.eg';

  @override
  String get emailVerificationHelp =>
      'سنرسل رمز تحقق مكونًا من 6 أرقام إلى هذا البريد';

  @override
  String get sending => 'جارٍ الإرسال...';

  @override
  String get sendVerificationCode => 'إرسال رمز التحقق';

  @override
  String get rememberPassword => 'هل تذكرت كلمة المرور؟';

  @override
  String get backToLogin => 'العودة لتسجيل الدخول';

  @override
  String get passwordUpdated => 'تم تحديث كلمة المرور';

  @override
  String get passwordResetFailed => 'فشل إعادة تعيين كلمة المرور';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get strongPasswordHelp => 'أنشئ كلمة مرور قوية لحسابك';

  @override
  String get enterNewPassword => 'أدخل كلمة المرور الجديدة';

  @override
  String get confirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get confirmNewPassword => 'أكد كلمة المرور الجديدة';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get incompleteCode => 'الرمز غير مكتمل';

  @override
  String get completeVerificationCode =>
      'يرجى إدخال رمز التحقق الكامل المكون من 6 أرقام.';

  @override
  String get codeVerified => 'تم التحقق من الرمز';

  @override
  String get verificationCodeAccepted => 'تم قبول رمز التحقق بنجاح.';

  @override
  String get verificationFailed => 'فشل التحقق';

  @override
  String get codeSent => 'تم إرسال الرمز';

  @override
  String get newVerificationCodeSent =>
      'تم إرسال رمز تحقق جديد إلى بريدك الإلكتروني.';

  @override
  String get couldNotResendCode => 'تعذر إعادة إرسال الرمز';

  @override
  String get verifyCode => 'التحقق من الرمز';

  @override
  String get checkEmailForCode => 'راجع بريدك الإلكتروني للحصول على الرمز';

  @override
  String resendIn(int seconds) {
    return 'إعادة الإرسال خلال $seconds';
  }

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String get verify => 'تحقق';

  @override
  String get failedToLoadDepartments => 'فشل تحميل الأقسام';

  @override
  String failedToLoadDepartmentsMessage(String message) {
    return 'فشل تحميل الأقسام: $message';
  }

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get enterFirstName => 'أدخل اسمك الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get enterLastName => 'أدخل اسم العائلة';

  @override
  String get studentCode => 'كود الطالب';

  @override
  String get gpa => 'المعدل';

  @override
  String get creditsLabel => 'الساعات المعتمدة';

  @override
  String get level => 'المستوى';

  @override
  String get recommendedCourses => 'المقررات الموصى بها';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get registrationAlert => 'تنبيه التسجيل';

  @override
  String get registrationAlertMessage =>
      'فتح تسجيل المقررات لفصل ربيع 2025 بعد 3 أيام. تحقق من جدولك المحفوظ.';

  @override
  String get degreeProgress => 'تقدم البرنامج الدراسي';

  @override
  String get degreeProgramName => 'بكالوريوس علوم الحاسب';

  @override
  String creditsRatio(String completed, String required) {
    return '$completed / $required';
  }

  @override
  String onTrackToGraduate(String semester) {
    return 'أنت على المسار الصحيح للتخرج في $semester.';
  }

  @override
  String get spring2026 => 'ربيع 2026';

  @override
  String courseCredits(String credits) {
    return '$credits ساعات معتمدة';
  }

  @override
  String get homeTab => 'الرئيسية';

  @override
  String get coursesTab => 'المقررات';

  @override
  String get aiChatTab => 'الدردشة الذكية';

  @override
  String get servicesTab => 'الخدمات';

  @override
  String get profileTab => 'الملف الشخصي';

  @override
  String get courseCatalogTitle => 'كتالوج المقررات';

  @override
  String get searchCoursesHint => 'ابحث عن المقررات...';

  @override
  String courseLevel(String level) {
    return 'المستوى $level';
  }

  @override
  String courseSemester(String semester) {
    return 'الفصل الدراسي $semester';
  }

  @override
  String get courseDescription => 'الوصف';

  @override
  String get academicPlacement => 'التصنيف الأكاديمي';

  @override
  String get specializations => 'التخصصات';

  @override
  String get semester => 'الفصل الدراسي';

  @override
  String courseAcademicPlacement(String level, String semester) {
    return 'المستوى $level، الفصل الدراسي $semester.';
  }

  @override
  String get courseCatalogEmptyMessage => 'لم يتم العثور على مقررات';

  @override
  String get aiChatUserDataUnavailableTitle => 'بيانات المستخدم غير متوفرة';

  @override
  String get aiChatUserDataLoadingDescription =>
      'يرجى الانتظار حتى يتم تحميل بيانات ملفك الشخصي.';

  @override
  String get aiChatStudentIdUnavailableTitle => 'معرّف الطالب غير متوفر';

  @override
  String get aiChatStudentIdMissingDescription =>
      'رمز الطالب مفقود من ملفك الشخصي.';

  @override
  String get aiChatAssistantTitle => 'المساعد الذكي';

  @override
  String get aiChatStatusOnline => 'متصل';

  @override
  String get aiChatAskAnythingHint => 'اطرح علي أي سؤال...';

  @override
  String get aiChatQuickActionRecommendCourses => 'اقتراح مقررات';

  @override
  String get aiChatQuickActionGpaSimulator => 'محاكاة المعدل';

  @override
  String get aiChatQuickActionBoostMyGpa => 'رفع معدلي';

  @override
  String get aiChatQuickActionStudyPlan => 'خطة دراسية';

  @override
  String get nationalId => 'الرقم القومي';

  @override
  String get enterNationalId => 'أدخل الرقم القومي';

  @override
  String get signingUp => 'جارٍ إنشاء الحساب...';

  @override
  String get registrationSuccessful => 'تم إنشاء الحساب';

  @override
  String get registrationFailed => 'فشل إنشاء الحساب';

  @override
  String get phone => 'رقم الهاتف';

  @override
  String get department => 'القسم';

  @override
  String get selectDepartment => 'اختر قسمك';

  @override
  String get departmentRequired => 'يرجى اختيار القسم';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get completeYourProfile => 'أكمل ملفك الشخصي';

  @override
  String get addProfilePhoto => 'أضف صورة شخصية لتخصيص حسابك.';

  @override
  String get whyAddPhoto => 'لماذا تضيف صورة؟';

  @override
  String get photoExplanation =>
      'تساعدك الصورة الشخصية على تقديم نفسك، ويمكنك تغييرها أو حذفها لاحقًا من إعدادات الملف الشخصي.';

  @override
  String get continueAction => 'متابعة';

  @override
  String get nameRequired => 'الاسم مطلوب';

  @override
  String get nameMinLength => 'يجب ألا يقل الاسم عن 3 أحرف';

  @override
  String get codeRequired => 'الرمز مطلوب';

  @override
  String get codeSixDigits => 'يجب أن يتكون الرمز من 6 أرقام';

  @override
  String get codeDigitsOnly => 'يجب أن يحتوي الرمز على أرقام فقط';
}
