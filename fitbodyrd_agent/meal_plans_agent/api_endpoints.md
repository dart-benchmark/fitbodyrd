# API Endpoints Specification - Meal Plan Agent

Documentación detallada de todos los endpoints del backend que el agente de meal
plans necesita para funcionar.

## Base URL

```
Development: http://localhost:8080/api
Production: https://api.fitbodyrd.com/api
```

---

## 1. Get User Profile

Obtiene el perfil completo del usuario con todos los datos necesarios para crear
el plan nutricional.

### Endpoint

```
GET /users/{userId}/profile
```

### Path Parameters

| Parameter | Type    | Required | Description    |
| --------- | ------- | -------- | -------------- |
| userId    | integer | Yes      | ID del usuario |

### Response (200 OK)

```json
{
    "id": 123,
    "name": "Juan Pérez",
    "email": "juan.perez@email.com",
    "fullName": "Juan Alberto Pérez García",
    "birthDate": "1990-05-15",
    "age": 35,
    "sex": "male",
    "weightKgs": 85.5,
    "heightMs": 1.75,
    "bmi": 27.9,
    "weightCategory": "overweight",
    "bodyGoal": "loseWeight",
    "activityLevel": "moderatelyActive",
    "daysPerWeekExercise": 4,
    "timePerExerciseSessionMinutes": 60,
    "experienceLevel": "intermediate",
    "hasEquipment": true,
    "dietaryRestriction": "none"
}
```

### Response (404 Not Found)

```json
{
    "error": "User not found",
    "code": "USER_NOT_FOUND"
}
```

### Implementation Notes

- El campo `age` debe calcularse en el backend desde `birthDate`
- El campo `bmi` debe calcularse usando la fórmula: weight (kg) / (height (m))²
- El campo `weightCategory` clasifica el BMI: "underweight" (<18.5), "normal"
  (18.5-24.9), "overweight" (25-29.9), "obese" (≥30)
- `sex` debe estar en formato: "male", "female", "other" (según el enum Sex del
  servidor)
- Todos los campos del perfil son obligatorios para crear planes

---

## 2. Calculate Daily Macros

Calcula los requerimientos nutricionales diarios usando fórmulas de BMR y TDEE.

### Endpoint

```
POST /nutrition/calculate-macros
```

### Request Body

```json
{
    "userId": 123,
    "mealTypes": ["breakfast", "lunch", "snack", "dinner"]
}
```

### Request Body Schema

| Field     | Type          | Required | Description                                                                                                        |
| --------- | ------------- | -------- | ------------------------------------------------------------------------------------------------------------------ |
| userId    | integer       | Yes      | ID del usuario                                                                                                     |
| mealTypes | array[string] | Yes      | Lista de tipos de comidas (2-5 comidas diferentes). Valores: breakfast, brunch, lunch, snack, dinner. Sin repetir. |

### Response (200 OK)

```json
{
    "bmr": 1850.5,
    "tdee": 2870.0,
    "targetCalories": 2370.0,
    "caloricAdjustment": -500,
    "dailyProteins": 177.75,
    "dailyCarbs": 237.0,
    "dailyFats": 79.0,
    "proteinPercentage": 30,
    "carbsPercentage": 40,
    "fatsPercentage": 30,
    "proteinGramsPerKg": 2.08,
    "mealDistribution": {
        "breakfast": {
            "calories": 592.5,
            "proteins": 44.44,
            "carbs": 59.25,
            "fats": 19.75,
            "percentage": 25.0
        },
        "lunch": {
            "calories": 888.75,
            "proteins": 66.66,
            "carbs": 88.88,
            "fats": 23.7,
            "percentage": 37.5
        },
        "snack": {
            "calories": 196.71,
            "proteins": 14.75,
            "carbs": 19.66,
            "fats": 6.56,
            "percentage": 8.3
        },
        "dinner": {
            "calories": 692.04,
            "proteins": 51.90,
            "carbs": 69.21,
            "fats": 23.10,
            "percentage": 29.2
        }
    }
}
```

### Response (404 Not Found)

```json
{
    "error": "User not found",
    "code": "USER_NOT_FOUND"
}
```

### Implementation Notes

- El backend debe obtener todos los datos del perfil del usuario desde la base
  de datos usando `userId`
- Los campos requeridos del perfil son: `weightKgs`, `heightMs`, `age`, `sex`,
  `activityLevel`, `bodyGoal`
- Si el perfil del usuario está incompleto, retornar error 400 con
  `code: "INCOMPLETE_PROFILE"`
