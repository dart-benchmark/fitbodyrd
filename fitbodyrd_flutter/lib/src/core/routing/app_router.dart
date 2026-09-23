// To instatiate cubits within GoRouter routes without warnings
// ignore_for_file: discarded_futures

import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/screens/validate_code_screen.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/screens/home_dashboard_screen.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_generation_cubit.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/screens/nutrition_dashboard_screen.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fitbodyrd_flutter/features/onboarding/screens/onboarding_screen.dart';
import 'package:fitbodyrd_flutter/features/profile/presentation/screens/profile_screen.dart';
import 'package:fitbodyrd_flutter/features/splash/presentation/cubits/splash_cubit/splash_cubit.dart';
import 'package:fitbodyrd_flutter/features/splash/presentation/screens/splash_screen.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/exercise_details_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/screens/exercise_details_screen.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/screens/workout_dashboard_screen.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/screens/workout_history_screen.dart';
import 'package:fitbodyrd_flutter/src/core/common/screens/root_screen.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/routing/app_routes.dart';
import 'package:fitbodyrd_flutter/src/core/routing/go_router_refresh_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _shellNavigatorHome = GlobalKey<NavigatorState>();
final _shellNavigatorNutrition = GlobalKey<NavigatorState>();
final _shellNavigatorExercises = GlobalKey<NavigatorState>();
final _shellNavigatorProfile = GlobalKey<NavigatorState>();

GoRouter getRouter(AuthRepository authRepository) {
  return GoRouter(
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepository.isLoggedIn;

      if (isLoggedIn &&
          (state.matchedLocation == '/login' ||
              state.matchedLocation == '/register' ||
              state.matchedLocation == '/login/forgot-password')) {
        return '/splash';
      }

      if (!isLoggedIn) {
        if (state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/login/forgot-password' ||
            state.matchedLocation == '/register/validate-code') {
          return state.matchedLocation;
        }
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: AppRoutes.login.name,
        builder: (context, state) => BlocProvider<AuthCubit>(
          create: (context) => sl(),
          child: const LoginScreen(),
        ),
        routes: [
          GoRoute(
            path: 'forgot-password',
            name: AppRoutes.forgotPassword.name,
            builder: (context, state) => BlocProvider<ForgotPasswordCubit>(
              create: (context) => sl(),
              child: Scaffold(
                body: Center(child: Text('Forgot Password Screen')),
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.register.name,
        builder: (context, state) => BlocProvider<AuthCubit>(
          create: (context) => sl(),
          child: const RegisterScreen(),
        ),
        routes: [
          GoRoute(
            path: 'validate-code',
            name: AppRoutes.validateCode.name,
            builder: (context, state) => BlocProvider<AuthCubit>(
              create: (context) => sl(),
              child: const ValidateCodeScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRoutes.onboarding.name,
        builder: (context, state) => BlocProvider<OnboardingCubit>(
          create: (context) => sl(),
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/exercises/history',
        name: AppRoutes.workoutHistory.name,
        builder: (context, state) => const WorkoutHistoryScreen(),
      ),
      GoRoute(
        path: '/exercises/details',
        name: AppRoutes.exerciseDetails.name,
        builder: (context, state) => BlocProvider<ExerciseDetailsCubit>(
          create: (context) => sl(),
          child: ExerciseDetailsScreen(
            workoutExercise: state.extra! as WorkoutExercise,
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            RootScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: [
              GoRoute(
                path: '/',
                name: AppRoutes.home.name,
                builder: (context, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider<UserCubit>(
                      create: (context) => sl()..getUser(),
                    ),
                  ],
                  child: const HomeDashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorNutrition,
            routes: [
              GoRoute(
                path: '/nutrition',
                name: AppRoutes.nutrition.name,
                builder: (context, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider<NutritionGenerationCubit>(
                      create: (context) => sl(),
                    ),
                  ],
                  child: const NutritionDashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorExercises,
            routes: [
              GoRoute(
                path: '/exercises',
                name: AppRoutes.exercises.name,
                builder: (context, state) => const WorkoutDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: [
              GoRoute(
                path: '/profile',
                name: AppRoutes.profile.name,
                builder: (context, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider<UserCubit>(
                      create: (context) => sl()..getUser(),
                    ),
                  ],
                  child: const ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/splash',
        name: AppRoutes.splash.name,
        builder: (context, state) => BlocProvider<SplashCubit>(
          create: (context) => sl(),
          child: const SplashScreen(),
        ),
      ),
    ],
  );
}
