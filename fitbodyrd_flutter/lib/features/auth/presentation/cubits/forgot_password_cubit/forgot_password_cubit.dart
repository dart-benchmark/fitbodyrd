import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authRepository)
      : super(const ForgotPasswordInitial());

  final AuthRepository _authRepository;
  String? email;

  Future<void> sendEmail(String email) async {
    this.email = email;
    emit(const ForgotPasswordLoading());

    await _authRepository.sendResetPasswordEmail(email: email);

    emit(const ForgotPasswordEmailSent());
  }

  Future<void> changePassword({
    required String code,
    required String newPassword,
  }) async {
    emit(const ForgotPasswordLoading());

    final result = await _authRepository.changePassword(
      email: email!,
      verificationCode: code,
      newPassword: newPassword,
    );

    result.fold(
      (_) {
        emit(const ForgotPasswordInitial());
        emit(const ForgotPasswordSuccess());
      },
      (failure) => emit(ForgotPasswordError(message: failure.message)),
    );
  }
}
