# Tools Specification - Meal Plan Agent

Especificación detallada de cada tool que el agente necesita, incluyendo
descripción, input, output y ejemplos.

---

## 1. getUserProfile

**Descripción**: Obtiene el perfil completo del usuario con todos los datos
necesarios para calcular requerimientos nutricionales y respetar preferencias.

**Endpoint**: `GET /api/users/{userId}/profile`

**Input**:

```json
{
    "userId": 123
}
```

**Output**:

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
    "bodyGoal": "loseWeight",
    "activityLevel": "moderatelyActive",
    "daysPerWeekExercise": 4,
    "timePerExerciseSessionMinutes": 60,
    "experienceLevel": "intermediate",
    "hasEquipment": true,
    "dietaryRestriction": "none"
}
```

**Uso**: Llamar al inicio del flujo para obtener todos los datos del usuario
necesarios para crear el plan.

---

## 2. calculateDailyMacros

**Descripción**: Calcula los requerimientos nutricionales diarios del usuario
basado en su perfil (BMR, TDEE) y ajusta según su objetivo (déficit/superávit
calórico). Retorna calorías y macronutrientes distribuidos de forma óptima.

**Endpoint**: `POST /api/nutrition/calculate-macros`

**Input**:

```json
{
    "userId": 123,
    "mealTypes": ["breakfast", "lunch", "snack", "dinner"]
}
```

**Nota:** El backend obtiene automáticamente todos los datos del perfil del
usuario (weightKgs, heightMs, age, sex, activityLevel, bodyGoal) desde la base
de datos usando el `userId`.

**Output**:

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

**Uso**: Llamar después de obtener el perfil del usuario para calcular los
objetivos nutricionales del plan.

**Fórmulas aplicadas**:

- **BMR (Hombres)**: (10 × peso_kg) + (6.25 × altura_cm) - (5 × edad) + 5
- **BMR (Mujeres)**: (10 × peso_kg) + (6.25 × altura_cm) - (5 × edad) - 161
- **TDEE**: BMR × Factor de actividad
  - Sedentary: 1.2
  - Lightly Active: 1.375
  - Moderately Active: 1.55
  - Active: 1.725
  - Very Active: 1.9

---

## 3. getFoodCategories

**Descripción**: Obtiene todas las categorías de alimentos disponibles en la
base de datos para organizar la búsqueda de alimentos por tipo.

**Endpoint**: `GET /api/foods/categories`

**Input**: Ninguno

**Output**:

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
        },
        {
            "id": 4,
            "name": "Carbohidratos",
            "slug": "carbohidratos",
            "parentCategoryId": null,
            "iconName": "grain",
            "colorHex": "#FFD43B",
            "displayOrder": 4
        },
        {
            "id": 5,
            "name": "Lácteos",
            "slug": "lacteos",
            "parentCategoryId": null,
            "iconName": "dairy",
            "colorHex": "#74C0FC",
            "displayOrder": 5
        },
        {
            "id": 6,
            "name": "Grasas Saludables",
            "slug": "grasas-saludables",
            "parentCategoryId": null,
            "iconName": "oil",
            "colorHex": "#FFD700",
            "displayOrder": 6
        }
    ]
}
```

**Uso**: Llamar una vez al inicio para tener el catálogo de categorías y poder
buscar alimentos organizadamente.

---

## 4. searchFoodsByCategory

**Descripción**: Busca alimentos dentro de una categoría específica, aplicando
filtros por restricciones dietéticas y preferencia por alimentos locales.
Retorna alimentos con sus macronutrientes y tamaños de porción.

**Endpoint**: `POST /api/foods/search-by-category`

**Input**:

```json
{
    "categoryId": 3,
    "dietaryRestriction": "none",
    "isLocalOnly": true,
    "excludeFoodIds": [45, 67, 89],
    "limit": 20
}
```

**Nota:** El backend siempre filtra automáticamente por `isActive = true`. Los
alimentos inactivos nunca se incluyen en los resultados.