- `mealTypes` debe contener entre 2 y 5 comidas **diferentes**. Si está fuera de
  este rango, retornar error 400 con `code: "INVALID_MEAL_TYPES_COUNT"`
- `mealTypes` **no debe contener valores duplicados**. Si hay duplicados,
  retornar error 400 con `code: "DUPLICATE_MEAL_TYPES"`
- Los únicos valores válidos son: `breakfast`, `brunch`, `lunch`, `snack`,
  `dinner`

### Implementation Logic

**BMR Calculation (Mifflin-St Jeor):**

```
Hombres: BMR = (10 × peso_kg) + (6.25 × altura_cm) - (5 × edad) + 5
Mujeres: BMR = (10 × peso_kg) + (6.25 × altura_cm) - (5 × edad) - 161
```

**TDEE Calculation:**

```
TDEE = BMR × Activity Factor

Activity Factors:
- sedentary: 1.2
- lightlyActive: 1.375
- moderatelyActive: 1.55
- active: 1.725
- veryActive: 1.9
```

**Caloric Adjustment by Goal:**

```
loseWeight: TDEE - 500 calories (déficit)
maintainWeight: TDEE (mantenimiento)
gainMuscleMass: TDEE + 300 calories (superávit)
```

**Macro Distribution by Goal:**

```
loseWeight: 30% P / 40% C / 30% F
maintainWeight: 25% P / 45% C / 30% F
gainMuscleMass: 30% P / 45% C / 25% F
```

**Dynamic Meal Distribution:**

The distribution must be calculated based on the `mealTypes` array using
relative weights:

```
Meal Type Weights:
- breakfast: 3.0
- brunch: 4.0
- lunch: 4.5
- snack: 1.0
- dinner: 3.5

Formula:
1. totalWeight = sum(weight for each mealType)
2. For each meal: percentage = (weight / totalWeight) × 100
3. meal_calories = dailyCalories × (percentage / 100)
4. meal_proteins = dailyProteins × (percentage / 100)
5. meal_carbs = dailyCarbs × (percentage / 100)
6. meal_fats = dailyFats × (percentage / 100)

Example for ["breakfast", "lunch", "snack", "dinner"]:
- totalWeight = 3.0 + 4.5 + 1.0 + 3.5 = 12.0
- breakfast: 3.0/12.0 = 25.0%
- lunch: 4.5/12.0 = 37.5%
- snack: 1.0/12.0 = 8.3%
- dinner: 3.5/12.0 = 29.2%
```

---

## 3. Get Food Categories

Obtiene todas las categorías de alimentos disponibles.

### Endpoint

```
GET /foods/categories
```

### Query Parameters

Ninguno

### Response (200 OK)

```json
{
    "categories": [
        {
            "id": 1,
            "name": "Frutas",
            "slug": "frutas",
            "parentCategoryId": null,
            "iconName": "fruit",
            "colorHex": "#FF6B6B",
            "displayOrder": 1
        },
        {
            "id": 2,
            "name": "Verduras",
            "slug": "verduras",
            "parentCategoryId": null,
            "iconName": "vegetable",
            "colorHex": "#51CF66",
            "displayOrder": 2
        },
        {
            "id": 3,
            "name": "Proteínas",
            "slug": "proteinas",
            "parentCategoryId": null,
            "iconName": "meat",
            "colorHex": "#FF8787",
            "displayOrder": 3
        }
    ]
}
```

### Implementation Notes

- Retornar solo categorías de nivel superior (parentCategoryId = null)
- Ordenar por `displayOrder` ASC
- Incluir solo categorías que tengan alimentos activos

---

## 4. Search Foods by Category

Busca alimentos dentro de una categoría aplicando filtros.

### Endpoint

```
POST /foods/search-by-category
```

### Request Body

```json
{
    "categoryId": 3,
    "dietaryRestriction": "none",
    "isLocalOnly": true,
    "excludeFoodIds": [45, 67, 89],
    "limit": 20
}
```

### Request Body Schema

| Field              | Type       | Required | Default | Description                       |
| ------------------ | ---------- | -------- | ------- | --------------------------------- |
| categoryId         | integer    | Yes      | -       | ID de la categoría                |
| dietaryRestriction | string     | No       | "none"  | Restricción dietética del usuario |
| isLocalOnly        | boolean    | No       | true    | Solo alimentos locales            |
| excludeFoodIds     | array[int] | No       | []      | IDs de alimentos a excluir        |
| limit              | integer    | No       | 20      | Máximo de resultados              |

