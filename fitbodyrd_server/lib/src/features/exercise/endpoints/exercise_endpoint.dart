import 'package:fitbodyrd_server/src/errors/exceptions/generic_exceptions.dart';
import 'package:fitbodyrd_server/src/features/exercise/exceptions/exercise_exceptions.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ExerciseEndpoint extends Endpoint {
  Future<List<Exercise>> getAllExercises(Session session) async {
    final exercises = await Exercise.db.find(
      session,
      orderByList: (t) => [Order(column: t.name), Order(column: t.createdAt)],
      include: Exercise.include(
        alternatives: ExerciseAlternative.includeList(
          include: ExerciseAlternative.include(
            alternativeExercise: Exercise.include(
              images: ExerciseImage.includeList(),
            ),
          ),
        ),
        images: ExerciseImage.includeList(
          orderBy: (t) => t.orderIndex,
        ),
      ),
    );

    return exercises;
  }

  Future<Exercise> getExerciseById(Session session, int id) async {
    final exercise = await Exercise.db.findById(
      session,
      id,
      include: Exercise.include(
        alternatives: ExerciseAlternative.includeList(
          include: ExerciseAlternative.include(
            alternativeExercise: Exercise.include(
              images: ExerciseImage.includeList(),
            ),
          ),
        ),
        images: ExerciseImage.includeList(
          orderBy: (t) => t.orderIndex,
        ),
      ),
    );

    if (exercise == null) {
      throw ExerciseExceptions.exerciseNotFound();
    }

    return exercise;
  }

  Future<Exercise> createExercise(
    Session session, {
    required String name,
    String? description,
    required List<ExerciseCategory> category,
    required List<ExerciseMuscleGroup> muscleGroup,
    required ExerciseDifficulty difficulty,
    bool? requiresEquipment,
    String? equipmentNeeded,
    String? videoUrl,
    List<String>? images,
  }) async {
    if (requiresEquipment == true &&
        (equipmentNeeded == null || equipmentNeeded.isEmpty)) {
      throw ExerciseExceptions.equipmentMissing();
    }

    final exercise = Exercise(
      name: name,
      description: description,
      category: category,
      muscleGroup: muscleGroup,
      difficulty: difficulty,
      equipmentNeeded: equipmentNeeded,
      videoUrl: videoUrl,
      requiresEquipment: requiresEquipment ?? false,
    );

    try {
      return await Exercise.db.insertRow(session, exercise);
    } on DatabaseException catch (e, st) {
      session.log(
        'Database error creating exercise: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );

      throw ExerciseExceptions.nameAlreadyExists();
    } catch (e, st) {
      session.log(
        'Error creating exercise: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );

      throw GenericExceptions.internalServerError();
    }
  }

  Future<Exercise> updateExercise(Session session, Exercise exercise) async {
    final existingExercise = await Exercise.db.findById(session, exercise.id!);

    if (existingExercise == null) {
      throw ExerciseExceptions.exerciseNotFound();
    }

    if (exercise.requiresEquipment == true &&
        (exercise.equipmentNeeded == null ||
            exercise.equipmentNeeded!.isEmpty)) {
      throw ExerciseExceptions.equipmentMissing();
    }

    try {
      return await Exercise.db.updateRow(
        session,
        exercise.copyWith(updatedAt: DateTime.now()),
      );
    } on DatabaseException catch (e, st) {
      session.log(
        'Database error updating exercise: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );

      throw ExerciseExceptions.nameAlreadyExists();
    } catch (e, st) {
      session.log(
        'Error updating exercise: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );

      throw GenericExceptions.internalServerError();
    }
  }

  Future<void> deleteExercise(Session session, int id) async {
    final existingExercise = await Exercise.db.findById(session, id);

    if (existingExercise == null) {
      throw ExerciseExceptions.exerciseNotFound();
    }

    try {
      await session.db.transaction(
        (transaction) async {
          // Delete associated images
          await ExerciseImage.db.deleteWhere(
            session,
            where: (t) => t.exerciseId.equals(id),
            transaction: transaction,
          );

          // Delete associated alternatives
          await ExerciseAlternative.db.deleteWhere(
            session,
            where: (t) =>
                t.exerciseId.equals(id) | t.alternativeExerciseId.equals(id),
            transaction: transaction,
          );

          // Delete the exercise
          await Exercise.db
              .deleteRow(session, existingExercise, transaction: transaction);
        },
      );
    } catch (e, st) {
      session.log(
        'Error deleting exercise: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );

      throw GenericExceptions.internalServerError();
    }
  }

  Future<List<ExerciseImage>> getExerciseImages(
    Session session,
    int exerciseId,
  ) async {
    final exercise = await Exercise.db.findById(session, exerciseId);

    if (exercise == null) {
      throw ExerciseExceptions.exerciseNotFound();
    }

    final images = await ExerciseImage.db.find(
      session,
      where: (t) => t.exerciseId.equals(exerciseId),
    );
    return images;
  }

  Future<ExerciseImage> addExerciseImage(
    Session session, {
    required int exerciseId,
    required String imageUrl,
  }) async {
    final exercise = await Exercise.db.findById(
      session,
      exerciseId,
      include: Exercise.include(
        images: ExerciseImage.includeList(
          orderBy: (t) => t.orderIndex,
        ),
      ),
    );

    if (exercise == null) {
      throw ExerciseExceptions.exerciseNotFound();
    }

    final nextOrderIndex =
        exercise.images!.isEmpty ? 0 : exercise.images!.last.orderIndex + 1;

    final image = ExerciseImage(
      exerciseId: exerciseId,
      imageUrl: imageUrl,
      orderIndex: nextOrderIndex,
    );

    try {
      return await ExerciseImage.db.insertRow(session, image);
    } catch (e, st) {
      session.log(
        'Error adding exercise image: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );

      throw GenericExceptions.internalServerError();
    }
  }

  Future<void> deleteExerciseImage(Session session, int imageId) async {
    final existingImage = await ExerciseImage.db.findById(session, imageId);

    if (existingImage == null) {
      throw ExerciseExceptions.imageNotFound();
    }

    try {
      await ExerciseImage.db.deleteRow(session, existingImage);
    } catch (e, st) {
      session.log(
        'Error deleting exercise image: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );

      throw GenericExceptions.internalServerError();
    }
  }

  Future<List<ExerciseImage>> reorderImages(
    Session session,
    int exerciseId,
    List<ExerciseImageOrder> newOrder,
  ) async {
    final exercise = await Exercise.db.findById(session, exerciseId);

    if (exercise == null) {
      throw ExerciseExceptions.exerciseNotFound();
    }

    final images = await ExerciseImage.db.find(
      session,
      where: (t) => t.exerciseId.equals(exerciseId),
    );

    if (images.length != newOrder.length ||
        !newOrder
            .every((order) => images.any((image) => image.id == order.id))) {
      throw ExerciseExceptions.invalidImageOrder();
    }

    try {
      for (var order in newOrder) {
        var image = images.firstWhere((img) => img.id == order.id);
        image = image.copyWith(orderIndex: order.orderIndex);
        await ExerciseImage.db.updateRow(session, image);
      }

      final updatedImages = await ExerciseImage.db.find(
        session,
        where: (t) => t.exerciseId.equals(exerciseId),
        orderBy: (t) => t.orderIndex,
      );

      return updatedImages;
    } catch (e, st) {
      session.log(
        'Error reordering exercise images: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );

      throw GenericExceptions.internalServerError();
    }
  }

  Future<StringList> getAllExerciseNames(Session session) async {
    final exercises = await Exercise.db.find(
      session,
      orderByList: (t) => [Order(column: t.name), Order(column: t.createdAt)],
    );

    return StringList(items: exercises.map((e) => e.name).toList());
  }

  Future<List<Exercise>> searchExercises(
    Session session, {
    List<ExerciseCategory>? categoriesIn,
    List<ExerciseMuscleGroup>? muscleGroupsIn,
    List<ExerciseDifficulty>? difficultiesIn,
    bool? includeExercisesRequiringEquipment,
  }) async {
    final exercises = await Exercise.db.find(
      session,
      where: (t) {
        Expression<dynamic> condition = Constant.bool(true);

        if (difficultiesIn != null && difficultiesIn.isNotEmpty) {
          condition = condition & t.difficulty.inSet(difficultiesIn.toSet());
        }

        if (includeExercisesRequiringEquipment == false) {
          condition = condition &
              t.requiresEquipment.equals(includeExercisesRequiringEquipment);
        }

        return condition;
      },
      orderByList: (t) => [Order(column: t.name), Order(column: t.createdAt)],
      include: Exercise.include(
        alternatives: ExerciseAlternative.includeList(
          include: ExerciseAlternative.include(
            alternativeExercise: Exercise.include(
              images: ExerciseImage.includeList(),
            ),
          ),
        ),
        images: ExerciseImage.includeList(
          orderBy: (t) => t.orderIndex,
        ),
      ),
    );

    return exercises.where((exercise) {
      bool matchesCategory = true;
      bool matchesMuscleGroup = true;

      if (categoriesIn != null && categoriesIn.isNotEmpty) {
        matchesCategory = exercise.category
            .any((category) => categoriesIn.contains(category));
      }

      if (muscleGroupsIn != null && muscleGroupsIn.isNotEmpty) {
        matchesMuscleGroup = exercise.muscleGroup
            .any((muscle) => muscleGroupsIn.contains(muscle));
      }

      return matchesCategory && matchesMuscleGroup;
    }).toList();
  }
}
