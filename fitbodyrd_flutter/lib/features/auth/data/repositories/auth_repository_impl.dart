import 'dart:async';

import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/entities/local_auth_state.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:fitbodyrd_flutter/src/core/env/app_env.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart'
    as auth;
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required SessionManager sessionManager,
    required EmailAuthController emailAuth,
    required Client client,
    required UserRepository userRepository,
  })  : _sessionManager = sessionManager,
        _client = client,
        _emailAuth = emailAuth,
        _userRepository = userRepository
  //_deviceIdService = deviceIdService {
  {
    _sessionManager.addListener(_onAuthStateChanged);
  }

  final SessionManager _sessionManager;
  final EmailAuthController _emailAuth;
  final Client _client;
  final UserRepository _userRepository;
  // final DeviceIdService _deviceIdService;
  final StreamController<LocalAuthState> _authStateController =
      StreamController<LocalAuthState>.broadcast();

  void _onAuthStateChanged() {
    final newState =
        isLoggedIn ? LocalAuthState.signedIn : LocalAuthState.signedOut;
    _authStateController.add(newState);
  }

  @override
  Stream<LocalAuthState> authStateChanges() => _authStateController.stream;

  @override
  FutureResultVoid createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final username = email.split('@').first;
    final result = await _emailAuth.createAccountRequest(
      username,
      email,
      password,
    );

    if (result) {
      return right(null);
    } else {
      return left(
        ServerFailure(
          message: 'No se pudo crear la cuenta',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  bool get isLoggedIn => _sessionManager.isSignedIn;

  @override
  FutureResultVoid signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _emailAuth.signIn(email, password);

    if (result != null) {
      return right(null);
    } else {
      return left(
        ServerFailure(
          message: 'Correo electrónico o contraseña incorrectos',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  FutureResultVoid signOut() async {
    // final deviceId = await _deviceIdService.getDeviceId();

    // await _client.user.deleteUserToken(deviceId);

    _userRepository.clearUser();

    final result = await _sessionManager.signOutDevice();

    if (result) {
      return right(null);
    } else {
      return left(
        ServerFailure(
          message: 'No se pudo cerrar sesión',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  FutureResultVoid validateUserWithEmailAndCode({
    required String email,
    required String validationCode,
  }) async {
    final result = await _emailAuth.validateAccount(email, validationCode);

    if (result != null) {
      // await _client.user.setAuthMethod(AuthMethod.email);
      return right(null);
    } else {
      return left(
        ServerFailure(
          message: 'No se pudo validar el código',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  FutureResultVoid signInWithGoogle() async {
    try {
      final userInfo = await auth.signInWithGoogle(
        _client.modules.auth,
        serverClientId: AppEnv.googleServerClientId,
        clientId: AppEnv.googleClientId,
        redirectUri: Uri.parse(AppEnv.googleRedirectUrl),
      );

      if (userInfo == null) {
        return left(
          ServerFailure(
            message: 'No se pudo iniciar sesión con Google',
            statusCode: 500,
          ),
        );
      }

      return right(null);
    } on Exception catch (_) {
      return left(
        ServerFailure(
          message: 'No se pudo iniciar sesión con Google',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  FutureResultVoid changePassword({
    required String email,
    required String verificationCode,
    required String newPassword,
    bool signInAfterChange = false,
  }) async {
    final result = await _emailAuth.resetPassword(
      email,
      verificationCode,
      newPassword,
    );

    if (result) {
      if (signInAfterChange) {
        final signInResult = await _emailAuth.signIn(email, newPassword);
        if (signInResult == null) {
          return left(
            ServerFailure(
              message:
                  'No se pudo iniciar sesión después de cambiar la contraseña',
              statusCode: 500,
            ),
          );
        }
      }

      return right(null);
    } else {
      return left(
        ServerFailure(
          message: 'Código de verificación inválido',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  FutureResultVoid sendResetPasswordEmail({required String email}) async {
    final result = await _emailAuth.initiatePasswordReset(email);

    if (result) {
      return right(null);
    } else {
      return left(
        ServerFailure(
          message: 'No se pudo enviar el correo de restablecimiento',
          statusCode: 500,
        ),
      );
    }
  }
}
