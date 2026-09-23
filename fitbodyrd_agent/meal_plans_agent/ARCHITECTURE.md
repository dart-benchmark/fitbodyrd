# Architecture Diagram - Meal Plan Agent

## System Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                          FLUTTER APP (User)                          │
│                                                                       │
│  [Plan Request] → userId: 123, weeks: 2                             │
│  [Progress View] ← Polling /progress every 5s                       │
│  [Plan View] ← Display generated meal plan                          │
└───────────────────────────────┬─────────────────────────────────────┘
                                │
                                ↓
┌─────────────────────────────────────────────────────────────────────┐
│                          n8n WORKFLOW                                 │
│                                                                       │
│  ┌────────────┐      ┌──────────────┐      ┌─────────────┐         │
│  │  Webhook   │─────→│   Validate   │─────→│  AI Agent   │         │
│  │  Trigger   │      │    Input     │      │   (GPT-4)   │         │
│  └────────────┘      └──────────────┘      └──────┬──────┘         │
│                                                     │                 │
│                                    ┌────────────────┴─────────┐      │
│                                    ↓                          ↓      │
│                            ┌───────────────┐          ┌───────────┐ │
│                            │   8 Tools     │          │  Format   │ │
│                            │ (HTTP Nodes)  │          │ Response  │ │
│                            └───────┬───────┘          └─────┬─────┘ │
│                                    │                        │        │
└────────────────────────────────────┼────────────────────────┼────────┘
                                     │                        │
                                     ↓                        ↓
┌─────────────────────────────────────────────────────────────────────┐
│                    FITBODYRD BACKEND (Serverpod)                     │
│                                                                       │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                     API ENDPOINTS                             │   │
│  │                                                               │   │
│  │  1. GET  /users/{id}/profile                                │   │
│  │  2. POST /nutrition/calculate-macros                        │   │
│  │  3. GET  /foods/categories                                  │   │
│  │  4. POST /foods/search-by-category                          │   │
│  │  5. GET  /users/{id}/food-preferences                       │   │
│  │  6. POST /nutrition-plans                                   │   │
│  │  7. POST /nutrition-plans/{id}/days                         │   │
│  │  8. POST /nutrition-plans/{id}/progress                     │   │
│  │                                                               │   │
│  └────────────────────────┬──────────────────────────────────────┘   │
│                           │                                           │
│  ┌────────────────────────┴──────────────────────────────────────┐   │
│  │                  BUSINESS LOGIC                                │   │
│  │                                                                 │   │
│  │  • NutritionCalculator (BMR, TDEE, Macros)                    │   │
│  │  • MealPlanValidator (Constraints, Tolerances)                │   │
│  │  • FoodSearchService (Filters, Restrictions)                  │   │
│  │                                                                 │   │
│  └────────────────────────┬──────────────────────────────────────┘   │
│                           │                                           │
└───────────────────────────┼───────────────────────────────────────────┘
                            │
                            ↓
┌─────────────────────────────────────────────────────────────────────┐
│                    POSTGRESQL DATABASE                               │
│                                                                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐          │
│  │    users     │  │ user_profiles│  │ user_food_prefs  │          │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────────┘          │
│         │                 │                  │                       │
│         └─────────────────┴──────────────────┘                       │
│                           │                                           │
│  ┌────────────────────────┴──────────────────────────────────────┐   │
│  │                   MEAL PLAN TABLES                             │   │
│  │                                                                 │   │
│  │  nutrition_plans (1 record)                                   │   │
│  │       ↓                                                         │   │
│  │  meal_plans (7×weeks×5 records)                               │   │
│  │       ↓                                                         │   │
│  │  meal_plan_foods (many records)                               │   │
│  │                                                                 │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                       │
│  ┌──────────────┐  ┌──────────────────┐  ┌────────────────────┐    │
│  │    foods     │  │ food_categories   │  │ food_serving_sizes │    │
│  └──────────────┘  └──────────────────┘  └────────────────────┘    │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

## Data Flow - Plan Generation

