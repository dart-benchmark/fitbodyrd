# 📚 Documentation Index - Meal Plan Agent

Complete documentation for the FitBodyRD Meal Plan Agent. Start here to navigate
all files.

---

## 🚀 Getting Started (Read First)

### 1. [QUICKSTART.md](./QUICKSTART.md)

**Read this first!** 5-step guide to get up and running quickly.

- Quick overview
- Implementation checklist
- Example walkthrough
- Common problems and solutions

**Time to read:** 10 minutes

---

## 📖 Core Documentation

### 2. [README.md](./README.md)

Complete overview of the agent system.

- Purpose and features
- File structure
- Workflow explanation
- Macro distribution tables
- Technical notes

**Who should read:** Everyone on the team **Time to read:** 15 minutes

---

### 3. [ARCHITECTURE.md](./ARCHITECTURE.md)

Visual diagrams and technical architecture.

- System architecture diagram
- Data flow visualization
- Tool call sequence
- Database schema
- Decision tree
- Error handling flow

**Who should read:** Developers, architects **Time to read:** 10 minutes

---

## 🔧 Implementation Guides

### 4. [system_prompt.md](./system_prompt.md)

**THE BRAIN OF THE AGENT** - Complete system prompt for the AI.

- Language requirements (Spanish)
- Enums and allowed values
- Complete workflow (step-by-step)
- Calculation rules (BMR, TDEE, macros)
- Variety and preference rules
- Error handling
- Output format
- Critical restrictions

**Who should read:**

- AI/ML engineers (to understand agent behavior)
- Backend developers (to align API design)
- QA (to create test cases)

**Time to read:** 30 minutes **Copy-paste:** Entire content goes into n8n AI
Agent node

---

### 5. [tools_specification.md](./tools_specification.md)

Detailed specification of all 8 tools.

- Tool purpose and description
- Input schemas with examples
- Output formats with examples
- Usage patterns
- Implementation notes

**Who should read:**

- n8n workflow developers
- Backend API developers

**Time to read:** 25 minutes

---

### 6. [api_endpoints.md](./api_endpoints.md)

Complete backend API specification.

- 8 endpoint definitions
- Request/response schemas
- Implementation logic (formulas, filters)
- Validation rules
- Error codes
- Database operations
- Performance considerations

**Who should read:**

- Backend developers (primary)
- API consumers
- DevOps (for deployment)

**Time to read:** 35 minutes

---

### 7. [user_prompt_template.md](./user_prompt_template.md)

User input format and validation.

- Simple JSON format
- Field descriptions
- Examples
- Validations
- Error cases
- Alternative formats (natural language)
- n8n integration options

**Who should read:**

- Frontend developers
- n8n workflow developers
- Product managers

**Time to read:** 10 minutes

---

### 8. [n8n_setup_guide.md](./n8n_setup_guide.md)

Step-by-step n8n configuration guide.

- Prerequisites
- Credential setup
- 8 tool node configurations (copy-paste ready)
- AI Agent configuration
- Complete workflow structure
- Testing procedures
- Troubleshooting
- Optimization tips
- Production deployment checklist

**Who should read:**

- n8n administrators
- DevOps engineers
- Workflow developers

**Time to read:** 45 minutes **Implementation time:** 2-3 hours

---

## 📊 Quick Reference Tables

### File Reading Order by Role

| Role                   | Recommended Reading Order                                          | Time   |
| ---------------------- | ------------------------------------------------------------------ | ------ |
| **Project Manager**    | QUICKSTART → README → ARCHITECTURE                                 | 35 min |
| **Backend Developer**  | QUICKSTART → api_endpoints → system_prompt → tools_specification   | 90 min |
| **n8n Developer**      | QUICKSTART → n8n_setup_guide → tools_specification → system_prompt | 90 min |
| **Frontend Developer** | QUICKSTART → README → user_prompt_template → api_endpoints         | 50 min |
| **QA Engineer**        | QUICKSTART → README → system_prompt → tools_specification          | 80 min |
| **Data Scientist**     | system_prompt → api_endpoints → ARCHITECTURE                       | 75 min |

---

### Documentation by Purpose

| I want to...                | Read this file                  |
| --------------------------- | ------------------------------- |
| Understand the big picture  | README.md                       |
| Set up the agent in n8n     | n8n_setup_guide.md              |
| Implement backend endpoints | api_endpoints.md                |
| Understand agent's logic    | system_prompt.md                |
| Configure tools             | tools_specification.md          |
| Build the frontend          | user_prompt_template.md         |
| Debug issues                | QUICKSTART.md (Troubleshooting) |
| Visualize the flow          | ARCHITECTURE.md                 |

---

## 🎯 Implementation Phases

