import 'dart:async';

import 'package:fitbodyrd_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:fitbodyrd_flutter/features/profile/presentation/widgets/fitness_info_section.dart';
import 'package:fitbodyrd_flutter/features/profile/presentation/widgets/profile_header.dart';
import 'package:fitbodyrd_flutter/features/profile/presentation/widgets/user_stats_section.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/style/style_constants.dart';
import 'package:fitbodyrd_flutter/src/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:record_result/record_result.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    unawaited(_loadAppVersion());
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'Versión ${packageInfo.version}+${packageInfo.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const KText.headlineSmall('Perfil'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  KSizedBox.s20(),
                  KText.bodyLarge('Error al cargar el perfil'),
                  KSizedBox.s10(),
                  KText.bodyMedium(state.message),
                ],
              ),
            );
          }

          if (state is UserLoaded) {
            final user = state.user;
            return SingleChildScrollView(
              padding: StyleConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Profile Header
                  ProfileHeader(user: user),
                  KSizedBox.s30(),

                  // User Stats Section
                  UserStatsSection(user: user),
                  KSizedBox.s30(),

                  // Fitness Info Section
                  FitnessInfoSection(user: user),
                  KSizedBox.s30(),

                  // Logout Button
                  CButton.primary(
                    text: 'Cerrar Sesión',
                    onPressed: () => _handleLogout(context),
                  ),
                  KSizedBox.s20(),

                  // App Version
                  if (_appVersion.isNotEmpty)
                    Center(
                      child: KText.bodySmall(
                        _appVersion,
                        color: KColors.greyScale.g600,
                      ),
                    ),
                  KSizedBox.s20(),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    // Sign out
    final result = await sl<AuthRepository>().signOut();

    // Handle result
    result.fold(
      (_) {
        // Success - navigation will be handled by auth state changes
      },
      (error) {
        if (context.mounted) {
          CoreUtils.showSnackBar(context, error.message);
        }
      },
    );
  }
}
