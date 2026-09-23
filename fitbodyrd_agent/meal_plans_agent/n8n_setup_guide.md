# n8n Workflow Setup Guide - Meal Plan Agent

Guía completa para configurar el agente de planes nutricionales en n8n.

---

## Requisitos Previos

1. **n8n instalado y funcionando**
   - Self-hosted o n8n Cloud
   - Versión recomendada: 1.0.0+

2. **Backend de FitBodyRD desplegado**
   - Todos los endpoints de la API funcionando
   - Authentication JWT configurado

3. **OpenAI API Key** (o provider de LLM compatible)
   - GPT-4 o superior recomendado
   - Suficiente crédito para ~100-130 API calls por plan

---

## Paso 1: Crear Credenciales

### 1.1 Credencial para FitBodyRD API

1. En n8n, ve a **Credentials** > **New Credential**
2. Selecciona **HTTP Header Auth**
3. Configura:
   ```
   Name: FitBodyRD API
   Header Name: Authorization
   Header Value: Bearer YOUR_JWT_TOKEN
   ```
4. Guarda la credencial

### 1.2 Credencial para OpenAI

1. Ve a **Credentials** > **New Credential**
2. Selecciona **OpenAI**
3. Configura:
   ```
   API Key: sk-your-openai-api-key
   ```
4. Guarda la credencial

---

## Paso 2: Crear Tools (HTTP Requests)

Cada tool del agente es un **HTTP Request Node** configurado como herramienta
para el AI Agent.

### Tool 1: getUserProfile

**Node Type:** HTTP Request

**Configuration:**

```
Method: GET
URL: {{$env.FITBODYRD_API_URL}}/users/{{$json.userId}}/profile
Authentication: FitBodyRD API (credential)
Response Format: JSON

Options:
  - Timeout: 10000ms
```

**Tool Configuration:**

```json
{
    "name": "getUserProfile",
    "description": "Obtiene el perfil completo del usuario con datos necesarios para calcular requerimientos nutricionales. Retorna edad, peso, altura, sexo, objetivo corporal, nivel de actividad y restricción dietética.",
    "schema": {
        "type": "object",
        "properties": {
            "userId": {
                "type": "integer",
                "description": "ID del usuario"
            }
        },
        "required": ["userId"]
    }
}
```

---

### Tool 2: calculateDailyMacros

**Node Type:** HTTP Request

**Configuration:**

```
Method: POST
URL: {{$env.FITBODYRD_API_URL}}/nutrition/calculate-macros
Authentication: FitBodyRD API (credential)
Body: JSON
Response Format: JSON

Body:
{
  "userId": "={{$json.userId}}",
  "mealTypes": "={{$json.mealTypes}}"
}
```

**Nota:** El backend obtiene automáticamente todos los datos del perfil del
usuario (weightKgs, heightMs, age, sex, activityLevel, bodyGoal) desde la base
de datos usando el `userId`.

**Tool Configuration:**

```json
{
    "name": "calculateDailyMacros",
    "description": "Calcula los requerimientos nutricionales diarios del usuario usando fórmulas de BMR y TDEE. Ajusta calorías según objetivo (déficit para perder peso, superávit para ganar músculo). Retorna calorías totales, macros (proteínas, carbohidratos, grasas) y distribución dinámica por cada comida según los mealTypes especificados.",
    "schema": {
        "type": "object",
        "properties": {
            "userId": {
                "type": "integer",
                "description": "ID del usuario"
            },
            "mealTypes": {
                "type": "array",
                "items": {
                    "type": "string",
                    "enum": ["breakfast", "brunch", "lunch", "snack", "dinner"]
                },
                "minItems": 2,
                "maxItems": 5,
                "uniqueItems": true,
                "description": "Lista de 2-5 tipos de comidas diferentes (sin repetir) para cada día"
            }
        },
        "required": [
            "userId",
            "mealTypes"
        ]
    }
}
```

