/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../features/dashboard/endpoints/dashboard_endpoint.dart' as _i2;
import '../features/exercise/endpoints/exercise_endpoint.dart' as _i3;
import '../features/food/endpoints/food_endpoint.dart' as _i4;
import '../features/nutrition/endpoints/food_intake_log_endpoint.dart' as _i5;
import '../features/nutrition/endpoints/nutrition_endpoint.dart' as _i6;
import '../features/nutrition_plan/endpoints/nutrition_plan_endpoint.dart'
    as _i7;
import '../features/user/endpoints/admin_user_endpoint.dart' as _i8;
import '../features/user/endpoints/user_endpoint.dart' as _i9;
import '../features/workouts/endpoints/workout_endpoint.dart' as _i10;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_category.dart'
    as _i11;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_muscle_group.dart'
    as _i12;
import 'package:fitbodyrd_server/src/generated/common/models/exercise_difficulty.dart'
    as _i13;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise.dart'
    as _i14;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_image_order.dart'
    as _i15;
import 'package:fitbodyrd_server/src/generated/features/food/dto/create_serving_size.dto.dart'
    as _i16;
import 'package:fitbodyrd_server/src/generated/features/food/dto/create_micronutrient.dto.dart'
    as _i17;
import 'package:fitbodyrd_server/src/generated/features/food/models/dietary_restriction.dart'
    as _i18;
import 'package:fitbodyrd_server/src/generated/features/nutrition/dto/create_food_intake_log.dto.dart'
    as _i19;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/models/meal_type.dart'
    as _i20;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/dto/create_meal_plan.dto.dart'
    as _i21;
import 'package:fitbodyrd_server/src/generated/common/models/stream_status.dart'
    as _i22;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/dto/update_meal_plan_food.dto.dart'
    as _i23;
import 'package:fitbodyrd_server/src/generated/features/user/models/app_user.dart'
    as _i24;
import 'package:fitbodyrd_server/src/generated/features/user/models/auth_method.dart'
    as _i25;
import 'package:fitbodyrd_server/src/generated/features/workouts/dto/create_workout_session.dto.dart'
    as _i26;
import 'package:fitbodyrd_server/src/generated/features/workouts/dto/create_workout_plan.dto.dart'
    as _i27;
