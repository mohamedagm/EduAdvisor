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
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';

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
}