---

### Tool 3: getFoodCategories

**Node Type:** HTTP Request

**Configuration:**

```
Method: GET
URL: {{$env.FITBODYRD_API_URL}}/foods/categories
Authentication: FitBodyRD API (credential)
Response Format: JSON
```

**Tool Configuration:**

```json
{
    "name": "getFoodCategories",
    "description": "Obtiene todas las categorías de alimentos disponibles en la base de datos (frutas, verduras, proteínas, carbohidratos, lácteos, grasas saludables, etc.). Usa estas categorías para buscar alimentos específicos al crear comidas.",
    "schema": {
        "type": "object",
        "properties": {}
    }
}
```

---

### Tool 4: searchFoodsByCategory

**Node Type:** HTTP Request

**Configuration:**

```
Method: POST
URL: {{$env.FITBODYRD_API_URL}}/foods/search-by-category
Authentication: FitBodyRD API (credential)
Body: JSON
Response Format: JSON

Body:
{
  "categoryId": "={{$json.categoryId}}",
  "dietaryRestriction": "={{$json.dietaryRestriction || 'none'}}",
  "isLocalOnly": "={{$json.isLocalOnly !== false}}",
  "excludeFoodIds": "={{$json.excludeFoodIds || []}}",
  "limit": "={{$json.limit || 20}}"
}
```

**Nota:** El backend siempre filtra automáticamente por `isActive = true`. Los
alimentos inactivos nunca se incluyen en los resultados.

**Tool Configuration:**

```json
{
    "name": "searchFoodsByCategory",
    "description": "Busca alimentos dentro de una categoría específica aplicando filtros. Respeta restricciones dietéticas (vegetariano, vegano, keto, etc), prioriza alimentos locales de Santiago de los Caballeros, y excluye alimentos especificados. Retorna alimentos con macronutrientes (por 100g) y tamaños de porción disponibles.",
    "schema": {
        "type": "object",
        "properties": {
            "categoryId": {
                "type": "integer",
                "description": "ID de la categoría de alimentos"
            },
            "dietaryRestriction": {
                "type": "string",
                "enum": [
                    "none",
                    "vegetarian",
                    "vegan",
                    "keto",
                    "paleo",
                    "pescatarian"
                ]
            },
            "isLocalOnly": {
                "type": "boolean",
                "description": "Solo alimentos locales (default: true)"
            },
            "excludeFoodIds": {
                "type": "array",
                "items": { "type": "integer" },
                "description": "IDs de alimentos a excluir"
            },
            "limit": {
                "type": "integer",
                "description": "Máximo de resultados (default: 20)"
            }
        },
        "required": ["categoryId"]
    }
}
```

---

### Tool 5: getUserFoodPreferences

**Node Type:** HTTP Request

**Configuration:**

```
Method: GET
URL: {{$env.FITBODYRD_API_URL}}/users/{{$json.userId}}/food-preferences
Authentication: FitBodyRD API (credential)
Response Format: JSON
```

**Tool Configuration:**

```json
{
    "name": "getUserFoodPreferences",
    "description": "Obtiene las preferencias alimenticias del usuario: alimentos favoritos (incluir frecuentemente), alimentos a excluir (no le gustan), alergias alimentarias (nunca incluir, peligroso), e intolerancias (evitar, causan malestar). CRÍTICO: nunca incluir alimentos de allergyFoodIds o excludedFoodIds en ningún plan.",
    "schema": {
        "type": "object",
        "properties": {
            "userId": { "type": "integer", "description": "ID del usuario" }
        },
        "required": ["userId"]
    }
}
```

---

### Tool 6: createNutritionPlan

**Node Type:** HTTP Request

**Configuration:**