**Output**:

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
        },
        {
            "id": 102,
            "name": "Huevos",
            "categoryId": 3,
            "categoryName": "Proteínas",
            "calories": 155.0,
            "proteins": 13.0,
            "carbs": 1.1,
            "fats": 11.0,
            "fiber": 0.0,
            "isLocal": true,
            "imageUrl": "https://example.com/huevos.jpg",
            "brand": "",
            "barcode": "HUEVO-001",
            "servingSizes": [
                {
                    "id": 1003,
                    "servingName": "1 unidad grande",
                    "grams": 50.0,
                    "isDefault": true
                },
                {
                    "id": 1004,
                    "servingName": "2 unidades",
                    "grams": 100.0,
                    "isDefault": false
                }
            ]
        }
    ],
    "totalCount": 45
}
```

**Parámetros**:

- `categoryId`: ID de la categoría a buscar
- `dietaryRestriction`: Filtrar alimentos incompatibles con la restricción
- `isLocalOnly`: Si true, solo retorna alimentos con `is_local=true`
- `excludeFoodIds`: Array de IDs de alimentos a excluir (para evitar repetición)
- `limit`: Cantidad máxima de resultados

**Uso**: Llamar múltiples veces durante la creación del plan para obtener
alimentos de diferentes categorías según la comida que se está armando.

---

## 5. getUserFoodPreferences

**Descripción**: Obtiene las preferencias alimenticias del usuario (favoritos,
exclusiones, alergias, intolerancias) para respetarlas al crear el plan.

**Endpoint**: `GET /api/users/{userId}/food-preferences`

**Input**:

```json
{
    "userId": 123
}
```

**Output**:

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

**Uso**: Llamar al inicio del flujo para obtener las restricciones y
preferencias que se deben aplicar durante toda la creación del plan.

---

## 6. createNutritionPlan

**Descripción**: Crea el registro base del plan nutricional en la tabla
`nutrition_plans` con las fechas y objetivos macro. Este es el contenedor
principal que agrupa todos los días del plan.

**Endpoint**: `POST /api/nutrition-plans`

**Input**:

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

**Output**:

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

**Uso**: Llamar después de calcular los macros diarios y antes de empezar a
crear los días individuales del plan.

**Nota sobre mealTypes:** El array `mealTypes` en `calculateDailyMacros` debe
contener entre 2 y 5 tipos de comidas **diferentes** (sin repetir). Los valores
permitidos son: `breakfast`, `brunch`, `lunch`, `snack`, `dinner`. Cada valor
solo puede aparecer una vez en el array.

---

## 7. createMealPlanDay

**Descripción**: Crea un día completo del plan de comidas con todas las comidas
(desayuno, almuerzo, cena, snacks) y sus alimentos correspondientes. Crea
registros en `meal_plans` y `meal_plan_foods`. Este es el tool más complejo y
crítico del agente.

**Endpoint**: `POST /api/nutrition-plans/{nutritionPlanId}/days`

**Input**:

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
                    "foodId": 23,
                    "foodName": "Plátano maduro",
                    "quantityGrams": 118.0,
                    "servingSizeId": 230,
                    "servingQuantity": 1.0,
                    "calories": 105.0,
                    "proteins": 1.3,
                    "carbs": 27.0,
                    "fats": 0.4
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
            "foods": [
                {
                    "foodId": 101,
                    "foodName": "Pechuga de Pollo",
                    "quantityGrams": 180.0,
                    "servingSizeId": 1001,
                    "servingQuantity": 1.2,
                    "calories": 297.0,
                    "proteins": 55.8,
                    "carbs": 0.0,
                    "fats": 6.48
                },
                {
                    "foodId": 45,
                    "foodName": "Arroz blanco cocido",
                    "quantityGrams": 200.0,
                    "servingSizeId": 450,
                    "servingQuantity": 1.27,
                    "calories": 260.0,
                    "proteins": 5.4,
                    "carbs": 56.0,
                    "fats": 0.6
                },
                {
                    "foodId": 78,
                    "foodName": "Habichuelas rojas",
                    "quantityGrams": 100.0,
                    "servingSizeId": 780,
                    "servingQuantity": 1.0,
                    "calories": 127.0,
                    "proteins": 8.7,
                    "carbs": 22.8,
                    "fats": 0.5
                },
                {
                    "foodId": 92,
                    "foodName": "Ensalada mixta",
                    "quantityGrams": 150.0,
                    "servingSizeId": 920,
                    "servingQuantity": 1.0,
                    "calories": 45.0,
                    "proteins": 2.1,
                    "carbs": 8.5,
                    "fats": 0.5
                },
                {
                    "foodId": 112,
                    "foodName": "Aguacate",
                    "quantityGrams": 50.0,
                    "servingSizeId": 1120,
                    "servingQuantity": 0.5,
                    "calories": 80.0,
                    "proteins": 1.0,
                    "carbs": 4.3,
                    "fats": 7.3
                }
            ]
        },
        {
            "mealType": "dinner",
            "targetCalories": 711.0,
            "targetProteins": 53.33,
            "targetCarbs": 59.25,
            "targetFats": 23.7,
            "foods": [
                {
                    "foodId": 135,
                    "foodName": "Salmón",
                    "quantityGrams": 150.0,
                    "servingSizeId": 1350,
                    "servingQuantity": 1.0,
                    "calories": 312.0,
                    "proteins": 39.0,
                    "carbs": 0.0,
                    "fats": 18.0
                },
                {
                    "foodId": 56,
                    "foodName": "Batata asada",
                    "quantityGrams": 200.0,
                    "servingSizeId": 560,
                    "servingQuantity": 1.0,
                    "calories": 180.0,
                    "proteins": 4.0,
                    "carbs": 41.4,
                    "fats": 0.3
                },
                {
                    "foodId": 88,
                    "foodName": "Brócoli al vapor",
                    "quantityGrams": 150.0,
                    "servingSizeId": 880,
                    "servingQuantity": 1.5,
                    "calories": 51.0,
                    "proteins": 4.3,
                    "carbs": 10.0,
                    "fats": 0.6
                }
            ]
        },
        {
            "mealType": "snack",
            "targetCalories": 118.5,
            "targetProteins": 8.89,
            "targetCarbs": 11.85,
            "targetFats": 5.93,
            "foods": [
                {
                    "foodId": 200,
                    "foodName": "Yogur griego natural",
                    "quantityGrams": 100.0,
                    "servingSizeId": 2000,
                    "servingQuantity": 1.0,
                    "calories": 97.0,
                    "proteins": 10.0,
                    "carbs": 3.6,
                    "fats": 5.0
                },
                {
                    "foodId": 23,
                    "foodName": "Plátano maduro",
                    "quantityGrams": 59.0,
                    "servingSizeId": 230,
                    "servingQuantity": 0.5,
                    "calories": 52.5,
                    "proteins": 0.65,
                    "carbs": 13.5,
                    "fats": 0.2
                }
            ]
        }
    ]
}
```

