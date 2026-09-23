# Meal Plan Agent

Agent de IA para n8n que genera planes nutricionales personalizados basados en
el perfil del usuario, sus objetivos, y los alimentos disponibles en la base de
datos.

## 📁 Estructura de Archivos

```
meal_plans_agent/
├── README.md                          # Este archivo - Overview general
├── system_prompt.md                   # Prompt del sistema con toda la lógica del agente
├── user_prompt_template.md            # Template del prompt del usuario
├── tools_specification.md             # Especificación detallada de cada tool con ejemplos
├── api_endpoints.md                   # Documentación de endpoints del backend
└── n8n_setup_guide.md                # Guía para configurar el agente en n8n
```

## 🎯 Propósito

Este agente crea planes de alimentación personalizados que:

- Calculan requerimientos calóricos y macro nutricionales basados en perfil del
  usuario
- Distribuyen macros inteligentemente entre comidas (desayuno, almuerzo, cena,
  snacks)
- Respetan preferencias alimenticias, alergias, intolerancias y restricciones
  dietéticas
- Priorizan alimentos locales de Santiago de los Caballeros
- Varían los alimentos a lo largo de la semana para evitar monotonía
- Se crean progresivamente (día por día) para evitar timeouts y mostrar progreso
  en la app

## 🔧 Tools Requeridos

El agente necesita los siguientes tools conectados a tu backend:

1. **getUserProfile** - Obtiene perfil completo del usuario
2. **calculateDailyMacros** - Calcula requerimientos nutricionales diarios
3. **getFoodCategories** - Lista categorías de alimentos
4. **searchFoodsByCategory** - Busca alimentos por categoría con filtros
5. **getUserFoodPreferences** - Obtiene preferencias alimenticias del usuario
6. **createNutritionPlan** - Crea el plan nutricional base
7. **createMealPlanDay** - Crea un día completo del plan con todas sus comidas
8. **updateMealPlanProgress** - Actualiza el progreso de generación del plan

## 🔄 Flujo de Trabajo

```
1. Usuario solicita plan → userId + semanas
2. Agente obtiene perfil del usuario
3. Calcula macros diarios (TDEE, distribución)
4. Obtiene categorías de alimentos
5. Obtiene preferencias del usuario
6. Crea nutrition_plan en BD
7. Para cada día (1-7 * semanas):
   a. Selecciona alimentos para cada comida
   b. Ajusta porciones para cumplir macros
   c. Crea meal_plan + meal_plan_foods en BD
   d. Actualiza progreso
8. Retorna plan completado
```

## 🌟 Características

- **Cálculo automático**: BMR, TDEE, déficit/superávit según objetivo
- **Distribución inteligente**: Macros distribuidos según tipo de comida
- **Variedad garantizada**: Tracking de alimentos usados para evitar repetición
- **Preferencias respetadas**: Excluye alergias, intolerancias y alimentos no
  deseados
- **Prioridad local**: Favorece alimentos disponibles en RD
- **Progreso visible**: Creación día por día para feedback en tiempo real
- **Idioma español**: Todas las respuestas y descripciones en español

## 🚀 Uso en n8n

Ver `n8n_setup_guide.md` para instrucciones detalladas de configuración.

**Input del usuario:**

```json
{
  "userId": 123,
  "weeks": 2,
  "mealTypes": ["breakfast", "lunch", "snack", "dinner"]
}
```

**Output del agente:**

```json
{
  "success": true,
  "nutritionPlanId": 456,
  "startDate": "2025-11-08",
  "endDate": "2025-11-21",
  "dailyCalories": 2100,
  "dailyProteins": 157.5,
  "dailyCarbs": 210.0,
  "dailyFats": 70.0,
  "totalDays": 14,
  "daysCreated": 14,
  "mealsPerDay": 4,
  "totalMeals": 56,
  "mealTypes": ["breakfast", "lunch", "snack", "dinner"],
  "summary": "Plan nutricional de 14 días creado exitosamente con 4 comidas diarias..."
}
```

## 📊 Distribución Dinámica de Macros

El agente distribuye los macros automáticamente según los tipos de comidas que
el usuario seleccione. El usuario puede elegir entre 2 y 5 tipos de comidas
**diferentes** (sin repetir).

### Pesos Relativos por Tipo de Comida

| Tipo      | Peso | Descripción                     |
| --------- | ---- | ------------------------------- |
| breakfast | 3.0  | Desayuno completo               |
| brunch    | 4.0  | Desayuno tardío (más abundante) |
| lunch     | 4.5  | Comida principal del día        |
| snack     | 1.0  | Merienda ligera                 |
| dinner    | 3.5  | Cena completa                   |

### Ejemplos de Distribución

**3 comidas [breakfast, lunch, dinner]:**

- breakfast: 27.3% | lunch: 40.9% | dinner: 31.8%

**4 comidas [breakfast, lunch, snack, dinner]:**

- breakfast: 25.0% | lunch: 37.5% | snack: 8.3% | dinner: 29.2%

**5 comidas [breakfast, brunch, lunch, snack, dinner]:**

- breakfast: 18.8% | brunch: 25.0% | lunch: 28.1% | snack: 6.3% | dinner: 21.9%

## 🎯 Objetivos y Ajustes Calóricos

| Objetivo      | Ajuste Calórico    | Distribución Macros   |
| ------------- | ------------------ | --------------------- |
| Perder peso   | -500 kcal del TDEE | 30% P / 40% C / 30% G |
| Mantener peso | TDEE               | 25% P / 45% C / 30% G |
| Ganar músculo | +300 kcal del TDEE | 30% P / 45% C / 25% G |

## 📝 Notas Técnicas

- Tolerancia de ±10% en macros por comida para flexibilidad
- Mínimo 3 alimentos diferentes por día
- Máximo 2 repeticiones del mismo alimento por semana
- Porciones redondeadas a tamaños prácticos de serving_sizes
- Preferencia por alimentos con `is_local=true`
- Exclusión automática de alimentos con `is_active=false`
