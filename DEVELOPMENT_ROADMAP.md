# FitBodyRD Development Roadmap

> **Last Updated**: January 2025\
> **Project Status**: Active Development

This document tracks the development progress and next steps for the FitBodyRD
fitness and nutrition tracking application.

---

## 🎯 Current Sprint

### ✅ Recently Completed

- [x] Splash screen redirection logic with profile verification
- [x] User cache clearing on logout
- [x] Multi-step onboarding flow with Spanish localization
- [x] Enum extensions for Spanish translations (`Sex`, `BodyGoal`,
      `ActivityLevel`, `ExerciseDifficulty`, `DietaryRestriction`,
      `ExerciseMuscleGroup`)
- [x] Input validation for body stats (decimal-only height/weight fields)
- [x] Profile screen with user info, logout, and app version display
- [x] README documentation for both Flutter app and backend server
- [x] CI/CD pipeline for automated APK builds and releases
- [x] Version checking and automatic minor version bumping in release pipeline
- [x] Docker-based Flutter build environment for faster CI/CD
- [x] Meal plan view implementation with day selector
- [x] Food intake logging with checkbox tracking
- [x] Backend support for consumed food tracking (`FoodIntakeLog` model and
      endpoints)
- [x] Nutrition dashboard UI enhancements (macro visibility, data filtering)
- [x] Meal section macro breakdown (consumed vs. target)
- [x] Individual food item macro display
- [x] Animated day transitions in nutrition dashboard
- [x] Fixed backend date filtering for food intake logs
- [x] Meal editing and deletion with swipe-to-delete
- [x] Edit dialog with serving size selection and manual gram input
- [x] Soft delete pattern for meal plan foods
- [x] Automatic intake log updates when editing/deleting logged foods
- [x] Transaction-based updates for data consistency
- [x] Food search and selection feature
- [x] Search foods by name with debounced input
- [x] Add foods to meal plans with portion configuration
- [x] Duplicate food prevention in same meal plan
- [x] Backend validation for food additions
- [x] Workout dashboard with active plan display
- [x] Date selector for workout view (similar to nutrition)
- [x] Daily workout session display with exercises
- [x] Rest day messaging for days without sessions
- [x] Exercise details screen with comprehensive information
- [x] Workout plan generation integration
- [x] Automatic dashboard refresh after plan generation
- [x] Exercise logging with dedicated `getExerciseLogs` API endpoint
- [x] Exercise completion tracking with optimistic UI updates
- [x] Toggle exercise completion (log/unlog) with instant feedback
- [x] Smooth logging UX without dashboard reloads
- [x] Motivational dialog on session completion
- [x] Delete exercise logs functionality
- [x] Exercise statistics graphs on exercise details screen
- [x] Line charts for weight, reps, sets, and difficulty progression
- [x] Time period selector with preset buttons (30 days, 3 months, 6 months, 1
      year, all time)
- [x] Summary statistics cards (total sessions, max weight, average reps/sets,
      average difficulty)
- [x] Automatic log loading when opening exercise details screen
- [x] Home dashboard with personalized greeting and user name
- [x] Weekly summary metrics (workouts completed, nutrition days logged)
- [x] Today's progress card showing nutrition and workout status
- [x] Quick action buttons for navigation to nutrition and workout screens
- [x] Server-side weekly summary aggregation endpoint
- [x] Dashboard repository and state management implementation
- [x] Comprehensive workout history tracking with date range filtering
- [x] Workout progress metrics (total workouts, streaks, averages)
- [x] Workout history screen with session details and progress visualization
- [x] Progress metrics cards (total workouts, current/longest streak, averages)
- [x] Workout frequency chart showing workouts per week
- [x] Session details view with expandable cards and exercise information
- [x] Navigation to exercise details from workout history
- [x] Quick action button for workout history on home screen
- [x] Dynamic color coding for nutrition progress indicators (green/yellow/red
      based on target ranges)
- [x] Contextual messages for nutrition progress (perfect, too much, too little
      feedback)
- [x] Color-coded macro tracking (proteins, carbs, fats) with visual feedback

### 🔄 In Progress

- [ ] (No items currently in progress)

---

## 📋 Backlog

### High Priority

#### 🏋️ Workout Features

- [x] Implement active workout plan display
- [x] Add date selector for workout sessions
- [x] Display daily workout sessions with exercises
- [x] Create exercise details screen
- [x] Integrate workout plan generation
- [x] Add exercise completion tracking
- [x] Exercise logging with dedicated API endpoint
- [x] Toggle exercise completion (log/unlog)
- [x] Optimistic UI updates for smooth logging experience
- [x] Session completion celebration dialog
- [x] Exercise statistics graphs with line charts
- [x] Time period filtering for exercise logs
- [x] Summary statistics display for exercises
- [x] Build comprehensive workout history tracking
- [x] Create advanced workout progress visualization
- [ ] Add workout reminders/notifications
- [ ] Implement workout plan editing

