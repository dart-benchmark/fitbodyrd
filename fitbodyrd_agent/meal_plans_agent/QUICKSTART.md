# Quick Start Guide - Meal Plan Agent

Guía rápida para empezar a usar el agente de planes nutricionales.

---

## 🚀 Inicio Rápido (5 pasos)

### 1. Lee la Documentación

```
📁 meal_plans_agent/
├── README.md                  ← Empieza aquí (overview general)
├── system_prompt.md           ← Prompt del sistema (copia a n8n)
├── user_prompt_template.md    ← Formato del input del usuario
├── tools_specification.md     ← Detalles de cada tool
├── api_endpoints.md           ← Endpoints que debes implementar
└── n8n_setup_guide.md        ← Configuración paso a paso en n8n
```

### 2. Implementa los Endpoints en tu Backend

Necesitas crear **8 endpoints** en `fitbodyrd_server`:

```dart
// lib/src/endpoints/nutrition_endpoints.dart

// 1. GET /users/{userId}/profile
// 2. POST /nutrition/calculate-macros
// 3. GET /foods/categories
// 4. POST /foods/search-by-category
// 5. GET /users/{userId}/food-preferences
// 6. POST /nutrition-plans
// 7. POST /nutrition-plans/{nutritionPlanId}/days
// 8. POST /nutrition-plans/{nutritionPlanId}/progress
```

Ver `api_endpoints.md` para especificaciones completas.

### 3. Configura n8n

1. Crea las credenciales (FitBodyRD API + OpenAI)
2. Crea 8 HTTP Request nodes (uno por tool)
3. Crea el AI Agent node
4. Pega el contenido de `system_prompt.md`
5. Conecta los tools al agent

Ver `n8n_setup_guide.md` para guía detallada.

### 4. Prueba con un Usuario

```bash
curl -X POST https://your-n8n.com/webhook/meal-plan-agent \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 1,
    "weeks": 1
  }'
```

### 5. Monitorea y Ajusta

- Revisa logs en n8n > Executions
- Verifica que se crean los 7 días
- Ajusta tolerancias si es necesario

---

## 📋 Checklist de Implementación

### Backend (Dart/Serverpod)

- [ ] Endpoint: GET /users/{userId}/profile
- [ ] Endpoint: POST /nutrition/calculate-macros
  - [ ] Implementar fórmula BMR (Mifflin-St Jeor)
  - [ ] Implementar cálculo TDEE
  - [ ] Implementar ajustes por objetivo
  - [ ] Implementar distribución por comida
- [ ] Endpoint: GET /foods/categories
- [ ] Endpoint: POST /foods/search-by-category
  - [ ] Filtro por dietary restriction
  - [ ] Filtro por is_local
  - [ ] Filtro por is_active
  - [ ] Exclusión por food IDs
- [ ] Endpoint: GET /users/{userId}/food-preferences
- [ ] Endpoint: POST /nutrition-plans
  - [ ] Validación de fechas
  - [ ] Validación de macros
- [ ] Endpoint: POST /nutrition-plans/{nutritionPlanId}/days
  - [ ] Crear meal_plans (5 por día)
  - [ ] Crear meal_plan_foods (N por comida)
  - [ ] Usar transacciones
- [ ] Endpoint: POST /nutrition-plans/{nutritionPlanId}/progress
- [ ] Indexes en base de datos optimizados
- [ ] Tests unitarios de endpoints
- [ ] Tests de integración

### n8n

- [ ] Credencial FitBodyRD API configurada
- [ ] Credencial OpenAI configurada
- [ ] 8 HTTP Request nodes creados
- [ ] Tool schemas configurados
- [ ] AI Agent node creado
- [ ] System prompt pegado
- [ ] Tools conectados al agent
- [ ] Webhook trigger configurado
- [ ] Validation node agregado
- [ ] Response formatting node agregado
- [ ] Variables de entorno configuradas
- [ ] Workflow testeado con usuario real
- [ ] Error handling implementado

### Flutter App (Opcional)

- [ ] Pantalla para solicitar plan nutricional
- [ ] Input: número de semanas (1-8)
- [ ] Progress indicator mientras se genera
- [ ] Polling del endpoint de progreso
- [ ] Pantalla para ver plan generado
- [ ] Vista por día y por comida
- [ ] Calculadora de porciones
- [ ] Marcar comidas como completadas

