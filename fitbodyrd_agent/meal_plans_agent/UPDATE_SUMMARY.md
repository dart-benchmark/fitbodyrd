# Update Summary - Dynamic Meal Types

## 🎯 What Changed

The meal plan agent now supports **flexible meal configurations**. Instead of a
fixed 5-meal structure, users can now specify exactly which meals they want each
day (2-6 meals).

---

## ✨ New Feature: Custom Meal Types

### Before (Fixed Structure):

```json
{
    "userId": 123,
    "weeks": 2
}
// Always created: desayuno, almuerzo, cena, snack_1, snack_2 (5 meals/day)
```

### After (Flexible Structure):

```json
{
    "userId": 123,
    "weeks": 2,
    "mealTypes": ["breakfast", "lunch", "snack", "dinner"]
}
// Creates only the specified meals (4 meals/day in this example)
```

---

## 📋 MealPlanType Enum

The available meal types match your backend enum:

| Value       | Spanish  | Description                |
| ----------- | -------- | -------------------------- |
| `breakfast` | Desayuno | Morning meal               |
| `brunch`    | Brunch   | Late breakfast/early lunch |
| `lunch`     | Almuerzo | Main midday meal           |
| `snack`     | Merienda | Light snack                |
| `dinner`    | Cena     | Evening meal               |

**Constraints:**

- Minimum: 2 meals per day
- Maximum: 6 meals per day
- No duplicates allowed
- Must be valid enum values

---

## 🔢 Dynamic Macro Distribution

### New Algorithm

The agent now calculates macro distribution dynamically based on meal type
weights:

```python
Weights:
- breakfast: 3.0
- brunch: 4.0
- lunch: 4.5
- snack: 1.0
- dinner: 3.5

Formula:
1. totalWeight = sum(weight for each selected mealType)
2. percentage = (mealWeight / totalWeight) × 100
3. meal_macros = daily_macros × (percentage / 100)
```

### Examples

**2 meals (Intermittent Fasting):**

```json
["lunch", "dinner"]
→ lunch: 56.25% | dinner: 43.75%
```

**3 meals (Standard):**

```json
["breakfast", "lunch", "dinner"]
→ breakfast: 27.3% | lunch: 40.9% | dinner: 31.8%
```

**4 meals (Balanced):**

```json
["breakfast", "lunch", "snack", "dinner"]
→ breakfast: 25.0% | lunch: 37.5% | snack: 8.3% | dinner: 29.2%
```

**5 meals (Frequent):**

```json
["breakfast", "brunch", "lunch", "snack", "dinner"]
→ breakfast: 18.8% | brunch: 25.0% | lunch: 28.1% | snack: 6.3% | dinner: 21.9%
```

---

## 📝 Updated Files

### 1. **user_prompt_template.md**

- ✅ Added `mealTypes` field to input schema
- ✅ Added MealPlanType enum table
- ✅ Updated all examples with mealTypes
- ✅ Added validation rules for mealTypes
- ✅ Added new error case for invalid mealTypes

### 2. **system_prompt.md**

- ✅ Updated Meal Type enum section
- ✅ Added dynamic distribution algorithm
- ✅ Updated workflow to use user-specified mealTypes
- ✅ Updated food category recommendations for all meal types
- ✅ Updated example conversation
- ✅ Updated validation rules

### 3. **api_endpoints.md**

- ✅ Added `mealTypes` parameter to calculateDailyMacros endpoint
- ✅ Updated mealDistribution response format
- ✅ Added dynamic distribution formula documentation
- ✅ Updated example responses

### 4. **tools_specification.md**

- ✅ Updated calculateDailyMacros tool input/output
- ✅ Updated createMealPlanDay examples
- ✅ Changed meal type values to new enum

### 5. **README.md**

- ✅ Updated input/output examples
- ✅ Replaced fixed distribution table with dynamic weights table
- ✅ Added distribution examples for different meal counts
- ✅ Added `mealsPerDay` and `totalMeals` to output

---

## 🔧 Backend Implementation Changes Needed

### 1. Update `calculateDailyMacros` Endpoint

**Add parameter:**

```dart
class CalculateMacrosRequest {
  final int userId;
  final double weightKgs;
  final double heightMs;
  final int age;
  final String sex;
  final String activityLevel;
  final String bodyGoal;
  final List<String> mealTypes; // NEW
}
```

**Implement distribution logic:**

```dart
Map<String, double> calculateMealDistribution(List<String> mealTypes) {
  const weights = {
    'breakfast': 3.0,
    'brunch': 4.0,
    'lunch': 4.5,
    'snack': 1.0,
    'dinner': 3.5,
  };
  
  double totalWeight = mealTypes.fold(0.0, (sum, type) => sum + weights[type]!);
  
  Map<String, double> distribution = {};
  for (var mealType in mealTypes) {
    distribution[mealType] = (weights[mealType]! / totalWeight) * 100;
  }
  
  return distribution;
}
```

### 2. Update Validation

**Validate mealTypes:**

```dart
void validateMealTypes(List<String> mealTypes) {
  const validTypes = ['breakfast', 'brunch', 'lunch', 'snack', 'dinner'];
  
  // Check not empty
  if (mealTypes.isEmpty) {
    throw ValidationException('mealTypes cannot be empty');
  }
  
  // Check min/max
  if (mealTypes.length < 2 || mealTypes.length > 6) {
    throw ValidationException('mealTypes must contain 2-6 meals');
  }
  
  // Check valid values
  for (var type in mealTypes) {
    if (!validTypes.contains(type)) {
      throw ValidationException('Invalid meal type: $type');
    }
  }
  
  // Check no duplicates
  if (mealTypes.toSet().length != mealTypes.length) {
    throw ValidationException('mealTypes contains duplicates');
  }
}
```

