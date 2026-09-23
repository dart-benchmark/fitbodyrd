import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/services/refresh_helper.dart';
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
  group('UserCubit', () {
    late UserCubit cubit;
    late MockUserRepository mockRepository;
    late RefreshHelper refreshHelper;

    setUp(() {
      mockRepository = MockUserRepository();
      refreshHelper = RefreshHelper();
      cubit = UserCubit(mockRepository, refreshHelper);
    });

    tearDown(() async {
      await cubit.close();
      await refreshHelper.dispose();
    });

    test('initial state is UserInitial', () {
      expect(cubit.state, isA<UserInitial>());
    });

    group('getUser', () {
      test('should emit UserLoaded when user is provided', () async {
        // Arrange
        final providedUser = createMockUserProfile(
          id: 1,
          fullName: 'Provided User',
        );

        // Act
        await cubit.getUser(user: providedUser);

        // Assert
        expect(cubit.state, isA<UserLoaded>());
        final loadedState = cubit.state as UserLoaded;
        expect(loadedState.user, equals(providedUser));
        expect(loadedState.user.fullName, equals('Provided User'));
        verifyNever(() => mockRepository.getCachedUser());
      });

      test('should call refreshUser when user is not provided', () async {
        // Arrange
        final fetchedUser = createMockUserProfile(
          id: 2,
          fullName: 'Fetched User',
        );

        when(() => mockRepository.getCachedUser())
            .thenAnswer((_) async => right(fetchedUser));

        // Act
        await cubit.getUser();

        // Assert
        expect(cubit.state, isA<UserLoaded>());
        final loadedState = cubit.state as UserLoaded;
        expect(loadedState.user, equals(fetchedUser));
        verify(() => mockRepository.getCachedUser()).called(1);
      });
    });

    group('refreshUser', () {
      test('should emit UserLoading then UserLoaded on success', () async {
        // Arrange
        final refreshedUser = createMockUserProfile(
          id: 3,
          fullName: 'Refreshed User',
        );

        when(() => mockRepository.getCachedUser())
            .thenAnswer((_) async => right(refreshedUser));

        // Act
        final future = cubit.refreshUser();

        // Assert - check loading state is emitted
        expect(cubit.state, isA<UserLoading>());

        // Wait for completion
        await future;

        // Assert - check final state
        expect(cubit.state, isA<UserLoaded>());
        final loadedState = cubit.state as UserLoaded;
        expect(loadedState.user, equals(refreshedUser));
        verify(() => mockRepository.getCachedUser()).called(1);
      });

      test('should emit UserError when refreshUser fails', () async {
        // Arrange
        final failure = ServerFailure(
          statusCode: 500,
          message: 'Failed to fetch user',
        );

        when(() => mockRepository.getCachedUser())
            .thenAnswer((_) async => left(failure));

        // Act
        await cubit.refreshUser();

        // Assert
        expect(cubit.state, isA<UserError>());
        final errorState = cubit.state as UserError;
        expect(errorState.message, equals('Failed to fetch user'));
        verify(() => mockRepository.getCachedUser()).called(1);
      });
    });

    group('refresh stream subscription', () {
      test('should call refreshUser when refresh stream emits', () async {
        // Arrange
        final refreshedUser = createMockUserProfile(
          id: 4,
          fullName: 'Stream Refreshed User',
        );

        when(() => mockRepository.getCachedUser())
            .thenAnswer((_) async => right(refreshedUser));

        // Act - call getUser to set up the subscription
        await cubit.getUser();

        // Reset mock to verify it's called again
        reset(mockRepository);
        when(() => mockRepository.getCachedUser())
            .thenAnswer((_) async => right(refreshedUser));

        // Trigger refresh stream
        refreshHelper.refreshUser();

        // Wait for async operation
        await Future<void>.delayed(const Duration(milliseconds: 50));

        // Assert - verify refreshUser was called
        verify(() => mockRepository.getCachedUser()).called(1);
      });

      test('should set up subscription when getUser is called', () async {
        // Arrange
        final user = createMockUserProfile(id: 5);

        // Act
        await cubit.getUser(user: user);

        // Assert - subscription should be set up
        // Verify by triggering refresh and checking it's called
        reset(mockRepository);
        when(() => mockRepository.getCachedUser())
            .thenAnswer((_) async => right(user));

        refreshHelper.refreshUser();
        await Future<void>.delayed(const Duration(milliseconds: 50));

        verify(() => mockRepository.getCachedUser()).called(1);
      });
    });

    group('cleanup on close', () {
      test('should cancel refresh subscription on close', () async {
        // Arrange
        final user = createMockUserProfile(id: 6);
        await cubit.getUser(user: user);

        // Act
        await cubit.close();

        // Assert - subscription should be cancelled
        // Verify by triggering refresh and checking it's NOT called
        reset(mockRepository);
        when(() => mockRepository.getCachedUser())
            .thenAnswer((_) async => right(user));

        refreshHelper.refreshUser();
        await Future<void>.delayed(const Duration(milliseconds: 50));

        // Should not be called because subscription was cancelled
        verifyNever(() => mockRepository.getCachedUser());
      });
    });
  });
}
