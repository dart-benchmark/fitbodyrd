# User Prompt Template - Meal Plan Agent

Este es el template del prompt que el usuario proporciona al agente para generar
un plan nutricional personalizado.

---

## Formato Simple

```json
{
    "userId": 123,
    "weeks": 2,
    "mealTypes": ["breakfast", "lunch", "snack", "dinner"]
}
```

---

## Descripción de Campos

| Campo       | Tipo          | Requerido | Descripción                              | Valores Permitidos    |
| ----------- | ------------- | --------- | ---------------------------------------- | --------------------- |
| `userId`    | integer       | Sí        | ID único del usuario en la base de datos | Entero positivo > 0   |
| `weeks`     | integer       | Sí        | Duración del plan en semanas             | 1-8 semanas           |
| `mealTypes` | array[string] | Sí        | Lista de tipos de comidas para cada día  | Ver MealPlanType enum |

### MealPlanType Enum

Los valores permitidos para `mealTypes` son:

| Valor       | Descripción              | Ejemplo de Horario  |
| ----------- | ------------------------ | ------------------- |
| `breakfast` | Desayuno                 | 7:00 AM - 9:00 AM   |
| `brunch`    | Brunch (desayuno tardío) | 10:00 AM - 12:00 PM |
| `lunch`     | Almuerzo                 | 12:00 PM - 2:00 PM  |
| `snack`     | Merienda                 | 3:00 PM - 5:00 PM   |
| `dinner`    | Cena                     | 6:00 PM - 9:00 PM   |

**Notas importantes:**

- El usuario puede seleccionar entre 2 y 5 tipos de comidas diferentes por día
- Cada tipo de comida solo puede aparecer **una vez** en el array `mealTypes`
- No se permiten valores duplicados (ej: ❌ `["breakfast", "snack", "snack"]`)

---

## Ejemplos de Uso

### Ejemplo 1: Plan estándar de 3 comidas

```json
{
    "userId": 45,
    "weeks": 1,
    "mealTypes": ["breakfast", "lunch", "dinner"]
}
```

**Resultado:** Plan de 7 días con 3 comidas diarias = 21 comidas totales

---

### Ejemplo 2: Plan con 4 comidas (incluye merienda)

```json
{
    "userId": 123,
    "weeks": 2,
    "mealTypes": ["breakfast", "lunch", "snack", "dinner"]
}
```

**Resultado:** Plan de 14 días con 4 comidas diarias = 56 comidas totales

---

### Ejemplo 3: Plan intensivo de 5 comidas

```json
{
    "userId": 789,
    "weeks": 4,
    "mealTypes": ["breakfast", "brunch", "lunch", "snack", "dinner"]
}
```

**Resultado:** Plan de 28 días con 5 comidas diarias = 140 comidas totales

---

### Ejemplo 4: Plan minimalista de 2 comidas (Intermittent Fasting)

```json
{
    "userId": 234,
    "weeks": 2,
    "mealTypes": ["lunch", "dinner"]
}
```

**Resultado:** Plan de 14 días con 2 comidas diarias = 28 comidas totales

---

## Validaciones

El agente validará:

1. **userId existe**: El usuario debe existir en la base de datos
2. **weeks válido**: Debe ser un número entre 1 y 8
3. **mealTypes válido**:
   - Array no vacío
   - Mínimo 2 comidas, máximo 6 comidas
   - Solo valores del enum MealPlanType
   - Sin duplicados
4. **Perfil completo**: El usuario debe tener su perfil completo (weight,
   height, age, etc.)
5. **No plan activo**: Opcionalmente, validar que el usuario no tenga otro plan
   activo

---

## Respuesta del Agente

Una vez procesado, el agente retornará:

````json
**Output del agente:**
```json
{
  "success": true,
  "nutritionPlanId": 456,
  "userId": 123,
  "startDate": "2025-11-08",
  "endDate": "2025-11-21",
  "totalDays": 14,
  "daysCreated": 14,
  "mealsPerDay": 4,
  "totalMeals": 56,
  "mealTypes": ["breakfast", "lunch", "snack", "dinner"],
  "dailyTargets": {
    "calories": 2370,
    "proteins": 177.75,
    "carbs": 237.0,
    "fats": 79.0
  },
  "summary": "¡Plan nutricional de 2 semanas creado exitosamente! 🎉\n\nTu plan personalizado para perder peso incluye 14 días de comidas balanceadas con 4 comidas diarias (desayuno, almuerzo, merienda, cena)...",
  "motivationalMessage": "Recuerda: la consistencia es clave. ¡Tú puedes lograrlo! 🌟"
}
````

```
---

## Formato Alternativo (Texto Natural)

Si prefieres que el usuario pueda escribir en lenguaje natural, el agente también puede procesar:
```

"Crea un plan de alimentación de 2 semanas para el usuario 123"

```
```

"Quiero un meal plan de 4 semanas para mi usuario ID 789"

```
```

"Plan nutricional de 1 semana, userId: 45"

````
El agente debe extraer:
- `userId`: Buscar números después de "usuario", "user", "userId", "ID"
- `weeks`: Buscar números antes de "semana(s)", "week(s)"

---

## Integración en n8n

### Opción 1: Webhook Input
```javascript
// n8n Webhook Node
{
  "body": {
    "userId": {{ $json.userId }},
    "weeks": {{ $json.weeks }}
  }
}
````