**Output**:

```json
{
  "success": true,
  "dayNumber": 1,
  "date": "2025-11-08",
  "mealsCreated": 4,
  "totalFoodsAdded": 11,
  "actualTotals": {
    "calories": 2362.0,
    "proteins": 176.58,
    "carbs": 239.13,
    "fats": 77.68
  },
  "variance": {
    "calories": -0.34,
    "proteins": -0.66,
    "carbs": +0.90,
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

**Uso**: Llamar una vez por cada día del plan (en un loop). El agente debe crear
progresivamente cada día y esperar la confirmación antes de proceder al
siguiente.

**Consideraciones importantes**:

- El agente es responsable de seleccionar los alimentos y calcular las porciones
- Debe aplicar lógica de variedad (tracking de alimentos usados previamente)
- Debe aplicar lógica de preferencias (favoritos, exclusiones)
- Debe ajustar porciones para acercarse a los macros objetivo (±10% tolerancia)
- Debe usar serving_sizes reales de la base de datos

---

## 8. updateMealPlanProgress

**Descripción**: Actualiza el progreso de creación del plan nutricional para que
la app pueda mostrar feedback en tiempo real al usuario. Esto mejora la UX
durante la generación del plan.

**Endpoint**: `POST /api/nutrition-plans/{nutritionPlanId}/progress`

**Input**:

```json
{
    "nutritionPlanId": 456,
    "currentDay": 5,
    "totalDays": 14,
    "status": "generando",
    "message": "Creando día 5 de 14..."
}
```

**Output**:

```json
{
    "success": true,
    "progressPercentage": 35.71,
    "currentDay": 5,
    "totalDays": 14,
    "status": "generando",
    "updatedAt": "2025-11-08T10:35:22Z"
}
```

**Uso**: Llamar después de crear cada día exitosamente para actualizar el
progreso. También llamar al final con `status: "completado"`.

**Estados posibles**:

- `"generando"`: Plan en proceso de creación
- `"completado"`: Plan completado exitosamente
- `"error"`: Error durante la generación

---

## Resumen de Flujo de Tools

```
1. getUserProfile(userId)
2. calculateDailyMacros(profile data)
3. getFoodCategories()
4. getUserFoodPreferences(userId)
5. createNutritionPlan(userId, dates, macros)
6. Loop for cada día:
   a. searchFoodsByCategory() - múltiples veces para diferentes categorías
   b. [Agente selecciona y calcula porciones internamente]
   c. createMealPlanDay(nutritionPlanId, date, meals)
   d. updateMealPlanProgress(nutritionPlanId, progress)
7. updateMealPlanProgress(nutritionPlanId, status: "completado")
```

**Cantidad total de llamadas para plan de 2 semanas**:

- getUserProfile: 1
- calculateDailyMacros: 1
- getFoodCategories: 1
- getUserFoodPreferences: 1
- createNutritionPlan: 1
- searchFoodsByCategory: ~70-100 (5-7 por día × 14 días)
- createMealPlanDay: 14 (uno por día)
- updateMealPlanProgress: 15 (uno por día + uno final)

**Total: ~103-133 llamadas de tools**
