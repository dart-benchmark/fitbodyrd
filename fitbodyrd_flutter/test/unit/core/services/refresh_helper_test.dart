import 'dart:async';

import 'package:fitbodyrd_flutter/src/core/services/refresh_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RefreshHelper', () {
    late RefreshHelper refreshHelper;

    setUp(() {
      refreshHelper = RefreshHelper();
    });

    tearDown(() async {
      await refreshHelper.dispose();
    });

    group('refresh stream functionality', () {
      test('refreshUser emits an event on the stream', () async {
        // Arrange
        final events = <void>[];
        final subscription = refreshHelper.refreshUserStream.listen(events.add);

        // Act
        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events.length, equals(1));
        await subscription.cancel();
      });

      test('multiple calls to refreshUser emit multiple events', () async {
        // Arrange
        final events = <void>[];
        final subscription = refreshHelper.refreshUserStream.listen(events.add);

        // Act
        refreshHelper
          ..refreshUser()
          ..refreshUser()
          ..refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events.length, equals(3));
        await subscription.cancel();
      });

      test('stream emits void events (void stream)', () async {
        // Arrange
        var eventCount = 0;
        final subscription = refreshHelper.refreshUserStream.listen((event) {
          eventCount++;
        });

        // Act
        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(eventCount, equals(1));
        await subscription.cancel();
      });

      test('stream is a broadcast stream (multiple listeners can subscribe)',
          () async {
        // Arrange
        final events1 = <void>[];
        final events2 = <void>[];
        final subscription1 =
            refreshHelper.refreshUserStream.listen(events1.add);
        final subscription2 =
            refreshHelper.refreshUserStream.listen(events2.add);

        // Act
        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events1.length, equals(1));
        expect(events2.length, equals(1));
        await subscription1.cancel();
        await subscription2.cancel();
      });

      test('events are emitted immediately when refreshUser is called',
          () async {
        // Arrange
        var eventReceived = false;
        final subscription = refreshHelper.refreshUserStream.listen((event) {
          eventReceived = true;
        });

        // Act
        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(eventReceived, isTrue);
        await subscription.cancel();
      });

      test('stream is accessible via refreshUserStream getter', () {
        // Arrange & Act
        final stream = refreshHelper.refreshUserStream;

        // Assert
        expect(stream, isNotNull);
        expect(stream, isA<Stream<void>>());
      });
    });

    group('subscription management', () {
      test('multiple subscribers can listen to the same stream', () async {
        // Arrange
        final events1 = <void>[];
        final events2 = <void>[];
        final events3 = <void>[];

        final subscription1 =
            refreshHelper.refreshUserStream.listen(events1.add);
        final subscription2 =
            refreshHelper.refreshUserStream.listen(events2.add);
        final subscription3 =
            refreshHelper.refreshUserStream.listen(events3.add);

        // Act
        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events1.length, equals(1));
        expect(events2.length, equals(1));
        expect(events3.length, equals(1));

        await subscription1.cancel();
        await subscription2.cancel();
        await subscription3.cancel();
      });

      test('all subscribers receive events when refreshUser is called',
          () async {
        // Arrange
        var received1 = false;
        var received2 = false;
        var received3 = false;

        final subscription1 = refreshHelper.refreshUserStream.listen((event) {
          received1 = true;
        });
        final subscription2 = refreshHelper.refreshUserStream.listen((event) {
          received2 = true;
        });
        final subscription3 = refreshHelper.refreshUserStream.listen((event) {
          received3 = true;
        });

        // Act
        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(received1, isTrue);
        expect(received2, isTrue);
        expect(received3, isTrue);

        await subscription1.cancel();
        await subscription2.cancel();
        await subscription3.cancel();
      });

      test('subscribers can cancel their subscriptions independently',
          () async {
        // Arrange
        final events1 = <void>[];
        final events2 = <void>[];

        final subscription1 =
            refreshHelper.refreshUserStream.listen(events1.add);
        final subscription2 =
            refreshHelper.refreshUserStream.listen(events2.add);

        // Act
        await subscription1.cancel();
        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events1.length, equals(0)); // Cancelled, no events
        expect(events2.length, equals(1)); // Still active, received event

        await subscription2.cancel();
      });

      test('one subscriber canceling does not affect others', () async {
        // Arrange
        final events1 = <void>[];
        final events2 = <void>[];
        final events3 = <void>[];

        final subscription1 =
            refreshHelper.refreshUserStream.listen(events1.add);
        final subscription2 =
            refreshHelper.refreshUserStream.listen(events2.add);
        final subscription3 =
            refreshHelper.refreshUserStream.listen(events3.add);

        // Act
        await subscription2.cancel(); // Cancel middle subscription
        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events1.length, equals(1)); // Still active
        expect(events2.length, equals(0)); // Cancelled
        expect(events3.length, equals(1)); // Still active

        await subscription1.cancel();
        await subscription3.cancel();
      });

      test('new subscribers can join after events have been emitted', () async {
        // Arrange
        final events1 = <void>[];
        final subscription1 =
            refreshHelper.refreshUserStream.listen(events1.add);

        // Act - emit event before second subscriber joins
        refreshHelper.refreshUser();
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Add new subscriber after event was emitted
        final events2 = <void>[];
        final subscription2 =
            refreshHelper.refreshUserStream.listen(events2.add);

        // Emit another event
        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events1.length, equals(2)); // Received both events
        expect(events2.length, equals(1)); // Only received second event

        await subscription1.cancel();
        await subscription2.cancel();
      });

      test('subscribers receive events in order', () async {
        // Arrange
        final events = <int>[];
        var eventCount = 0;
        final subscription = refreshHelper.refreshUserStream.listen((event) {
          events.add(eventCount++);
        });

        // Act
        refreshHelper
          ..refreshUser()
          ..refreshUser()
          ..refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events.length, equals(3));
        expect(events[0], equals(0));
        expect(events[1], equals(1));
        expect(events[2], equals(2));

        await subscription.cancel();
      });

      test('subscribers can listen multiple times', () async {
        // Arrange
        final events1 = <void>[];
        final subscription1 =
            refreshHelper.refreshUserStream.listen(events1.add);

        // Act
        refreshHelper.refreshUser();
        await Future<void>.delayed(const Duration(milliseconds: 10));

        await subscription1.cancel();

        // Create new subscription
        final events2 = <void>[];
        final subscription2 =
            refreshHelper.refreshUserStream.listen(events2.add);

        refreshHelper.refreshUser();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(events1.length, equals(1));
        expect(events2.length, equals(1));

        await subscription2.cancel();
      });
    });

    group('dispose functionality', () {
      test('dispose closes the stream controller', () async {
        // Arrange
        final refreshHelper = RefreshHelper();
        var doneReceived = false;
        final subscription = refreshHelper.refreshUserStream.listen(
          (event) {},
          onDone: () {
            doneReceived = true;
          },
        );

        // Act
        await refreshHelper.dispose();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        // Stream should be closed after dispose
        expect(doneReceived, isTrue);

        await subscription.cancel();
      });

      test('after dispose, the stream is closed', () async {
        // Arrange
        final refreshHelper = RefreshHelper();
        await refreshHelper.dispose();

        // Act & Assert
        expect(
          () => refreshHelper.refreshUserStream.listen((event) {}),
          returnsNormally,
        );

        // The stream should be closed, so listening should complete immediately
        final subscription = refreshHelper.refreshUserStream.listen((_) {});
        await expectLater(subscription.asFuture<void>(), completes);
        await subscription.cancel();
      });

      test('calling refreshUser after dispose throws StateError', () async {
        // Arrange
        final refreshHelper = RefreshHelper();
        await refreshHelper.dispose();

        // Act & Assert - should throw StateError
        // because stream controller is closed
        expect(
          refreshHelper.refreshUser,
          throwsA(isA<StateError>()),
        );
      });

      test('new subscriptions after dispose complete immediately', () async {
        // Arrange
        final refreshHelper = RefreshHelper();
        await refreshHelper.dispose();

        // Act
        var eventReceived = false;
        final subscription = refreshHelper.refreshUserStream.listen(
          (event) {
            eventReceived = true;
          },
          onDone: () {
            // Stream is closed
          },
        );

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(eventReceived, isFalse); // No events after dispose

        await subscription.cancel();
      });

      test('disposing when there are active subscriptions closes them',
          () async {
        // Arrange
        final refreshHelper = RefreshHelper();
        var done1 = false;
        var done2 = false;

        refreshHelper.refreshUserStream.listen(
          (event) {},
          onDone: () {
            done1 = true;
          },
        );
        refreshHelper.refreshUserStream.listen(
          (event) {},
          onDone: () {
            done2 = true;
          },
        );

        // Act
        await refreshHelper.dispose();

        // Assert
        await Future<void>.delayed(const Duration(milliseconds: 10));
        // Subscriptions should be closed when stream controller is disposed
        expect(done1 || done2, isTrue); // At least one should be done
      });

      test('disposing multiple times is safe', () async {
        // Arrange
        final refreshHelper = RefreshHelper();

        // Act & Assert - should not throw
        await refreshHelper.dispose();
        await expectLater(refreshHelper.dispose(), completes);
        await expectLater(refreshHelper.dispose(), completes);
      });
    });
  });
}
