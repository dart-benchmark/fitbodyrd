# Example Test Patterns for Frontend

This file demonstrates the testing patterns used in the Flutter frontend.

## Cubit Test Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:fitbodyrd_flutter/features/auth/data/repositories/auth_repository.dart';

// Mock the repository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthCubit', () {
    late AuthCubit cubit;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      cubit = AuthCubit(authRepository: mockRepository);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is AuthInitial', () {
      expect(cubit.state, isA<AuthInitial>());
    });

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthSuccess] when signIn succeeds',
      setUp: () {
        when(() => mockRepository.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => user);
      },
      build: () => cubit,
      act: (cubit) => cubit.signIn(email: 'test@example.com', password: 'password'),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthSuccess>(),
      ],
      verify: (_) {
        verify(() => mockRepository.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password',
        )).called(1);
      },
    );
  });
}
```

## Repository Test Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fitbodyrd_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';

// Mock the client
class MockClient extends Mock implements Client {}

void main() {
  group('AuthRepositoryImpl', () {
    late AuthRepositoryImpl repository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      repository = AuthRepositoryImpl(client: mockClient);
    });

    test('signInWithEmailAndPassword returns user on success', () async {
      // Arrange
      final expectedUser = User(id: 1, email: 'test@example.com');
      when(() => mockClient.auth.signInWithEmailPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenAnswer((_) async => expectedUser);

      // Act
      final result = await repository.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      );

      // Assert
      expect(result, equals(expectedUser));
      verify(() => mockClient.auth.signInWithEmailPassword(
        email: 'test@example.com',
        password: 'password',
      )).called(1);
    });

    test('signInWithEmailAndPassword throws exception on failure', () async {
      // Arrange
      when(() => mockClient.auth.signInWithEmailPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenThrow(Exception('Invalid credentials'));

      // Act & Assert
      expect(
        () => repository.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'wrong',
        ),
        throwsException,
      );
    });
  });
}
```

## Notes

- Use `mocktail` for creating mocks
- Use `bloc_test` package for testing Cubits/Blocs (if available)
- Follow Arrange-Act-Assert pattern
- Test both success and failure paths
- Verify method calls with `verify()`
- Use `setUp()` and `tearDown()` for test initialization and cleanup
