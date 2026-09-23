import 'package:fitbodyrd_flutter/features/auth/domain/entities/local_auth_state.dart';
import 'package:record_result/record_result.dart';

/// An interface for accessing authentication functionalities.
abstract interface class AuthRepository {
  /// Attempts to sign in the user with the provided email and password.
  FutureResultVoid signInWithEmailAndPassword({
    /// The email address of the user.
    required String email,

    /// The user's password.
    required String password,
  });

  /// Attempts to sign in the user with the provided email and password.
  FutureResultVoid createUserWithEmailAndPassword({
    /// The email address of the user.
    required String email,

    /// The user's password.
    required String password,
  });

  FutureResultVoid validateUserWithEmailAndCode({
    /// The email address of the user.
    required String email,
    required String validationCode,
  });

  /// Signs out the currently authenticated user.
  FutureResultVoid signOut();

  /// Provides a stream of events representing
  /// changes in the authentication state.
  Stream<LocalAuthState> authStateChanges();

  /// Returns whether the user is logged in.
  bool get isLoggedIn;

  /// Attempts to sign in the user with Google.
  FutureResultVoid signInWithGoogle();

  /// Sends a password reset email to the user.
  FutureResultVoid sendResetPasswordEmail({required String email});

  /// Changes the user's password.
  FutureResultVoid changePassword({
    required String email,
    required String verificationCode,
    required String newPassword,
    bool signInAfterChange = false,
  });
}
