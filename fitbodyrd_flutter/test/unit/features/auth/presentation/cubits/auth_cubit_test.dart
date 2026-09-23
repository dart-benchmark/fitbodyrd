import 'dart:async';

import 'package:fitbodyrd_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('AuthCubit', () {
    late AuthCubit cubit;
    late MockAuthRepository mockAuthRepository;
    late MockUserRepository mockUserRepository;
    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockUserRepository = MockUserRepository();

      cubit = AuthCubit(
        authRepository: mockAuthRepository,
        userRepository: mockUserRepository,
      );
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is AuthInitial', () {
      expect(cubit.state, isA<AuthInitial>());
    });

    group('signIn', () {
      test('should emit AuthLoading when signIn is called', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';

        when(
          () => mockAuthRepository.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 50));
          return voidSuccess;
        });

        when(
          () => mockUserRepository.refreshUser(),
        ).thenAnswer((_) async => voidSuccess);

        // Act
        final future = cubit.signIn(email: email, password: password);

        // Assert - check that loading state is emitted immediately
        expect(cubit.state, isA<AuthLoading>());

        // Wait for completion
        await future;
      });

      test('should emit AuthSuccess when signIn succeeds', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';

        when(
          () => mockAuthRepository.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => voidSuccess);

        when(
          () => mockUserRepository.refreshUser(),
        ).thenAnswer((_) async => voidSuccess);

        // Act
        await cubit.signIn(email: email, password: password);

        // Assert
        expect(cubit.state, isA<AuthSuccess>());
        verify(
          () => mockAuthRepository.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('should emit AuthError then AuthInitial when signIn fails',
          () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'wrongpassword';

        final failure = ServerFailure(
          statusCode: 500,
          message: 'Invalid credentials',
        );

        when(
          () => mockAuthRepository.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => left(failure));

        // Act
        await cubit.signIn(email: email, password: password);

        // Assert - should end in AuthInitial after error
        expect(cubit.state, isA<AuthInitial>());
        verify(
          () => mockAuthRepository.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('should prevent duplicate calls when already loading', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';

        when(
          () => mockAuthRepository.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 100));
          return voidSuccess;
        });

        when(
          () => mockUserRepository.refreshUser(),
        ).thenAnswer((_) async => voidSuccess);

        // Act - call signIn twice quickly
        unawaited(cubit.signIn(email: email, password: password));
        unawaited(cubit.signIn(email: email, password: password));

        // Wait a bit to ensure first call is in progress
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert - should only be called once
        verify(
          () => mockAuthRepository.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);

        // Wait for completion
        await Future<void>.delayed(const Duration(milliseconds: 150));
      });
    });

    group('signUp', () {
      test('should emit AuthLoading when signUp is called', () async {
        // Arrange
        const email = 'newuser@example.com';
        const password = 'password123';
        const fullName = 'New User';

        when(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 50));
          return voidSuccess;
        });

        // Act
        final future = cubit.signUp(
          email: email,
          password: password,
          fullName: fullName,
        );

        // Assert - check that loading state is emitted immediately
        expect(cubit.state, isA<AuthLoading>());

        // Wait for completion
        await future;
      });

      test('should emit AuthNeedsValidation when signUp succeeds', () async {
        // Arrange
        const email = 'newuser@example.com';
        const password = 'password123';
        const fullName = 'New User';

        when(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => voidSuccess);

        // Act
        await cubit.signUp(
          email: email,
          password: password,
          fullName: fullName,
        );

        // Assert
        expect(cubit.state, isA<AuthNeedsValidation>());
        expect(cubit.email, equals(email));
        expect(cubit.password, equals(password.trim()));
        verify(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('should emit AuthError when signUp fails', () async {
        // Arrange
        const email = 'newuser@example.com';
        const password = 'password123';
        const fullName = 'New User';

        final failure = ServerFailure(
          statusCode: 500,
          message: 'Email already exists',
        );

        when(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => left(failure));

        // Act
        await cubit.signUp(
          email: email,
          password: password,
          fullName: fullName,
        );

        // Assert
        expect(cubit.state, isA<AuthError>());
        final errorState = cubit.state as AuthError;
        expect(errorState.failure, equals(failure));
        verify(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('should prevent duplicate calls when already loading', () async {
        // Arrange
        const email = 'newuser@example.com';
        const password = 'password123';
        const fullName = 'New User';

        when(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 100));
          return voidSuccess;
        });

        when(
          () => mockUserRepository.refreshUser(),
        ).thenAnswer((_) async => voidSuccess);

        // Act - call signUp twice quickly
        unawaited(
          cubit.signUp(
            email: email,
            password: password,
            fullName: fullName,
          ),
        );
        unawaited(
          cubit.signUp(
            email: email,
            password: password,
            fullName: fullName,
          ),
        );

        // Wait a bit to ensure first call is in progress
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert - should only be called once
        verify(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);

        // Wait for completion
        await Future<void>.delayed(const Duration(milliseconds: 150));
      });
    });

    group('close', () {
      test('should reset email and password and emit AuthInitial', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';

        when(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => voidSuccess);

        // Set email and password by calling signUp
        await cubit.signUp(
          email: email,
          password: password,
          fullName: 'Test User',
        );

        expect(cubit.email, equals(email));
        expect(cubit.password, equals(password.trim()));

        // Act
        await cubit.close();

        // Assert
        expect(cubit.email, isNull);
        expect(cubit.password, isNull);
        expect(cubit.state, isA<AuthInitial>());
      });
    });
  });
}