### Response (200 OK)

```json
{
    "foods": [
        {
            "id": 101,
            "name": "Pechuga de Pollo",
            "categoryId": 3,
            "categoryName": "Proteínas",
            "calories": 165.0,
            "proteins": 31.0,
            "carbs": 0.0,
            "fats": 3.6,
            "fiber": 0.0,
            "isLocal": true,
            "imageUrl": "https://example.com/pollo.jpg",
            "brand": "",
            "barcode": "POLLO-001",
            "servingSizes": [
                {
                    "id": 1001,
                    "servingName": "1 pechuga mediana",
                    "grams": 150.0,
                    "isDefault": true
                },
                {
                    "id": 1002,
                    "servingName": "100g",
                    "grams": 100.0,
                    "isDefault": false
                }
            ]
        }
    ],
    "totalCount": 45
}
```

### Dietary Restriction Filters

**Vegetarian:** Excluir categorías: Carnes, Pollo, Pescado, Mariscos

**Vegan:** Excluir categorías: Carnes, Pollo, Pescado, Mariscos, Lácteos,
Huevos, Miel

**Keto:** Priorizar alimentos con: `carbs < 10g per 100g`, `fats > 15g per 100g`

**Paleo:** Excluir categorías: Granos, Lácteos, Legumbres, Azúcares procesados

**Pescatarian:** Excluir categorías: Carnes rojas, Pollo, Cerdo (permitir
Pescado/Mariscos)

### Implementation Notes

- Solo retornar alimentos activos (`isActive = true`). Los alimentos inactivos
  nunca deben incluirse en los resultados
- Todos los valores nutricionales son **por 100g**
- Incluir SIEMPRE el array `servingSizes` con cada alimento
- Al menos un servingSize debe tener `isDefault: true`
- Ordenar resultados por: favoritos primero, luego por nombre

---

## 5. Get User Food Preferences

Obtiene las preferencias alimenticias del usuario.

### Endpoint

```
GET /users/{userId}/food-preferences
```

### Path Parameters

| Parameter | Type    | Required | Description    |
| --------- | ------- | -------- | -------------- |
| userId    | integer | Yes      | ID del usuario |

### Response (200 OK)

```json
{
    "preferences": [
        {
            "id": 1,
            "userId": 123,
            "foodId": 45,
            "foodName": "Camarones",
            "preferenceType": "alergia",
            "notes": "Alergia severa a mariscos"
        },
        {
            "id": 2,
            "userId": 123,
            "foodId": 67,
            "foodName": "Leche entera",
            "preferenceType": "intolerancia",
            "notes": "Intolerancia a la lactosa"
        },
        {
            "id": 3,
            "userId": 123,
            "foodId": 89,
            "foodName": "Brócoli",
            "preferenceType": "excluir",
            "notes": "No me gusta el sabor"
        },
        {
            "id": 4,
            "userId": 123,
            "foodId": 112,
            "foodName": "Aguacate",
            "preferenceType": "favorito",
            "notes": "Me encanta, incluir frecuentemente"
        }
    ],
    "excludedFoodIds": [45, 67, 89],
    "favoriteFoodIds": [112],
    "allergyFoodIds": [45],
    "intoleranceFoodIds": [67]
}
```

### Response (200 OK - Sin preferencias)

```json
{
    "preferences": [],
    "excludedFoodIds": [],
    "favoriteFoodIds": [],
    "allergyFoodIds": [],
    "intoleranceFoodIds": []
}
```

### Implementation Notes

- Los arrays `excludedFoodIds`, `allergyFoodIds`, `intoleranceFoodIds` deben
  combinarse para exclusión total
- Nunca incluir estos alimentos en ningún plan
- `favoriteFoodIds` son sugerencias, no obligatorios

---

## 6. Create Nutrition Plan

Crea el registro base del plan nutricional.

### Endpoint

```
POST /nutrition-plans
```

### Request Body

```json
{
    "userId": 123,
    "startDate": "2025-11-08",
    "endDate": "2025-11-21",
    "dailyCalories": 2370,
    "dailyProteins": 177.75,
    "dailyCarbs": 237.0,
    "dailyFats": 79.0
}
```

### Request Body Schema