### Phase 1: Backend Foundation (Week 1)

**Files needed:**

- api_endpoints.md (primary)
- system_prompt.md (for context)
- tools_specification.md (for I/O examples)

**Deliverables:**

- [ ] 8 API endpoints implemented
- [ ] Database migrations applied
- [ ] Unit tests written
- [ ] API documentation published

---

### Phase 2: n8n Integration (Week 2)

**Files needed:**

- n8n_setup_guide.md (primary)
- tools_specification.md (for tool schemas)
- system_prompt.md (for agent config)

**Deliverables:**

- [ ] n8n workflow created
- [ ] 8 tools configured
- [ ] AI Agent node configured
- [ ] End-to-end testing completed

---

### Phase 3: Frontend Integration (Week 3)

**Files needed:**

- user_prompt_template.md (primary)
- api_endpoints.md (for progress polling)
- README.md (for UX flow)

**Deliverables:**

- [ ] Plan request UI
- [ ] Progress tracking
- [ ] Plan display UI
- [ ] Error handling

---

### Phase 4: Testing & Optimization (Week 4)

**Files needed:**

- QUICKSTART.md (test cases)
- system_prompt.md (validation rules)
- ARCHITECTURE.md (performance metrics)

**Deliverables:**

- [ ] Load testing completed
- [ ] Cost optimization done
- [ ] User acceptance testing passed
- [ ] Production deployment

---

## 📝 Key Concepts to Understand

### For Everyone:

1. **Progressive Generation**: Plans are created day-by-day to avoid timeouts
2. **Real-time Progress**: Users see progress as each day is created
3. **Smart Selection**: Agent picks foods intelligently based on preferences
4. **Macro Balancing**: ±10% tolerance for realistic meal combinations

### For Developers:

1. **Tool-based Architecture**: Agent only calls tools, never invents data
2. **Stateless Tools**: Each tool is independent HTTP request
3. **Transactional Days**: Each day is saved atomically
4. **Variety Tracking**: Agent maintains internal state for food rotation

### For Product:

1. **User Input is Minimal**: Just userId + weeks
2. **Personalization is Automatic**: Based on profile, preferences, goals
3. **Cultural Relevance**: Dominican foods and meal patterns
4. **Flexible Editing**: Users can modify generated plans (future feature)

---

## 🔍 Deep Dives

### Nutritional Calculations

See: `api_endpoints.md` (calculateDailyMacros section)

- BMR formula (Mifflin-St Jeor)
- TDEE calculation
- Macro distribution by goal
- Meal-level breakdown

### Food Selection Logic

See: `system_prompt.md` (Rules section)

- Category selection by meal type
- Preference priority order
- Variety scoring system
- Portion calculation methods

### Database Design

See: `ARCHITECTURE.md` (Database Schema)

- Table relationships
- Indexes for performance
- Transaction boundaries
- Data integrity constraints

### Error Scenarios

See: `QUICKSTART.md` (Debugging section)

- Common errors and solutions
- Retry strategies
- Fallback behaviors
- User-facing messages

---

## 📈 Performance Benchmarks

| Metric         | Target          | Measured | Status |
| -------------- | --------------- | -------- | ------ |
| Time (1 week)  | <2 min          | TBD      | ⏳     |
| Time (2 weeks) | <4 min          | TBD      | ⏳     |
| Time (4 weeks) | <8 min          | TBD      | ⏳     |
| Success rate   | >95%            | TBD      | ⏳     |
| Macro accuracy | ±10%            | TBD      | ⏳     |
| Food variety   | <3 repeats/week | TBD      | ⏳     |
| Cost per plan  | <$3 USD         | TBD      | ⏳     |

---

## 🐛 Known Limitations

1. **Language**: System only supports Spanish (by design)
2. **Max Plan Length**: 8 weeks maximum
3. **Macro Tolerance**: ±10% variance allowed
4. **Food Database**: Requires sufficient variety for restrictions
5. **Concurrent Users**: Limited by n8n and backend capacity
6. **No Real-time Editing**: Plans generated all at once

**Future Improvements:** See README.md (Próximos Pasos)

---

## 🤝 Contributing

### Updating Documentation

When making changes:

1. Update the relevant .md file
2. Update this INDEX.md if adding/removing files
3. Update QUICKSTART.md if changing core flows
4. Increment version in file headers (if using versions)

### File Naming Convention

- **ALL CAPS.md**: Entry points and guides (README, QUICKSTART)
- **lowercase.md**: Technical specifications and prompts
- **CamelCase.md**: Special documents (not used currently)

---

## 📞 Support & Questions

### For Implementation Questions:

