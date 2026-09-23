import 'dart:async';

import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fitbodyrd_flutter/features/auth/data/repositories/user_repository_impl.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:fitbodyrd_flutter/features/home/data/repositories/dashboard_repository_impl.dart';
import 'package:fitbodyrd_flutter/features/home/domain/repositories/dashboard_repository.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/cubits/home_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/nutrition/data/repositories/nutrition_repository_impl.dart';
import 'package:fitbodyrd_flutter/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_generation_cubit.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fitbodyrd_flutter/features/splash/presentation/cubits/splash_cubit/splash_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/data/repositories/workout_repository_impl.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/exercise_details_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_generation_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_history_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/env/app_env.dart';
import 'package:fitbodyrd_flutter/src/core/routing/app_router.dart';
import 'package:fitbodyrd_flutter/src/core/services/dashboard_refresh_service.dart';
import 'package:fitbodyrd_flutter/src/core/services/device_id_service.dart';
import 'package:fitbodyrd_flutter/src/core/services/preferences_helper.dart';
import 'package:fitbodyrd_flutter/src/core/services/refresh_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> injectDependencies() async {
  await initCore();
  await Future.wait([
    initAuth(),
    initSplash(),
    initOnboarding(),
    initNutrition(),
    initWorkouts(),
    initHome(),
  ]);
}

Future<void> initCore() async {
  final prefsWithCache = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: PreferencesConstants.values,
    ),
  );

  sl
    ..registerSingleton<SharedPreferencesWithCache>(prefsWithCache)
    ..registerLazySingleton(() => PreferencesHelper(sharedPreferences: sl()))
    ..registerLazySingleton(
      RefreshHelper.new,
      dispose: (param) => param.dispose(),
    )
    ..registerLazySingleton(
      DashboardRefreshService.new,
      dispose: (param) => param.dispose(),
    )
    ..registerLazySingleton(() => getRouter(sl()))
    ..registerLazySingleton<Client>(
      () =>
          Client(
              AppEnv.serverpodUrl,
            )
            ..connectivityMonitor = FlutterConnectivityMonitor()
            ..authKeyProvider = FlutterAuthenticationKeyManager(),
    )
    ..registerLazySingleton<SessionManager>(
      () => SessionManager(caller: sl<Client>().modules.auth),
    )
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<DeviceIdService>(
      () => DeviceIdService(storage: sl()),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        client: sl(),
      ),
    );

  await sl<SessionManager>().initialize();

  if (sl<SessionManager>().isSignedIn) {
    unawaited(sl<UserRepository>().refreshUser());
  }
}

Future<void> initAuth() async {
  sl
    ..registerLazySingleton(
      () => EmailAuthController(sl<Client>().modules.auth),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        client: sl(),
        sessionManager: sl(),
        emailAuth: sl(),
        userRepository: sl(),
      ),
    )
    ..registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        authRepository: sl(),
        userRepository: sl(),
      ),
    )
    ..registerFactory<UserCubit>(() => UserCubit(sl(), sl()))
    ..registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(sl()));
}

Future<void> initSplash() async {
  sl.registerFactory(() => SplashCubit(userRepository: sl()));
}

Future<void> initOnboarding() async {
  sl.registerFactory(
    () => OnboardingCubit(
      userRepository: sl(),
      sessionManager: sl(),
    ),
  );
}

Future<void> initNutrition() async {
  sl
    ..registerLazySingleton<NutritionRepository>(
      () => NutritionRepositoryImpl(
        client: sl(),
        sessionManager: sl(),
      ),
    )
    ..registerFactory(
      () => NutritionGenerationCubit(nutritionRepository: sl()),
    )
    ..registerLazySingleton(
      () => NutritionDashboardCubit(
        sl<NutritionRepository>(),
        sl<DashboardRefreshService>(),
      ),
    );
}

Future<void> initWorkouts() async {
  sl
    ..registerLazySingleton<WorkoutRepository>(
      () => WorkoutRepositoryImpl(
        client: sl(),
        sessionManager: sl(),
      ),
    )
    ..registerFactory(
      () => WorkoutGenerationCubit(repository: sl()),
    )
    ..registerFactory(
      () => ExerciseDetailsCubit(sl<WorkoutRepository>()),
    )
    ..registerFactory(
      // Used to load the workout history on init
      // ignore: discarded_futures
      () => WorkoutHistoryCubit(sl<WorkoutRepository>())..loadWorkoutHistory(),
    )
    ..registerLazySingleton(
      () => WorkoutDashboardCubit(
        sl<WorkoutRepository>(),
        sl<DashboardRefreshService>(),
      ),
    );
}

Future<void> initHome() async {
  sl
    ..registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(
        client: sl(),
        sessionManager: sl(),
      ),
    )
    ..registerLazySingleton(
      () => HomeDashboardCubit(
        sl<DashboardRepository>(),
        sl<NutritionRepository>(),
        sl<WorkoutRepository>(),
        // Used to load the dashboard on init
        // ignore: discarded_futures
      )..loadDashboard(),
    );
}