| Field         | Type    | Required | Description                        |
| ------------- | ------- | -------- | ---------------------------------- |
| userId        | integer | Yes      | ID del usuario                     |
| startDate     | date    | Yes      | Fecha de inicio (ISO 8601)         |
| endDate       | date    | Yes      | Fecha de fin (ISO 8601)            |
| dailyCalories | integer | Yes      | Calorías objetivo diarias          |
| dailyProteins | decimal | Yes      | Proteínas objetivo diarias (g)     |
| dailyCarbs    | decimal | Yes      | Carbohidratos objetivo diarios (g) |
| dailyFats     | decimal | Yes      | Grasas objetivo diarias (g)        |

### Response (201 Created)

```json
{
    "id": 456,
    "userId": 123,
    "startDate": "2025-11-08",
    "endDate": "2025-11-21",
    "dailyCalories": 2370,
    "dailyProteins": 177.75,
    "dailyCarbs": 237.0,
    "dailyFats": 79.0,
    "status": "activo",
    "createdAt": "2025-11-08T10:30:00Z"
}
```

### Response (400 Bad Request)

```json
{
    "error": "Invalid date range",
    "code": "INVALID_DATE_RANGE",
    "details": "endDate must be after startDate"
}
```

### Validation Rules

- `startDate` no puede ser en el pasado (excepto hoy)
- `endDate` debe ser después de `startDate`
- `dailyCalories` debe estar entre 1200-5000
- Macros deben sumar aproximadamente las calorías: (P×4 + C×4 + F×9) ≈ calories
  ±10%

---

## 7. Create Meal Plan Day

Crea un día completo del plan con todas sus comidas y alimentos.

### Endpoint

```
POST /nutrition-plans/{nutritionPlanId}/days
```

### Path Parameters

| Parameter       | Type    | Required | Description           |
| --------------- | ------- | -------- | --------------------- |
| nutritionPlanId | integer | Yes      | ID del nutrition plan |

### Request Body

```json
{
  "nutritionPlanId": 456,
  "date": "2025-11-08",
  "dayNumber": 1,
  "meals": [
    {
      "mealType": "breakfast",
      "targetCalories": 592.5,
      "targetProteins": 44.44,
      "targetCarbs": 71.1,
      "targetFats": 19.75,
      "foods": [
        {
          "foodId": 15,
          "foodName": "Avena",
          "quantityGrams": 80.0,
          "servingSizeId": 150,
          "servingQuantity": 0.8,
          "calories": 304.0,
          "proteins": 10.8,
          "carbs": 54.4,
          "fats": 5.6
        },
        {
          "foodId": 102,
          "foodName": "Huevos",
          "quantityGrams": 150.0,
          "servingSizeId": 1004,
          "servingQuantity": 1.5,
          "calories": 232.5,
          "proteins": 19.5,
          "carbs": 1.65,
          "fats": 16.5
        }
      ]
    },
    {
      "mealType": "lunch",
      "targetCalories": 829.5,
      "targetProteins": 62.21,
      "targetCarbs": 82.95,
      "targetFats": 23.7,
      "foods": [...]
    },
    {
      "mealType": "snack",
      "targetCalories": 196.71,
      "targetProteins": 14.75,
      "targetCarbs": 19.66,
      "targetFats": 6.56,
      "foods": [...]
    },
    {
      "mealType": "dinner",
      "targetCalories": 692.04,
      "targetProteins": 51.90,
      "targetCarbs": 69.21,
      "targetFats": 23.10,
      "foods": [...]
    }
  ]
}
```

### Request Body Schema

**Root Level:**

| Field           | Type        | Required | Description                          |
| --------------- | ----------- | -------- | ------------------------------------ |
| nutritionPlanId | integer     | Yes      | ID del plan nutricional              |
| date            | date        | Yes      | Fecha del día (ISO 8601)             |
| dayNumber       | integer     | Yes      | Número de día (1-N)                  |
| meals           | array[Meal] | Yes      | Array de comidas (2-5 según el plan) |

**Meal Object:**

| Field          | Type        | Required | Description                                          |
| -------------- | ----------- | -------- | ---------------------------------------------------- |
| mealType       | string      | Yes      | Tipo de comida (breakfast/brunch/lunch/snack/dinner) |
| targetCalories | decimal     | Yes      | Calorías objetivo de la comida                       |
| targetProteins | decimal     | Yes      | Proteínas objetivo (g)                               |
| targetCarbs    | decimal     | Yes      | Carbohidratos objetivo (g)                           |
| targetFats     | decimal     | Yes      | Grasas objetivo (g)                                  |
| foods          | array[Food] | Yes      | Array de alimentos (min 1)                           |

**Food Object:**