1. Check QUICKSTART.md troubleshooting section
2. Review relevant technical doc
3. Check n8n_setup_guide.md for n8n-specific issues
4. Review api_endpoints.md for backend issues

### For Business Logic Questions:

1. Review system_prompt.md for agent behavior
2. Check README.md for feature explanations
3. Review ARCHITECTURE.md for flow understanding

### For Integration Questions:

1. Check user_prompt_template.md for input format
2. Review api_endpoints.md for API contracts
3. Check tools_specification.md for tool schemas

---

## 📦 Deliverables Checklist

Use this when completing the project:

### Documentation

- [x] README.md - Overview and introduction
- [x] QUICKSTART.md - Fast-start guide
- [x] ARCHITECTURE.md - System diagrams
- [x] system_prompt.md - AI agent prompt
- [x] tools_specification.md - Tool definitions
- [x] api_endpoints.md - Backend API spec
- [x] user_prompt_template.md - User input format
- [x] n8n_setup_guide.md - n8n configuration
- [x] INDEX.md - This navigation document

### Backend (To Do)

- [ ] 8 API endpoints implemented
- [ ] Database migrations created
- [ ] Unit tests written
- [ ] Integration tests written
- [ ] API documentation generated
- [ ] Performance tests done

### n8n (To Do)

- [ ] Workflow created
- [ ] 8 tools configured
- [ ] AI Agent configured
- [ ] Testing completed
- [ ] Production deployment

### Frontend (To Do)

- [ ] Plan request screen
- [ ] Progress tracking screen
- [ ] Plan display screen
- [ ] Error handling
- [ ] Loading states

---

## 🎓 Learning Path

### Day 1: Understanding

- Read QUICKSTART.md (10 min)
- Read README.md (15 min)
- Review ARCHITECTURE.md diagrams (10 min)
- **Goal:** Understand what the agent does and how

### Day 2: Backend Design

- Study api_endpoints.md (35 min)
- Review db_design_v1.dbml (15 min)
- Map endpoints to database tables
- **Goal:** Understand data flow and storage

### Day 3: Agent Logic

- Study system_prompt.md (30 min)
- Review tools_specification.md (25 min)
- Understand decision tree in ARCHITECTURE.md
- **Goal:** Understand agent's behavior

### Day 4: Integration

- Study n8n_setup_guide.md (45 min)
- Review user_prompt_template.md (10 min)
- Practice with tool schemas
- **Goal:** Understand how pieces connect

### Day 5: Implementation

- Set up development environment
- Start implementing based on role
- Reference docs as needed
- **Goal:** Begin actual work

---

## 🏆 Success Criteria

You'll know the implementation is successful when:

✅ User can request a plan with just userId + weeks ✅ Agent generates plan in
<5 minutes for 2 weeks ✅ All macros are within ±10% of target ✅ No food
allergies are included ✅ Food variety is maintained (no excessive repetition)
✅ Progress is visible to user in real-time ✅ Plans are saved correctly in
database ✅ User can view and follow the plan in app ✅ Error handling is
graceful and informative ✅ Cost per plan is under $3 USD

---

## 📚 Additional Resources

### Nutrition Science

- [Mifflin-St Jeor Equation](https://pubmed.ncbi.nlm.nih.gov/2305711/)
- [TDEE Calculator Science](https://www.calculator.net/tdee-calculator.html)
- [Macro Distribution Guide](https://www.healthline.com/nutrition/best-macronutrient-ratio)

### Technical Resources

- [n8n AI Agent Docs](https://docs.n8n.io/langchain/)
- [Serverpod Documentation](https://docs.serverpod.dev/)
- [OpenAI API Reference](https://platform.openai.com/docs)
- [PostgreSQL Best Practices](https://wiki.postgresql.org/wiki/Don%27t_Do_This)

---

## 🗺️ Document Map

```
meal_plans_agent/
│
├── INDEX.md (YOU ARE HERE) ─────────┐
│                                     │
├── 📗 QUICKSTART.md ← Start here    │
│   └─→ Fastest path to implementation│
│                                     │
├── 📘 README.md                      │
│   └─→ Complete overview            │
│                                     │
├── 📙 ARCHITECTURE.md                │
│   └─→ Visual diagrams              │
│                                     │
├── 🔧 Technical Specs: ──────────────┤
│   ├── system_prompt.md             │
│   ├── tools_specification.md       │
│   ├── api_endpoints.md             │
│   ├── user_prompt_template.md      │
│   └── n8n_setup_guide.md          │
│                                     │
└─────────────────────────────────────┘
```

---

**Last Updated:** November 8, 2025 **Version:** 1.0.0 **Status:** ✅
Documentation Complete, Ready for Implementation

---

¡Feliz implementación! 🚀