```
Method: POST
URL: {{$env.FITBODYRD_API_URL}}/nutrition-plans
Authentication: FitBodyRD API (credential)
Body: JSON
Response Format: JSON

Body:
{
  "userId": "={{$json.userId}}",
  "startDate": "={{$json.startDate}}",
  "endDate": "={{$json.endDate}}",
  "dailyCalories": "={{$json.dailyCalories}}",
  "dailyProteins": "={{$json.dailyProteins}}",
  "dailyCarbs": "={{$json.dailyCarbs}}",
  "dailyFats": "={{$json.dailyFats}}"
}
```

**Tool Configuration:**

```json
{
    "name": "createNutritionPlan",
    "description": "Crea el registro base del plan nutricional en la base de datos. Este es el contenedor principal que agrupa todos los días del plan. Retorna el nutritionPlanId que debe usarse para crear cada día individual del plan.",
    "schema": {
        "type": "object",
        "properties": {
            "userId": { "type": "integer" },
            "startDate": {
                "type": "string",
                "format": "date",
                "description": "Fecha inicio formato YYYY-MM-DD"
            },
            "endDate": {
                "type": "string",
                "format": "date",
                "description": "Fecha fin formato YYYY-MM-DD"
            },
            "dailyCalories": { "type": "integer" },
            "dailyProteins": { "type": "number" },
            "dailyCarbs": { "type": "number" },
            "dailyFats": { "type": "number" }
        },
        "required": [
            "userId",
            "startDate",
            "endDate",
            "dailyCalories",
            "dailyProteins",
            "dailyCarbs",
            "dailyFats"
        ]
    }
}
```

---

### Tool 7: createMealPlanDay

**Node Type:** HTTP Request

**Configuration:**

```
Method: POST
URL: {{$env.FITBODYRD_API_URL}}/nutrition-plans/{{$json.nutritionPlanId}}/days
Authentication: FitBodyRD API (credential)
Body: JSON
Response Format: JSON
Timeout: 30000ms

Body:
{
  "nutritionPlanId": "={{$json.nutritionPlanId}}",
  "date": "={{$json.date}}",
  "dayNumber": "={{$json.dayNumber}}",
  "meals": "={{$json.meals}}"
}
```

**Tool Configuration:**

```json
{
    "name": "createMealPlanDay",
    "description": "Crea un día completo del plan de comidas con todas las 5 comidas (desayuno, almuerzo, cena, snack_1, snack_2) y sus alimentos correspondientes. Guarda todos los datos en la base de datos. Este es el tool más complejo: debes seleccionar alimentos apropiados, calcular porciones precisas para cumplir macros objetivo (±10% tolerancia), y asegurar variedad. Retorna IDs de las comidas creadas y totales nutricionales reales.",
    "schema": {
        "type": "object",
        "properties": {
            "nutritionPlanId": { "type": "integer" },
            "date": { "type": "string", "format": "date" },
            "dayNumber": { "type": "integer" },
            "meals": {
                "type": "array",
                "description": "Array de exactamente 5 comidas",
                "items": {
                    "type": "object",
                    "properties": {
                        "mealType": {
                            "type": "string",
                            "enum": [
                                "desayuno",
                                "almuerzo",
                                "cena",
                                "snack_1",
                                "snack_2"
                            ]
                        },
                        "targetCalories": { "type": "number" },
                        "targetProteins": { "type": "number" },
                        "targetCarbs": { "type": "number" },
                        "targetFats": { "type": "number" },
                        "foods": {
                            "type": "array",
                            "items": {
                                "type": "object",
                                "properties": {
                                    "foodId": { "type": "integer" },
                                    "foodName": { "type": "string" },
                                    "quantityGrams": { "type": "number" },
                                    "servingSizeId": { "type": "integer" },
                                    "servingQuantity": { "type": "number" },
                                    "calories": { "type": "number" },
                                    "proteins": { "type": "number" },
                                    "carbs": { "type": "number" },
                                    "fats": { "type": "number" }
                                }
                            }
                        }
                    }
                }
            }
        },
        "required": ["nutritionPlanId", "date", "dayNumber", "meals"]
    }
}
```