| Field           | Type    | Required | Description                  |
| --------------- | ------- | -------- | ---------------------------- |
| foodId          | integer | Yes      | ID del alimento              |
| foodName        | string  | Yes      | Nombre del alimento          |
| quantityGrams   | decimal | Yes      | Cantidad en gramos           |
| servingSizeId   | integer | Yes      | ID del serving size usado    |
| servingQuantity | decimal | Yes      | Cantidad de porciones        |
| calories        | decimal | Yes      | Calorías calculadas          |
| proteins        | decimal | Yes      | Proteínas calculadas (g)     |
| carbs           | decimal | Yes      | Carbohidratos calculados (g) |
| fats            | decimal | Yes      | Grasas calculadas (g)        |

### Response (201 Created)

```json
{
    "success": true,
    "dayNumber": 1,
    "date": "2025-11-08",
    "mealsCreated": 4,
    "totalFoodsAdded": 13,
    "actualTotals": {
        "calories": 2362.0,
        "proteins": 176.58,
        "carbs": 239.13,
        "fats": 77.68
    },
    "variance": {
        "calories": -0.34,
        "proteins": -0.66,
        "carbs": 0.90,
        "fats": -1.67
    },
    "mealPlanIds": [
        {
            "mealType": "breakfast",
            "mealPlanId": 1001
        },
        {
            "mealType": "lunch",
            "mealPlanId": 1002
        },
        {
            "mealType": "snack",
            "mealPlanId": 1003
        },
        {
            "mealType": "dinner",
            "mealPlanId": 1004
        }
    ]
}
```

### Database Operations

Este endpoint debe crear:

1. **N registros en `meal_plans`** (uno por cada comida en el array meals, 2-5
   comidas)
   ```sql
   INSERT INTO meal_plans (nutrition_plan_id, date, meal_type)
   VALUES (456, '2025-11-08', 'breakfast'), ...
   ```

2. **N registros en `meal_plan_foods`** (uno por cada alimento)
   ```sql
   INSERT INTO meal_plan_foods (meal_plan_id, food_id, quantity, is_user_modified, was_user_deleted)
   VALUES (1001, 15, 80.0, false, false), ...
   ```

### Validation Rules

- `date` debe estar dentro del rango del nutrition_plan (startDate - endDate)
- `dayNumber` debe ser único por nutrition_plan
- Deben incluirse entre 2 y 5 meals, coincidiendo con los mealTypes definidos en
  el nutrition plan
- Los `mealType` en el request deben coincidir exactamente con los definidos en
  el nutrition plan
- Cada meal debe tener al menos 1 food
- `foodId` debe existir y estar activo
- `servingSizeId` debe pertenecer al `foodId` especificado

---

## 8. Update Meal Plan Progress

Actualiza el progreso de generación del plan nutricional.

### Endpoint

```
POST /nutrition-plans/{nutritionPlanId}/progress
```

### Path Parameters

| Parameter       | Type    | Required | Description             |
| --------------- | ------- | -------- | ----------------------- |
| nutritionPlanId | integer | Yes      | ID del plan nutricional |

### Request Body

```json
{
    "userId": 123,
    "nutritionPlanId": 456,
    "currentDay": 5,
    "totalDays": 14,
    "status": "waiting",
    "message": "Creando día 5 de 14..."
}
```

### Request Body Schema

| Field           | Type    | Required | Description                                 |
| --------------- | ------- | -------- | ------------------------------------------- |
| userId          | integer | Yes      | ID del usuario                              |
| nutritionPlanId | integer | Yes      | ID del plan                                 |
| currentDay      | integer | Yes      | Día actual procesado                        |
| totalDays       | integer | Yes      | Total de días del plan                      |
| status          | string  | Yes      | waiting/completed/error (StreamStatus enum) |
| message         | string  | Yes      | Mensaje para el usuario                     |

### Response (200 OK)

```json
{
    "success": true,
    "progressPercentage": 35.71,
    "currentDay": 5,
    "totalDays": 14,
    "status": "waiting",
    "updatedAt": "2025-11-08T10:35:22Z"
}
```

### Status Values (StreamStatus enum)

- `"waiting"`: Plan en proceso de creación
- `"completed"`: Plan completado exitosamente
- `"error"`: Error durante la generación

### Implementation Notes

- Este endpoint puede actualizar un campo en `nutrition_plans` o una tabla
  separada `nutrition_plan_progress`
- El frontend debe hacer polling de este endpoint para mostrar progreso en
  tiempo real
- `progressPercentage = (currentDay / totalDays) × 100`