---

## 🎯 Flujo Completo de Datos

```
Usuario (App) 
  ↓ 
  {userId: 123, weeks: 2}
  ↓
n8n Webhook
  ↓
AI Agent (GPT-4) + Tools
  ↓
  [Tool 1] getUserProfile → Backend GET /users/123/profile
  [Tool 2] calculateDailyMacros → Backend POST /nutrition/calculate-macros
  [Tool 3] getFoodCategories → Backend GET /foods/categories
  [Tool 4] getUserFoodPreferences → Backend GET /users/123/food-preferences
  [Tool 5] createNutritionPlan → Backend POST /nutrition-plans
  ↓
  Loop 14 veces (1 por día):
    [Tool 6] searchFoodsByCategory → Backend POST /foods/search-by-category (×5-7)
    [Agent] Selecciona alimentos y calcula porciones
    [Tool 7] createMealPlanDay → Backend POST /nutrition-plans/456/days
    [Tool 8] updateMealPlanProgress → Backend POST /nutrition-plans/456/progress
  ↓
Backend Database
  ↓
  nutrition_plans (1 registro)
  meal_plans (70 registros = 14 días × 5 comidas)
  meal_plan_foods (150-200 registros)
  ↓
Usuario (App) ve plan completo
```

---

## 🔍 Ejemplo Completo

### Input del Usuario

```json
{
    "userId": 123,
    "weeks": 2
}
```

### Proceso Interno (lo que hace el agente)

**Día 1:**

```
1. Obtiene perfil: Juan, 35 años, 85kg, 1.75m, objetivo: perder peso
2. Calcula macros: 2370 cal, 178g P, 237g C, 79g F
3. Obtiene categorías: Frutas, Proteínas, Carbohidratos, etc
4. Obtiene preferencias: Alergia a camarones, favorito aguacate
5. Crea nutrition_plan #456

Día 1:
  Desayuno (593 cal, 44g P, 71g C, 20g F):
    - 80g Avena (304 cal, 11g P, 54g C, 6g F)
    - 118g Plátano (105 cal, 1g P, 27g C, 0g F)
    - 150g Huevos (233 cal, 20g P, 2g C, 17g F)
  
  Almuerzo (830 cal, 62g P, 83g C, 24g F):
    - 180g Pollo (297 cal, 56g P, 0g C, 6g F)
    - 200g Arroz (260 cal, 5g P, 56g C, 1g F)
    - 100g Habichuelas (127 cal, 9g P, 23g C, 1g F)
    - 150g Ensalada (45 cal, 2g P, 9g C, 1g F)
    - 50g Aguacate (80 cal, 1g P, 4g C, 7g F)
  
  [... cena, snack_1, snack_2]
  
✓ Día 1 creado → Progress 7%

Día 2:
  [Similar pero con alimentos diferentes]
✓ Día 2 creado → Progress 14%

... continúa hasta día 14

✓ Día 14 creado → Progress 100%
✓ Plan completado
```

### Output Final

```json
{
    "success": true,
    "nutritionPlanId": 456,
    "startDate": "2025-11-08",
    "endDate": "2025-11-21",
    "totalDays": 14,
    "daysCreated": 14,
    "dailyTargets": {
        "calories": 2370,
        "proteins": 177.75,
        "carbs": 237.0,
        "fats": 79.0
    },
    "summary": "¡Plan nutricional de 2 semanas creado exitosamente! 🎉\n\nTu plan personalizado para perder peso incluye 14 días de comidas balanceadas con un objetivo diario de 2,370 calorías, distribuidas en:\n- 177.8g de proteína para preservar masa muscular\n- 237g de carbohidratos para energía sostenida\n- 79g de grasas saludables\n\nTodas las comidas respetan tus preferencias y restricciones alimenticias. Los alimentos se han variado para que disfrutes una dieta diversa y deliciosa.\n\n¡Comienza tu transformación hoy! 💪"
}
```

---

## 💡 Tips para Implementación

### Backend (Serverpod)

**Estructura sugerida:**