---

### Tool 8: updateMealPlanProgress

**Node Type:** HTTP Request

**Configuration:**

```
Method: POST
URL: {{$env.FITBODYRD_API_URL}}/nutrition-plans/{{$json.nutritionPlanId}}/progress
Authentication: FitBodyRD API (credential)
Body: JSON
Response Format: JSON

Body:
{
  "nutritionPlanId": "={{$json.nutritionPlanId}}",
  "currentDay": "={{$json.currentDay}}",
  "totalDays": "={{$json.totalDays}}",
  "status": "={{$json.status}}",
  "message": "={{$json.message}}"
}
```

**Tool Configuration:**

```json
{
    "name": "updateMealPlanProgress",
    "description": "Actualiza el progreso de creación del plan nutricional para feedback en tiempo real. La app puede mostrar al usuario qué día se está creando actualmente. Llama esto después de crear cada día con status='generando', y al final con status='completado'.",
    "schema": {
        "type": "object",
        "properties": {
            "nutritionPlanId": { "type": "integer" },
            "currentDay": { "type": "integer" },
            "totalDays": { "type": "integer" },
            "status": {
                "type": "string",
                "enum": ["generando", "completado", "error"]
            },
            "message": { "type": "string" }
        },
        "required": [
            "nutritionPlanId",
            "currentDay",
            "totalDays",
            "status",
            "message"
        ]
    }
}
```

---

## Paso 3: Crear el AI Agent Node

1. Arrastra un **AI Agent** node al canvas
2. Configura:

### Agent Configuration

```
Agent Type: Tools Agent
Model: gpt-4o (OpenAI)
Credential: OpenAI (tu credencial)

System Message: 
[Pega aquí el contenido completo de system_prompt.md]

Temperature: 0.3
Max Iterations: 150
```

### Connect Tools

Conecta los 8 HTTP Request nodes como herramientas del agente:

- getUserProfile
- calculateDailyMacros
- getFoodCategories
- searchFoodsByCategory
- getUserFoodPreferences
- createNutritionPlan
- createMealPlanDay
- updateMealPlanProgress

---

## Paso 4: Crear el Workflow Completo

### Estructura del Workflow

```
[Webhook/Trigger] 
    ↓
[Validate Input] 
    ↓
[AI Agent] ← [8 Tool Nodes]
    ↓
[Format Response]
    ↓
[Send Response/Notification]
```

### Node 1: Webhook Trigger

**Node Type:** Webhook

**Configuration:**

```
HTTP Method: POST
Path: meal-plan-agent
Authentication: None (o Basic Auth si prefieres)
Response Mode: When Last Node Finishes
```

**Expected Input:**

```json
{
    "userId": 123,
    "weeks": 2
}
```

---

### Node 2: Validate Input

**Node Type:** Code Node (JavaScript)

```javascript
// Validar input del usuario
const userId = $input.item.json.userId;
const weeks = $input.item.json.weeks;

// Validaciones
if (!userId || typeof userId !== "number" || userId <= 0) {
    throw new Error("userId debe ser un número positivo");
}

if (!weeks || typeof weeks !== "number" || weeks < 1 || weeks > 8) {
    throw new Error("weeks debe estar entre 1 y 8");
}

// Preparar prompt para el agente
const userPrompt = `userId: ${userId}\nweeks: ${weeks}`;

return {
    json: {
        userId,
        weeks,
        userPrompt,
    },
};
```

---

### Node 3: AI Agent

(Ya configurado en Paso 3)

**Input:** Recibe `userPrompt` del nodo anterior

---

### Node 4: Format Response

**Node Type:** Code Node (JavaScript)