### Suggested Table Schema (opcional)

```sql
CREATE TABLE nutrition_plan_progress (
  id INTEGER PRIMARY KEY,
  nutrition_plan_id INTEGER REFERENCES nutrition_plans(id),
  current_day INTEGER NOT NULL,
  total_days INTEGER NOT NULL,
  status VARCHAR(20) NOT NULL,
  message TEXT,
  progress_percentage DECIMAL(5,2),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

---

## Error Responses

### Standard Error Format

```json
{
    "error": "Error message",
    "code": "ERROR_CODE",
    "details": "Additional details about the error"
}
```

### Common Error Codes

| Code                     | HTTP Status | Description                                            |
| ------------------------ | ----------- | ------------------------------------------------------ |
| USER_NOT_FOUND           | 404         | Usuario no existe                                      |
| FOOD_NOT_FOUND           | 404         | Alimento no existe                                     |
| NUTRITION_PLAN_NOT_FOUND | 404         | Plan nutricional no existe                             |
| INVALID_DATE_RANGE       | 400         | Rango de fechas inválido                               |
| INVALID_MACROS           | 400         | Macros no suman correctamente                          |
| DUPLICATE_DAY            | 409         | Día ya existe en el plan                               |
| INSUFFICIENT_FOODS       | 422         | No hay suficientes alimentos que cumplan restricciones |
| VALIDATION_ERROR         | 400         | Error de validación de datos                           |
| SERVER_ERROR             | 500         | Error interno del servidor                             |

---

## Rate Limiting

Sugiero implementar rate limiting para proteger el backend:

```
- /nutrition/calculate-macros: 10 requests/minute por IP
- /nutrition-plans (POST): 5 requests/minute por usuario
- /nutrition-plans/{id}/days (POST): 30 requests/minute por plan
- Otros endpoints: 100 requests/minute por IP
```

---

## Authentication

Todos los endpoints requieren autenticación JWT:

```
Headers:
Authorization: Bearer {jwt_token}
```

El token debe incluir el `userId` en el payload. El backend debe validar que el
usuario autenticado coincide con el `userId` en las requests.

---

## Database Indexes Recommended

Para optimizar performance del agente:

```sql
-- Búsqueda de alimentos
CREATE INDEX idx_foods_category ON foods(category_id);
CREATE INDEX idx_foods_active ON foods(is_active);
CREATE INDEX idx_foods_local ON foods(is_local);
CREATE INDEX idx_foods_name ON foods(name);

-- Serving sizes
CREATE INDEX idx_serving_sizes_food ON food_serving_sizes(food_id);

-- Preferencias
CREATE INDEX idx_preferences_user ON user_food_preferences(user_id);
CREATE INDEX idx_preferences_food ON user_food_preferences(food_id);

-- Meal plans
CREATE INDEX idx_meal_plans_nutrition_plan ON meal_plans(nutrition_plan_id);
CREATE INDEX idx_meal_plans_date ON meal_plans(date);
CREATE INDEX idx_meal_plan_foods_meal ON meal_plan_foods(meal_plan_id);
CREATE INDEX idx_meal_plan_foods_food ON meal_plan_foods(food_id);
```

---

## Testing Endpoints

Sugiero crear estos endpoints adicionales para testing:

### Get Nutrition Plan Details

```
GET /nutrition-plans/{nutritionPlanId}
```

Retorna el plan completo con todos sus días y comidas.

### Delete Nutrition Plan

```
DELETE /nutrition-plans/{nutritionPlanId}
```

Elimina un plan (soft delete) para testing.

### Validate Meal Plan Day

```
POST /nutrition-plans/validate-day
```

Valida un día antes de guardarlo (para testing del agente).

---

## Performance Considerations

**Expected Load:**

- Plan de 2 semanas = ~100-130 API calls
- Tiempo estimado: 2-3 minutos (con delays entre días)
- Concurrent plans: máximo 10 usuarios simultáneos

**Optimization Tips:**

1. Cache food categories (cambian raramente)
2. Batch insert para meal_plan_foods (múltiples alimentos a la vez)
3. Use database transactions para createMealPlanDay
4. Index all foreign keys
5. Consider read replicas for food searches

---

## Webhook for Progress (Optional)

En lugar de polling, considera un webhook para notificar progreso:

```
POST https://n8n.yourserver.com/webhook/meal-plan-progress
```

El backend puede notificar n8n cada vez que se completa un día, y n8n puede
actualizar al usuario vía push notification.
