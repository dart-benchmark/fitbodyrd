import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/entities/local_auth_state.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

// Mock classes
class MockSessionManager extends Mock implements SessionManager {}

class MockEmailAuthController extends Mock implements EmailAuthController {}

class MockClient extends Mock implements Client {}

class MockUserRepository extends Mock implements UserRepository {}

final mockUserInfo = UserInfo(
  userIdentifier: '1234567890',
  created: DateTime.now(),
  scopeNames: ['user'],
  blocked: false,
  id: 1,
  email: 'test@example.com',
  fullName: 'Test User',
  userName: 'testuser',
  imageUrl: 'https://example.com/image.png',
);

void main() {
  group('AuthRepositoryImpl', () {
    late AuthRepositoryImpl authRepository;
    late MockSessionManager mockSessionManager;
    late MockEmailAuthController mockEmailAuth;
    late MockClient mockClient;
    late MockUserRepository mockUserRepository;
    late VoidCallback? capturedListener;

    setUp(() {
      mockSessionManager = MockSessionManager();
      mockEmailAuth = MockEmailAuthController();
      mockClient = MockClient();
      mockUserRepository = MockUserRepository();

      // Register fallback values for mocktail
      registerFallbackValue(Object());

      // Capture the listener when addListener is called
      when(() => mockSessionManager.addListener(any()))
          .thenAnswer((invocation) {
        capturedListener = invocation.positionalArguments[0] as VoidCallback;
      });

      authRepository = AuthRepositoryImpl(
        sessionManager: mockSessionManager,
        emailAuth: mockEmailAuth,
        client: mockClient,
        userRepository: mockUserRepository,
      );
    });

    tearDown(() {
      authRepository = AuthRepositoryImpl(
        sessionManager: mockSessionManager,
        emailAuth: mockEmailAuth,
        client: mockClient,
        userRepository: mockUserRepository,
      );
    });

    group('signInWithEmailAndPassword', () {
      test('should return right(null) when signIn succeeds', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';
        when(() => mockEmailAuth.signIn(email, password))
            .thenAnswer((_) async => mockUserInfo);

        // Act
        final result = await authRepository.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Assert
        result.fold(
          (value) => expect(value, isNull),
          (failure) => fail('Expected success but got failure: $failure'),
        );
        verify(() => mockEmailAuth.signIn(email, password)).called(1);
      });

      test('should return left(ServerFailure) when signIn returns null',
          () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'wrongpassword';
        when(() => mockEmailAuth.signIn(email, password))
            .thenAnswer((_) async => null);

        // Act
        final result = await authRepository.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(
              (failure as ServerFailure).message,
              equals('Correo electrónico o contraseña incorrectos'),
            );
            expect(failure.statusCode, equals(500));
          },
        );
        verify(() => mockEmailAuth.signIn(email, password)).called(1);
      });
    });

    group('createUserWithEmailAndPassword', () {
      test('should return right(null) when createAccountRequest succeeds',
          () async {
        // Arrange
        const email = 'newuser@example.com';
        const password = 'password123';
        when(
          () => mockEmailAuth.createAccountRequest(
            'newuser',
            email,
            password,
          ),
        ).thenAnswer((_) async => true);

        // Act
        final result = await authRepository.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Assert
        result.fold(
          (value) => expect(value, isNull),
          (failure) => fail('Expected success but got failure: $failure'),
        );
        verify(
          () => mockEmailAuth.createAccountRequest(
            'newuser',
            email,
            password,
          ),
        ).called(1);
      });

      test('should extract username from email correctly', () async {
        // Arrange
        const email = 'testuser@example.com';
        const password = 'password123';
        when(
          () => mockEmailAuth.createAccountRequest(
            'testuser',
            email,
            password,
          ),
        ).thenAnswer((_) async => true);

        // Act
        await authRepository.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Assert
        verify(
          () => mockEmailAuth.createAccountRequest(
            'testuser',
            email,
            password,
          ),
        ).called(1);
      });

      test('should return left(ServerFailure) when createAccountRequest fails',
          () async {
        // Arrange
        const email = 'user@example.com';
        const password = 'password123';
        when(
          () => mockEmailAuth.createAccountRequest(
            'user',
            email,
            password,
          ),
        ).thenAnswer((_) async => false);

        // Act
        final result = await authRepository.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(
              (failure as ServerFailure).message,
              equals('No se pudo crear la cuenta'),
            );
            expect(failure.statusCode, equals(500));
          },
        );
        verify(
          () => mockEmailAuth.createAccountRequest(
            'user',
            email,
            password,
          ),
        ).called(1);
      });
    });

    group('signInWithGoogle', () {
      test(
        'should return right(null) when signInWithGoogle succeeds',
        () async {
          // Arrange
          // Note: signInWithGoogle is a top-level function,
          // so we can't easily mock it
          // This test would require integration testing or
          // dependency injection refactoring
          // For now, we'll test the exception handling path
          // This is a limitation of the current implementation

          // This test would need the actual Google sign-in flow or
          // a refactored design
          // Skipping for now as it requires external dependencies
        },
        skip: 'Requires refactoring to inject Google sign-in dependency',
      );

      test(
        'should return left(ServerFailure) when signInWithGoogle returns null',
        () async {
          // This test would require mocking the top-level function
          // which is not easily testable with the current implementation
        },
        skip: 'Requires refactoring to inject Google sign-in dependency',
      );

      test(
        'should return left(ServerFailure) when'
        ' signInWithGoogle throws exception',
        () async {
          // This test would require mocking the top-level function
          // which is not easily testable with the current implementation
        },
        skip: 'Requires refactoring to inject Google sign-in dependency',
      );
    });

    group('signOut', () {
      test(
          'should return right(null) and clear user'
          ' when signOutDevice succeeds', () async {
        // Arrange
        when(() => mockSessionManager.signOutDevice())
            .thenAnswer((_) async => true);

        // Act
        final result = await authRepository.signOut();

        // Assert
        result.fold(
          (value) => expect(value, isNull),
          (failure) => fail('Expected success but got failure: $failure'),
        );
        verify(() => mockUserRepository.clearUser()).called(1);
        verify(() => mockSessionManager.signOutDevice()).called(1);
      });

      test('should return left(ServerFailure) when signOutDevice fails',
          () async {
        // Arrange
        when(() => mockSessionManager.signOutDevice())
            .thenAnswer((_) async => false);

        // Act
        final result = await authRepository.signOut();

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(
              (failure as ServerFailure).message,
              equals('No se pudo cerrar sesión'),
            );
            expect(failure.statusCode, equals(500));
          },
        );
        verify(() => mockUserRepository.clearUser()).called(1);
        verify(() => mockSessionManager.signOutDevice()).called(1);
      });
    });

    group('validateUserWithEmailAndCode', () {
      test('should return right(null) when validateAccount succeeds', () async {
        // Arrange
        const email = 'test@example.com';
        const validationCode = '123456';
        when(() => mockEmailAuth.validateAccount(email, validationCode))
            .thenAnswer((_) async => mockUserInfo);

        // Act
        final result = await authRepository.validateUserWithEmailAndCode(
          email: email,
          validationCode: validationCode,
        );

        // Assert
        result.fold(
          (value) => expect(value, isNull),
          (failure) => fail('Expected success but got failure: $failure'),
        );
        verify(() => mockEmailAuth.validateAccount(email, validationCode))
            .called(1);
      });

      test(
          'should return left(ServerFailure) when validateAccount returns null',
          () async {
        // Arrange
        const email = 'test@example.com';
        const validationCode = 'wrongcode';
        when(() => mockEmailAuth.validateAccount(email, validationCode))
            .thenAnswer((_) async => null);

        // Act
        final result = await authRepository.validateUserWithEmailAndCode(
          email: email,
          validationCode: validationCode,
        );

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(
              (failure as ServerFailure).message,
              equals('No se pudo validar el código'),
            );
            expect(failure.statusCode, equals(500));
          },
        );
        verify(() => mockEmailAuth.validateAccount(email, validationCode))
            .called(1);
      });
    });

    group('changePassword', () {
      test(
        'should return right(null) when'
        ' resetPassword succeeds without'
        ' sign in',
        () async {
          // Arrange
          const email = 'test@example.com';
          const verificationCode = '123456';
          const newPassword = 'newpassword123';
          when(
            () => mockEmailAuth.resetPassword(
              email,
              verificationCode,
              newPassword,
            ),
          ).thenAnswer((_) async => true);

          // Act
          final result = await authRepository.changePassword(
            email: email,
            verificationCode: verificationCode,
            newPassword: newPassword,
          );

          // Assert
          result.fold(
            (value) => expect(value, isNull),
            (failure) => fail('Expected success but got failure: $failure'),
          );
          verify(
            () => mockEmailAuth.resetPassword(
              email,
              verificationCode,
              newPassword,
            ),
          ).called(1);
          verifyNever(() => mockEmailAuth.signIn(any(), any()));
        },
      );

      test(
          'should return right(null) when'
          ' resetPassword succeeds with'
          ' sign in', () async {
        // Arrange
        const email = 'test@example.com';
        const verificationCode = '123456';
        const newPassword = 'newpassword123';
        when(
          () => mockEmailAuth.resetPassword(
            email,
            verificationCode,
            newPassword,
          ),
        ).thenAnswer((_) async => true);
        when(() => mockEmailAuth.signIn(email, newPassword))
            .thenAnswer((_) async => mockUserInfo);

        // Act
        final result = await authRepository.changePassword(
          email: email,
          verificationCode: verificationCode,
          newPassword: newPassword,
          signInAfterChange: true,
        );

        // Assert
        result.fold(
          (value) => expect(value, isNull),
          (failure) => fail('Expected success but got failure: $failure'),
        );
        verify(
          () => mockEmailAuth.resetPassword(
            email,
            verificationCode,
            newPassword,
          ),
        ).called(1);
        verify(() => mockEmailAuth.signIn(email, newPassword)).called(1);
      });

      test('should return left(ServerFailure) when resetPassword fails',
          () async {
        // Arrange
        const email = 'test@example.com';
        const verificationCode = 'wrongcode';
        const newPassword = 'newpassword123';
        when(
          () => mockEmailAuth.resetPassword(
            email,
            verificationCode,
            newPassword,
          ),
        ).thenAnswer((_) async => false);

        // Act
        final result = await authRepository.changePassword(
          email: email,
          verificationCode: verificationCode,
          newPassword: newPassword,
        );

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(
              (failure as ServerFailure).message,
              equals('Código de verificación inválido'),
            );
            expect(failure.statusCode, equals(500));
          },
        );
        verify(
          () => mockEmailAuth.resetPassword(
            email,
            verificationCode,
            newPassword,
          ),
        ).called(1);
        verifyNever(() => mockEmailAuth.signIn(any(), any()));
      });

      test('should return left(ServerFailure) when sign in after change fails',
          () async {
        // Arrange
        const email = 'test@example.com';
        const verificationCode = '123456';
        const newPassword = 'newpassword123';
        when(
          () => mockEmailAuth.resetPassword(
            email,
            verificationCode,
            newPassword,
          ),
        ).thenAnswer((_) async => true);
        when(() => mockEmailAuth.signIn(email, newPassword))
            .thenAnswer((_) async => null);

        // Act
        final result = await authRepository.changePassword(
          email: email,
          verificationCode: verificationCode,
          newPassword: newPassword,
          signInAfterChange: true,
        );

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(
              (failure as ServerFailure).message,
              equals(
                'No se pudo iniciar sesión después de cambiar la contraseña',
              ),
            );
            expect(failure.statusCode, equals(500));
          },
        );
        verify(
          () => mockEmailAuth.resetPassword(
            email,
            verificationCode,
            newPassword,
          ),
        ).called(1);
        verify(() => mockEmailAuth.signIn(email, newPassword)).called(1);
      });
    });

    group('sendResetPasswordEmail', () {
      test('should return right(null) when initiatePasswordReset succeeds',
          () async {
        // Arrange
        const email = 'test@example.com';
        when(() => mockEmailAuth.initiatePasswordReset(email))
            .thenAnswer((_) async => true);

        // Act
        final result = await authRepository.sendResetPasswordEmail(
          email: email,
        );

        // Assert
        result.fold(
          (value) => expect(value, isNull),
          (failure) => fail('Expected success but got failure: $failure'),
        );
        verify(() => mockEmailAuth.initiatePasswordReset(email)).called(1);
      });

      test('should return left(ServerFailure) when initiatePasswordReset fails',
          () async {
        // Arrange
        const email = 'test@example.com';
        when(() => mockEmailAuth.initiatePasswordReset(email))
            .thenAnswer((_) async => false);

        // Act
        final result = await authRepository.sendResetPasswordEmail(
          email: email,
        );

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(
              (failure as ServerFailure).message,
              equals('No se pudo enviar el correo de restablecimiento'),
            );
            expect(failure.statusCode, equals(500));
          },
        );
        verify(() => mockEmailAuth.initiatePasswordReset(email)).called(1);
      });
    });

    group('authStateChanges', () {
      test('should emit signedIn when isLoggedIn is true', () async {
        // Arrange
        when(() => mockSessionManager.isSignedIn).thenReturn(true);
        final events = <LocalAuthState>[];
        final subscription =
            authRepository.authStateChanges().listen(events.add);

        // Act - trigger the listener callback
        if (capturedListener != null) {
          capturedListener?.call();
        }

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events.length, greaterThanOrEqualTo(1));
        expect(events.last, equals(LocalAuthState.signedIn));
        await subscription.cancel();
      });

      test('should emit signedOut when isLoggedIn is false', () async {
        // Arrange
        when(() => mockSessionManager.isSignedIn).thenReturn(false);
        final events = <LocalAuthState>[];
        final subscription =
            authRepository.authStateChanges().listen(events.add);

        // Act - trigger the listener callback
        if (capturedListener != null) {
          capturedListener?.call();
        }

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events.length, greaterThanOrEqualTo(1));
        expect(events.last, equals(LocalAuthState.signedOut));
        await subscription.cancel();
      });

      test('should support multiple listeners (broadcast stream)', () async {
        // Arrange
        when(() => mockSessionManager.isSignedIn).thenReturn(true);
        final events1 = <LocalAuthState>[];
        final events2 = <LocalAuthState>[];
        final subscription1 =
            authRepository.authStateChanges().listen(events1.add);
        final subscription2 =
            authRepository.authStateChanges().listen(events2.add);

        // Act - trigger the listener callback
        if (capturedListener != null) {
          capturedListener?.call();
        }

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events1.length, greaterThanOrEqualTo(1));
        expect(events2.length, greaterThanOrEqualTo(1));
        expect(events1.last, equals(LocalAuthState.signedIn));
        expect(events2.last, equals(LocalAuthState.signedIn));
        await subscription1.cancel();
        await subscription2.cancel();
      });

      test('should emit events when session manager state changes', () async {
        // Arrange
        when(() => mockSessionManager.isSignedIn).thenReturn(false);
        final events = <LocalAuthState>[];
        final subscription =
            authRepository.authStateChanges().listen(events.add);

        // Act - trigger state change to signed out
        if (capturedListener != null) {
          capturedListener?.call();
        }
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Change state to signed in
        when(() => mockSessionManager.isSignedIn).thenReturn(true);
        if (capturedListener != null) {
          capturedListener?.call();
        }

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events.length, greaterThanOrEqualTo(2));
        expect(events[events.length - 2], equals(LocalAuthState.signedOut));
        expect(events.last, equals(LocalAuthState.signedIn));
        await subscription.cancel();
      });
    });

    group('isLoggedIn', () {
      test('should return true when sessionManager.isSignedIn is true', () {
        // Arrange
        when(() => mockSessionManager.isSignedIn).thenReturn(true);

        // Act
        final result = authRepository.isLoggedIn;

        // Assert
        expect(result, isTrue);
        verify(() => mockSessionManager.isSignedIn).called(1);
      });

      test('should return false when sessionManager.isSignedIn is false', () {
        // Arrange
        when(() => mockSessionManager.isSignedIn).thenReturn(false);

        // Act
        final result = authRepository.isLoggedIn;

        // Assert
        expect(result, isFalse);
        verify(() => mockSessionManager.isSignedIn).called(1);
      });
    });
  });
}