```dart
lib/src/
├── endpoints/
│   ├── user_endpoints.dart           # getUserProfile
│   ├── nutrition_endpoints.dart      # calculate, plan CRUD
│   └── food_endpoints.dart           # categories, search
├── business_logic/
│   ├── nutrition_calculator.dart     # BMR, TDEE, macros
│   └── meal_plan_generator.dart      # Validaciones
└── database/
    └── queries/
        ├── food_queries.dart
        └── nutrition_plan_queries.dart
```

**Ejemplo de nutrition_calculator.dart:**

```dart
class NutritionCalculator {
  static double calculateBMR({
    required double weightKgs,
    required double heightMs,
    required int age,
    required String sex,
  }) {
    final heightCm = heightMs * 100;
    
    if (sex == 'M') {
      return (10 * weightKgs) + (6.25 * heightCm) - (5 * age) + 5;
    } else {
      return (10 * weightKgs) + (6.25 * heightCm) - (5 * age) - 161;
    }
  }
  
  static double calculateTDEE(double bmr, String activityLevel) {
    const factors = {
      'sedentary': 1.2,
      'lightlyActive': 1.375,
      'moderatelyActive': 1.55,
      'active': 1.725,
      'veryActive': 1.9,
    };
    return bmr * factors[activityLevel]!;
  }
  
  // ... más métodos
}
```

### n8n

**Tip 1: Usa Function Nodes para debugging**

```javascript
// Agrega esto después del AI Agent para ver qué retorna
console.log("Agent Output:", JSON.stringify($input.item.json, null, 2));
return $input.all();
```

**Tip 2: Manejo de errores**

```javascript
// En cada tool, agrega error handling
try {
    const response = await $http.request(options);
    return { json: response };
} catch (error) {
    console.error("Tool error:", error.message);
    return {
        json: {
            error: error.message,
            tool: "searchFoodsByCategory",
        },
    };
}
```

**Tip 3: Rate limiting**

```javascript
// Agrega delays entre calls intensivos
await new Promise((resolve) => setTimeout(resolve, 500)); // 500ms delay
```

---

## 🐛 Debugging

### Problema: Agent no llama tools

**Solución:**

1. Verifica que el tool schema sea válido JSON
2. Asegura que la description sea clara
3. Aumenta temperature a 0.5
4. Revisa que los tools estén conectados

### Problema: Macros no cuadran

**Solución:**

1. Verifica cálculos: (P×4 + C×4 + F×9) ≈ calories
2. Usa decimales con 2 dígitos de precisión
3. Ajusta tolerancia a ±10% en system prompt

### Problema: Plan se repite mucho

**Solución:**

1. Aumenta el límite de búsqueda de alimentos (limit: 30)
2. Mejora el tracking de variedad en el agente
3. Agrega más alimentos a la BD

---

## 📊 Métricas de Éxito

Monitorea estas métricas:

- ✅ **Tasa de éxito:** >95% de planes completados sin error
- ✅ **Tiempo de generación:** <5 min para 2 semanas
- ✅ **Precisión nutricional:** ±10% de macros objetivo
- ✅ **Variedad:** <3 repeticiones por alimento/semana
- ✅ **Satisfacción:** Feedback positivo de usuarios

---

## 🎓 Recursos de Aprendizaje

- **Nutrición:** [FAO Nutrition Guide](https://www.fao.org/nutrition/)
- **BMR/TDEE:** [Research Paper](https://pubmed.ncbi.nlm.nih.gov/2305711/)
- **n8n Agents:** [Official Docs](https://docs.n8n.io/langchain/)
- **Serverpod:** [Documentation](https://docs.serverpod.dev/)

---

## 📞 Soporte

Si tienes preguntas o problemas durante la implementación:

1. Revisa la documentación completa en cada archivo .md
2. Verifica los logs de n8n y del backend
3. Testea cada tool individualmente
4. Usa la comunidad de n8n para preguntas específicas

---

## ✨ Próximos Pasos

Una vez que el agente esté funcionando:

1. **Optimiza:** Reduce costos, mejora velocidad
2. **Expande:** Agrega más features (intercambio de alimentos, recetas)
3. **Analiza:** Mide engagement de usuarios con sus planes
4. **Itera:** Mejora el system prompt basado en feedback

---

¡Éxito con tu implementación! 🚀💪