import 'package:fitbodyrd_server/src/generated/features/workouts/models/exercise_log.dart'
    as _i28;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i29;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'dashboard': _i2.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'exercise': _i3.ExerciseEndpoint()
        ..initialize(
          server,
          'exercise',
          null,
        ),
      'food': _i4.FoodEndpoint()
        ..initialize(
          server,
          'food',
          null,
        ),
      'foodIntakeLog': _i5.FoodIntakeLogEndpoint()
        ..initialize(
          server,
          'foodIntakeLog',
          null,
        ),
      'nutrition': _i6.NutritionEndpoint()
        ..initialize(
          server,
          'nutrition',
          null,
        ),
      'nutritionPlan': _i7.NutritionPlanEndpoint()
        ..initialize(
          server,
          'nutritionPlan',
          null,
        ),
      'adminUser': _i8.AdminUserEndpoint()
        ..initialize(
          server,
          'adminUser',
          null,
        ),
      'user': _i9.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'workout': _i10.WorkoutEndpoint()
        ..initialize(
          server,
          'workout',
          null,
        ),
    };
    connectors['dashboard'] = _i1.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getWeeklySummary': _i1.MethodConnector(
          name: 'getWeeklySummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i2.DashboardEndpoint)
                  .getWeeklySummary(session),
        ),
      },
    );
    connectors['exercise'] = _i1.EndpointConnector(
      name: 'exercise',
      endpoint: endpoints['exercise']!,
      methodConnectors: {
        'getAllExercises': _i1.MethodConnector(
          name: 'getAllExercises',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .getAllExercises(session),
        ),
        'getExerciseById': _i1.MethodConnector(
          name: 'getExerciseById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .getExerciseById(
                    session,
                    params['id'],
                  ),
        ),
        'createExercise': _i1.MethodConnector(
          name: 'createExercise',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<List<_i11.ExerciseCategory>>(),
              nullable: false,
            ),
            'muscleGroup': _i1.ParameterDescription(
              name: 'muscleGroup',
              type: _i1.getType<List<_i12.ExerciseMuscleGroup>>(),
              nullable: false,
            ),
            'difficulty': _i1.ParameterDescription(
              name: 'difficulty',
              type: _i1.getType<_i13.ExerciseDifficulty>(),
              nullable: false,
            ),
            'requiresEquipment': _i1.ParameterDescription(
              name: 'requiresEquipment',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'equipmentNeeded': _i1.ParameterDescription(
              name: 'equipmentNeeded',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'videoUrl': _i1.ParameterDescription(
              name: 'videoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'images': _i1.ParameterDescription(
              name: 'images',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .createExercise(
                    session,
                    name: params['name'],
                    description: params['description'],
                    category: params['category'],
                    muscleGroup: params['muscleGroup'],
                    difficulty: params['difficulty'],
                    requiresEquipment: params['requiresEquipment'],
                    equipmentNeeded: params['equipmentNeeded'],
                    videoUrl: params['videoUrl'],
                    images: params['images'],
                  ),
        ),
        'updateExercise': _i1.MethodConnector(
          name: 'updateExercise',
          params: {
            'exercise': _i1.ParameterDescription(
              name: 'exercise',
              type: _i1.getType<_i14.Exercise>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .updateExercise(
                    session,
                    params['exercise'],
                  ),
        ),
        'deleteExercise': _i1.MethodConnector(
          name: 'deleteExercise',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .deleteExercise(
                    session,
                    params['id'],
                  ),
        ),
        'getExerciseImages': _i1.MethodConnector(
          name: 'getExerciseImages',
          params: {
            'exerciseId': _i1.ParameterDescription(
              name: 'exerciseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .getExerciseImages(
                    session,
                    params['exerciseId'],
                  ),
        ),
        'addExerciseImage': _i1.MethodConnector(
          name: 'addExerciseImage',
          params: {
            'exerciseId': _i1.ParameterDescription(
              name: 'exerciseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .addExerciseImage(
                    session,
                    exerciseId: params['exerciseId'],
                    imageUrl: params['imageUrl'],
                  ),
        ),
        'deleteExerciseImage': _i1.MethodConnector(
          name: 'deleteExerciseImage',
          params: {
            'imageId': _i1.ParameterDescription(
              name: 'imageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .deleteExerciseImage(
                    session,
                    params['imageId'],
                  ),
        ),
        'reorderImages': _i1.MethodConnector(
          name: 'reorderImages',
          params: {
            'exerciseId': _i1.ParameterDescription(
              name: 'exerciseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newOrder': _i1.ParameterDescription(
              name: 'newOrder',
              type: _i1.getType<List<_i15.ExerciseImageOrder>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['exercise'] as _i3.ExerciseEndpoint).reorderImages(
                    session,
                    params['exerciseId'],
                    params['newOrder'],
                  ),
        ),
        'getAllExerciseNames': _i1.MethodConnector(
          name: 'getAllExerciseNames',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .getAllExerciseNames(session),
        ),
        'searchExercises': _i1.MethodConnector(
          name: 'searchExercises',
          params: {
            'categoriesIn': _i1.ParameterDescription(
              name: 'categoriesIn',
              type: _i1.getType<List<_i11.ExerciseCategory>?>(),
              nullable: true,
            ),
            'muscleGroupsIn': _i1.ParameterDescription(
              name: 'muscleGroupsIn',
              type: _i1.getType<List<_i12.ExerciseMuscleGroup>?>(),
              nullable: true,
            ),
            'difficultiesIn': _i1.ParameterDescription(
              name: 'difficultiesIn',
              type: _i1.getType<List<_i13.ExerciseDifficulty>?>(),
              nullable: true,
            ),
            'includeExercisesRequiringEquipment': _i1.ParameterDescription(
              name: 'includeExercisesRequiringEquipment',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['exercise'] as _i3.ExerciseEndpoint)
                  .searchExercises(
                    session,
                    categoriesIn: params['categoriesIn'],
                    muscleGroupsIn: params['muscleGroupsIn'],
                    difficultiesIn: params['difficultiesIn'],
                    includeExercisesRequiringEquipment:
                        params['includeExercisesRequiringEquipment'],
                  ),
        ),
      },
    );
    connectors['food'] = _i1.EndpointConnector(
      name: 'food',
      endpoint: endpoints['food']!,
      methodConnectors: {
        'getAllFoodCategories': _i1.MethodConnector(
          name: 'getAllFoodCategories',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint)
                  .getAllFoodCategories(session),
        ),
        'getParentFoodCategories': _i1.MethodConnector(
          name: 'getParentFoodCategories',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint)
                  .getParentFoodCategories(session),
        ),
        'getFoodCategoryById': _i1.MethodConnector(
          name: 'getFoodCategoryById',
          params: {
            'foodCategoryId': _i1.ParameterDescription(
              name: 'foodCategoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['food'] as _i4.FoodEndpoint).getFoodCategoryById(
                    session,
                    params['foodCategoryId'],
                  ),
        ),
        'createFoodCategory': _i1.MethodConnector(
          name: 'createFoodCategory',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'colorHex': _i1.ParameterDescription(
              name: 'colorHex',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'displayOrder': _i1.ParameterDescription(
              name: 'displayOrder',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'iconName': _i1.ParameterDescription(
              name: 'iconName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'parentCategoryId': _i1.ParameterDescription(
              name: 'parentCategoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['food'] as _i4.FoodEndpoint).createFoodCategory(
                    session,
                    name: params['name'],
                    slug: params['slug'],
                    colorHex: params['colorHex'],
                    displayOrder: params['displayOrder'],
                    iconName: params['iconName'],
                    parentCategoryId: params['parentCategoryId'],
                  ),
        ),
        'updateFoodCategory': _i1.MethodConnector(
          name: 'updateFoodCategory',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'colorHex': _i1.ParameterDescription(
              name: 'colorHex',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'displayOrder': _i1.ParameterDescription(
              name: 'displayOrder',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'iconName': _i1.ParameterDescription(
              name: 'iconName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'parentCategoryId': _i1.ParameterDescription(
              name: 'parentCategoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['food'] as _i4.FoodEndpoint).updateFoodCategory(
                    session,
                    params['categoryId'],
                    name: params['name'],
                    slug: params['slug'],
                    colorHex: params['colorHex'],
                    displayOrder: params['displayOrder'],
                    iconName: params['iconName'],
                    parentCategoryId: params['parentCategoryId'],
                  ),
        ),
        'deleteFoodCategory': _i1.MethodConnector(
          name: 'deleteFoodCategory',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['food'] as _i4.FoodEndpoint).deleteFoodCategory(
                    session,
                    params['categoryId'],
                  ),
        ),
        'getFoods': _i1.MethodConnector(
          name: 'getFoods',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['food'] as _i4.FoodEndpoint).getFoods(session),
        ),
        'getFoodById': _i1.MethodConnector(
          name: 'getFoodById',
          params: {
            'foodId': _i1.ParameterDescription(
              name: 'foodId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint).getFoodById(
                session,
                params['foodId'],
              ),
        ),
        'createFood': _i1.MethodConnector(
          name: 'createFood',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'calories': _i1.ParameterDescription(
              name: 'calories',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'proteins': _i1.ParameterDescription(
              name: 'proteins',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'carbs': _i1.ParameterDescription(
              name: 'carbs',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'fats': _i1.ParameterDescription(
              name: 'fats',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'fiber': _i1.ParameterDescription(
              name: 'fiber',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'isLocal': _i1.ParameterDescription(
              name: 'isLocal',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'brand': _i1.ParameterDescription(
              name: 'brand',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'barcode': _i1.ParameterDescription(
              name: 'barcode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'servingSizes': _i1.ParameterDescription(
              name: 'servingSizes',
              type: _i1.getType<List<_i16.CreateServingSizeDto>?>(),
              nullable: true,
            ),
            'micronutrients': _i1.ParameterDescription(
              name: 'micronutrients',
              type: _i1.getType<List<_i17.CreateMicronutrientDto>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint).createFood(
                session,
                name: params['name'],
                categoryId: params['categoryId'],
                calories: params['calories'],
                proteins: params['proteins'],
                carbs: params['carbs'],
                fats: params['fats'],
                fiber: params['fiber'],
                isLocal: params['isLocal'],
                brand: params['brand'],
                imageUrl: params['imageUrl'],
                barcode: params['barcode'],
                servingSizes: params['servingSizes'],
                micronutrients: params['micronutrients'],
              ),
        ),
        'updateFood': _i1.MethodConnector(
          name: 'updateFood',
          params: {
            'foodId': _i1.ParameterDescription(
              name: 'foodId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'calories': _i1.ParameterDescription(
              name: 'calories',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'proteins': _i1.ParameterDescription(
              name: 'proteins',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'carbs': _i1.ParameterDescription(
              name: 'carbs',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'fats': _i1.ParameterDescription(
              name: 'fats',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'fiber': _i1.ParameterDescription(
              name: 'fiber',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'isLocal': _i1.ParameterDescription(
              name: 'isLocal',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'brand': _i1.ParameterDescription(
              name: 'brand',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'barcode': _i1.ParameterDescription(
              name: 'barcode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'servingSizes': _i1.ParameterDescription(
              name: 'servingSizes',
              type: _i1.getType<List<_i16.CreateServingSizeDto>?>(),
              nullable: true,
            ),
            'micronutrients': _i1.ParameterDescription(
              name: 'micronutrients',
              type: _i1.getType<List<_i17.CreateMicronutrientDto>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint).updateFood(
                session,
                params['foodId'],
                name: params['name'],
                categoryId: params['categoryId'],
                calories: params['calories'],
                proteins: params['proteins'],
                carbs: params['carbs'],
                fats: params['fats'],
                fiber: params['fiber'],
                isLocal: params['isLocal'],
                brand: params['brand'],
                imageUrl: params['imageUrl'],
                barcode: params['barcode'],
                isActive: params['isActive'],
                servingSizes: params['servingSizes'],
                micronutrients: params['micronutrients'],
              ),
        ),
        'deleteFood': _i1.MethodConnector(
          name: 'deleteFood',
          params: {
            'foodId': _i1.ParameterDescription(
              name: 'foodId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint).deleteFood(
                session,
                params['foodId'],
              ),
        ),
        'createFoodServingSize': _i1.MethodConnector(
          name: 'createFoodServingSize',
          params: {
            'foodId': _i1.ParameterDescription(
              name: 'foodId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'grams': _i1.ParameterDescription(
              name: 'grams',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'isDefault': _i1.ParameterDescription(
              name: 'isDefault',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['food'] as _i4.FoodEndpoint).createFoodServingSize(
                    session,
                    foodId: params['foodId'],
                    name: params['name'],
                    grams: params['grams'],
                    isDefault: params['isDefault'],
                  ),
        ),
        'updateFoodServingSize': _i1.MethodConnector(
          name: 'updateFoodServingSize',
          params: {
            'servingSizeId': _i1.ParameterDescription(
              name: 'servingSizeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'grams': _i1.ParameterDescription(
              name: 'grams',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'isDefault': _i1.ParameterDescription(
              name: 'isDefault',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['food'] as _i4.FoodEndpoint).updateFoodServingSize(
                    session,
                    params['servingSizeId'],
                    name: params['name'],
                    grams: params['grams'],
                    isDefault: params['isDefault'],
                  ),
        ),
        'deleteFoodServingSize': _i1.MethodConnector(
          name: 'deleteFoodServingSize',
          params: {
            'servingSizeId': _i1.ParameterDescription(
              name: 'servingSizeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['food'] as _i4.FoodEndpoint).deleteFoodServingSize(
                    session,
                    params['servingSizeId'],
                  ),
        ),
        'createFoodMicronutrient': _i1.MethodConnector(
          name: 'createFoodMicronutrient',
          params: {
            'foodId': _i1.ParameterDescription(
              name: 'foodId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'unit': _i1.ParameterDescription(
              name: 'unit',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint)
                  .createFoodMicronutrient(
                    session,
                    foodId: params['foodId'],
                    name: params['name'],
                    amount: params['amount'],
                    unit: params['unit'],
                  ),
        ),
        'updateFoodMicronutrient': _i1.MethodConnector(
          name: 'updateFoodMicronutrient',
          params: {
            'micronutrientId': _i1.ParameterDescription(
              name: 'micronutrientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'unit': _i1.ParameterDescription(
              name: 'unit',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint)
                  .updateFoodMicronutrient(
                    session,
                    params['micronutrientId'],
                    name: params['name'],
                    amount: params['amount'],
                    unit: params['unit'],
                  ),
        ),
        'deleteFoodMicronutrient': _i1.MethodConnector(
          name: 'deleteFoodMicronutrient',
          params: {
            'micronutrientId': _i1.ParameterDescription(
              name: 'micronutrientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint)
                  .deleteFoodMicronutrient(
                    session,
                    params['micronutrientId'],
                  ),
        ),
        'searchFoods': _i1.MethodConnector(
          name: 'searchFoods',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dietaryRestriction': _i1.ParameterDescription(
              name: 'dietaryRestriction',
              type: _i1.getType<_i18.DietaryRestriction?>(),
              nullable: true,
            ),
            'isLocalOnly': _i1.ParameterDescription(
              name: 'isLocalOnly',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'excludeFoodIds': _i1.ParameterDescription(
              name: 'excludeFoodIds',
              type: _i1.getType<List<int>?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint).searchFoods(
                session,
                categoryId: params['categoryId'],
                dietaryRestriction: params['dietaryRestriction'],
                isLocalOnly: params['isLocalOnly'],
                excludeFoodIds: params['excludeFoodIds'],
                limit: params['limit'],
              ),
        ),
        'searchFoodsV2': _i1.MethodConnector(
          name: 'searchFoodsV2',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['food'] as _i4.FoodEndpoint).searchFoodsV2(
                session,
                query: params['query'],
                categoryId: params['categoryId'],
                limit: params['limit'],
              ),
        ),
        'getFoodCatalogue': _i1.MethodConnector(
          name: 'getFoodCatalogue',
          params: {
            'excludeFoodIds': _i1.ParameterDescription(
              name: 'excludeFoodIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['food'] as _i4.FoodEndpoint).getFoodCatalogue(
                    session,
                    params['excludeFoodIds'],
                  ),
        ),
      },
    );
    connectors['foodIntakeLog'] = _i1.EndpointConnector(
      name: 'foodIntakeLog',
      endpoint: endpoints['foodIntakeLog']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'dto': _i1.ParameterDescription(
              name: 'dto',
              type: _i1.getType<_i19.CreateFoodIntakeLog>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['foodIntakeLog'] as _i5.FoodIntakeLogEndpoint)
                      .create(
                        session,
                        params['dto'],
                      ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['foodIntakeLog'] as _i5.FoodIntakeLogEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
        'getByDate': _i1.MethodConnector(
          name: 'getByDate',
          params: {
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['foodIntakeLog'] as _i5.FoodIntakeLogEndpoint)
                      .getByDate(
                        session,
                        params['date'],
                      ),
        ),
      },
    );
    connectors['nutrition'] = _i1.EndpointConnector(
      name: 'nutrition',
      endpoint: endpoints['nutrition']!,
      methodConnectors: {
        'calculateMacros': _i1.MethodConnector(
          name: 'calculateMacros',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'mealTypes': _i1.ParameterDescription(
              name: 'mealTypes',
              type: _i1.getType<List<_i20.MealPlanType>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['nutrition'] as _i6.NutritionEndpoint)
                  .calculateMacros(
                    session,
                    params['userId'],
                    params['mealTypes'],
                  ),
        ),
      },
    );
    connectors['nutritionPlan'] = _i1.EndpointConnector(
      name: 'nutritionPlan',
      endpoint: endpoints['nutritionPlan']!,
      methodConnectors: {
        'createNutritionPlan': _i1.MethodConnector(
          name: 'createNutritionPlan',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'dailyCalories': _i1.ParameterDescription(
              name: 'dailyCalories',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'dailyProteins': _i1.ParameterDescription(
              name: 'dailyProteins',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'dailyCarbs': _i1.ParameterDescription(
              name: 'dailyCarbs',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'dailyFats': _i1.ParameterDescription(
              name: 'dailyFats',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                      .createNutritionPlan(
                        session,
                        userId: params['userId'],
                        startDate: params['startDate'],
                        endDate: params['endDate'],
                        dailyCalories: params['dailyCalories'],
                        dailyProteins: params['dailyProteins'],
                        dailyCarbs: params['dailyCarbs'],
                        dailyFats: params['dailyFats'],
                      ),
        ),
        'getNutritionPlanById': _i1.MethodConnector(
          name: 'getNutritionPlanById',
          params: {
            'planId': _i1.ParameterDescription(
              name: 'planId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                      .getNutritionPlanById(
                        session,
                        params['planId'],
                      ),
        ),
        'createMealPlan': _i1.MethodConnector(
          name: 'createMealPlan',
          params: {
            'mealPlanDto': _i1.ParameterDescription(
              name: 'mealPlanDto',
              type: _i1.getType<_i21.CreateMealPlanDto>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                      .createMealPlan(
                        session,
                        params['mealPlanDto'],
                      ),
        ),
        'updateNutritionPlanProgress': _i1.MethodConnector(
          name: 'updateNutritionPlanProgress',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'nutritionPlanId': _i1.ParameterDescription(
              name: 'nutritionPlanId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'currentDay': _i1.ParameterDescription(
              name: 'currentDay',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'totalDays': _i1.ParameterDescription(
              name: 'totalDays',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i22.StreamStatus>(),
              nullable: false,
            ),
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                      .updateNutritionPlanProgress(
                        session,
                        userId: params['userId'],
                        nutritionPlanId: params['nutritionPlanId'],
                        currentDay: params['currentDay'],
                        totalDays: params['totalDays'],
                        status: params['status'],
                        message: params['message'],
                      ),
        ),
        'notifyErrorCreatingNutritionPlan': _i1.MethodConnector(
          name: 'notifyErrorCreatingNutritionPlan',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                      .notifyErrorCreatingNutritionPlan(
                        session,
                        params['userId'],
                      ),
        ),
        'getActiveNutritionPlan': _i1.MethodConnector(
          name: 'getActiveNutritionPlan',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                      .getActiveNutritionPlan(
                        session,
                        params['userId'],
                      ),
        ),
        'updateMealPlanFood': _i1.MethodConnector(
          name: 'updateMealPlanFood',
          params: {
            'mealPlanFoodId': _i1.ParameterDescription(
              name: 'mealPlanFoodId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'updateDto': _i1.ParameterDescription(
              name: 'updateDto',
              type: _i1.getType<_i23.UpdateMealPlanFoodDto>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                      .updateMealPlanFood(
                        session,
                        mealPlanFoodId: params['mealPlanFoodId'],
                        updateDto: params['updateDto'],
                      ),
        ),
        'deleteMealPlanFood': _i1.MethodConnector(
          name: 'deleteMealPlanFood',
          params: {
            'mealPlanFoodId': _i1.ParameterDescription(
              name: 'mealPlanFoodId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                      .deleteMealPlanFood(
                        session,
                        mealPlanFoodId: params['mealPlanFoodId'],
                        userId: params['userId'],
                      ),
        ),
        'addMealPlanFood': _i1.MethodConnector(
          name: 'addMealPlanFood',
          params: {
            'mealPlanId': _i1.ParameterDescription(
              name: 'mealPlanId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'foodId': _i1.ParameterDescription(
              name: 'foodId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'servingSizeId': _i1.ParameterDescription(
              name: 'servingSizeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'servingQuantity': _i1.ParameterDescription(
              name: 'servingQuantity',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'quantityGrams': _i1.ParameterDescription(
              name: 'quantityGrams',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                      .addMealPlanFood(
                        session,
                        mealPlanId: params['mealPlanId'],
                        foodId: params['foodId'],
                        servingSizeId: params['servingSizeId'],
                        servingQuantity: params['servingQuantity'],
                        quantityGrams: params['quantityGrams'],
                      ),
        ),
        'requestNutritionPlanGeneration': _i1.MethodStreamConnector(
          name: 'requestNutritionPlanGeneration',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'weeks': _i1.ParameterDescription(
              name: 'weeks',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'mealTypes': _i1.ParameterDescription(
              name: 'mealTypes',
              type: _i1.getType<List<_i20.MealPlanType>>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['nutritionPlan'] as _i7.NutritionPlanEndpoint)
                  .requestNutritionPlanGeneration(
                    session,
                    params['userId'],
                    params['weeks'],
                    params['mealTypes'],
                  ),
        ),
      },
    );
    connectors['adminUser'] = _i1.EndpointConnector(
      name: 'adminUser',
      endpoint: endpoints['adminUser']!,
      methodConnectors: {
        'findUserProfile': _i1.MethodConnector(
          name: 'findUserProfile',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminUser'] as _i8.AdminUserEndpoint)
                  .findUserProfile(
                    session,
                    params['userId'],
                  ),
        ),
        'getUserFoodPreferences': _i1.MethodConnector(
          name: 'getUserFoodPreferences',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminUser'] as _i8.AdminUserEndpoint)
                  .getUserFoodPreferences(
                    session,
                    params['userId'],
                  ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getCurrentUserProfile': _i1.MethodConnector(
          name: 'getCurrentUserProfile',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i9.UserEndpoint)
                  .getCurrentUserProfile(session),
        ),
        'createUserProfile': _i1.MethodConnector(
          name: 'createUserProfile',
          params: {
            'userProfile': _i1.ParameterDescription(
              name: 'userProfile',
              type: _i1.getType<_i24.UserProfile>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i9.UserEndpoint).createUserProfile(
                    session,
                    params['userProfile'],
                  ),
        ),
        'setAuthMethod': _i1.MethodConnector(
          name: 'setAuthMethod',
          params: {
            'authMethod': _i1.ParameterDescription(
              name: 'authMethod',
              type: _i1.getType<_i25.AuthMethod>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i9.UserEndpoint).setAuthMethod(
                session,
                params['authMethod'],
              ),
        ),
      },
    );
    connectors['workout'] = _i1.EndpointConnector(
      name: 'workout',
      endpoint: endpoints['workout']!,
      methodConnectors: {
        'getActiveWorkoutPlan': _i1.MethodConnector(
          name: 'getActiveWorkoutPlan',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .getActiveWorkoutPlan(
                    session,
                    params['userId'],
                  ),
        ),
        'getExerciseLogs': _i1.MethodConnector(
          name: 'getExerciseLogs',
          params: {
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'exerciseIds': _i1.ParameterDescription(
              name: 'exerciseIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .getExerciseLogs(
                    session,
                    params['startDate'],
                    params['endDate'],
                    params['exerciseIds'],
                  ),
        ),
        'deleteExerciseLog': _i1.MethodConnector(
          name: 'deleteExerciseLog',
          params: {
            'logId': _i1.ParameterDescription(
              name: 'logId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .deleteExerciseLog(
                    session,
                    params['logId'],
                  ),
        ),
        'createBaseWorkoutPlan': _i1.MethodConnector(
          name: 'createBaseWorkoutPlan',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'difficultyLevel': _i1.ParameterDescription(
              name: 'difficultyLevel',
              type: _i1.getType<_i13.ExerciseDifficulty>(),
              nullable: false,
            ),
            'sessionsCount': _i1.ParameterDescription(
              name: 'sessionsCount',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .createBaseWorkoutPlan(
                    session,
                    params['userId'],
                    params['name'],
                    params['startDate'],
                    params['endDate'],
                    params['difficultyLevel'],
                    params['sessionsCount'],
                  ),
        ),
        'createWorkoutSession': _i1.MethodConnector(
          name: 'createWorkoutSession',
          params: {
            'workoutPlanId': _i1.ParameterDescription(
              name: 'workoutPlanId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'workoutSession': _i1.ParameterDescription(
              name: 'workoutSession',
              type: _i1.getType<_i26.CreateWorkoutSessionDto>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .createWorkoutSession(
                    session,
                    params['workoutPlanId'],
                    params['workoutSession'],
                  ),
        ),
        'createWorkoutPlan': _i1.MethodConnector(
          name: 'createWorkoutPlan',
          params: {
            'workoutPlan': _i1.ParameterDescription(
              name: 'workoutPlan',
              type: _i1.getType<_i27.CreateWorkoutPlanDto>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .createWorkoutPlan(
                    session,
                    params['workoutPlan'],
                  ),
        ),
        'notifyErrorCreatingWorkoutPlan': _i1.MethodConnector(
          name: 'notifyErrorCreatingWorkoutPlan',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .notifyErrorCreatingWorkoutPlan(
                    session,
                    params['userId'],
                  ),
        ),
        'logWorkoutExercise': _i1.MethodConnector(
          name: 'logWorkoutExercise',
          params: {
            'log': _i1.ParameterDescription(
              name: 'log',
              type: _i1.getType<_i28.ExerciseLog>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .logWorkoutExercise(
                    session,
                    params['log'],
                  ),
        ),
        'getWorkoutHistory': _i1.MethodConnector(
          name: 'getWorkoutHistory',
          params: {
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .getWorkoutHistory(
                    session,
                    params['startDate'],
                    params['endDate'],
                  ),
        ),
        'getWorkoutProgressMetrics': _i1.MethodConnector(
          name: 'getWorkoutProgressMetrics',
          params: {
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .getWorkoutProgressMetrics(
                    session,
                    params['startDate'],
                    params['endDate'],
                  ),
        ),
        'getWorkoutSessionsByDateRange': _i1.MethodConnector(
          name: 'getWorkoutSessionsByDateRange',
          params: {
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .getWorkoutSessionsByDateRange(
                    session,
                    params['startDate'],
                    params['endDate'],
                  ),
        ),
        'requestWorkoutPlanGeneration': _i1.MethodStreamConnector(
          name: 'requestWorkoutPlanGeneration',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'numberOfWeeks': _i1.ParameterDescription(
              name: 'numberOfWeeks',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .requestWorkoutPlanGeneration(
                    session,
                    params['userId'],
                    params['numberOfWeeks'],
                  ),
        ),
        'listenToWorkoutTips': _i1.MethodStreamConnector(
          name: 'listenToWorkoutTips',
          params: {},
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['workout'] as _i10.WorkoutEndpoint)
                  .listenToWorkoutTips(session),
        ),
      },
    );
    modules['serverpod_auth'] = _i29.Endpoints()..initializeEndpoints(server);
  }
}