```
Step 1: USER REQUEST
────────────────────
{userId: 123, weeks: 2}
         │
         ↓
         
Step 2: GET USER DATA
─────────────────────
Agent → getUserProfile(123)
         ↓
Backend → Query user_profiles
         ↓
Return: {age: 35, weight: 85kg, height: 1.75m, goal: loseWeight, ...}
         │
         ↓
         
Step 3: CALCULATE NUTRITION
───────────────────────────
Agent → calculateDailyMacros(profile)
         ↓
Backend → BMR = (10 × 85) + (6.25 × 175) - (5 × 35) + 5 = 1850
         → TDEE = 1850 × 1.55 = 2870
         → Target = 2870 - 500 = 2370 cal
         → Macros: 178g P, 237g C, 79g F
         → Distribution per meal
         ↓
Return: {dailyCalories: 2370, dailyProteins: 178, ...}
         │
         ↓
         
Step 4: GET FOOD DATA
─────────────────────
Agent → getFoodCategories()
         ↓
Backend → Query food_categories
         ↓
Return: [Frutas, Proteínas, Carbohidratos, ...]
         │
Agent → getUserFoodPreferences(123)
         ↓
Backend → Query user_food_preferences
         ↓
Return: {excludedFoodIds: [45, 67], favoriteFoodIds: [112], ...}
         │
         ↓
         
Step 5: CREATE PLAN CONTAINER
──────────────────────────────
Agent → createNutritionPlan({userId, dates, macros})
         ↓
Backend → INSERT INTO nutrition_plans
         ↓
Return: {id: 456, status: 'activo'}
         │
         ↓
         
Step 6: CREATE DAY 1
────────────────────

Agent → Desayuno (593 cal, 44g P, 71g C, 20g F)
         ↓
Agent → searchFoodsByCategory({categoryId: 4, ...}) // Carbohidratos
         ↓
Backend → SELECT * FROM foods 
           WHERE category_id = 4 
           AND is_active = true 
           AND is_local = true
           AND id NOT IN (45, 67)
         ↓
Return: [Avena, Arroz, Pan, ...]
         │
Agent → SELECT: Avena (80g) → 304 cal, 11g P, 54g C, 6g F
         │
Agent → searchFoodsByCategory({categoryId: 1, ...}) // Frutas
         ↓
Return: [Plátano, Mango, Lechosa, ...]
         │
Agent → SELECT: Plátano (118g) → 105 cal, 1g P, 27g C, 0g F
         │
Agent → searchFoodsByCategory({categoryId: 3, ...}) // Proteínas
         ↓
Return: [Huevos, Pollo, Queso, ...]
         │
Agent → SELECT: Huevos (150g) → 233 cal, 20g P, 2g C, 17g F
         │
         ↓
Agent → Validate totals: 642 cal vs 593 target (within 10% ✓)
         │
         ↓
         
[Repeat for Almuerzo, Cena, Snack_1, Snack_2]
         │
         ↓
         
Agent → createMealPlanDay({
          nutritionPlanId: 456,
          date: '2025-11-08',
          dayNumber: 1,
          meals: [desayuno, almuerzo, cena, snack_1, snack_2]
        })
         ↓
Backend → BEGIN TRANSACTION
         → INSERT INTO meal_plans (5 records)
         → INSERT INTO meal_plan_foods (13 records)
         → COMMIT
         ↓
Return: {success: true, mealsCreated: 5, totalFoodsAdded: 13}
         │
         ↓
Agent → updateMealPlanProgress({
          nutritionPlanId: 456,
          currentDay: 1,
          totalDays: 14,
          status: 'generando',
          message: 'Creando día 1 de 14...'
        })
         ↓
Backend → UPDATE nutrition_plans SET progress = 7.14%
         ↓
         
[REPEAT STEPS FOR DAYS 2-14]
         │
         ↓
         
Step 7: FINALIZE
────────────────
Agent → updateMealPlanProgress({
          nutritionPlanId: 456,
          currentDay: 14,
          totalDays: 14,
          status: 'completado'
        })
         ↓
Backend → UPDATE nutrition_plans SET status = 'activo', progress = 100%
         ↓
Agent → Return summary in Spanish
         ↓
User ← "¡Plan nutricional de 2 semanas creado exitosamente! 🎉"
```

## Tool Call Sequence (14-day plan)

```
Initialization Phase:
├─ Tool 1: getUserProfile                    (1 call)
├─ Tool 2: calculateDailyMacros              (1 call)
├─ Tool 3: getFoodCategories                 (1 call)
└─ Tool 4: getUserFoodPreferences            (1 call)
                                             ────────
                                             4 calls

Plan Creation Phase:
└─ Tool 5: createNutritionPlan               (1 call)
                                             ────────
                                             1 call

Day Generation Phase (14 iterations):
├─ Day 1:
│  ├─ Tool 6: searchFoodsByCategory          (6-8 calls)
│  ├─ [Agent: Food selection & portioning]
│  ├─ Tool 7: createMealPlanDay              (1 call)
│  └─ Tool 8: updateMealPlanProgress         (1 call)
├─ Day 2:
│  ├─ Tool 6: searchFoodsByCategory          (6-8 calls)
│  ├─ Tool 7: createMealPlanDay              (1 call)
│  └─ Tool 8: updateMealPlanProgress         (1 call)
└─ ... (repeat for days 3-14)
                                             ────────────────
                                             ~100-120 calls

Finalization Phase:
└─ Tool 8: updateMealPlanProgress            (1 call)
                                             ────────
                                             1 call

TOTAL: ~106-126 tool calls
TIME: ~2-4 minutes for 14-day plan
COST: ~$2.40-$3.00 USD (GPT-4)
```

## Database Schema (Relevant Tables)

