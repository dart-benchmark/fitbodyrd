import 'dart:async';

import 'package:fitbodyrd_flutter/features/splash/presentation/cubits/splash_cubit/splash_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<SplashCubit>().checkUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToHome) {
          context.goNamed(AppRoutes.home.name);
        } else if (state is SplashNavigateToOnboarding) {
          context.goNamed(AppRoutes.onboarding.name);
        } else if (state is SplashNavigateToLogin) {
          context.goNamed(AppRoutes.login.name);
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Replace with App Icon/Logo
        ),
      ),
    );
  }
}
