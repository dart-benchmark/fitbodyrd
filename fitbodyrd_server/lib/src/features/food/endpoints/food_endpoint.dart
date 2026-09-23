import 'package:fitbodyrd_server/src/features/food/exceptions/food_exceptions.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class FoodEndpoint extends Endpoint {
  static const String parentCategoryCacheKey = 'parent_food_categories';

  Future<List<FoodCategory>> getAllFoodCategories(
    Session session,
  ) async {
    return await FoodCategory.db.find(
      session,
      where: (t) => t.parentCategoryId.equals(null),
      orderBy: (t) => t.displayOrder,
      include: FoodCategory.include(
        subCategories: FoodCategory.includeList(
          orderBy: (t) => t.displayOrder,
          include: FoodCategory.include(
            subCategories: FoodCategory.includeList(
              orderBy: (t) => t.displayOrder,
            ),
          ),
        ),
      ),
    );
  }

  Future<List<FoodCategory>> getParentFoodCategories(
    Session session,
  ) async {
    final cachedCategories = await session.caches.localPrio
        .get<FoodCategoryList>(parentCategoryCacheKey);

    if (cachedCategories != null) {
      return cachedCategories.categories;
    }

    final parentCategories = await FoodCategory.db.find(
      session,
      where: (t) =>
          t.parentCategoryId.equals(null) & t.foods.count().notEquals(0),
      orderBy: (t) => t.displayOrder,
    );

    await session.caches.localPrio.put(
      parentCategoryCacheKey,
      FoodCategoryList(categories: parentCategories),
      lifetime: const Duration(days: 7),
    );

    return parentCategories;
  }

  Future<FoodCategory> getFoodCategoryById(
    Session session,
    int foodCategoryId,
  ) async {
    final category = await FoodCategory.db.findById(
      session,
      foodCategoryId,
      include: FoodCategory.include(
        subCategories: FoodCategory.includeList(
          include: FoodCategory.include(
            subCategories: FoodCategory.includeList(
              orderBy: (t) => t.displayOrder,
            ),
          ),
        ),
      ),
    );

    if (category == null) {
      throw FoodExceptions.categoryNotFound(foodCategoryId);
    }

    return category;
  }

  Future<FoodCategory> createFoodCategory(
    Session session, {
    required String name,
    required String slug,
    required String colorHex,
    required int displayOrder,
    required String iconName,
    int? parentCategoryId,
  }) async {
    final newCategory = FoodCategory(
      name: name,
      slug: slug,
      colorHex: colorHex,
      displayOrder: displayOrder,
      iconName: iconName,
      parentCategoryId: parentCategoryId,
    );

    return await FoodCategory.db.insertRow(session, newCategory);
  }

  Future<FoodCategory> updateFoodCategory(
    Session session,
    int categoryId, {
    String? name,
    String? slug,
    String? colorHex,
    int? displayOrder,
    String? iconName,
    int? parentCategoryId,
  }) async {
    final category = await getFoodCategoryById(session, categoryId);

    category.name = name ?? category.name;
    category.slug = slug ?? category.slug;
    category.colorHex = colorHex ?? category.colorHex;
    category.displayOrder = displayOrder ?? category.displayOrder;
    category.iconName = iconName ?? category.iconName;
    category.parentCategoryId = parentCategoryId;
    category.updatedAt = DateTime.now();

    return await FoodCategory.db.updateRow(session, category);
  }

  Future<void> deleteFoodCategory(
    Session session,
    int categoryId,
  ) async {
    final category = await FoodCategory.db.findById(
      session,
      categoryId,
      include: FoodCategory.include(
        foods: Food.includeList(),
        subCategories: FoodCategory.includeList(),
      ),
    );

    if (category == null) {
      throw FoodExceptions.categoryNotFound(categoryId);
    }

    if (category.foods!.isNotEmpty) {
      throw FoodExceptions.categoryHasFoods(categoryId);
    }

    if (category.subCategories!.isNotEmpty) {
      throw FoodExceptions.categoryHasSubcategories(categoryId);
    }

    await FoodCategory.db.deleteRow(session, category);
  }

  Future<List<Food>> getFoods(Session session) async {
    return await Food.db.find(
      session,
      orderBy: (t) => t.name,
      include: Food.include(
        servingSizes: FoodServingSize.includeList(
          orderBy: (t) => t.isDefault,
        ),
        micronutrients: FoodMicronutrient.includeList(
          orderBy: (t) => t.name,
        ),
        category: FoodCategory.include(),
      ),
    );
  }

  Future<Food> getFoodById(
    Session session,
    int foodId,
  ) async {
    final food = await Food.db.findById(
      session,
      foodId,
      include: Food.include(
        servingSizes: FoodServingSize.includeList(
          orderBy: (t) => t.isDefault,
        ),
        micronutrients: FoodMicronutrient.includeList(
          orderBy: (t) => t.name,
        ),
        category: FoodCategory.include(),
      ),
    );

    if (food == null) {
      throw FoodExceptions.foodNotFound(foodId);
    }

    return food;
  }

  Future<Food> createFood(
    Session session, {
    required String name,
    required int categoryId,
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
    required double fiber,
    required bool isLocal,
    String? brand,
    String? imageUrl,
    String? barcode,
    List<CreateServingSizeDto>? servingSizes,
    List<CreateMicronutrientDto>? micronutrients,
  }) async {
    await getFoodCategoryById(session, categoryId);

    final insertedFoodId = await session.db.transaction(
      (transaction) async {
        final newFood = Food(
          name: name,
          categoryId: categoryId,
          calories: calories,
          proteins: proteins,
          carbs: carbs,
          fats: fats,
          fiber: fiber,
          isLocal: isLocal,
          brand: brand,
          imageUrl: imageUrl,
          barcode: barcode,
        );

        final insertedFood = await Food.db.insertRow(
          session,
          newFood,
          transaction: transaction,
        );

        if (servingSizes != null) {
          for (var servingSizeDto in servingSizes) {
            final servingSize = FoodServingSize(
              foodId: insertedFood.id!,
              name: servingSizeDto.name,
              grams: servingSizeDto.grams,
              isDefault: servingSizeDto.isDefault,
            );
            await FoodServingSize.db.insertRow(
              session,
              servingSize,
              transaction: transaction,
            );
          }
        }

        if (micronutrients != null) {
          for (var micronutrientDto in micronutrients) {
            final micronutrient = FoodMicronutrient(
              foodId: insertedFood.id!,
              name: micronutrientDto.name,
              amount: micronutrientDto.amount,
              unit: micronutrientDto.unit,
            );
            await FoodMicronutrient.db.insertRow(
              session,
              micronutrient,
              transaction: transaction,
            );
          }
        }

        return insertedFood.id!;
      },
    );

    return getFoodById(session, insertedFoodId);
  }

  Future<Food> updateFood(
    Session session,
    int foodId, {
    String? name,
    int? categoryId,
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
    double? fiber,
    bool? isLocal,
    String? brand,
    String? imageUrl,
    String? barcode,
    bool? isActive,
    List<CreateServingSizeDto>? servingSizes,
    List<CreateMicronutrientDto>? micronutrients,
  }) async {
    final food = await getFoodById(session, foodId);

    if (categoryId != null) {
      await getFoodCategoryById(session, food.categoryId);
    }

    food.name = name ?? food.name;
    food.categoryId = categoryId ?? food.categoryId;
    food.calories = calories ?? food.calories;
    food.proteins = proteins ?? food.proteins;
    food.carbs = carbs ?? food.carbs;
    food.fats = fats ?? food.fats;
    food.fiber = fiber ?? food.fiber;
    food.isLocal = isLocal ?? food.isLocal;
    food.brand = brand ?? food.brand;
    food.imageUrl = imageUrl ?? food.imageUrl;
    food.barcode = barcode ?? food.barcode;
    food.isActive = isActive ?? food.isActive;
    food.updatedAt = DateTime.now();

    await session.db.transaction(
      (transaction) async {
        await Food.db.updateRow(
          session,
          food,
          transaction: transaction,
        );

        if (servingSizes != null) {
          // Delete existing serving sizes
          await FoodServingSize.db.deleteWhere(
            session,
            where: (t) => t.foodId.equals(food.id!),
            transaction: transaction,
          );

          // Insert new serving sizes
          for (var servingSize in servingSizes) {
            final actualServingSize = FoodServingSize(
              foodId: food.id!,
              name: servingSize.name,
              grams: servingSize.grams,
              isDefault: servingSize.isDefault,
            );
            await FoodServingSize.db.insertRow(
              session,
              actualServingSize,
              transaction: transaction,
            );
          }
        }

        if (micronutrients != null) {
          // Delete existing micronutrients
          await FoodMicronutrient.db.deleteWhere(
            session,
            where: (t) => t.foodId.equals(food.id!),
            transaction: transaction,
          );

          // Insert new micronutrients
          for (var micronutrient in micronutrients) {
            final actualMicronutrient = FoodMicronutrient(
              foodId: food.id!,
              name: micronutrient.name,
              amount: micronutrient.amount,
              unit: micronutrient.unit,
            );
            await FoodMicronutrient.db.insertRow(
              session,
              actualMicronutrient,
              transaction: transaction,
            );
          }
        }
      },
    );

    return getFoodById(session, foodId);
  }

  Future<void> deleteFood(
    Session session,
    int foodId,
  ) async {
    final food = await getFoodById(session, foodId);

    await Food.db.deleteRow(session, food);
  }

  Future<FoodServingSize> createFoodServingSize(
    Session session, {
    required int foodId,
    required String name,
    required double grams,
    required bool isDefault,
  }) async {
    await getFoodById(session, foodId);

    final newServingSize = FoodServingSize(
      foodId: foodId,
      name: name,
      grams: grams,
      isDefault: isDefault,
    );

    return await FoodServingSize.db.insertRow(session, newServingSize);
  }

  Future<FoodServingSize> updateFoodServingSize(
    Session session,
    int servingSizeId, {
    String? name,
    double? grams,
    bool? isDefault,
  }) async {
    final servingSize = await FoodServingSize.db.findById(
      session,
      servingSizeId,
    );

    if (servingSize == null) {
      throw FoodExceptions.servingSizeNotFound(servingSizeId);
    }

    servingSize.name = name ?? servingSize.name;
    servingSize.grams = grams ?? servingSize.grams;
    servingSize.isDefault = isDefault ?? servingSize.isDefault;
    servingSize.updatedAt = DateTime.now();

    return await FoodServingSize.db.updateRow(session, servingSize);
  }

  Future<void> deleteFoodServingSize(
    Session session,
    int servingSizeId,
  ) async {
    final servingSize = await FoodServingSize.db.findById(
      session,
      servingSizeId,
    );

    if (servingSize == null) {
      throw FoodExceptions.servingSizeNotFound(servingSizeId);
    }

    await FoodServingSize.db.deleteRow(session, servingSize);
  }

  Future<FoodMicronutrient> createFoodMicronutrient(
    Session session, {
    required int foodId,
    required String name,
    required double amount,
    required String unit,
  }) async {
    await getFoodById(session, foodId);

    final newMicronutrient = FoodMicronutrient(
      foodId: foodId,
      name: name,
      amount: amount,
      unit: unit,
    );

    return await FoodMicronutrient.db.insertRow(session, newMicronutrient);
  }

  Future<FoodMicronutrient> updateFoodMicronutrient(
    Session session,
    int micronutrientId, {
    String? name,
    double? amount,
    String? unit,
  }) async {
    final micronutrient = await FoodMicronutrient.db.findById(
      session,
      micronutrientId,
    );

    if (micronutrient == null) {
      throw FoodExceptions.micronutrientNotFound(micronutrientId);
    }

    micronutrient.name = name ?? micronutrient.name;
    micronutrient.amount = amount ?? micronutrient.amount;
    micronutrient.unit = unit ?? micronutrient.unit;
    micronutrient.updatedAt = DateTime.now();

    return await FoodMicronutrient.db.updateRow(session, micronutrient);
  }

  Future<void> deleteFoodMicronutrient(
    Session session,
    int micronutrientId,
  ) async {
    final micronutrient = await FoodMicronutrient.db.findById(
      session,
      micronutrientId,
    );

    if (micronutrient == null) {
      throw FoodExceptions.micronutrientNotFound(micronutrientId);
    }

    await FoodMicronutrient.db.deleteRow(session, micronutrient);
  }

  Future<SearchEndpointsResponseDto> searchFoods(
    Session session, {
    required int categoryId,
    DietaryRestriction? dietaryRestriction = DietaryRestriction.none,
    bool? isLocalOnly = true,
    List<int>? excludeFoodIds = const [],
    int? limit = 20,
  }) async {
    final foods = await Food.db.find(
      session,
      where: (t) {
        var condition = t.categoryId.equals(categoryId);

        condition = condition & t.isActive.equals(true);

        if (isLocalOnly == true) {
          condition = condition & t.isLocal.equals(true);
        }

        if (excludeFoodIds != null && excludeFoodIds.isNotEmpty) {
          condition = condition & t.id.notInSet(excludeFoodIds.toSet());
        }

        return condition;
      },
      orderBy: (t) => t.name,
      limit: limit,
      include: Food.include(
        servingSizes: FoodServingSize.includeList(
          orderBy: (t) => t.isDefault,
        ),
        micronutrients: FoodMicronutrient.includeList(
          orderBy: (t) => t.name,
        ),
        category: FoodCategory.include(),
      ),
    );

    final totalCount = foods.length;

    return SearchEndpointsResponseDto(
      foods: foods,
      totalCount: totalCount,
    );
  }

  Future<SearchEndpointsResponseDto> searchFoodsV2(
    Session session, {
    required String query,
    int? categoryId,
    int? limit = 20,
  }) async {
    final foods = await Food.db.find(
      session,
      where: (t) {
        var condition = t.isActive.equals(true);

        if (categoryId != null) {
          condition = condition & t.categoryId.equals(categoryId);
        }

        if (query.isNotEmpty) {
          condition = condition & t.name.ilike('%$query%');
        }

        return condition;
      },
      orderBy: (t) => t.name,
      limit: limit,
      include: Food.include(
        servingSizes: FoodServingSize.includeList(
          orderBy: (t) => t.isDefault,
        ),
        micronutrients: FoodMicronutrient.includeList(
          orderBy: (t) => t.name,
        ),
        category: FoodCategory.include(),
      ),
    );

    final totalCount = foods.length;

    return SearchEndpointsResponseDto(
      foods: foods,
      totalCount: totalCount,
    );
  }

  Future<FoodCatalogueDto> getFoodCatalogue(
    Session session,
    List<int> excludeFoodIds,
  ) async {
    final parentCategories = await getParentFoodCategories(session);

    List<FoodCategoryDetailDto> categoryDetails = [];

    for (var parentCategory in parentCategories) {
      final foods = await Food.db.find(
        session,
        where: (t) =>
            t.categoryId.equals(parentCategory.id!) &
            t.isActive.equals(true) &
            t.id.notInSet(excludeFoodIds.toSet()),
        orderBy: (t) => t.name,
        include: Food.include(
          servingSizes: FoodServingSize.includeList(
            orderBy: (t) => t.isDefault,
          ),
          micronutrients: FoodMicronutrient.includeList(
            orderBy: (t) => t.name,
          ),
        ),
        limit: 25,
      );

      if (foods.isNotEmpty) {
        categoryDetails.add(
          FoodCategoryDetailDto(
            category: parentCategory.name,
            categoryId: parentCategory.id!,
            foods: foods,
          ),
        );
      }
    }

    return FoodCatalogueDto(categories: categoryDetails);
  }
}
