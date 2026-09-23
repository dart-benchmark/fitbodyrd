import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/auth/data/repositories/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';

// Mock classes
class MockClient extends Mock implements Client {}

class MockEndpointUser extends Mock implements EndpointUser {}

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
  group('UserRepositoryImpl', () {
    late UserRepositoryImpl userRepository;
    late MockClient mockClient;
    late MockEndpointUser mockEndpointUser;

    setUp(() {
      mockClient = MockClient();
      mockEndpointUser = MockEndpointUser();

      // Register fallback values for mocktail
      registerFallbackValue(Object());

      // Set up the user endpoint on the mock client
      when(() => mockClient.user).thenReturn(mockEndpointUser);

      userRepository = UserRepositoryImpl(client: mockClient);
    });

    group('getCachedUser', () {
      test('should return cached user when user is already cached', () async {
        // Arrange
        final cachedUser = createMockUserProfile(
          id: 1,
          fullName: 'Cached User',
        );

        // First, populate the cache by calling getCachedUser
        // with a successful fetch
        when(() => mockEndpointUser.getCurrentUserProfile())
            .thenAnswer((_) async => cachedUser);

        final firstResult = await userRepository.getCachedUser();
        firstResult.fold(
          (user) => expect(user, equals(cachedUser)),
          (_) => fail('Expected success on first call'),
        );

        // Reset the mock to verify it's not called again
        reset(mockEndpointUser);
        when(() => mockClient.user).thenReturn(mockEndpointUser);

        // Act - call getCachedUser again
        final result = await userRepository.getCachedUser();

        // Assert
        result.fold(
          (user) {
            expect(user, equals(cachedUser));
            expect(user!.fullName, equals('Cached User'));
          },
          (_) => fail('Expected success but got failure'),
        );

        // Verify that getCurrentUserProfile was not called (cache was used)
        verifyNever(() => mockEndpointUser.getCurrentUserProfile());
      });

      test('should fetch user from server when cache is empty', () async {
        // Arrange
        final fetchedUser = createMockUserProfile(
          id: 2,
          fullName: 'Fetched User',
          email: 'fetched@example.com',
        );

        when(() => mockEndpointUser.getCurrentUserProfile())
            .thenAnswer((_) async => fetchedUser);

        // Act
        final result = await userRepository.getCachedUser();

        // Assert
        result.fold(
          (user) {
            expect(user, equals(fetchedUser));
            // Type system incorrectly infers user as nullable in fold callback
            expect(user!.fullName, equals('Fetched User'));
            expect(user.email, equals('fetched@example.com'));
          },
          (_) => fail('Expected success but got failure'),
        );

        verify(() => mockEndpointUser.getCurrentUserProfile()).called(1);
      });

      test(
          'should return ServerFailure when '
          'getCurrentUserProfile throws AppException', () async {
        // Arrange
        final exception = AppException(
          module: 'user',
          message: 'User not found',
          errorCode: 6000,
          httpStatus: 404,
        );

        when(() => mockEndpointUser.getCurrentUserProfile())
            .thenThrow(exception);

        // Act
        final result = await userRepository.getCachedUser();

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            final serverFailure = failure as ServerFailure;
            expect(serverFailure.statusCode, equals(6000));
            expect(serverFailure.message, equals('User not found'));
          },
        );

        verify(() => mockEndpointUser.getCurrentUserProfile()).called(1);
      });
    });

    group('refreshUser', () {
      test('should fetch user from server and update cache on success',
          () async {
        // Arrange
        final refreshedUser = createMockUserProfile(
          id: 3,
          fullName: 'Refreshed User',
          email: 'refreshed@example.com',
        );

        when(() => mockEndpointUser.getCurrentUserProfile())
            .thenAnswer((_) async => refreshedUser);

        // Act
        final result = await userRepository.refreshUser();

        // Assert - verify refreshUser succeeded
        result.fold(
          (_) {
            // Success - no action needed here
          },
          (_) => fail('Expected success but got failure'),
        );

        verify(() => mockEndpointUser.getCurrentUserProfile()).called(1);

        // Verify cache was updated by checking getCachedUser
        // returns the refreshed user without calling the server again
        reset(mockEndpointUser);
        when(() => mockClient.user).thenReturn(mockEndpointUser);

        // Now getCachedUser should return the cached (refreshed) user
        final cachedResult = await userRepository.getCachedUser();
        cachedResult.fold(
          (user) {
            expect(user, equals(refreshedUser));
            expect(user!.fullName, equals('Refreshed User'));
          },
          (_) => fail('Expected cached user'),
        );

        // Verify that getCurrentUserProfile
        // was not called again (cache was used)
        verifyNever(() => mockEndpointUser.getCurrentUserProfile());
      });

      test(
          'should return ServerFailure when '
          'getCurrentUserProfile throws AppException', () async {
        // Arrange
        final exception = AppException(
          module: 'user',
          message: 'Unauthorized',
          errorCode: 1001,
          httpStatus: 401,
        );

        when(() => mockEndpointUser.getCurrentUserProfile())
            .thenThrow(exception);

        // Act
        final result = await userRepository.refreshUser();

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            final serverFailure = failure as ServerFailure;
            expect(serverFailure.statusCode, equals(1001));
            expect(serverFailure.message, equals('Unauthorized'));
          },
        );

        verify(() => mockEndpointUser.getCurrentUserProfile()).called(1);
      });
    });

    group('clearUser', () {
      test('should clear cached user', () async {
        // Arrange - first populate the cache
        final cachedUser = createMockUserProfile(
          id: 4,
          fullName: 'User to Clear',
        );

        when(() => mockEndpointUser.getCurrentUserProfile())
            .thenAnswer((_) async => cachedUser);

        // Populate cache
        final firstResult = await userRepository.getCachedUser();
        firstResult.fold(
          (user) => expect(user, equals(cachedUser)),
          (_) => fail('Expected success on first call'),
        );

        // Reset mock to verify it will be called after clear
        reset(mockEndpointUser);
        when(() => mockClient.user).thenReturn(mockEndpointUser);

        // Act - clear the cache
        userRepository.clearUser();

        // Assert - verify that getCachedUser now fetches from server
        final newUser = createMockUserProfile(
          id: 5,
          fullName: 'New User',
        );

        when(() => mockEndpointUser.getCurrentUserProfile())
            .thenAnswer((_) async => newUser);

        final result = await userRepository.getCachedUser();

        result.fold(
          (user) {
            expect(user, equals(newUser));
            expect(user!.fullName, equals('New User'));
          },
          (_) => fail('Expected success but got failure'),
        );

        // Verify that getCurrentUserProfile was called (cache was cleared)
        verify(() => mockEndpointUser.getCurrentUserProfile()).called(1);
      });
    });
  });
}