#### 🍎 Nutrition Features

- [x] Implement meal logging interface
- [x] Build nutrition plan generation (meal plan view)
- [x] Create daily nutrition tracking dashboard
- [x] Add day selector for viewing different days
- [x] Display meals separated by meal plan types
- [x] Implement food intake tracking with checkboxes
- [x] Show macro breakdown per meal section
- [x] Display individual food item macros
- [x] Add meal editing and deletion
- [x] Add food search and selection
- [x] Dynamic color coding for nutrition progress (calories and macros)
- [x] Contextual feedback messages for nutrition tracking
- [ ] Add barcode scanning for food items
- [ ] Implement custom food creation
- [ ] Implement meal templates for quick logging

#### 📊 Dashboard & Analytics

- [x] Create main dashboard with key metrics
- [x] Build weekly summary views with aggregated metrics
- [x] Today's progress tracking (nutrition and workouts)
- [x] Personalized greeting with user name
- [x] Quick action navigation buttons (nutrition, workouts, workout history)
- [ ] Add progress charts (weight, body measurements)
- [ ] Build monthly summary views
- [ ] Implement goal tracking visualization
- [ ] Add achievement/milestone system

### Medium Priority

#### 👤 User Profile & Settings

- [ ] Add profile photo upload
- [ ] Implement body measurements tracking
- [ ] Create settings screen for preferences
- [ ] Add notification preferences
- [ ] Implement theme customization (light/dark mode)
- [ ] Add language selection (English/Spanish)

#### 🔔 Notifications & Reminders

- [ ] Implement push notifications
- [ ] Add workout reminders
- [ ] Create meal logging reminders
- [ ] Add progress milestone notifications
- [ ] Implement weekly summary notifications

#### 🔐 Authentication Enhancements

- [ ] Add password reset flow
- [ ] Implement email verification
- [ ] Add biometric authentication (fingerprint/face)
- [ ] Create account deletion flow
- [ ] Add session management improvements

### Low Priority

#### 🎨 UI/UX Improvements

- [ ] Add loading skeletons for better UX
- [ ] Implement pull-to-refresh on lists
- [ ] Add animations and transitions
- [ ] Create empty state illustrations
- [ ] Improve error state messaging
- [ ] Add haptic feedback

#### 🌐 Social Features

- [ ] Add friend/community system
- [ ] Implement workout sharing
- [ ] Create leaderboards
- [ ] Add social feed for achievements
- [ ] Implement challenges/competitions

#### 📱 Platform-Specific Features

- [ ] iOS widget for quick stats
- [ ] Android widget for quick stats
- [ ] Apple Health integration
- [ ] Google Fit integration
- [ ] Wear OS companion app
- [ ] Apple Watch companion app

---

## 🔧 Technical Debt & Improvements

### Code Quality

- [ ] Add comprehensive unit tests for business logic
- [ ] Implement integration tests for critical flows
- [ ] Add widget tests for UI components
- [ ] Set up code coverage reporting
- [ ] Implement automated linting in CI/CD
- [ ] Add API documentation with Swagger/OpenAPI

### Performance

- [ ] Optimize image loading and caching
- [ ] Implement pagination for large lists
- [ ] Add database query optimization
- [ ] Implement lazy loading for heavy screens
- [ ] Profile app performance with DevTools
- [ ] Optimize bundle size

### Infrastructure

- [x] Set up CI/CD pipeline for APK builds
- [x] Configure automated APK releases to GitHub
- [x] Implement version checking in CI/CD
- [x] Set up Docker-based build environment
- [ ] Configure automated testing in CI/CD
- [ ] Set up staging environment
- [ ] Implement error tracking (Sentry/Firebase Crashlytics)
- [ ] Add analytics (Firebase Analytics/Mixpanel)
- [ ] Set up automated backups for production database
- [ ] Add iOS build pipeline

### Security

- [ ] Implement rate limiting on API endpoints
- [ ] Add input sanitization and validation
- [ ] Set up security headers
- [ ] Implement API key rotation
- [ ] Add penetration testing
- [ ] Set up SSL certificate management

---

## 🚀 Future Features (Ideas)

### AI & Machine Learning

- [ ] AI-powered meal recommendations
- [ ] Personalized workout plan generation
- [ ] Progress prediction and insights
- [ ] Food recognition from photos
- [ ] Form analysis for exercises (using camera)

