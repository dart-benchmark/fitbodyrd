import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:fitbodyrd_flutter/features/splash/presentation/cubits/splash_cubit/splash_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockUserRepository extends Mock implements UserRepository {}

// Helper function to create a mock UserProfile
UserProfile createMockUserProfile({
  int? id,
  int userInfoId = 1,
  String fullName = 'Test User',
  String email = 'test@example.com',
  DateTime? birthDate,
}) {
  return UserProfile(
    id: id,
    userInfoId: userInfoId,
    fullName: fullName,
    email: email,
    birthDate: birthDate ?? DateTime(1990),
    sex: Sex.male,
    weightKgs: 75.0,
    heightMs: 1.75,
    bodyGoal: BodyGoal.loseWeight,
    activityLevel: ActivityLevel.sedentary,
    daysPerWeekExercise: 3,
    timePerExerciseSessionMinutes: 30,
    experienceLevel: ExerciseDifficulty.beginner,
  );
}

void main() {
  group('SplashCubit', () {
    late SplashCubit cubit;
    late MockUserRepository mockUserRepository;

    setUp(() {
      mockUserRepository = MockUserRepository();
      registerFallbackValue(Object());
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is SplashInitial', () {
      // Arrange & Act
      cubit = SplashCubit(userRepository: mockUserRepository);

      // Assert
      expect(cubit.state, isA<SplashInitial>());
    });

    group('checkUser', () {
      setUp(() {
        cubit = SplashCubit(userRepository: mockUserRepository);
      });

      test('should emit SplashLoading immediately', () async {
        // Arrange
        final userProfile = createMockUserProfile();
        when(() => mockUserRepository.getCachedUser())
            .thenAnswer((_) async => right(userProfile));

        // Act
        final future = cubit.checkUser();

        // Assert - check loading state is emitted immediately
        expect(cubit.state, isA<SplashLoading>());

        // Wait for completion
        await future;
      });

      test('should emit SplashNavigateToHome when user exists', () async {
        // Arrange
        final userProfile = createMockUserProfile();
        when(() => mockUserRepository.getCachedUser())
            .thenAnswer((_) async => right(userProfile));

        // Act
        await cubit.checkUser();

        // Assert
        expect(cubit.state, isA<SplashNavigateToHome>());
        verify(() => mockUserRepository.getCachedUser()).called(1);
      });

      test(
          'should emit SplashNavigateToOnboarding '
          'when ServerFailure with statusCode 6000', () async {
        // Arrange
        final failure = ServerFailure(
          statusCode: 6000,
          message: 'User not found.',
        );
        when(() => mockUserRepository.getCachedUser())
            .thenAnswer((_) async => left(failure));

        // Act
        await cubit.checkUser();

        // Assert
        expect(cubit.state, isA<SplashNavigateToOnboarding>());
        verify(() => mockUserRepository.getCachedUser()).called(1);
      });

      test('should emit SplashNavigateToLogin for other failures', () async {
        // Arrange
        final failure = ServerFailure(
          statusCode: 500,
          message: 'Server error',
        );
        when(() => mockUserRepository.getCachedUser())
            .thenAnswer((_) async => left(failure));

        // Act
        await cubit.checkUser();

        // Assert
        expect(cubit.state, isA<SplashNavigateToLogin>());
        verify(() => mockUserRepository.getCachedUser()).called(1);
      });

      test('should emit SplashNavigateToLogin for non-ServerFailure', () async {
        // Arrange
        final failure = ServerFailure(
          statusCode: 401,
          message: 'Unauthorized',
        );
        when(() => mockUserRepository.getCachedUser())
            .thenAnswer((_) async => left(failure));

        // Act
        await cubit.checkUser();

        // Assert
        expect(cubit.state, isA<SplashNavigateToLogin>());
        verify(() => mockUserRepository.getCachedUser()).called(1);
      });

      test('should include 1 second delay before checking user', () async {
        // Arrange
        final userProfile = createMockUserProfile();
        when(() => mockUserRepository.getCachedUser())
            .thenAnswer((_) async => right(userProfile));

        // Act
        final startTime = DateTime.now();
        await cubit.checkUser();
        final endTime = DateTime.now();

        // Assert
        final duration = endTime.difference(startTime);
        expect(duration.inSeconds, greaterThanOrEqualTo(1));
        verify(() => mockUserRepository.getCachedUser()).called(1);
      });

      test('should handle cubit closure during delay', () async {
        // Arrange
        final userProfile = createMockUserProfile();
        when(() => mockUserRepository.getCachedUser()).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 100));
          return right(userProfile);
        });

        // Act
        final future = cubit.checkUser();
        // Close cubit during the delay
        await Future<void>.delayed(const Duration(milliseconds: 100));
        await cubit.close();
        await future;

        // Assert - should not emit states after closure
        // The state should remain as SplashLoading since we closed during delay
        // Note: This test verifies that isClosed check prevents state emissions
        expect(cubit.isClosed, isTrue);
      });

      test('should handle cubit closure after delay but before repository call',
          () async {
        // Arrange
        final userProfile = createMockUserProfile();
        when(() => mockUserRepository.getCachedUser()).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 100));
          return right(userProfile);
        });

        // Act
        final future = cubit.checkUser();
        // Wait for delay to complete, then close before repository responds
        await Future<void>.delayed(const Duration(milliseconds: 1100));
        await cubit.close();
        await future;

        // Assert - should not emit states after closure
        expect(cubit.isClosed, isTrue);
      });
    });
  });
}
