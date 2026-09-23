import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/home/data/repositories/dashboard_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

// Mock classes
class MockClient extends Mock implements Client {}

class MockEndpointDashboard extends Mock implements EndpointDashboard {}

class MockSessionManager extends Mock implements SessionManager {}

// Helper function to create a mock WeeklySummaryDto
WeeklySummaryDto createMockWeeklySummary({
  int workoutsCompleted = 0,
  int workoutsScheduled = 0,
  int nutritionDaysLogged = 0,
  int totalExercisesLogged = 0,
  int totalMealsLogged = 0,
  DateTime? weekStartDate,
  DateTime? weekEndDate,
}) {
  final now = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - 1));
  return WeeklySummaryDto(
    workoutsCompleted: workoutsCompleted,
    workoutsScheduled: workoutsScheduled,
    nutritionDaysLogged: nutritionDaysLogged,
    totalExercisesLogged: totalExercisesLogged,
    totalMealsLogged: totalMealsLogged,
    weekStartDate: weekStartDate ?? monday,
    weekEndDate: weekEndDate ?? monday.add(const Duration(days: 6)),
  );
}

void main() {
  group('DashboardRepositoryImpl', () {
    late DashboardRepositoryImpl dashboardRepository;
    late MockClient mockClient;
    late MockEndpointDashboard mockEndpointDashboard;
    late MockSessionManager mockSessionManager;

    setUp(() {
      mockClient = MockClient();
      mockEndpointDashboard = MockEndpointDashboard();
      mockSessionManager = MockSessionManager();

      registerFallbackValue(Object());

      when(() => mockClient.dashboard).thenReturn(mockEndpointDashboard);

      dashboardRepository = DashboardRepositoryImpl(
        client: mockClient,
        sessionManager: mockSessionManager,
      );
    });

    group('getWeeklySummary', () {
      test('should return WeeklySummaryDto on success', () async {
        // Arrange
        final mockSummary = createMockWeeklySummary(
          workoutsCompleted: 3,
          workoutsScheduled: 5,
          nutritionDaysLogged: 4,
          totalExercisesLogged: 10,
          totalMealsLogged: 12,
        );
        when(() => mockEndpointDashboard.getWeeklySummary())
            .thenAnswer((_) async => mockSummary);

        // Act
        final result = await dashboardRepository.getWeeklySummary();

        // Assert
        result.fold(
          (summary) {
            expect(summary, equals(mockSummary));
            expect(summary!.workoutsCompleted, equals(3));
            expect(summary.workoutsScheduled, equals(5));
            expect(summary.nutritionDaysLogged, equals(4));
            expect(summary.totalExercisesLogged, equals(10));
            expect(summary.totalMealsLogged, equals(12));
          },
          (_) => fail('Expected success but got failure'),
        );
        verify(() => mockEndpointDashboard.getWeeklySummary()).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final exception = AppException(
          module: 'dashboard',
          message: 'Failed to load summary',
          errorCode: 5000,
          httpStatus: 500,
        );
        when(() => mockEndpointDashboard.getWeeklySummary())
            .thenThrow(exception);

        // Act
        final result = await dashboardRepository.getWeeklySummary();

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            final serverFailure = failure as ServerFailure;
            expect(serverFailure.statusCode, equals(5000));
            expect(serverFailure.message, equals('Failed to load summary'));
          },
        );
        verify(() => mockEndpointDashboard.getWeeklySummary()).called(1);
      });

      test('should return ServerFailure when generic Exception is thrown',
          () async {
        // Arrange
        when(() => mockEndpointDashboard.getWeeklySummary())
            .thenThrow(Exception('Network error'));

        // Act
        final result = await dashboardRepository.getWeeklySummary();

        // Assert
        result.fold(
          (_) => fail('Expected failure but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            final serverFailure = failure as ServerFailure;
            expect(serverFailure.statusCode, equals(500));
            expect(serverFailure.message, contains('Network error'));
          },
        );
        verify(() => mockEndpointDashboard.getWeeklySummary()).called(1);
      });

      test('should return empty summary when no data exists', () async {
        // Arrange
        final emptySummary = createMockWeeklySummary();
        when(() => mockEndpointDashboard.getWeeklySummary())
            .thenAnswer((_) async => emptySummary);

        // Act
        final result = await dashboardRepository.getWeeklySummary();

        // Assert
        result.fold(
          (summary) {
            expect(summary!.workoutsCompleted, equals(0));
            expect(summary.workoutsScheduled, equals(0));
            expect(summary.nutritionDaysLogged, equals(0));
            expect(summary.totalExercisesLogged, equals(0));
            expect(summary.totalMealsLogged, equals(0));
          },
          (_) => fail('Expected success but got failure'),
        );
        verify(() => mockEndpointDashboard.getWeeklySummary()).called(1);
      });
    });
  });
}
