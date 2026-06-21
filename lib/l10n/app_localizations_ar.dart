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

  @override
  String get myProfile => 'ملفي الشخصي';

  @override
  String profileStudentId(String id) {
    return 'المعرّف: $id';
  }

  @override
  String get progressToGraduation => 'التقدم نحو التخرج';

  @override
  String get creditsCompleted => 'الساعات المعتمدة المكتملة';

  @override
  String creditsRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ساعة معتمدة متبقية',
      many: '$count ساعة معتمدة متبقية',
      few: '$count ساعات معتمدة متبقية',
      two: 'ساعتان معتمدتان متبقيتان',
      one: 'ساعة معتمدة واحدة متبقية',
      zero: 'لا توجد ساعات معتمدة متبقية',
    );
    return '$_temp0';
  }

  @override
  String get myCourses => 'مقرراتي';

  @override
  String get completed => 'مكتملة';

  @override
  String get inProgress => 'قيد الدراسة';

  @override
  String get remaining => 'متبقية';

  @override
  String get noProfileCourses => 'لا توجد مقررات هنا بعد.';

  @override
  String get courseFallbackName => 'مقرر';

  @override
  String creditHoursShort(String credits) {
    return '$credits س.م.';
  }

  @override
  String get notifications => 'الإشعارات';

  @override
  String unreadNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count إشعار غير مقروء',
      many: '$count إشعارًا غير مقروء',
      few: '$count إشعارات غير مقروءة',
      two: 'إشعاران غير مقروءين',
      one: 'إشعار واحد غير مقروء',
      zero: 'لا توجد إشعارات غير مقروءة',
    );
    return '$_temp0';
  }

  @override
  String get markAllAsRead => 'تحديد الكل كمقروء';

  @override
  String get courseRegistrationApproved => 'تمت الموافقة على تسجيل المقرر';

  @override
  String get courseRegistrationApprovedMessage =>
      'تمت الموافقة على طلب تسجيل المقرر الخاص بك';

  @override
  String get courseRegistrationRejected => 'تم رفض تسجيل المقرر';

  @override
  String get courseRegistrationRejectedMessage =>
      'تم رفض طلب تسجيل المقرر الخاص بك';

  @override
  String get newNotification => 'جديد';

  @override
  String get viewRejectionReason => 'عرض سبب الرفض';

  @override
  String get newCourseAvailable => 'مقرر جديد متاح';

  @override
  String courseAvailableForEnrollment(String course) {
    return 'أصبح $course متاحًا للتسجيل';
  }

  @override
  String get registrationDeadline => 'الموعد النهائي للتسجيل';

  @override
  String registrationDeadlineMessage(String semester, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days يوم',
      many: '$days يومًا',
      few: '$days أيام',
      two: 'يومين',
      one: 'يوم واحد',
    );
    return 'ينتهي تسجيل المقررات لفصل $semester خلال $_temp0';
  }

  @override
  String get spring2024 => 'ربيع 2024';

  @override
  String get databaseSystems => 'نظم قواعد البيانات';

  @override
  String get artificialIntelligence => 'الذكاء الاصطناعي';

  @override
  String get advancedAlgorithms => 'الخوارزميات المتقدمة';

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'منذ $count ساعة',
      many: 'منذ $count ساعة',
      few: 'منذ $count ساعات',
      two: 'منذ ساعتين',
      one: 'منذ ساعة واحدة',
      zero: 'الآن',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'منذ $count يوم',
      many: 'منذ $count يومًا',
      few: 'منذ $count أيام',
      two: 'منذ يومين',
      one: 'منذ يوم واحد',
      zero: 'اليوم',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get profileInformation => 'معلومات الملف الشخصي';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get language => 'اللغة';

  @override
  String get englishLanguage => 'الإنجليزية';

  @override
  String get arabicLanguage => 'العربية';

  @override
  String get appearance => 'المظهر';

  @override
  String get appearanceDescription => 'اختر مظهر EduAdvisor على هذا الجهاز';

  @override
  String get systemTheme => 'النظام';

  @override
  String get lightTheme => 'فاتح';

  @override
  String get darkTheme => 'داكن';

  @override
  String themeOptionSemantics(String theme) {
    return 'المظهر $theme';
  }

  @override
  String get pushNotifications => 'الإشعارات الفورية';

  @override
  String get receivePushNotifications => 'استلام الإشعارات الفورية';

  @override
  String get emailNotifications => 'إشعارات البريد الإلكتروني';

  @override
  String get receiveEmailUpdates => 'استلام التحديثات عبر البريد الإلكتروني';

  @override
  String get gradeAlerts => 'تنبيهات الدرجات';

  @override
  String get notifyWhenGradesPosted => 'التنبيه عند نشر الدرجات';

  @override
  String get security => 'الأمان';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get support => 'الدعم';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get aboutEduAdvisor => 'حول EduAdvisor';

  @override
  String get settingOn => 'مفعّل';

  @override
  String get settingOff => 'متوقف';

  @override
  String get loggingOut => 'جارٍ تسجيل الخروج...';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get loggedOut => 'تم تسجيل الخروج';

  @override
  String get loggedOutDescription => 'تم تسجيل خروجك بنجاح.';

  @override
  String get loggedOutLocally => 'تم تسجيل الخروج محليًا';

  @override
  String get loggedOutLocallyDescription => 'تم مسح جلستك المحلية.';

  @override
  String get servicesDescription => 'الوصول إلى الأدوات والموارد الأكاديمية';

  @override
  String get academicTools => 'الأدوات الأكاديمية';

  @override
  String get courseRecommendationService => 'اقتراح المقررات';

  @override
  String get courseRecommendationServiceDescription =>
      'احصل على اقتراحات مقررات مدعومة بالذكاء الاصطناعي بناءً على معدلك ومستواك وسجلك الأكاديمي.';

  @override
  String get smartRecommendations => 'اقتراحات ذكية';

  @override
  String get courseRegistrationTitle => 'تسجيل المقررات';

  @override
  String get courseRegistrationServiceDescription =>
      'اختر مقرراتك وسجّلها مع عرض الرمز والاسم والساعات والمتطلبات السابقة.';

  @override
  String get registerNow => 'سجّل الآن';

  @override
  String get registrationStatusTitle => 'حالة التسجيل';

  @override
  String get registrationStatusServiceDescription =>
      'تابع طلبات التسجيل وحالة موافقة المرشد الأكاديمي لحظة بلحظة.';

  @override
  String get checkStatus => 'تحقق من الحالة';

  @override
  String get courseRecommendationsTitle => 'اقتراحات المقررات';

  @override
  String get aiPoweredSuggestionsForYou => 'اقتراحات مخصصة بالذكاء الاصطناعي';

  @override
  String get personalizedForYou => 'مخصص لك';

  @override
  String get basedOnAcademicProfile => 'بناءً على ملفك الأكاديمي';

  @override
  String get machineLearning => 'تعلم الآلة';

  @override
  String get advancedLinearAlgebra => 'الجبر الخطي المتقدم';

  @override
  String get hardDifficulty => 'صعب';

  @override
  String get machineLearningRecommendationReason =>
      'أداء قوي في هياكل البيانات ومجال مطلوب بشدة.';

  @override
  String get programmingStrengthBenefit => 'يتوافق مع نقاط قوتك في البرمجة';

  @override
  String get jobMarketDemandBenefit => 'طلب مرتفع في سوق العمل';

  @override
  String get gpaImprovementBenefit => 'قد يحسّن معدلك بمقدار +0.4';

  @override
  String get linearAlgebraRecommendationReason =>
      'أساس قوي لتخصص الذكاء الاصطناعي وتعلم الآلة.';

  @override
  String get mlTrackBenefit => 'أساسي لمسار تعلم الآلة والذكاء الاصطناعي';

  @override
  String get mathBackgroundBenefit => 'الاستفادة من خلفيتك الرياضية القوية';

  @override
  String get researchOpportunitiesBenefit => 'فرص بحثية';

  @override
  String get recommendationsUpdatedDaily => 'تُحدّث الاقتراحات يوميًا';

  @override
  String get recommendationsAiDescription =>
      'يحلل الذكاء الاصطناعي أداءك والمتطلبات السابقة وأهدافك المهنية لاقتراح أفضل المقررات.';

  @override
  String get creditLimitReached => 'تم بلوغ حد الساعات';

  @override
  String get creditLimitReachedDescription =>
      'لا يمكنك تجاوز الحد الأقصى للساعات المعتمدة.';

  @override
  String get registrationSubmitted => 'تم إرسال طلب التسجيل';

  @override
  String get submissionFailed => 'فشل إرسال الطلب';

  @override
  String get spring2024Semester => 'فصل ربيع 2024';

  @override
  String selectedCoursesCount(int count) {
    return 'المقررات المختارة ($count)';
  }

  @override
  String get addCourse => 'إضافة مقرر';

  @override
  String get submitting => 'جارٍ الإرسال...';

  @override
  String get submitForApproval => 'إرسال للموافقة';

  @override
  String get availableCourses => 'المقررات المتاحة';

  @override
  String get noAvailableCourses => 'لا توجد مقررات متاحة.';

  @override
  String get retake => 'إعادة دراسة';

  @override
  String get retakeCourseDescription => 'هذا المقرر محدد لإعادة دراسته.';

  @override
  String get totalCreditHours => 'إجمالي الساعات المعتمدة';

  @override
  String creditHoursRequired(int min, int max) {
    return 'المطلوب من $min إلى $max ساعة';
  }

  @override
  String addMoreCreditHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'أضف $count ساعة معتمدة',
      many: 'أضف $count ساعة معتمدة',
      few: 'أضف $count ساعات معتمدة',
      two: 'أضف ساعتين معتمدتين',
      one: 'أضف ساعة معتمدة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get minimumCreditRequirementMet => 'تم استيفاء الحد الأدنى للساعات';

  @override
  String get noCoursesSelected => 'لم يتم اختيار مقررات';

  @override
  String get addCourseToStart => 'اضغط على \"إضافة مقرر\" للبدء';

  @override
  String get trackCourseRequests => 'تابع طلبات تسجيل مقرراتك';

  @override
  String get pending => 'قيد المراجعة';

  @override
  String get approved => 'تمت الموافقة';

  @override
  String get rejected => 'مرفوض';

  @override
  String get allRegistrations => 'جميع طلبات التسجيل';

  @override
  String get noRegistrationRequests => 'لا توجد طلبات تسجيل بعد.';

  @override
  String coursesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقرر',
      many: '$count مقررًا',
      few: '$count مقررات',
      two: 'مقرران',
      one: 'مقرر واحد',
      zero: 'لا توجد مقررات',
    );
    return '$_temp0';
  }

  @override
  String get submitted => 'تاريخ الإرسال';

  @override
  String get totalCourses => 'إجمالي المقررات';

  @override
  String get academicAdvisor => 'المرشد الأكاديمي';

  @override
  String get rejectionReason => 'سبب الرفض:';

  @override
  String get advisorNote => 'ملاحظة المرشد:';
}