### 3. Update Database Queries

**meal_plans table:** Already uses `meal_type` enum, just ensure it matches:

```sql
-- Your existing enum should be:
CREATE TYPE meal_plan_type AS ENUM ('breakfast', 'brunch', 'lunch', 'snack', 'dinner');
```

---

## 🧪 Testing Scenarios

### Test Case 1: Intermittent Fasting (2 meals)

```json
{
    "userId": 1,
    "weeks": 1,
    "mealTypes": ["lunch", "dinner"]
}
```

**Expected:** 14 meals total (7 days × 2 meals)

---

### Test Case 2: Standard (3 meals)

```json
{
    "userId": 1,
    "weeks": 2,
    "mealTypes": ["breakfast", "lunch", "dinner"]
}
```

**Expected:** 42 meals total (14 days × 3 meals)

---

### Test Case 3: Balanced (4 meals)

```json
{
    "userId": 1,
    "weeks": 2,
    "mealTypes": ["breakfast", "lunch", "snack", "dinner"]
}
```

**Expected:** 56 meals total (14 days × 4 meals)

---

### Test Case 4: Frequent (5 meals)

```json
{
    "userId": 1,
    "weeks": 1,
    "mealTypes": ["breakfast", "brunch", "lunch", "snack", "dinner"]
}
```

**Expected:** 35 meals total (7 days × 5 meals)

---

### Test Case 5: Invalid - Too Few

```json
{
    "userId": 1,
    "weeks": 1,
    "mealTypes": ["lunch"]
}
```

**Expected:** Error 400 - "mealTypes must contain 2-6 meals"

---

### Test Case 6: Invalid - Duplicates

```json
{
    "userId": 1,
    "weeks": 1,
    "mealTypes": ["breakfast", "breakfast", "lunch"]
}
```

**Expected:** Error 400 - "mealTypes contains duplicates"

---

### Test Case 7: Invalid - Wrong Value

```json
{
    "userId": 1,
    "weeks": 1,
    "mealTypes": ["desayuno", "almuerzo"]
}
```

**Expected:** Error 400 - "Invalid meal type: desayuno"

---

## 🎨 Frontend Changes Needed

### Meal Type Selector UI

Add a multi-select component for meal types:

```dart
class MealTypeSelector extends StatefulWidget {
  final List<String> selectedMealTypes;
  final Function(List<String>) onChanged;
  
  const MealTypeSelector({
    required this.selectedMealTypes,
    required this.onChanged,
  });
}

// Options to display:
const mealTypeOptions = [
  {'value': 'breakfast', 'label': 'Desayuno', 'icon': '🍳'},
  {'value': 'brunch', 'label': 'Brunch', 'icon': '🥐'},
  {'value': 'lunch', 'label': 'Almuerzo', 'icon': '🍽️'},
  {'value': 'snack', 'label': 'Merienda', 'icon': '🍎'},
  {'value': 'dinner', 'label': 'Cena', 'icon': '🌙'},
];
```

### Validation in UI

```dart
String? validateMealTypes(List<String> mealTypes) {
  if (mealTypes.isEmpty) {
    return 'Selecciona al menos 2 comidas';
  }
  if (mealTypes.length < 2) {
    return 'Selecciona al menos 2 comidas';
  }
  if (mealTypes.length > 6) {
    return 'Máximo 6 comidas por día';
  }
  return null;
}
```

---

## 📊 Impact Analysis

### Performance

- **No significant change** - Same number of API calls
- Tool calls vary based on meal count: ~6-8 calls per meal type per day

### Cost

- **Cost per plan scales with meals**:
  - 2 meals/day: ~$1.50 for 2 weeks
  - 4 meals/day: ~$2.50 for 2 weeks
  - 6 meals/day: ~$3.50 for 2 weeks

### Database

- **Storage varies linearly** with meal count
- Indexes remain the same
- No schema changes needed (enum already exists)

---

## ✅ Migration Checklist

- [ ] Update backend calculateDailyMacros endpoint
- [ ] Implement dynamic distribution algorithm
- [ ] Add mealTypes validation
- [ ] Update API documentation
- [ ] Update Serverpod protocol files
- [ ] Add frontend meal type selector
- [ ] Update frontend validation
- [ ] Write unit tests for distribution algorithm
- [ ] Write integration tests for all meal count scenarios
- [ ] Update n8n workflow (just add mealTypes to tool schema)
- [ ] Test with real users (different meal preferences)
- [ ] Update app onboarding to ask for meal preferences

---

## 🚀 Benefits of This Change

1. **Flexibility**: Users can match their eating schedule
2. **Intermittent Fasting**: Support for 2-meal plans
3. **Bodybuilding**: Support for 6-meal plans
4. **Personalization**: Better fits different lifestyles
5. **Cultural Adaptation**: Brunch option for weekend patterns
6. **Cost Efficiency**: Users only pay for meals they need

---

## 📚 Updated Documentation

All documentation files have been updated:

- ✅ user_prompt_template.md
- ✅ system_prompt.md
- ✅ api_endpoints.md
- ✅ tools_specification.md
- ✅ README.md

The n8n_setup_guide.md and other guides remain mostly the same, just need to
update tool schemas to include `mealTypes` parameter.

---

## 🎯 Next Steps

1. **Implement backend changes** (priority)
2. **Test distribution algorithm** with all scenarios
3. **Update n8n tool schemas** to include mealTypes
4. **Build frontend selector** for meal types
5. **Test end-to-end** with various meal configurations
6. **Gather user feedback** on flexibility
7. **Consider presets** (e.g., "Standard", "Intermittent Fasting",
   "Bodybuilder")

---

**Date Updated:** November 8, 2025\
**Version:** 2.0.0\
**Breaking Change:** Yes (requires `mealTypes` parameter)
