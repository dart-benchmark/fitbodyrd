# Exception Registry

This document is automatically generated from the exception files in the codebase.

**Last Updated:** 2025-11-26 12:29:22

## Overview

- **Total Modules:** 7
- **Total Exceptions:** 34
- **Available Codes:** 6966

## Module Overview

| Module | Range | Defined | Available | File |
|--------|-------|---------|-----------|------|
| Generic | 1000-1999 | 2 | 998 | `lib/src/errors/exceptions/generic_exceptions.dart` |
| Exercise | 2000-2999 | 5 | 995 | `lib/src/features/exercise/exceptions/exercise_exceptions.dart` |
| Food | 3000-3999 | 6 | 994 | `lib/src/features/food/exceptions/food_exceptions.dart` |
| Nutrition | 4000-4999 | 1 | 999 | `lib/src/features/nutrition/exceptions/nutrition_exceptions.dart` |
| Nutrition_Plan | 5000-5999 | 13 | 987 | `lib/src/features/nutrition_plan/exceptions/nutrition_plan_exceptions.dart` |
| User | 6000-6999 | 3 | 997 | `lib/src/features/user/exceptions/user_exceptions.dart` |
| Workout | 7000-7999 | 4 | 996 | `lib/src/features/workouts/exceptions/workout_exceptions.dart` |

## Generic Module

**Range:** 1000-1999  
**File:** `lib/src/errors/exceptions/generic_exceptions.dart`  
**Exceptions:** 2  
**Available:** 998

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 1000 | 500 | `internalServerError()` | Internal server error. |
| 1001 | 401 | `userNotAuthenticated()` | User not authenticated. |

## Exercise Module

**Range:** 2000-2999  
**File:** `lib/src/features/exercise/exceptions/exercise_exceptions.dart`  
**Exceptions:** 5  
**Available:** 995

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 2000 | 400 | `equipmentMissing()` | Required equipment is missing for the exercise. |
| 2001 | 404 | `imageNotFound()` | Exercise image not found. |
| 2002 | 400 | `invalidImageOrder()` | Invalid image order provided. |
| 2003 | 400 | `nameAlreadyExists()` | An exercise with the same name already exists. |
| 2004 | 404 | `exerciseNotFound()` | Exercise not found. |

## Food Module

**Range:** 3000-3999  
**File:** `lib/src/features/food/exceptions/food_exceptions.dart`  
**Exceptions:** 6  
**Available:** 994

### Categories

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 3000 | 404 | `categoryNotFound(int categoryId)` | Food category with ID $categoryId not found. |
| 3001 | 400 | `categoryHasFoods(int categoryId)` | Food category with ID $categoryId has associated foods and cannot be deleted. |
| 3002 | 400 | `categoryHasSubcategories(int categoryId)` | Food category with ID $categoryId has subcategories and cannot be deleted. |

### Food Items

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 3100 | 404 | `foodNotFound(int foodId)` | Food item with ID $foodId not found. |

### Serving Sizes

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 3200 | 404 | `servingSizeNotFound(int servingSizeId)` | Serving size with ID $servingSizeId not found. |

### Micronutrients

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 3300 | 404 | `micronutrientNotFound(int micronutrientId)` | Micronutrient with ID $micronutrientId not found. |


## Nutrition Module

**Range:** 4000-4999  
**File:** `lib/src/features/nutrition/exceptions/nutrition_exceptions.dart`  
**Exceptions:** 1  
**Available:** 999

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 4000 | 400 | `invalidMealTypesCount(int count)` | Invalid number of meal types: $count. Must be between 2 and 5. |

## Nutrition_Plan Module

**Range:** 5000-5999  
**File:** `lib/src/features/nutrition_plan/exceptions/nutrition_plan_exceptions.dart`  
**Exceptions:** 13  
**Available:** 987

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 5000 | 409 | `activePlanAlreadyExists(int userId)` | Active nutrition plan already exists for user with ID $userId. |
| 5001 | 400 | `invalidNutritionValues()` | Invalid nutrition values: daily calories, proteins, carbs, and fats must be greater than zero. |
| 5002 | 400 | `invalidDailyCalories(double dailyCalories)` | Invalid daily calories: $dailyCalories. It must be between 1200 and 5000. |
| 5003 | 400 | `invalidDateRange(DateTime startDate, DateTime endDate)` | Invalid date range: end date $endDate is before start date $startDate. |
| 5004 | 404 | `nutritionPlanNotFound(int planId)` | Nutrition plan with ID $planId not found. |
| 5005 | 404 | `noActiveNutritionPlan(int userId)` | No active nutrition plan found for user with ID $userId. |
| 5006 | 500 | `databaseException(DatabaseQueryException e)` | Complex message |
| 5007 | 400 | `invalidQuantity()` | Invalid quantity: serving quantity and quantity in grams must be greater than zero. |
| 5008 | 404 | `mealPlanFoodNotFound(int mealPlanFoodId)` | Meal plan food with ID $mealPlanFoodId not found. |
| 5009 | 404 | `servingSizeNotFound(int servingSizeId)` | Serving size with ID $servingSizeId not found. |
| 5010 | 400 | `servingSizeMismatch(int servingSizeFoodId, int mealPlanFoodId)` | Serving size (food ID: $servingSizeFoodId) does not match the meal plan food (food ID: $mealPlanFoodId). |
| 5011 | 404 | `mealPlanNotFound(int mealPlanId)` | Meal plan with ID $mealPlanId not found. |
| 5012 | 409 | `foodAlreadyInMealPlan(int foodId, int mealPlanId)` | Food with ID $foodId already exists in meal plan with ID $mealPlanId. |

## User Module

**Range:** 6000-6999  
**File:** `lib/src/features/user/exceptions/user_exceptions.dart`  
**Exceptions:** 3  
**Available:** 997

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 6000 | 404 | `userNotFound()` | User not found. |
| 6001 | 401 | `userNotAuthenticated()` | User is not authenticated. |
| 6002 | 409 | `userProfileAlreadyExists()` | User profile already exists. |

## Workout Module

**Range:** 7000-7999  
**File:** `lib/src/features/workouts/exceptions/workout_exceptions.dart`  
**Exceptions:** 4  
**Available:** 996

| Code | HTTP | Method | Message |
|------|------|--------|---------|
| 7000 | 400 | `activeWorkoutPlanExists()` | Active workout plan already exists. |
| 7001 | 404 | `noActiveWorkoutPlan()` | No active workout plan found. |
| 7002 | 500 | `errorCreatingWorkoutPlan()` | Error creating workout plan. |
| 7003 | 404 | `exerciseLogNotFound()` | Exercise log not found or does not belong to the user. |

---

## Adding New Exceptions

1. Add your exception method to the appropriate `*_exceptions.dart` file
2. Run `python3 scripts/generate_exception_registry.py` to update this README
3. Ensure your error code is within the module's range
4. Follow the naming conventions for consistency

## Error Code Ranges

Error codes are organized by module to prevent conflicts:

- **1000-1999**: Generic/System errors
- **2000-2999**: Exercise module
- **3000-3999**: Food module
- **4000-4999**: Nutrition module
- **5000-5999**: Nutrition Plan module
- **6000-6999**: User module
- **7000-7999**: Workout module

---
*This file is auto-generated. Do not edit manually.*