```sql
┌─────────────────────────────────────────────────────────────────┐
│                       nutrition_plans                            │
├─────────────────────────────────────────────────────────────────┤
│ id: 456                                                          │
│ user_id: 123                                                     │
│ start_date: 2025-11-08                                          │
│ end_date: 2025-11-21                                            │
│ daily_calories: 2370                                            │
│ daily_proteins: 177.75                                          │
│ daily_carbs: 237.0                                              │
│ daily_fats: 79.0                                                │
│ status: 'activo'                                                │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ (1 to many)
                         ↓
┌─────────────────────────────────────────────────────────────────┐
│                         meal_plans                               │
├─────────────────────────────────────────────────────────────────┤
│ id: 1001 | nutrition_plan_id: 456 | date: 2025-11-08           │
│ meal_type: 'desayuno'                                           │
├─────────────────────────────────────────────────────────────────┤
│ id: 1002 | nutrition_plan_id: 456 | date: 2025-11-08           │
│ meal_type: 'almuerzo'                                           │
├─────────────────────────────────────────────────────────────────┤
│ id: 1003 | nutrition_plan_id: 456 | date: 2025-11-08           │
│ meal_type: 'cena'                                               │
├─────────────────────────────────────────────────────────────────┤
│ ... (70 total records for 14 days × 5 meals)                   │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ (1 to many)
                         ↓
┌─────────────────────────────────────────────────────────────────┐
│                      meal_plan_foods                             │
├─────────────────────────────────────────────────────────────────┤
│ id: 5001 | meal_plan_id: 1001 | food_id: 15                    │
│ quantity: 80.0 | is_user_modified: false                        │
├─────────────────────────────────────────────────────────────────┤
│ id: 5002 | meal_plan_id: 1001 | food_id: 23                    │
│ quantity: 118.0 | is_user_modified: false                       │
├─────────────────────────────────────────────────────────────────┤
│ id: 5003 | meal_plan_id: 1001 | food_id: 102                   │
│ quantity: 150.0 | is_user_modified: false                       │
├─────────────────────────────────────────────────────────────────┤
│ ... (150-200 total records)                                     │
└─────────────────────────────────────────────────────────────────┘
```

## Agent Decision Tree (Simplified)

```
START: Receive {userId, weeks}
  │
  ├─ Get user profile → SUCCESS?
  │   ├─ YES → Continue
  │   └─ NO → ERROR: "User not found"
  │
  ├─ Calculate macros → VALID?
  │   ├─ YES → Continue
  │   └─ NO → ERROR: "Invalid profile data"
  │
  ├─ Get food categories → FOUND?
  │   ├─ YES → Continue
  │   └─ NO → ERROR: "No food categories"
  │
  ├─ Get preferences → Continue (even if empty)
  │
  ├─ Create nutrition plan → SUCCESS?
  │   ├─ YES → Get planId, Continue
  │   └─ NO → ERROR: "Cannot create plan"
  │
  └─ FOR each day in 1...(weeks×7):
      │
      ├─ FOR each meal in mealTypes (e.g., [breakfast, lunch, snack, dinner]):
      │   │
      │   ├─ Get target macros for this meal
      │   │
      │   ├─ Search foods by category (multiple searches)
      │   │   └─ Filter: dietary restriction, local, active, exclude allergies
      │   │
      │   ├─ Select foods to meet macros
      │   │   ├─ Prioritize favorites
      │   │   ├─ Ensure variety (check recent days)
      │   │   └─ Calculate portions
      │   │
      │   └─ Validate meal totals → WITHIN ±10%?
      │       ├─ YES → Add to day
      │       └─ NO → Adjust portions, retry
      │
      ├─ Create meal plan day → SUCCESS?
      │   ├─ YES → Continue
      │   └─ NO → ERROR: "Cannot create day"
      │
      ├─ Update progress → Continue
      │
      └─ NEXT day
  │
END: Mark plan as completed, return summary
```

## Error Handling Flow

```
Any Tool Call
     │
     ├─ HTTP 200 → Process response
     │
     ├─ HTTP 400 → Validation error
     │   └─ Agent: Retry with corrected data
     │
     ├─ HTTP 404 → Not found
     │   └─ Agent: Report error to user, stop
     │
     ├─ HTTP 409 → Conflict (e.g., day already exists)
     │   └─ Agent: Skip or update existing
     │
     ├─ HTTP 422 → Business logic error
     │   └─ Agent: Try alternative approach or stop
     │
     ├─ HTTP 500 → Server error
     │   └─ Agent: Retry up to 3 times, then stop
     │
     └─ Timeout → No response
         └─ Agent: Retry with longer timeout
```

---

This architecture ensures: ✓ Scalability (progressive day creation) ✓ Real-time
feedback (progress updates) ✓ Data integrity (transactions, validations) ✓
Flexibility (agent makes smart decisions) ✓ Fault tolerance (error handling,
retries)
