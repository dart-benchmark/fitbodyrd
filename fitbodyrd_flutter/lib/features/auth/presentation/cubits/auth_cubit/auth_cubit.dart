import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(AuthInitial());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  String? email;
  String? password;

  @override
  // To avoid the cubit from disposing
  // ignore: must_call_super
  Future<void> close() async {
    email = null;
    password = null;
    emit(AuthInitial());

    // return super.close();
  }

  Future<void> signIn({
    required String email,
    required String password,
    bool skipLoading = false,
  }) async {
    if (state is AuthLoading && !skipLoading) return;

    emit(const AuthLoading());

    final result = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (isClosed) return;

    result.fold(
      (success) {
        unawaited(_userRepository.refreshUser());
        emit(AuthSuccess());
      },
      (failure) {
        emit(AuthError(failure));
        emit(AuthInitial());
      },
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    if (state is AuthLoading) return;

    emit(const AuthLoading());

    this.password = password.trim();

    final result = await _authRepository.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (isClosed) return;

    result.fold(
      (success) {
        this.email = email;
        emit(AuthNeedsValidation());
      },
      (failure) => emit(AuthError(failure)),
    );
  }

  Future<void> validateCode({required String validationCode}) async {
    if (state is! AuthNeedsValidation) return;

    emit(const AuthLoading());

    final result = await _authRepository.validateUserWithEmailAndCode(
      email: email!,
      validationCode: validationCode,
    );

    if (isClosed) return;

    result.fold(
      (success) async {
        if (password != null && email != null) {
          await signIn(email: email!, password: password!, skipLoading: true);
          return;
        }

        emit(AuthSuccess());
      },
      (failure) => emit(AuthError(failure)),
    );
  }

  Future<void> signInWithGoogle() async {
    if (state is AuthLoading) return;

    emit(const AuthLoading(showFullScreenLoading: true));

    final result = await _authRepository.signInWithGoogle();

    if (isClosed) return;

    result.fold(
      (success) {
        unawaited(_userRepository.refreshUser());
        emit(AuthSuccess());
      },
      (failure) {
        emit(AuthError(failure));
        emit(AuthInitial());
      },
    );
  }
}