### Opción 2: Manual Trigger

```javascript
// n8n Manual Trigger Node
{
  "userId": 123,
  "weeks": 2
}
```

### Opción 3: Schedule + Database

```javascript
// n8n Schedule Trigger + Query
// Buscar usuarios que necesitan nuevo plan
SELECT user_id 
FROM users 
WHERE next_plan_date <= CURRENT_DATE
AND active = true
```

---

## Límites Recomendados

| Límite               | Valor | Razón                                           |
| -------------------- | ----- | ----------------------------------------------- |
| Semanas mínimas      | 1     | Un plan debe durar al menos una semana completa |
| Semanas máximas      | 8     | Planes muy largos pueden volverse aburridos     |
| Duración recomendada | 2-4   | Balance entre variedad y sostenibilidad         |

---

## Casos de Error

### Error: Usuario no encontrado

```json
{
    "success": false,
    "error": "Usuario con ID 999 no encontrado en la base de datos",
    "code": "USER_NOT_FOUND"
}
```

### Error: Semanas inválidas

```json
{
    "success": false,
    "error": "El número de semanas debe estar entre 1 y 8",
    "code": "INVALID_WEEKS"
}
```

### Error: mealTypes inválidos

```json
{
    "success": false,
    "error": "mealTypes debe contener entre 2 y 6 comidas válidas del enum MealPlanType",
    "code": "INVALID_MEAL_TYPES",
    "details": "Valores permitidos: breakfast, brunch, lunch, snack, dinner"
}
```

### Error: Perfil incompleto

```json
{
    "success": false,
    "error": "El usuario no tiene un perfil completo. Por favor, complete peso, altura, edad y objetivos antes de crear un plan",
    "code": "INCOMPLETE_PROFILE"
}
```

### Error: Restricciones imposibles

```json
{
    "success": false,
    "error": "Las restricciones dietéticas del usuario hacen imposible crear un plan balanceado con los alimentos disponibles",
    "code": "INSUFFICIENT_FOODS"
}
```

---

## Variables de Entorno (n8n)

Configura estas variables en n8n para el agente:

```env
# API Configuration
FITBODYRD_API_URL=https://api.fitbodyrd.com
FITBODYRD_API_KEY=your_api_key_here

# Agent Configuration
MAX_WEEKS=8
MIN_WEEKS=1
DEFAULT_WEEKS=2

# Timeouts
API_TIMEOUT_MS=10000
PLAN_GENERATION_TIMEOUT_MS=300000
```

---

## Testing

### Test Case 1: Plan Básico

```json
{
    "userId": 1,
    "weeks": 1
}
```

**Esperado:** 7 días creados exitosamente

### Test Case 2: Plan Largo

```json
{
    "userId": 1,
    "weeks": 8
}
```

**Esperado:** 56 días creados exitosamente (puede tomar varios minutos)

### Test Case 3: Usuario Vegano

```json
{
    "userId": 2,
    "weeks": 2
}
```

**Esperado:** Plan sin productos animales, respetando
dietary_restriction="vegan"

### Test Case 4: Usuario con Alergias

```json
{
    "userId": 3,
    "weeks": 2
}
```

**Esperado:** Plan sin alimentos marcados como alergias

---

## Automatización Sugerida

### Crear planes automáticamente cada mes:

```javascript
// n8n Schedule Trigger: 1st of every month at 6 AM

// Query Node: Get users needing new plans
const usersNeedingPlans = await db.query(`
  SELECT id, name, email
  FROM users
  WHERE active = true
  AND (
    last_plan_end_date IS NULL 
    OR last_plan_end_date <= CURRENT_DATE
  )
`);

// Loop through users
for (const user of usersNeedingPlans) {
    // Call Meal Plan Agent
    await agent.run({
        userId: user.id,
        weeks: 4,
    });

    // Send notification
    await sendEmail({
        to: user.email,
        subject: "¡Tu nuevo plan nutricional está listo!",
        body: `Hola ${user.name}, tu plan de 4 semanas ha sido generado...`,
    });
}
```

---

## Notas Importantes

1. **El prompt es minimalista por diseño**: Solo necesitas userId y weeks. Todo
   lo demás (perfil, preferencias, cálculos) lo maneja el agente
   automáticamente.

2. **Fechas automáticas**: El agente calcula startDate (hoy) y endDate (hoy +
   weeks×7) automáticamente.

3. **Flexibilidad**: Si en el futuro quieres agregar más parámetros (ej:
   `startDate` personalizado), puedes extender este template.

4. **Idempotencia**: Si se ejecuta el mismo userId+weeks dos veces, se puede
   crear un nuevo plan o actualizar el existente (define la lógica en el
   backend).
