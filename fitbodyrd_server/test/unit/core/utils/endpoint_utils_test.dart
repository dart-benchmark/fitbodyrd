import 'package:fitbodyrd_server/src/common/utils/endpoint_utils.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  group('EndpointUtils', () {
    group('getUserIdFromSession', () {
      const mockUserId = 1;
      withServerpod('Given EndpointUtils.getUserIdFromSession', (
        sessionBuilder,
        endpoints,
      ) {
        test('returns userId when session is authenticated', () async {
          // Arrange
          var authenticatedSessionBuilder = sessionBuilder.copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              mockUserId.toString(),
              {},
            ),
          );
          final session = authenticatedSessionBuilder.build();

          // Act
          final userId = await EndpointUtils.getUserIdFromSession(session);

          // Assert
          expect(userId, isA<int>());
          expect(userId, equals(mockUserId));
        });

        test('throws AppException when session is not authenticated', () async {
          // Arrange
          var unauthenticatedSessionBuilder = sessionBuilder.copyWith(
            authentication: AuthenticationOverride.unauthenticated(),
          );
          final session = unauthenticatedSessionBuilder.build();

          // Act & Assert
          expect(
            () => EndpointUtils.getUserIdFromSession(session),
            throwsA(
              isA<AppException>()
                  .having((e) => e.module, 'module', 'generic')
                  .having(
                    (e) => e.message,
                    'message',
                    'User not authenticated.',
                  )
                  .having((e) => e.errorCode, 'errorCode', 1001)
                  .having((e) => e.httpStatus, 'httpStatus', 401),
            ),
          );
        });

        test('returns correct userId for different user IDs', () async {
          // Arrange
          const differentUserId = 999;
          var authenticatedSessionBuilder = sessionBuilder.copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              differentUserId.toString(),
              {},
            ),
          );
          final session = authenticatedSessionBuilder.build();

          // Act
          final userId = await EndpointUtils.getUserIdFromSession(session);

          // Assert
          expect(userId, equals(differentUserId));
        });
      });
    });

    group('isSameDay', () {
      test('returns true when dates are identical', () {
        // Arrange
        final date1 = DateTime(2024, 1, 15, 10, 30, 45);
        final date2 = DateTime(2024, 1, 15, 10, 30, 45);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isTrue);
      });

      test('returns true when dates are same day but different times', () {
        // Arrange
        final date1 = DateTime(2024, 1, 15, 0, 0, 0);
        final date2 = DateTime(2024, 1, 15, 23, 59, 59);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isTrue);
      });

      test('returns true when dates are same day with different hours', () {
        // Arrange
        final date1 = DateTime(2024, 1, 15, 8, 0, 0);
        final date2 = DateTime(2024, 1, 15, 20, 0, 0);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isTrue);
      });

      test('returns false when dates have different years', () {
        // Arrange
        final date1 = DateTime(2024, 1, 15, 10, 30, 45);
        final date2 = DateTime(2025, 1, 15, 10, 30, 45);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isFalse);
      });

      test('returns false when dates have different months', () {
        // Arrange
        final date1 = DateTime(2024, 1, 15, 10, 30, 45);
        final date2 = DateTime(2024, 2, 15, 10, 30, 45);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isFalse);
      });

      test('returns false when dates have different days', () {
        // Arrange
        final date1 = DateTime(2024, 1, 15, 10, 30, 45);
        final date2 = DateTime(2024, 1, 16, 10, 30, 45);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isFalse);
      });

      test('returns false when dates are on different sides of midnight', () {
        // Arrange
        final date1 = DateTime(2024, 1, 15, 23, 59, 59);
        final date2 = DateTime(2024, 1, 16, 0, 0, 1);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isFalse);
      });

      test('returns false when dates are far apart', () {
        // Arrange
        final date1 = DateTime(2020, 1, 1, 12, 0, 0);
        final date2 = DateTime(2024, 12, 31, 12, 0, 0);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isFalse);
      });

      test('returns false at year boundary (Dec 31 vs Jan 1)', () {
        // Arrange
        final date1 = DateTime(2024, 12, 31, 12, 0, 0);
        final date2 = DateTime(2025, 1, 1, 12, 0, 0);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isFalse);
      });

      test('returns false at month boundary (last day vs first day)', () {
        // Arrange
        final date1 = DateTime(2024, 1, 31, 12, 0, 0);
        final date2 = DateTime(2024, 2, 1, 12, 0, 0);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isFalse);
      });

      test('returns true for leap year date (Feb 29)', () {
        // Arrange
        final date1 = DateTime(2024, 2, 29, 10, 0, 0);
        final date2 = DateTime(2024, 2, 29, 20, 0, 0);

        // Act
        final result = EndpointUtils.isSameDay(date1, date2);

        // Assert
        expect(result, isTrue);
      });

      test(
        'returns false when comparing Feb 29 with Feb 28 in non-leap year',
        () {
          // Arrange
          final date1 = DateTime(2024, 2, 29, 12, 0, 0); // Leap year
          final date2 = DateTime(2023, 2, 28, 12, 0, 0); // Non-leap year

          // Act
          final result = EndpointUtils.isSameDay(date1, date2);

          // Assert
          expect(result, isFalse);
        },
      );
    });
  });
}