```javascript
// Formatear respuesta del agente
const agentOutput = $input.item.json;

// Extraer información relevante
const response = {
    success: true,
    timestamp: new Date().toISOString(),
    input: {
        userId: agentOutput.userId || $("Validate Input").item.json.userId,
        weeks: agentOutput.weeks || $("Validate Input").item.json.weeks,
    },
    result: agentOutput,
};

return { json: response };
```

---

### Node 5: Send Notification (Opcional)

**Node Type:** HTTP Request o Email

**Para notificar al usuario via email:**

```javascript
// Get user email
const userId = $('Validate Input').item.json.userId;
const planDetails = $('Format Response').item.json.result;

// Send email
{
  to: "{{$json.userEmail}}",
  subject: "¡Tu plan nutricional está listo! 🎉",
  body: `
    Hola,
    
    Tu plan nutricional de ${planDetails.totalDays} días ha sido generado exitosamente.
    
    Detalles:
    - Calorías diarias: ${planDetails.dailyTargets.calories}
    - Proteínas: ${planDetails.dailyTargets.proteins}g
    - Carbohidratos: ${planDetails.dailyTargets.carbs}g
    - Grasas: ${planDetails.dailyTargets.fats}g
    
    ¡Comienza tu transformación hoy!
    
    Equipo FitBodyRD
  `
}
```

---

## Paso 5: Variables de Entorno

Configura estas variables en n8n:

```env
FITBODYRD_API_URL=https://api.fitbodyrd.com/api
OPENAI_API_KEY=sk-your-key
MAX_WEEKS=8
MIN_WEEKS=1
```

**Para configurar:**

1. Ve a **Settings** > **Environments**
2. Agrega cada variable
3. Guarda

---

## Paso 6: Testing

### Test 1: Plan Simple (1 semana)

```bash
curl -X POST https://your-n8n-instance.com/webhook/meal-plan-agent \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 1,
    "weeks": 1
  }'
```

**Esperado:** 7 días creados en ~1-2 minutos

---

### Test 2: Plan Completo (2 semanas)

```bash
curl -X POST https://your-n8n-instance.com/webhook/meal-plan-agent \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 1,
    "weeks": 2
  }'
```

**Esperado:** 14 días creados en ~2-4 minutos

---

### Test 3: Usuario con Restricciones

```bash
curl -X POST https://your-n8n-instance.com/webhook/meal-plan-agent \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 5,
    "weeks": 2
  }'
```

(Donde userId 5 tiene dietary_restriction = "vegan")

**Esperado:** Plan sin productos animales

---

## Paso 7: Monitoreo y Logs

### Ver Ejecuciones

1. Ve a **Executions** en n8n
2. Filtra por workflow "Meal Plan Agent"
3. Revisa:
   - Tiempo de ejecución (debería ser 2-5 minutos por plan de 2 semanas)
   - Tool calls (debería ser ~100-130 para 2 semanas)
   - Errores (si hay)

### Logs Importantes

**Monitorea estos indicadores:**

- ✅ `getUserProfile`: Debe retornar perfil completo
- ✅ `calculateDailyMacros`: Debe retornar macros razonables
- ✅ `createNutritionPlan`: Debe retornar nutritionPlanId
- ✅ `createMealPlanDay`: Debe llamarse 7×weeks veces
- ✅ `updateMealPlanProgress`: Debe llamarse 7×weeks + 1 veces

---

## Optimizaciones

### 1. Caching de Datos Estáticos

Cachea categorías de alimentos para evitar llamadas repetidas:

```javascript
// En un nodo global
if (!$globalState.foodCategories) {
    const categories = await $tools.getFoodCategories();
    $globalState.foodCategories = categories;
}
```

### 2. Retry Logic

Agrega reintentos para requests fallidos:

```javascript
// En cada HTTP Request node
Options > Retry On Fail: true
Max Retries: 3
Retry Interval: 5000ms
```

### 3. Timeout Management

Ajusta timeouts según complejidad:

- Búsquedas simples: 5s
- Cálculos: 10s
- Creación de días: 30s

