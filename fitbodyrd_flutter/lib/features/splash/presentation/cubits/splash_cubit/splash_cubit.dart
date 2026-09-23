import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SplashInitial());

  final UserRepository _userRepository;

  Future<void> checkUser() async {
    emit(SplashLoading());

    // Small delay to ensure the splash screen is visible
    await Future<void>.delayed(const Duration(seconds: 1));
    if (isClosed) return;

    final result = await _userRepository.getCachedUser();

    if (isClosed) return;

    result.fold(
      (user) => emit(SplashNavigateToHome()),
      (failure) {
        if (failure is ServerFailure && failure.statusCode == 6000) {
          emit(SplashNavigateToOnboarding());
        } else {
          emit(SplashNavigateToLogin());
        }
      },
    );
  }
}