### Advanced Analytics

- [ ] Correlation analysis (diet vs. progress)
- [ ] Predictive analytics for goal achievement
- [ ] Personalized insights and recommendations
- [ ] Export data to CSV/PDF reports

### Integrations

- [ ] Integration with fitness trackers (Fitbit, Garmin)
- [ ] Integration with smart scales
- [ ] Integration with meal delivery services
- [ ] Integration with grocery shopping apps
- [ ] Calendar integration for meal/workout planning

### Gamification

- [ ] Achievement badges system
- [ ] Streak tracking
- [ ] Points and rewards system
- [ ] Daily challenges
- [ ] Seasonal events

---

## 📝 Notes & Decisions

### Architecture Decisions

- **State Management**: Using BLoC pattern with Cubit for state management
- **Dependency Injection**: GetIt for service location
- **Backend**: Serverpod framework with PostgreSQL and Redis
- **Authentication**: JWT-based with email/password and Google OAuth
- **Localization**: Spanish as primary language with enum extensions
- **Exercise Logs**: Dedicated `getExerciseLogs` API endpoint for fetching logs
  separately from workout plans
- **UI Updates**: Optimistic updates pattern for instant feedback on exercise
  logging/deletion
- **Charts**: Using `fl_chart` package for exercise statistics visualization
  with line charts for progress tracking
- **State Management**: Exercise details screen uses Cubit pattern for managing
  log loading and date range filtering
- **Dashboard Aggregation**: Weekly summary calculations performed on
  server-side for better performance and efficiency
- **Dashboard Architecture**: Home dashboard uses separate `DashboardRepository`
  and `DashboardEndpoint` for weekly metrics aggregation
- **Workout History**: Comprehensive history tracking with backend endpoints
  (`getWorkoutHistory`, `getWorkoutProgressMetrics`,
  `getWorkoutSessionsByDateRange`) for fetching past sessions, calculating
  streaks, and aggregating progress metrics
- **Progress Visualization**: Workout history screen with progress metrics
  cards, frequency charts, and session details with navigation to exercise
  details
- **Nutrition Color Coding**: Dynamic color system for nutrition progress
  indicators (green for 90-110% target, yellow for 70-90%/110-130%, red for
  <70%/>130%) with contextual Spanish messages to guide users on their nutrition
  goals

### Design Decisions

- **Onboarding**: Multi-step flow collecting user goals, body stats, activity
  level, exercise difficulty, and dietary restrictions
- **Navigation**: Bottom navigation with main sections (Home, Workouts,
  Nutrition, Profile)
- **Theme**: Material Design 3 with custom color scheme

### Known Issues

- [ ] Document any known bugs or issues here

---

## 📅 Release Planning

### Version 1.1.0 (MVP) - Target: TBD

**Core Features:**

- ✅ User authentication (email/password, Google OAuth)
- ✅ User onboarding flow
- ✅ Profile management
- ✅ Basic nutrition logging with meal plans
- ✅ Daily nutrition tracking dashboard
- ✅ Macro tracking and visualization
- ✅ Basic workout tracking with active plan display
- ✅ Workout completion tracking with exercise logging
- ✅ Exercise log management (create/delete)
- ✅ Session completion feedback
- ✅ Exercise statistics graphs and progress visualization
- ✅ Simple dashboard with key metrics
- ✅ Comprehensive workout history and progress tracking

### Version 1.2.0 - Target: TBD

**Enhanced Features:**

- [ ] Workout plan creation
- [ ] Nutrition plan generation
- [ ] Progress charts and analytics
- [ ] Push notifications
- [ ] Settings and preferences

### Version 1.3.0 - Target: TBD

**Advanced Features:**

- [ ] Social features (friends, sharing)
- [ ] Advanced analytics
- [ ] Health app integrations
- [ ] Widgets (iOS/Android)

---

## 🤝 Contributing

When working on items from this roadmap:

1. **Move items** from Backlog to "In Progress" when starting work
2. **Update status** regularly to reflect current state
3. **Mark completed** items with ✅ and move to "Recently Completed"
4. **Add notes** in the Notes section for important decisions
5. **Update** the "Last Updated" date at the top

---

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Serverpod Documentation](https://docs.serverpod.dev/)
- [BLoC Pattern Guide](https://bloclibrary.dev/)
- [Material Design 3](https://m3.material.io/)

---

**Project Repository**: [Add GitHub/GitLab link here]\
**Issue Tracker**: [Add issue tracker link here]\
**Project Board**: [Add project board link here]
