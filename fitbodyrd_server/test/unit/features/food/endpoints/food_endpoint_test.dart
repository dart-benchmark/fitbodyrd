import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Food endpoint', (sessionBuilder, endpoints) {
    group('getAllFoodCategories', () {
      test('should retrieve all parent categories with subcategories',
          () async {
        // Arrange
        final session = sessionBuilder.build();

        // Create parent category
        final parentCategory = FoodCategory(
          name: 'Fruits',
          slug: 'fruits',
          iconName: 'apple',
          colorHex: '#FF0000',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, parentCategory);
        final insertedParent = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Fruits'),
        );
        final parentId = insertedParent!.id!;

        // Create subcategory
        final subCategory = FoodCategory(
          name: 'Citrus',
          slug: 'citrus',
          iconName: 'orange',
          colorHex: '#FFA500',
          displayOrder: 0,
          parentCategoryId: parentId,
        );
        await FoodCategory.db.insertRow(session, subCategory);
        final insertedSub = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Citrus'),
        );
        final subId = insertedSub!.id!;

        // Create nested subcategory
        final nestedSubCategory = FoodCategory(
          name: 'Oranges',
          slug: 'oranges',
          iconName: 'orange',
          colorHex: '#FF8C00',
          displayOrder: 0,
          parentCategoryId: subId,
        );
        await FoodCategory.db.insertRow(session, nestedSubCategory);

        // Act
        final result =
            await endpoints.food.getAllFoodCategories(sessionBuilder);

        // Assert
        expect(result, isNotEmpty);
        final fruitsCategory = result.firstWhere((c) => c.name == 'Fruits');
        expect(fruitsCategory.subCategories, isNotEmpty);
        expect(fruitsCategory.subCategories!.first.name, equals('Citrus'));
        expect(fruitsCategory.subCategories!.first.subCategories, isNotEmpty);
        expect(fruitsCategory.subCategories!.first.subCategories!.first.name,
            equals('Oranges'));
      });
    });

    group('getParentFoodCategories', () {
      test('should retrieve parent categories with caching', () async {
        // Arrange
        final session = sessionBuilder.build();

        // Create parent category with food
        final parentCategory = FoodCategory(
          name: 'Vegetables',
          slug: 'vegetables',
          iconName: 'carrot',
          colorHex: '#00FF00',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, parentCategory);
        final insertedParent = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Vegetables'),
        );
        final parentId = insertedParent!.id!;

        // Create food in category
        final food = Food(
          name: 'Carrot',
          categoryId: parentId,
          calories: 41.0,
          proteins: 0.9,
          carbs: 10.0,
          fats: 0.2,
          fiber: 2.8,
          isLocal: true,
        );
        await Food.db.insertRow(session, food);

        // Act
        final result =
            await endpoints.food.getParentFoodCategories(sessionBuilder);

        // Assert
        expect(result, isNotEmpty);
        expect(result.first.name, equals('Vegetables'));
      });

      test('should return cached categories on second call', () async {
        // Arrange
        final session = sessionBuilder.build();

        // Create parent category with food
        final parentCategory = FoodCategory(
          name: 'Grains',
          slug: 'grains',
          iconName: 'wheat',
          colorHex: '#FFFF00',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, parentCategory);
        final insertedParent = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Grains'),
        );
        final parentId = insertedParent!.id!;

        // Create food in category
        final food = Food(
          name: 'Rice',
          categoryId: parentId,
          calories: 130.0,
          proteins: 2.7,
          carbs: 28.0,
          fats: 0.3,
          fiber: 0.4,
          isLocal: true,
        );
        await Food.db.insertRow(session, food);

        // Act - First call
        final result1 =
            await endpoints.food.getParentFoodCategories(sessionBuilder);

        // Act - Second call (should use cache)
        final result2 =
            await endpoints.food.getParentFoodCategories(sessionBuilder);

        // Assert
        expect(result1, isNotEmpty);
        expect(result2, isNotEmpty);
        // Both should return the same categories (cached)
        expect(result1.length, equals(result2.length));
        expect(result1.first.id, equals(result2.first.id));
      });
    });

    group('getFoodCategoryById', () {
      test('should retrieve category with nested subcategories', () async {
        // Arrange
        final session = sessionBuilder.build();

        // Create parent category
        final parentCategory = FoodCategory(
          name: 'Proteins',
          slug: 'proteins',
          iconName: 'meat',
          colorHex: '#8B0000',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, parentCategory);
        final insertedParent = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Proteins'),
        );
        final parentId = insertedParent!.id!;

        // Create subcategory
        final subCategory = FoodCategory(
          name: 'Meat',
          slug: 'meat',
          iconName: 'steak',
          colorHex: '#A52A2A',
          displayOrder: 0,
          parentCategoryId: parentId,
        );
        await FoodCategory.db.insertRow(session, subCategory);
        final insertedSub = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Meat'),
        );
        final subId = insertedSub!.id!;

        // Create nested subcategory
        final nestedSubCategory = FoodCategory(
          name: 'Beef',
          slug: 'beef',
          iconName: 'beef',
          colorHex: '#800000',
          displayOrder: 0,
          parentCategoryId: subId,
        );
        await FoodCategory.db.insertRow(session, nestedSubCategory);

        // Act
        final result = await endpoints.food.getFoodCategoryById(
          sessionBuilder,
          parentId,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.name, equals('Proteins'));
        expect(result.subCategories, isNotEmpty);
        expect(result.subCategories!.first.name, equals('Meat'));
        expect(result.subCategories!.first.subCategories, isNotEmpty);
        expect(result.subCategories!.first.subCategories!.first.name,
            equals('Beef'));
      });

      test(
          'should throw FoodExceptions.categoryNotFound when category does not exist',
          () async {
        // Arrange
        final nonExistentId = 99999;

        // Act & Assert
        await expectLater(
          endpoints.food.getFoodCategoryById(sessionBuilder, nonExistentId),
          throwsA(
            isA<AppException>()
                .having((e) => e.module, 'module', 'food')
                .having((e) => e.errorCode, 'errorCode', 3000)
                .having((e) => e.httpStatus, 'httpStatus', 404),
          ),
        );
      });
    });

    group('searchFoodsV2', () {
      test('should search foods by query', () async {
        // Arrange
        final session = sessionBuilder.build();

        // Create category
        final category = FoodCategory(
          name: 'Dairy',
          slug: 'dairy',
          iconName: 'milk',
          colorHex: '#FFFFFF',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, category);
        final insertedCategory = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Dairy'),
        );
        final categoryId = insertedCategory!.id!;

        // Create foods
        final food1 = Food(
          name: 'Milk',
          categoryId: categoryId,
          calories: 42.0,
          proteins: 3.4,
          carbs: 5.0,
          fats: 1.0,
          fiber: 0.0,
          isLocal: true,
          isActive: true,
        );
        final food2 = Food(
          name: 'Cheese',
          categoryId: categoryId,
          calories: 113.0,
          proteins: 7.0,
          carbs: 1.0,
          fats: 9.0,
          fiber: 0.0,
          isLocal: true,
          isActive: true,
        );
        final food3 = Food(
          name: 'Yogurt',
          categoryId: categoryId,
          calories: 59.0,
          proteins: 10.0,
          carbs: 3.6,
          fats: 0.4,
          fiber: 0.0,
          isLocal: true,
          isActive: true,
        );
        await Food.db.insertRow(session, food1);
        await Food.db.insertRow(session, food2);
        await Food.db.insertRow(session, food3);

        // Act
        final result = await endpoints.food.searchFoodsV2(
          sessionBuilder,
          query: 'Milk',
        );

        // Assert
        expect(result.foods, isNotEmpty);
        expect(result.foods.first.name, equals('Milk'));
        expect(result.totalCount, equals(1));
      });

      test('should filter foods by category', () async {
        // Arrange
        final session = sessionBuilder.build();

        // Create categories
        final category1 = FoodCategory(
          name: 'Fruits',
          slug: 'fruits',
          iconName: 'apple',
          colorHex: '#FF0000',
          displayOrder: 0,
        );
        final category2 = FoodCategory(
          name: 'Vegetables',
          slug: 'vegetables',
          iconName: 'carrot',
          colorHex: '#00FF00',
          displayOrder: 1,
        );
        await FoodCategory.db.insertRow(session, category1);
        await FoodCategory.db.insertRow(session, category2);
        final insertedCategory1 = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Fruits'),
        );
        final insertedCategory2 = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Vegetables'),
        );
        final categoryId1 = insertedCategory1!.id!;
        final categoryId2 = insertedCategory2!.id!;

        // Create foods in different categories
        final food1 = Food(
          name: 'Apple',
          categoryId: categoryId1,
          calories: 52.0,
          proteins: 0.3,
          carbs: 14.0,
          fats: 0.2,
          fiber: 2.4,
          isLocal: true,
          isActive: true,
        );
        final food2 = Food(
          name: 'Carrot',
          categoryId: categoryId2,
          calories: 41.0,
          proteins: 0.9,
          carbs: 10.0,
          fats: 0.2,
          fiber: 2.8,
          isLocal: true,
          isActive: true,
        );
        await Food.db.insertRow(session, food1);
        await Food.db.insertRow(session, food2);

        // Act
        final result = await endpoints.food.searchFoodsV2(
          sessionBuilder,
          query: '',
          categoryId: categoryId1,
        );

        // Assert
        expect(result.foods, isNotEmpty);
        expect(result.foods.every((f) => f.categoryId == categoryId1), isTrue);
        expect(result.foods.any((f) => f.name == 'Apple'), isTrue);
        expect(result.foods.any((f) => f.name == 'Carrot'), isFalse);
      });

      test('should respect limit parameter', () async {
        // Arrange
        final session = sessionBuilder.build();

        // Create category
        final category = FoodCategory(
          name: 'Nuts',
          slug: 'nuts',
          iconName: 'nut',
          colorHex: '#8B4513',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, category);
        final insertedCategory = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Nuts'),
        );
        final categoryId = insertedCategory!.id!;

        // Create multiple foods
        for (int i = 1; i <= 10; i++) {
          final food = Food(
            name: 'Nut $i',
            categoryId: categoryId,
            calories: 100.0 + i,
            proteins: 10.0 + i,
            carbs: 5.0 + i,
            fats: 5.0 + i,
            fiber: 2.0 + i,
            isLocal: true,
            isActive: true,
          );
          await Food.db.insertRow(session, food);
        }

        // Act
        final result = await endpoints.food.searchFoodsV2(
          sessionBuilder,
          query: '',
          limit: 5,
        );

        // Assert
        expect(result.foods.length, lessThanOrEqualTo(5));
        expect(result.totalCount, lessThanOrEqualTo(5));
      });
    });

    group('getFoodCatalogue', () {
      test('should retrieve food catalogue with exclusions', () async {
        // Arrange
        final session = sessionBuilder.build();

        // Create parent category with food
        final parentCategory = FoodCategory(
          name: 'Beverages',
          slug: 'beverages',
          iconName: 'drink',
          colorHex: '#0000FF',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, parentCategory);
        final insertedParent = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Beverages'),
        );
        final parentId = insertedParent!.id!;

        // Create foods
        final food1 = Food(
          name: 'Water',
          categoryId: parentId,
          calories: 0.0,
          proteins: 0.0,
          carbs: 0.0,
          fats: 0.0,
          fiber: 0.0,
          isLocal: true,
          isActive: true,
        );
        final food2 = Food(
          name: 'Juice',
          categoryId: parentId,
          calories: 45.0,
          proteins: 0.5,
          carbs: 11.0,
          fats: 0.1,
          fiber: 0.2,
          isLocal: true,
          isActive: true,
        );
        final food3 = Food(
          name: 'Soda',
          categoryId: parentId,
          calories: 40.0,
          proteins: 0.0,
          carbs: 10.0,
          fats: 0.0,
          fiber: 0.0,
          isLocal: true,
          isActive: true,
        );
        await Food.db.insertRow(session, food1);
        await Food.db.insertRow(session, food2);
        await Food.db.insertRow(session, food3);
        final insertedFood2 = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Juice'),
        );
        final insertedFood3 = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Soda'),
        );
        final food2Id = insertedFood2!.id!;
        final food3Id = insertedFood3!.id!;

        // Act - exclude food2 and food3
        final result = await endpoints.food.getFoodCatalogue(
          sessionBuilder,
          [food2Id, food3Id],
        );

        // Assert
        expect(result.categories, isNotEmpty);
        final beveragesCategory = result.categories.firstWhere(
          (c) => c.category == 'Beverages',
        );
        expect(beveragesCategory.foods.length, equals(1));
        expect(beveragesCategory.foods.first.name, equals('Water'));
        expect(beveragesCategory.foods.any((f) => f.name == 'Juice'), isFalse);
        expect(beveragesCategory.foods.any((f) => f.name == 'Soda'), isFalse);
      });
    });
  });
}
