import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/domain/repositories/user_repository.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

// Mock classes
class MockUserRepository extends Mock implements UserRepository {}

class MockSessionManager extends Mock implements SessionManager {}

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
  group('OnboardingCubit', () {
    late OnboardingCubit cubit;
    late MockUserRepository mockUserRepository;
    late MockSessionManager mockSessionManager;

    setUp(() {
      mockUserRepository = MockUserRepository();
      mockSessionManager = MockSessionManager();
      registerFallbackValue(Object());
    });

    tearDown(() async {
      await cubit.close();
    });

    setUpAll(() {
      registerFallbackValue(createMockUserProfile());
    });

    group('initial state', () {
      test('should have default values when no user info', () {
        // Arrange
        when(() => mockSessionManager.signedInUser).thenReturn(null);

        // Act
        cubit = OnboardingCubit(
          userRepository: mockUserRepository,
          sessionManager: mockSessionManager,
        );

        // Assert
        expect(cubit.state.userProfile, isNull);
        expect(cubit.state.currentStep, equals(0));
        expect(cubit.state.status, equals(OnboardingStatus.initial));
        expect(cubit.state.errorMessage, isNull);
      });

      test('should initialize with user info from SessionManager', () {
        // Arrange
        final userInfo = UserInfo(
          id: 1,
          userIdentifier: 'test_user_1',
          userName: 'Test User',
          email: 'test@example.com',
          created: DateTime(2024),
          scopeNames: ['user'],
          blocked: false,
        );
        when(() => mockSessionManager.signedInUser).thenReturn(userInfo);

        // Act
        cubit = OnboardingCubit(
          userRepository: mockUserRepository,
          sessionManager: mockSessionManager,
        );

        // Assert
        expect(cubit.state.userProfile, isNotNull);
        expect(cubit.state.userProfile!.userInfoId, equals(1));
        expect(cubit.state.userProfile!.fullName, equals('Test User'));
        expect(cubit.state.userProfile!.email, equals('test@example.com'));
        expect(cubit.state.currentStep, equals(0));
        expect(cubit.state.status, equals(OnboardingStatus.initial));
      });

      test('should handle null userName and email in userInfo', () {
        // Arrange
        final userInfo = UserInfo(
          id: 2,
          userIdentifier: 'test_user_2',
          created: DateTime(2024),
          scopeNames: ['user'],
          blocked: false,
        );
        when(() => mockSessionManager.signedInUser).thenReturn(userInfo);

        // Act
        cubit = OnboardingCubit(
          userRepository: mockUserRepository,
          sessionManager: mockSessionManager,
        );

        // Assert
        expect(cubit.state.userProfile, isNotNull);
        expect(cubit.state.userProfile!.fullName, equals(''));
        expect(cubit.state.userProfile!.email, equals(''));
      });
    });

    group('step navigation', () {
      setUp(() {
        when(() => mockSessionManager.signedInUser).thenReturn(null);
        cubit = OnboardingCubit(
          userRepository: mockUserRepository,
          sessionManager: mockSessionManager,
        );
      });

      test('nextPage should increment currentStep', () {
        // Arrange
        expect(cubit.state.currentStep, equals(0));

        // Act
        cubit.nextPage();

        // Assert
        expect(cubit.state.currentStep, equals(1));
      });

      test('nextPage should increment multiple times', () {
        // Arrange
        expect(cubit.state.currentStep, equals(0));

        // Act
        cubit
          ..nextPage()
          ..nextPage()
          ..nextPage();

        // Assert
        expect(cubit.state.currentStep, equals(3));
      });

      test('previousPage should decrement currentStep when > 0', () {
        // Arrange
        cubit
          ..nextPage()
          ..nextPage();
        expect(cubit.state.currentStep, equals(2));

        // Act
        cubit.previousPage();

        // Assert
        expect(cubit.state.currentStep, equals(1));
      });

      test('previousPage should do nothing when currentStep is 0', () {
        // Arrange
        expect(cubit.state.currentStep, equals(0));

        // Act
        cubit.previousPage();

        // Assert
        expect(cubit.state.currentStep, equals(0));
      });

      test('previousPage should not go below 0', () {
        // Arrange
        expect(cubit.state.currentStep, equals(0));

        // Act
        cubit
          ..previousPage()
          ..previousPage()
          ..previousPage();

        // Assert
        expect(cubit.state.currentStep, equals(0));
      });
    });

    group('user profile updates', () {
      setUp(() {
        when(() => mockSessionManager.signedInUser).thenReturn(null);
        cubit = OnboardingCubit(
          userRepository: mockUserRepository,
          sessionManager: mockSessionManager,
        );
      });

      test('updateUserProfile should update state with new profile', () {
        // Arrange
        final newProfile = createMockUserProfile(
          fullName: 'Updated User',
          email: 'updated@example.com',
        );

        // Act
        cubit.updateUserProfile(newProfile);

        // Assert
        expect(cubit.state.userProfile, equals(newProfile));
        expect(cubit.state.userProfile!.fullName, equals('Updated User'));
        expect(cubit.state.userProfile!.email, equals('updated@example.com'));
      });

      test('updateUserProfile should replace existing profile', () {
        // Arrange
        final initialProfile = createMockUserProfile(
          fullName: 'Initial User',
        );
        cubit.updateUserProfile(initialProfile);
        final updatedProfile = createMockUserProfile(
          fullName: 'Updated User',
        );

        // Act
        cubit.updateUserProfile(updatedProfile);

        // Assert
        expect(cubit.state.userProfile, equals(updatedProfile));
        expect(cubit.state.userProfile!.fullName, equals('Updated User'));
      });
    });

    group('submission flow', () {
      setUp(() {
        when(() => mockSessionManager.signedInUser).thenReturn(null);
        cubit = OnboardingCubit(
          userRepository: mockUserRepository,
          sessionManager: mockSessionManager,
        );
      });

      test('submit should emit submitting status', () async {
        // Arrange
        final userProfile = createMockUserProfile();
        cubit.updateUserProfile(userProfile);

        when(() => mockUserRepository.createUserProfile(any()))
            .thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 50));
          return voidSuccess;
        });

        // Act
        final future = cubit.submit();

        // Assert - check submitting status is emitted
        expect(cubit.state.status, equals(OnboardingStatus.submitting));

        // Wait for completion
        await future;
      });

      test('submit should emit success status on successful creation',
          () async {
        // Arrange
        final userProfile = createMockUserProfile();
        cubit.updateUserProfile(userProfile);

        when(() => mockUserRepository.createUserProfile(any()))
            .thenAnswer((_) async => voidSuccess);

        // Act
        await cubit.submit();

        // Assert
        expect(cubit.state.status, equals(OnboardingStatus.success));
        verify(() => mockUserRepository.createUserProfile(userProfile))
            .called(1);
      });

      test('submit should emit failure status with error message on failure',
          () async {
        // Arrange
        final userProfile = createMockUserProfile();
        cubit.updateUserProfile(userProfile);

        final failure = ServerFailure(
          statusCode: 500,
          message: 'Failed to create user profile',
        );

        when(() => mockUserRepository.createUserProfile(any()))
            .thenAnswer((_) async => left(failure));

        // Act
        await cubit.submit();

        // Assert
        expect(cubit.state.status, equals(OnboardingStatus.failure));
        expect(
          cubit.state.errorMessage,
          equals('Failed to create user profile'),
        );
        verify(() => mockUserRepository.createUserProfile(userProfile))
            .called(1);
      });

      test('submit should do nothing when userProfile is null', () async {
        // Arrange
        expect(cubit.state.userProfile, isNull);

        // Act
        await cubit.submit();

        // Assert
        expect(cubit.state.status, equals(OnboardingStatus.initial));
        verifyNever(() => mockUserRepository.createUserProfile(any()));
      });

      test('submit should handle different failure types', () async {
        // Arrange
        final userProfile = createMockUserProfile();
        cubit.updateUserProfile(userProfile);

        final failure = ServerFailure(
          statusCode: 400,
          message: 'Validation error',
        );

        when(() => mockUserRepository.createUserProfile(any()))
            .thenAnswer((_) async => left(failure));

        // Act
        await cubit.submit();

        // Assert
        expect(cubit.state.status, equals(OnboardingStatus.failure));
        expect(cubit.state.errorMessage, equals('Validation error'));
      });
    });
  });
}
