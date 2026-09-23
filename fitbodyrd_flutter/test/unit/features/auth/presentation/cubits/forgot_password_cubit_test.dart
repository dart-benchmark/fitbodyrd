import 'package:fitbodyrd_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('ForgotPasswordCubit', () {
    late ForgotPasswordCubit cubit;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      cubit = ForgotPasswordCubit(mockAuthRepository);
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is ForgotPasswordInitial', () {
      expect(cubit.state, isA<ForgotPasswordInitial>());
    });

    group('sendEmail', () {
      test(
          'should emit ForgotPasswordLoading '
          'then ForgotPasswordEmailSent on success', () async {
        // Arrange
        const email = 'test@example.com';

        when(
          () => mockAuthRepository.sendResetPasswordEmail(email: email),
        ).thenAnswer((_) async => voidSuccess);

        // Act
        final future = cubit.sendEmail(email);

        // Assert - check loading state is emitted
        expect(cubit.state, isA<ForgotPasswordLoading>());
        expect(cubit.email, equals(email));

        // Wait for completion
        await future;

        // Assert - check final state
        expect(cubit.state, isA<ForgotPasswordEmailSent>());
        verify(
          () => mockAuthRepository.sendResetPasswordEmail(email: email),
        ).called(1);
      });

      test('should store email when sendEmail is called', () async {
        // Arrange
        const email = 'user@example.com';

        when(
          () => mockAuthRepository.sendResetPasswordEmail(email: email),
        ).thenAnswer((_) async => voidSuccess);

        // Act
        await cubit.sendEmail(email);

        // Assert
        expect(cubit.email, equals(email));
      });
    });

    group('changePassword', () {
      test(
          'should emit ForgotPasswordLoading '
          'then ForgotPasswordSuccess on success', () async {
        // Arrange
        const email = 'test@example.com';
        const code = '123456';
        const newPassword = 'newpassword123';

        // First set email by calling sendEmail
        when(
          () => mockAuthRepository.sendResetPasswordEmail(email: email),
        ).thenAnswer((_) async => voidSuccess);
        await cubit.sendEmail(email);

        when(
          () => mockAuthRepository.changePassword(
            email: email,
            verificationCode: code,
            newPassword: newPassword,
          ),
        ).thenAnswer((_) async => voidSuccess);

        // Act
        final future = cubit.changePassword(
          code: code,
          newPassword: newPassword,
        );

        // Assert - check loading state is emitted
        expect(cubit.state, isA<ForgotPasswordLoading>());

        // Wait for completion
        await future;

        // Assert - check final state (should be Success after Initial)
        expect(cubit.state, isA<ForgotPasswordSuccess>());
        verify(
          () => mockAuthRepository.changePassword(
            email: email,
            verificationCode: code,
            newPassword: newPassword,
          ),
        ).called(1);
      });

      test('should emit ForgotPasswordError when changePassword fails',
          () async {
        // Arrange
        const email = 'test@example.com';
        const code = 'wrongcode';
        const newPassword = 'newpassword123';

        // First set email by calling sendEmail
        when(
          () => mockAuthRepository.sendResetPasswordEmail(email: email),
        ).thenAnswer((_) async => voidSuccess);
        await cubit.sendEmail(email);

        final failure = ServerFailure(
          statusCode: 500,
          message: 'Invalid verification code',
        );

        when(
          () => mockAuthRepository.changePassword(
            email: email,
            verificationCode: code,
            newPassword: newPassword,
          ),
        ).thenAnswer((_) async => left(failure));

        // Act
        await cubit.changePassword(
          code: code,
          newPassword: newPassword,
        );

        // Assert
        expect(cubit.state, isA<ForgotPasswordError>());
        final errorState = cubit.state as ForgotPasswordError;
        expect(errorState.message, equals('Invalid verification code'));
        verify(
          () => mockAuthRepository.changePassword(
            email: email,
            verificationCode: code,
            newPassword: newPassword,
          ),
        ).called(1);
      });
    });

    group('state transitions', () {
      test(
          'should transition through correct states during password reset flow',
          () async {
        // Arrange
        const email = 'test@example.com';
        const code = '123456';
        const newPassword = 'newpassword123';

        when(
          () => mockAuthRepository.sendResetPasswordEmail(email: email),
        ).thenAnswer((_) async => voidSuccess);

        when(
          () => mockAuthRepository.changePassword(
            email: email,
            verificationCode: code,
            newPassword: newPassword,
          ),
        ).thenAnswer((_) async => voidSuccess);

        // Act & Assert - sendEmail flow
        await cubit.sendEmail(email);
        expect(cubit.state, isA<ForgotPasswordEmailSent>());

        // Act & Assert - changePassword flow
        await cubit.changePassword(code: code, newPassword: newPassword);
        expect(cubit.state, isA<ForgotPasswordSuccess>());
      });
    });
  });
}