### 4. Parallel Execution

Para múltiples usuarios, crea instancias paralelas:

- Usa **Split in Batches** node
- Procesa 3-5 usuarios en paralelo
- Evita sobrecarga del backend

---

## Troubleshooting

### Problema: "Tool call timeout"

**Causa:** El agente está tardando mucho en un tool

**Solución:**

1. Aumenta timeout del HTTP Request a 30s
2. Verifica que el backend responda rápido
3. Reduce cantidad de alimentos retornados (limit: 15)

---

### Problema: "No foods found matching restrictions"

**Causa:** No hay suficientes alimentos en la BD para las restricciones del
usuario

**Solución:**

1. Ejecuta el agente `fill_foods_agent` para poblar más alimentos
2. Relaja restricciones temporalmente
3. Notifica al usuario que debe ampliar sus preferencias

---

### Problema: "Macros don't sum correctly"

**Causa:** Error en cálculo de porciones del agente

**Solución:**

1. Verifica que serving_sizes tengan grams correctos
2. Revisa la fórmula: (valor_100g × grams) / 100
3. Ajusta tolerancia a ±15% si es necesario

---

### Problema: "Agent loops indefinitely"

**Causa:** El agente no puede completar el plan y sigue intentando

**Solución:**

1. Verifica Max Iterations (debe ser 150+)
2. Revisa el system prompt para asegurar que tiene instrucciones claras de
   finalización
3. Agrega un nodo de timeout de seguridad (10 minutos)

---

## Costos Estimados

### OpenAI API Costs (GPT-4)

Para un plan de 2 semanas:

- Input tokens: ~80,000 tokens
- Output tokens: ~40,000 tokens
- Cost: ~$2.40 - $3.00 USD por plan

**Optimizaciones:**

- Usa GPT-4o mini para reducir 70% del costo
- Cachea system prompt (50% reducción en input tokens)
- Reduce verbosidad del agente

---

## Deployment en Producción

### Checklist

- [ ] Variables de entorno configuradas
- [ ] Credenciales guardadas de forma segura
- [ ] Webhook con autenticación habilitada
- [ ] Rate limiting configurado (5 requests/min por usuario)
- [ ] Logs y monitoreo activos
- [ ] Backup del workflow exportado
- [ ] Documentación interna actualizada
- [ ] Testing completo realizado
- [ ] Notificaciones de error configuradas

### Recomendaciones

1. **Alta Disponibilidad:** Usa n8n Cloud o self-hosted con auto-scaling
2. **Monitoring:** Integra con Sentry o similar para tracking de errores
3. **Backups:** Exporta el workflow semanalmente
4. **Versionado:** Usa Git para versionar workflows
5. **Testing:** Crea un ambiente de staging para probar cambios

---

## Mantenimiento

### Actualizaciones del System Prompt

Cuando actualices `system_prompt.md`:

1. Edita el AI Agent node
2. Pega el nuevo contenido en System Message
3. Guarda el workflow
4. Prueba con un usuario de testing

### Agregar Nuevos Tools

Si necesitas agregar un tool:

1. Crea el HTTP Request node
2. Configura el schema del tool
3. Conéctalo al AI Agent
4. Actualiza el system prompt para mencionar el nuevo tool
5. Prueba exhaustivamente

### Revisar Performance

Mensualmente, revisa:

- Tiempo promedio de ejecución
- Tasa de éxito/error
- Costos de API
- Feedback de usuarios

---

## Recursos Adicionales

- [n8n Documentation](https://docs.n8n.io)
- [OpenAI API Reference](https://platform.openai.com/docs)
- [AI Agent Best Practices](https://docs.n8n.io/integrations/builtin/cluster-nodes/root-nodes/n8n-nodes-langchain.agent/)

---

¡Tu agente de meal plans está listo para crear planes nutricionales increíbles!
🚀
