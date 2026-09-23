import 'package:fitbodyrd_server/src/features/exercise/exceptions/exercise_exceptions.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Exercise endpoint', (sessionBuilder, endpoints) {
    // Helper function to create a test Exercise
    Future<Exercise> createTestExercise({
      String? name,
      String? description,
      List<ExerciseCategory>? category,
      List<ExerciseMuscleGroup>? muscleGroup,
      ExerciseDifficulty? difficulty,
      bool? requiresEquipment,
      String? equipmentNeeded,
    }) async {
      final session = sessionBuilder.build();
      final exercise = Exercise(
        name: name ?? 'Test Exercise',
        description: description,
        category: category ?? [ExerciseCategory.cardio],
        muscleGroup: muscleGroup ?? [ExerciseMuscleGroup.legs],
        difficulty: difficulty ?? ExerciseDifficulty.beginner,
        requiresEquipment: requiresEquipment ?? false,
        equipmentNeeded: equipmentNeeded,
      );
      final inserted = await Exercise.db.insertRow(session, exercise);
      return inserted;
    }

    // Helper function to create a test ExerciseImage
    Future<ExerciseImage> createTestExerciseImage({
      required int exerciseId,
      String? imageUrl,
      int? orderIndex,
    }) async {
      final session = sessionBuilder.build();
      final image = ExerciseImage(
        exerciseId: exerciseId,
        imageUrl: imageUrl ?? 'https://example.com/image.jpg',
        orderIndex: orderIndex ?? 0,
      );
      final inserted = await ExerciseImage.db.insertRow(session, image);
      return inserted;
    }

    // Helper function to create a test ExerciseAlternative
    Future<ExerciseAlternative> createTestExerciseAlternative({
      required int exerciseId,
      required int alternativeExerciseId,
    }) async {
      final session = sessionBuilder.build();
      final alternative = ExerciseAlternative(
        exerciseId: exerciseId,
        alternativeExerciseId: alternativeExerciseId,
      );
      final inserted =
          await ExerciseAlternative.db.insertRow(session, alternative);
      return inserted;
    }

    group('getAllExercises', () {
      test('should return list of exercises', () async {
        // Arrange
        await createTestExercise(name: 'Exercise 1');
        await createTestExercise(name: 'Exercise 2');

        // Act
        final result = await endpoints.exercise.getAllExercises(sessionBuilder);

        // Assert
        expect(result, isNotEmpty);
        expect(result.length, greaterThanOrEqualTo(2));
      });

      test('should return exercises ordered by name then createdAt', () async {
        // Arrange
        final exercise1 = await createTestExercise(name: 'B Exercise');
        await Future.delayed(const Duration(milliseconds: 10));
        final exercise2 = await createTestExercise(name: 'A Exercise');

        // Act
        final result = await endpoints.exercise.getAllExercises(sessionBuilder);

        // Assert
        expect(result.length, greaterThanOrEqualTo(2));
        final exercise1Index = result.indexWhere((e) => e.id == exercise1.id);
        final exercise2Index = result.indexWhere((e) => e.id == exercise2.id);
        expect(exercise2Index, lessThan(exercise1Index));
      });

      test('should include alternatives and images', () async {
        // Arrange
        final exercise1 = await createTestExercise(name: 'Main Exercise');
        final exercise2 =
            await createTestExercise(name: 'Alternative Exercise');
        await createTestExerciseImage(exerciseId: exercise1.id!);
        await createTestExerciseAlternative(
          exerciseId: exercise1.id!,
          alternativeExerciseId: exercise2.id!,
        );

        // Act
        final result = await endpoints.exercise.getAllExercises(sessionBuilder);

        // Assert
        final mainExercise = result.firstWhere((e) => e.id == exercise1.id);
        expect(mainExercise.images, isNotNull);
        expect(mainExercise.images!.isNotEmpty, isTrue);
        expect(mainExercise.alternatives, isNotNull);
        expect(mainExercise.alternatives!.isNotEmpty, isTrue);
      });

      test('should return empty list when no exercises exist', () async {
        // Act
        final result = await endpoints.exercise.getAllExercises(sessionBuilder);

        // Assert
        expect(result, isEmpty);
      });
    });

    group('getExerciseById', () {
      test('should return exercise with full includes', () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');
        await createTestExerciseImage(exerciseId: exercise.id!);
        await createTestExerciseImage(exerciseId: exercise.id!, orderIndex: 1);

        // Act
        final result = await endpoints.exercise
            .getExerciseById(sessionBuilder, exercise.id!);

        // Assert
        expect(result, isNotNull);
        expect(result.id, equals(exercise.id));
        expect(result.name, equals('Test Exercise'));
        expect(result.images, isNotNull);
        expect(result.images!.length, equals(2));
      });

      test(
          'should throw ExerciseExceptions.exerciseNotFound when exercise does not exist',
          () async {
        // Act & Assert
        await expectLater(
          endpoints.exercise.getExerciseById(sessionBuilder, 99999),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.exerciseNotFound().errorCode)),
        );
      });

      test('should include alternatives and images', () async {
        // Arrange
        final exercise1 = await createTestExercise(name: 'Main Exercise');
        final exercise2 =
            await createTestExercise(name: 'Alternative Exercise');
        await createTestExerciseImage(exerciseId: exercise1.id!);
        await createTestExerciseAlternative(
          exerciseId: exercise1.id!,
          alternativeExerciseId: exercise2.id!,
        );

        // Act
        final result = await endpoints.exercise
            .getExerciseById(sessionBuilder, exercise1.id!);

        // Assert
        expect(result.images, isNotNull);
        expect(result.images!.isNotEmpty, isTrue);
        expect(result.alternatives, isNotNull);
        expect(result.alternatives!.isNotEmpty, isTrue);
        expect(result.alternatives!.first.alternativeExercise, isNotNull);
      });
    });

    group('createExercise', () {
      test('should create exercise with all fields', () async {
        // Act
        final result = await endpoints.exercise.createExercise(
          sessionBuilder,
          name: 'Full Exercise',
          description: 'A complete exercise description',
          category: [ExerciseCategory.strength],
          muscleGroup: [
            ExerciseMuscleGroup.chest,
            ExerciseMuscleGroup.shoulders
          ],
          difficulty: ExerciseDifficulty.intermediate,
          requiresEquipment: true,
          equipmentNeeded: 'Dumbbells',
          videoUrl: 'https://example.com/video.mp4',
        );

        // Assert
        expect(result, isNotNull);
        expect(result.id, isNotNull);
        expect(result.name, equals('Full Exercise'));
        expect(result.description, equals('A complete exercise description'));
        expect(result.category, contains(ExerciseCategory.strength));
        expect(result.muscleGroup, contains(ExerciseMuscleGroup.chest));
        expect(result.difficulty, equals(ExerciseDifficulty.intermediate));
        expect(result.requiresEquipment, isTrue);
        expect(result.equipmentNeeded, equals('Dumbbells'));
        expect(result.videoUrl, equals('https://example.com/video.mp4'));
      });

      test('should create exercise with minimal required fields', () async {
        // Act
        final result = await endpoints.exercise.createExercise(
          sessionBuilder,
          name: 'Minimal Exercise',
          category: [ExerciseCategory.cardio],
          muscleGroup: [ExerciseMuscleGroup.legs],
          difficulty: ExerciseDifficulty.beginner,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.id, isNotNull);
        expect(result.name, equals('Minimal Exercise'));
        expect(result.requiresEquipment, isFalse);
      });

      test(
          'should throw ExerciseExceptions.equipmentMissing when requiresEquipment is true but equipmentNeeded is null',
          () async {
        // Act & Assert
        await expectLater(
          endpoints.exercise.createExercise(
            sessionBuilder,
            name: 'Equipment Exercise',
            category: [ExerciseCategory.strength],
            muscleGroup: [ExerciseMuscleGroup.chest],
            difficulty: ExerciseDifficulty.beginner,
            requiresEquipment: true,
            equipmentNeeded: null,
          ),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.equipmentMissing().errorCode)),
        );
      });

      test(
          'should throw ExerciseExceptions.equipmentMissing when requiresEquipment is true but equipmentNeeded is empty',
          () async {
        // Act & Assert
        await expectLater(
          endpoints.exercise.createExercise(
            sessionBuilder,
            name: 'Equipment Exercise',
            category: [ExerciseCategory.strength],
            muscleGroup: [ExerciseMuscleGroup.chest],
            difficulty: ExerciseDifficulty.beginner,
            requiresEquipment: true,
            equipmentNeeded: '',
          ),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.equipmentMissing().errorCode)),
        );
      });

      test(
          'should throw ExerciseExceptions.nameAlreadyExists when duplicate name',
          () async {
        // Arrange
        await createTestExercise(name: 'Duplicate Exercise');

        // Act & Assert
        await expectLater(
          endpoints.exercise.createExercise(
            sessionBuilder,
            name: 'Duplicate Exercise',
            category: [ExerciseCategory.cardio],
            muscleGroup: [ExerciseMuscleGroup.legs],
            difficulty: ExerciseDifficulty.beginner,
          ),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.nameAlreadyExists().errorCode)),
        );
      });

      test('should verify categories and muscle groups are set correctly',
          () async {
        // Act
        final result = await endpoints.exercise.createExercise(
          sessionBuilder,
          name: 'Multi Category Exercise',
          category: [
            ExerciseCategory.strength,
            ExerciseCategory.flexibility,
          ],
          muscleGroup: [
            ExerciseMuscleGroup.chest,
            ExerciseMuscleGroup.back,
            ExerciseMuscleGroup.legs,
          ],
          difficulty: ExerciseDifficulty.advanced,
        );

        // Assert
        expect(result.category.length, equals(2));
        expect(result.category, contains(ExerciseCategory.strength));
        expect(result.category, contains(ExerciseCategory.flexibility));
        expect(result.muscleGroup.length, equals(3));
        expect(result.muscleGroup, contains(ExerciseMuscleGroup.chest));
        expect(result.muscleGroup, contains(ExerciseMuscleGroup.back));
        expect(result.muscleGroup, contains(ExerciseMuscleGroup.legs));
      });
    });

    group('updateExercise', () {
      test('should update existing exercise', () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Original Name');

        // Act
        final updated = await endpoints.exercise.updateExercise(
          sessionBuilder,
          exercise.copyWith(
            name: 'Updated Name',
            description: 'Updated description',
          ),
        );

        // Assert
        expect(updated.name, equals('Updated Name'));
        expect(updated.description, equals('Updated description'));
        expect(updated.updatedAt, isNot(equals(exercise.updatedAt)));
      });

      test(
          'should throw ExerciseExceptions.exerciseNotFound when exercise does not exist',
          () async {
        // Arrange
        final nonExistentExercise = Exercise(
          id: 99999,
          name: 'Non Existent',
          category: [ExerciseCategory.cardio],
          muscleGroup: [ExerciseMuscleGroup.legs],
          difficulty: ExerciseDifficulty.beginner,
        );

        // Act & Assert
        await expectLater(
          endpoints.exercise
              .updateExercise(sessionBuilder, nonExistentExercise),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.exerciseNotFound().errorCode)),
        );
      });

      test(
          'should throw ExerciseExceptions.equipmentMissing when requiresEquipment is true but equipmentNeeded is null',
          () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');

        // Act & Assert
        await expectLater(
          endpoints.exercise.updateExercise(
            sessionBuilder,
            exercise.copyWith(
              requiresEquipment: true,
              equipmentNeeded: null,
            ),
          ),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.equipmentMissing().errorCode)),
        );
      });

      test(
          'should throw ExerciseExceptions.nameAlreadyExists when duplicate name',
          () async {
        // Arrange
        await createTestExercise(name: 'Existing Exercise');
        final exercise2 = await createTestExercise(name: 'Exercise To Update');

        // Act & Assert
        await expectLater(
          endpoints.exercise.updateExercise(
            sessionBuilder,
            exercise2.copyWith(name: 'Existing Exercise'),
          ),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.nameAlreadyExists().errorCode)),
        );
      });
    });

    group('deleteExercise', () {
      test('should delete exercise and associated images and alternatives',
          () async {
        // Arrange
        final exercise1 = await createTestExercise(name: 'Main Exercise');
        final exercise2 =
            await createTestExercise(name: 'Alternative Exercise');
        await createTestExerciseImage(exerciseId: exercise1.id!);
        final alternative = await createTestExerciseAlternative(
          exerciseId: exercise1.id!,
          alternativeExerciseId: exercise2.id!,
        );

        // Act
        await endpoints.exercise.deleteExercise(sessionBuilder, exercise1.id!);

        // Assert
        final session = sessionBuilder.build();
        final deletedExercise =
            await Exercise.db.findById(session, exercise1.id!);
        expect(deletedExercise, isNull);

        final deletedAlternative =
            await ExerciseAlternative.db.findById(session, alternative.id!);
        expect(deletedAlternative, isNull);
      });

      test(
          'should throw ExerciseExceptions.exerciseNotFound when exercise does not exist',
          () async {
        // Act & Assert
        await expectLater(
          endpoints.exercise.deleteExercise(sessionBuilder, 99999),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.exerciseNotFound().errorCode)),
        );
      });
    });

    group('getExerciseImages', () {
      test('should return images for exercise', () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');
        await createTestExerciseImage(exerciseId: exercise.id!);
        await createTestExerciseImage(exerciseId: exercise.id!, orderIndex: 1);

        // Act
        final result = await endpoints.exercise
            .getExerciseImages(sessionBuilder, exercise.id!);

        // Assert
        expect(result, isNotEmpty);
        expect(result.length, equals(2));
      });

      test(
          'should throw ExerciseExceptions.exerciseNotFound when exercise does not exist',
          () async {
        // Act & Assert
        await expectLater(
          endpoints.exercise.getExerciseImages(sessionBuilder, 99999),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.exerciseNotFound().errorCode)),
        );
      });
    });

    group('addExerciseImage', () {
      test('should add image with correct orderIndex', () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');

        // Act
        final result = await endpoints.exercise.addExerciseImage(
          sessionBuilder,
          exerciseId: exercise.id!,
          imageUrl: 'https://example.com/image1.jpg',
        );

        // Assert
        expect(result, isNotNull);
        expect(result.exerciseId, equals(exercise.id));
        expect(result.imageUrl, equals('https://example.com/image1.jpg'));
        expect(result.orderIndex, equals(0));
      });

      test('should set first image orderIndex to 0', () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');

        // Act
        final result = await endpoints.exercise.addExerciseImage(
          sessionBuilder,
          exerciseId: exercise.id!,
          imageUrl: 'https://example.com/first.jpg',
        );

        // Assert
        expect(result.orderIndex, equals(0));
      });

      test('should increment orderIndex for subsequent images', () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');
        await endpoints.exercise.addExerciseImage(
          sessionBuilder,
          exerciseId: exercise.id!,
          imageUrl: 'https://example.com/first.jpg',
        );

        // Act
        final result2 = await endpoints.exercise.addExerciseImage(
          sessionBuilder,
          exerciseId: exercise.id!,
          imageUrl: 'https://example.com/second.jpg',
        );

        // Assert
        expect(result2.orderIndex, equals(1));
      });

      test(
          'should throw ExerciseExceptions.exerciseNotFound when exercise does not exist',
          () async {
        // Act & Assert
        await expectLater(
          endpoints.exercise.addExerciseImage(
            sessionBuilder,
            exerciseId: 99999,
            imageUrl: 'https://example.com/image.jpg',
          ),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.exerciseNotFound().errorCode)),
        );
      });
    });

    group('deleteExerciseImage', () {
      test('should delete image', () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');
        final image = await createTestExerciseImage(exerciseId: exercise.id!);
        final imageId = image.id!;

        // Act
        await endpoints.exercise.deleteExerciseImage(sessionBuilder, imageId);

        // Assert
        final session = sessionBuilder.build();
        final deletedImage = await ExerciseImage.db.findById(session, imageId);
        expect(deletedImage, isNull);
      });

      test(
          'should throw ExerciseExceptions.imageNotFound when image does not exist',
          () async {
        // Act & Assert
        await expectLater(
          endpoints.exercise.deleteExerciseImage(sessionBuilder, 99999),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.imageNotFound().errorCode)),
        );
      });
    });

    group('reorderImages', () {
      test('should reorder images correctly', () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');
        final image1 = await createTestExerciseImage(
          exerciseId: exercise.id!,
          orderIndex: 0,
        );
        final image2 = await createTestExerciseImage(
          exerciseId: exercise.id!,
          orderIndex: 1,
        );
        final image3 = await createTestExerciseImage(
          exerciseId: exercise.id!,
          orderIndex: 2,
        );

        // Act
        final result = await endpoints.exercise.reorderImages(
          sessionBuilder,
          exercise.id!,
          [
            ExerciseImageOrder(id: image3.id!, orderIndex: 0),
            ExerciseImageOrder(id: image1.id!, orderIndex: 1),
            ExerciseImageOrder(id: image2.id!, orderIndex: 2),
          ],
        );

        // Assert
        expect(result.length, equals(3));
        expect(result[0].id, equals(image3.id));
        expect(result[0].orderIndex, equals(0));
        expect(result[1].id, equals(image1.id));
        expect(result[1].orderIndex, equals(1));
        expect(result[2].id, equals(image2.id));
        expect(result[2].orderIndex, equals(2));
      });

      test(
          'should throw ExerciseExceptions.invalidImageOrder when order length does not match',
          () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');
        await createTestExerciseImage(exerciseId: exercise.id!);

        // Act & Assert
        await expectLater(
          endpoints.exercise.reorderImages(
            sessionBuilder,
            exercise.id!,
            [
              ExerciseImageOrder(id: 1, orderIndex: 0),
              ExerciseImageOrder(id: 2, orderIndex: 1),
            ],
          ),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.invalidImageOrder().errorCode)),
        );
      });

      test(
          'should throw ExerciseExceptions.invalidImageOrder when IDs do not match',
          () async {
        // Arrange
        final exercise = await createTestExercise(name: 'Test Exercise');
        await createTestExerciseImage(exerciseId: exercise.id!);

        // Act & Assert
        await expectLater(
          endpoints.exercise.reorderImages(
            sessionBuilder,
            exercise.id!,
            [
              ExerciseImageOrder(id: 99999, orderIndex: 0),
            ],
          ),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.invalidImageOrder().errorCode)),
        );
      });

      test(
          'should throw ExerciseExceptions.exerciseNotFound when exercise does not exist',
          () async {
        // Act & Assert
        await expectLater(
          endpoints.exercise.reorderImages(
            sessionBuilder,
            99999,
            [ExerciseImageOrder(id: 1, orderIndex: 0)],
          ),
          throwsA(predicate<AppException>((e) =>
              e.errorCode == ExerciseExceptions.exerciseNotFound().errorCode)),
        );
      });
    });

    group('getAllExerciseNames', () {
      test('should return StringList with all exercise names', () async {
        // Arrange
        await createTestExercise(name: 'Exercise A');
        await createTestExercise(name: 'Exercise B');

        // Act
        final result =
            await endpoints.exercise.getAllExerciseNames(sessionBuilder);

        // Assert
        expect(result, isNotNull);
        expect(result.items, isNotEmpty);
        expect(result.items.length, greaterThanOrEqualTo(2));
        expect(result.items, contains('Exercise A'));
        expect(result.items, contains('Exercise B'));
      });

      test('should return names ordered by name then createdAt', () async {
        // Arrange
        await createTestExercise(name: 'B Exercise');
        await Future.delayed(const Duration(milliseconds: 10));
        await createTestExercise(name: 'A Exercise');

        // Act
        final result =
            await endpoints.exercise.getAllExerciseNames(sessionBuilder);

        // Assert
        final aIndex = result.items.indexOf('A Exercise');
        final bIndex = result.items.indexOf('B Exercise');
        expect(aIndex, lessThan(bIndex));
      });
    });

    group('searchExercises', () {
      test('should filter by categories', () async {
        // Arrange
        await createTestExercise(
          name: 'Strength Exercise',
          category: [ExerciseCategory.strength],
        );
        await createTestExercise(
          name: 'Cardio Exercise',
          category: [ExerciseCategory.cardio],
        );

        // Act
        final result = await endpoints.exercise.searchExercises(
          sessionBuilder,
          categoriesIn: [ExerciseCategory.strength],
        );

        // Assert
        expect(result, isNotEmpty);
        expect(
          result.every((e) => e.category.contains(ExerciseCategory.strength)),
          isTrue,
        );
      });

      test('should filter by muscle groups', () async {
        // Arrange
        await createTestExercise(
          name: 'Chest Exercise',
          muscleGroup: [ExerciseMuscleGroup.chest],
        );
        await createTestExercise(
          name: 'Leg Exercise',
          muscleGroup: [ExerciseMuscleGroup.legs],
        );

        // Act
        final result = await endpoints.exercise.searchExercises(
          sessionBuilder,
          muscleGroupsIn: [ExerciseMuscleGroup.chest],
        );

        // Assert
        expect(result, isNotEmpty);
        expect(
          result
              .every((e) => e.muscleGroup.contains(ExerciseMuscleGroup.chest)),
          isTrue,
        );
      });

      test('should filter by difficulties', () async {
        // Arrange
        await createTestExercise(
          name: 'Beginner Exercise',
          difficulty: ExerciseDifficulty.beginner,
        );
        await createTestExercise(
          name: 'Advanced Exercise',
          difficulty: ExerciseDifficulty.advanced,
        );

        // Act
        final result = await endpoints.exercise.searchExercises(
          sessionBuilder,
          difficultiesIn: [ExerciseDifficulty.beginner],
        );

        // Assert
        expect(result, isNotEmpty);
        expect(
          result.every((e) => e.difficulty == ExerciseDifficulty.beginner),
          isTrue,
        );
      });

      test('should filter by requiresEquipment', () async {
        // Arrange
        await createTestExercise(
          name: 'No Equipment Exercise',
          requiresEquipment: false,
        );
        await createTestExercise(
          name: 'Equipment Exercise',
          requiresEquipment: true,
          equipmentNeeded: 'Dumbbells',
        );

        // Act
        final result = await endpoints.exercise.searchExercises(
          sessionBuilder,
          includeExercisesRequiringEquipment: false,
        );

        // Assert
        expect(result, isNotEmpty);
        expect(
          result.every((e) => e.requiresEquipment == false),
          isTrue,
        );
      });

      test('should combine multiple filters', () async {
        // Arrange
        await createTestExercise(
          name: 'Matching Exercise',
          category: [ExerciseCategory.strength],
          muscleGroup: [ExerciseMuscleGroup.chest],
          difficulty: ExerciseDifficulty.intermediate,
          requiresEquipment: false,
        );
        await createTestExercise(
          name: 'Non Matching Exercise',
          category: [ExerciseCategory.cardio],
          muscleGroup: [ExerciseMuscleGroup.legs],
          difficulty: ExerciseDifficulty.beginner,
        );

        // Act
        final result = await endpoints.exercise.searchExercises(
          sessionBuilder,
          categoriesIn: [ExerciseCategory.strength],
          muscleGroupsIn: [ExerciseMuscleGroup.chest],
          difficultiesIn: [ExerciseDifficulty.intermediate],
          includeExercisesRequiringEquipment: false,
        );

        // Assert
        expect(result, isNotEmpty);
        final matching =
            result.firstWhere((e) => e.name == 'Matching Exercise');
        expect(matching.category, contains(ExerciseCategory.strength));
        expect(matching.muscleGroup, contains(ExerciseMuscleGroup.chest));
        expect(matching.difficulty, equals(ExerciseDifficulty.intermediate));
      });

      test('should include alternatives and images', () async {
        // Arrange
        final exercise1 = await createTestExercise(name: 'Main Exercise');
        final exercise2 =
            await createTestExercise(name: 'Alternative Exercise');
        await createTestExerciseImage(exerciseId: exercise1.id!);
        await createTestExerciseAlternative(
          exerciseId: exercise1.id!,
          alternativeExerciseId: exercise2.id!,
        );

        // Act
        final result = await endpoints.exercise.searchExercises(sessionBuilder);

        // Assert
        final mainExercise = result.firstWhere((e) => e.id == exercise1.id);
        expect(mainExercise.images, isNotNull);
        expect(mainExercise.images!.isNotEmpty, isTrue);
        expect(mainExercise.alternatives, isNotNull);
        expect(mainExercise.alternatives!.isNotEmpty, isTrue);
      });
    });
  });
}
