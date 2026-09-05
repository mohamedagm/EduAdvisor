import 'package:edu_advisor/features/requests/data/repo/prerequisites_repository.dart';
import 'package:edu_advisor/features/requests/data/repo/student_history_repo.dart';
import 'package:edu_advisor/features/requests/manager/cubit/student_hestory_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_interceptor.dart';
import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/routing/app_startup_service.dart';
import 'package:edu_advisor/core/services/secure_storage_service.dart';
import 'package:edu_advisor/core/services/token_storage_service.dart';
import 'package:edu_advisor/core/services/user_cache_service.dart';
import 'package:edu_advisor/features/AIChat/data/datasources/ai_chat_remote_data_source.dart';
import 'package:edu_advisor/features/AIChat/data/repo/ai_chat_repo.dart';
import 'package:edu_advisor/features/advisor_nav/data/repo/advisor_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/departments_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/faculties_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/forgot_password_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/reset_password_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/verify_code_repo.dart';
import 'package:edu_advisor/features/CourseCatalog/data/repo/course_catalog_repo.dart';
import 'package:edu_advisor/features/profile/data/repo/profile_courses_repo.dart';
import 'package:edu_advisor/features/requests/data/repo/advisor_request_repo.dart';
import 'package:edu_advisor/features/services/data/repo/course_registration_repo.dart';
import 'package:edu_advisor/features/services/data/repo/recommendation_repo.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';

import 'package:edu_advisor/features/requests/manager/cubit/prerequisites_cubit.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  if (getIt.isRegistered<SecureStorageService>()) {
    return;
  }

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  getIt.registerLazySingleton<TokenStorageService>(
    () => TokenStorageService(secureStorageService: getIt()),
  );

  getIt.registerLazySingleton<UserCacheService>(
    () => UserCacheService(secureStorageService: getIt()),
  );

  getIt.registerLazySingleton<ApiInterceptor>(
    () =>
        ApiInterceptor(tokenStorageService: getIt(), userCacheService: getIt()),
  );

  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(apiInterceptor: getIt()),
  );

  getIt.registerLazySingleton<UserRepo>(() => UserRepo(apiConsumer: getIt()));

  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(apiConsumer: getIt()));

  getIt.registerLazySingleton<VerifyCodeRepo>(
    () => VerifyCodeRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<ForgotPasswordRepo>(
    () => ForgotPasswordRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<ResetPasswordRepo>(
    () => ResetPasswordRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<DepartmentsRepo>(
    () => DepartmentsRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<FacultiesRepo>(
    () => FacultiesRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<AdvisorRepo>(
    () => AdvisorRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<AdvisorRequestRepo>(
    () => AdvisorRequestRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<CourseCatalogRepo>(
    () => CourseCatalogRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<ProfileCoursesRepo>(
    () => ProfileCoursesRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<CourseRegistrationRepo>(
    () => CourseRegistrationRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<RecommendationRepo>(
    () => RecommendationRepo(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<AiChatRemoteDataSource>(
    () => AiChatRemoteDataSourceImpl(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<AiChatRepo>(
    () => AiChatRepo(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<AppStartupService>(
    () => AppStartupService(
      tokenStorageService: getIt(),
      userCacheService: getIt(),
      userRepo: getIt(),
    ),
  );
// 1. Register Prerequisites Repository
getIt.registerLazySingleton<PrerequisitesRepository>(
  () => PrerequisitesRepository(apiConsumer: getIt()),
);


getIt.registerFactory<PrerequisitesCubit>(
  () => PrerequisitesCubit(getIt<PrerequisitesRepository>()),
);


getIt.registerLazySingleton<StudentHistoryRepo>(
  () => StudentHistoryRepo(apiConsumer: getIt<ApiConsumer>()),
);

getIt.registerFactory<StudentHistoryCubit>(
  () => StudentHistoryCubit(getIt<StudentHistoryRepo>()),
);

}
