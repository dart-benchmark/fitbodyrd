# FitBodyRD Project Context

> **Quick Reference Guide** - Last Updated: January 2025

A comprehensive fitness and nutrition tracking application built with Flutter
and Serverpod. This document provides essential context for developers working
on the project.

---

## 📋 Executive Summary

**FitBodyRD** is a mobile fitness and nutrition tracking application designed to
help users achieve their body goals through personalized meal plans, workout
routines, and progress tracking. The project consists of three main components:

- **Flutter App** (`fitbodyrd_flutter/`) - Mobile client application
- **Serverpod Backend** (`fitbodyrd_server/`) - RESTful API server
- **Client Package** (`fitbodyrd_client/`) - Auto-generated Serverpod client

**Current Version**: 1.0.3+4 (Flutter app)

---

## 🏗️ Architecture Overview

### Tech Stack

**Frontend (Flutter)**

- **Framework**: Flutter 3.24.0+
- **Language**: Dart 3.5.0+
- **State Management**: BLoC (flutter_bloc) with Cubit pattern
- **Dependency Injection**: GetIt
- **Routing**: GoRouter
- **Backend Client**: Serverpod Flutter client
- **Storage**: flutter_secure_storage, shared_preferences

**Backend (Serverpod)**

- **Framework**: Serverpod 2.9.2
- **Database**: PostgreSQL 16 with pgvector extension
- **Cache**: Redis 6.2.6
- **Email**: Resend (via easy_resend)
- **HTTP Client**: Dio
- **Dependency Injection**: GetIt

**Architecture Pattern**

- **Flutter App**: Clean Architecture (Data → Domain → Presentation layers)
- **Backend**: Feature-based modular architecture
- **Communication**: Type-safe RPC calls via Serverpod protocol

---

## 📁 Project Structure

```
fitbodyrd/
├── fitbodyrd_flutter/          # Flutter mobile application
│   ├── lib/
│   │   ├── features/           # Feature modules (Clean Architecture)
│   │   │   ├── auth/          # Authentication
│   │   │   ├── onboarding/    # User onboarding flow
│   │   │   ├── nutrition/     # Nutrition tracking & meal plans
│   │   │   ├── workouts/      # Workout management
│   │   │   ├── profile/       # User profile
│   │   │   └── splash/        # Splash screen & routing
│   │   └── src/
│   │       ├── app/           # App configuration
│   │       └── core/          # Shared utilities
│   │           ├── env/       # Environment config
│   │           ├── extensions/# Dart extensions
│   │           ├── injections/# Dependency injection
│   │           ├── routing/   # Navigation (GoRouter)
│   │           ├── services/  # Core services
│   │           ├── style/     # Theme & design system
│   │           └── utils/     # Helper utilities
│   └── assets/                # Images, icons, etc.
│
├── fitbodyrd_server/           # Serverpod backend server
│   ├── lib/
│   │   ├── server.dart        # Server entry point
│   │   └── src/
│   │       ├── features/      # Feature modules
│   │       │   ├── auth/     # Authentication setup
│   │       │   ├── email/    # Email services
│   │       │   ├── exercise/ # Exercise database
│   │       │   ├── food/     # Food database
│   │       │   ├── nutrition/# Nutrition tracking
│   │       │   ├── nutrition_plan/ # Meal planning
│   │       │   ├── user/     # User management
│   │       │   └── workouts/ # Workout management
│   │       ├── generated/    # Serverpod generated code
│   │       └── web/          # Web routes & static files
│   ├── config/                # Environment configs (YAML)
│   ├── migrations/            # Database migrations
│   └── docker-compose.yaml    # Local dev database setup
│
├── fitbodyrd_client/          # Auto-generated Serverpod client
│   └── lib/src/protocol/      # Generated protocol code
│
└── fitbodyrd_agent/           # AI agent documentation
    └── meal_plans_agent/      # Meal plan generation agent
```

---

## 🎯 Key Features

### 1. Authentication (`features/auth/`)

- **Email/Password** authentication with email verification
- **Google OAuth** sign-in integration
- **JWT-based** session management
- **Password reset** flow (forgot password)
- **Secure token storage** using flutter_secure_storage

**Key Files:**

- `fitbodyrd_flutter/lib/features/auth/presentation/cubits/auth_cubit/`
- `fitbodyrd_flutter/lib/features/auth/presentation/screens/login_screen.dart`
- `fitbodyrd_server/lib/src/features/auth/utils/auth_setup.dart`

### 2. User Onboarding (`features/onboarding/`)

Multi-step onboarding flow collecting:

- Personal information (name, email, birth date)
- Body stats (weight, height, sex)
- Fitness goals (lose weight, maintain, gain muscle)
- Activity level (sedentary → very active)
- Exercise preferences (difficulty, equipment, time)
- Dietary restrictions (vegetarian, vegan, keto, etc.)

**Key Files:**

- `fitbodyrd_flutter/lib/features/onboarding/screens/onboarding_screen.dart`
- `fitbodyrd_flutter/lib/features/onboarding/presentation/cubit/onboarding_cubit.dart`

### 3. Nutrition Management (`features/nutrition/`)

- **Meal Plan Generation**: AI-powered personalized meal plans
- **Daily Nutrition Dashboard**: Track macros (protein, carbs, fats, calories)
- **Food Logging**: Log consumed foods with serving sizes
- **Meal Editing**: Edit/delete logged meals
- **Food Search**: Search and add foods to meal plans
- **Day Selector**: View nutrition data for different days
- **Macro Breakdown**: Per-meal and per-food macro visualization

**Key Files:**

- `fitbodyrd_flutter/lib/features/nutrition/presentation/screens/nutrition_dashboard_screen.dart`
- `fitbodyrd_flutter/lib/features/nutrition/presentation/cubits/nutrition_dashboard_cubit.dart`
- `fitbodyrd_server/lib/src/features/nutrition_plan/endpoints/nutrition_plan_endpoint.dart`
- `fitbodyrd_server/lib/src/features/nutrition/endpoints/nutrition_endpoint.dart`

### 4. Workout Management (`features/workouts/`)

- **Workout Plan Display**: View active workout plans
- **Exercise Logging**: Track completed exercises
- **Exercise Details**: View exercise information (images, videos, instructions)
- **Session Completion**: Celebration dialog on workout completion
- **Date Selector**: View workouts for different days
- **Rest Day Handling**: Display rest day messages

**Key Files:**

- `fitbodyrd_flutter/lib/features/workouts/presentation/screens/workout_dashboard_screen.dart`
- `fitbodyrd_flutter/lib/features/workouts/presentation/screens/exercise_details_screen.dart`
- `fitbodyrd_server/lib/src/features/workouts/endpoints/workout_endpoint.dart`

### 5. User Profile (`features/profile/`)

- View user information
- Display fitness metrics (BMI, weight category)
- App version display
- Logout functionality
- User stats section

**Key Files:**

- `fitbodyrd_flutter/lib/features/profile/presentation/screens/profile_screen.dart`

### 6. Splash Screen (`features/splash/`)

- Initial app routing logic
- Profile verification
- Redirects based on authentication and onboarding status

**Key Files:**

- `fitbodyrd_flutter/lib/features/splash/presentation/screens/splash_screen.dart`
- `fitbodyrd_flutter/lib/features/splash/presentation/cubits/splash_cubit/`

---

## 🗄️ Database Schema Overview

### Core Models

**User & Profile**

- `app_user` (via Serverpod Auth) - User accounts
- `user_profiles` - Extended user profile with fitness data
  - Body stats (weight, height, BMI)
  - Goals (lose weight, maintain, gain muscle)
  - Activity level, exercise preferences
  - Dietary restrictions

**Nutrition**

- `foods` - Food database with nutritional information
- `food_categories` - Food categorization
- `food_serving_sizes` - Serving size options per food
- `food_micronutrients` - Micronutrient data
- `nutrition_plans` - User nutrition plans
- `meal_plans` - Daily meal plans (part of nutrition plan)
- `meal_plan_foods` - Foods in each meal (soft delete support)
- `food_intake_logs` - Logged consumed foods

**Workouts**

- `exercises` - Exercise database
- `exercise_images` - Exercise images with ordering
- `exercise_alternatives` - Alternative exercises
- `workout_plans` - User workout plans
- `workout_sessions` - Daily workout sessions
- `workout_exercises` - Exercises in sessions
- `exercise_logs` - Logged completed exercises

**User Preferences**

- `user_food_preferences` - Food preferences (favorites, allergies, exclusions)

### Database Setup

**Development Database** (Docker Compose)

- PostgreSQL: `localhost:8090`
- Database: `fitbodyrd`
- Redis: `localhost:8091`

**Test Database**

- PostgreSQL: `localhost:9090`
- Database: `fitbodyrd_test`
- Redis: `localhost:9091`

**Migrations**

- Located in `fitbodyrd_server/migrations/`
- Auto-applied on server start
- Create new: `dart run serverpod_cli create-migration`

---

## 🔌 API Structure

### Endpoint Organization

All endpoints are organized by feature in `fitbodyrd_server/lib/src/features/`:

**Authentication** (`/auth/*`)

- Handled by Serverpod Auth module
- Email/password, Google OAuth

**User Management** (`/user/*`)

- `user_endpoint.dart` - User profile CRUD
- `admin_user_endpoint.dart` - Admin operations

**Food & Nutrition** (`/food/*`, `/nutrition/*`, `/nutritionPlan/*`)

- `food_endpoint.dart` - Food search, categories
- `nutrition_endpoint.dart` - Macro calculations, intake logs
- `nutrition_plan_endpoint.dart` - Meal plan generation and management
- `food_intake_log_endpoint.dart` - Food logging

**Workouts** (`/workouts/*`, `/exercise/*`)

- `workout_endpoint.dart` - Workout plans, sessions, exercise logs
- `exercise_endpoint.dart` - Exercise database queries

**Email** (`/email/*`)

- `email_endpoint.dart` - Email template management

### Future Calls (Background Jobs)

Registered in `fitbodyrd_server/lib/server.dart`:

- `emailTemplate` - Email template updates
- `workoutTip` - Workout tip generation
- `completeExpiredPlans` - Scheduled plan completion (runs at midnight DR time)

---

## 🚀 Development Setup

### Prerequisites

- **Flutter SDK**: >=3.24.0
- **Dart SDK**: >=3.5.0 <4.0.0
- **Docker & Docker Compose**: For local databases
- **PostgreSQL 16** with pgvector extension
- **Redis 6.2.6+**

### Backend Setup

1. **Start database services**
   ```bash
   cd fitbodyrd_server
   docker compose up --build --detach
   ```

2. **Install dependencies**
   ```bash
   dart pub get
   ```

3. **Configure environment**
   - Edit `config/development.yaml`
   - Add `config/passwords.yaml` (not in git)
   - Configure Google OAuth in `config/google_client_secret.json`

4. **Run server**
   ```bash
   dart bin/main.dart
   # Or use watch mode:
   ./run_serverpod_watch.sh
   ```

   Server runs on:
   - API: `http://localhost:8080`
   - Insights: `http://localhost:8081`
   - Web: `http://localhost:8082`

### Flutter App Setup

1. **Install dependencies**
   ```bash
   cd fitbodyrd_flutter
   flutter pub get
   ```

2. **Configure environment**
   - Create `.env` file (see README for template)
   - Set `SERVERPOD_URL`, Google OAuth credentials
   - Generate env code:
     ```bash
     dart run build_runner build --delete-conflicting-outputs
     ```

3. **Run app**
   ```bash
   flutter run
   ```

### Client Package

Auto-generated by Serverpod. Regenerate after backend changes:

```bash
cd fitbodyrd_server
dart run serverpod_cli generate
```

---

## ⚙️ Configuration Files

### Backend Configuration

**`fitbodyrd_server/config/`**

- `development.yaml` - Development environment config
- `staging.yaml` - Staging environment
- `production.yaml` - Production environment
- `test.yaml` - Test environment
- `passwords.yaml` - Sensitive credentials (not in git)
- `google_client_secret.json` - Google OAuth credentials

**Key Config Sections:**

- API server ports and hosts
- Database connection (PostgreSQL)
- Redis connection
- Authentication settings
- Email service (Resend) configuration

### Flutter App Configuration

**Environment Variables** (`.env` file)

- `ENVIRONMENT` - Environment name
- `SERVERPOD_URL` - Backend API URL
- `GOOGLE_REDIRECT_URL` - OAuth redirect
- `GOOGLE_SERVER_CLIENT_ID` - Server OAuth client ID
- `GOOGLE_CLIENT_ID_ANDROID` - Android OAuth client ID
- `GOOGLE_CLIENT_ID_IOS` - iOS OAuth client ID

**Generated from `.env`** via `envied` package:

- `fitbodyrd_flutter/lib/src/core/env/app_env.dart`

---

## 🎨 Design System

### Theme Configuration

**Location**: `fitbodyrd_flutter/lib/src/core/style/`

- **Colors**: `k_colors.dart` - Brand colors and theme
- **Typography**: `k_text.dart` - Text styles (Google Fonts)
- **Spacing**: `k_sizedbox.dart` - Consistent spacing utilities
- **Theme**: `app_theme.dart` - Material Design 3 theme

### Localization

- **Primary Language**: Spanish
- **Enum Translations**:
  `fitbodyrd_flutter/lib/src/core/extensions/enum_translations.dart`
- Translated enums: `Sex`, `BodyGoal`, `ActivityLevel`, `ExerciseDifficulty`,
  `DietaryRestriction`, `ExerciseMuscleGroup`

---

## 🔑 Key Design Decisions

### Architecture Patterns

1. **Clean Architecture** (Flutter)
   - Separation: Data → Domain → Presentation
   - Repositories abstract data sources
   - Use cases in domain layer (future expansion)

2. **BLoC Pattern**
   - Cubit for simple state management
   - State classes for immutable state
   - Repository pattern for data access

3. **Dependency Injection**
   - GetIt for service location
   - Centralized in `injection_container.dart`
   - Lazy singletons for services, factories for cubits

### State Management

- **Optimistic UI Updates**: Exercise logging uses optimistic updates for
  instant feedback
- **Stream-based Auth**: GoRouter refresh stream for auth state changes
- **Cached Preferences**: SharedPreferencesWithCache for performance

### Data Flow

```
UI (Widget) 
  → Cubit (State Management)
    → Repository (Data Abstraction)
      → Serverpod Client (API Calls)
        → Serverpod Server (Business Logic)
          → PostgreSQL Database
```

### Navigation

- **GoRouter** with declarative routing
- **StatefulShellRoute** for bottom navigation
- **Route Guards**: Auth-based redirects
- **Deep Linking**: Supported via GoRouter

### Backend Patterns

- **Feature-based Modules**: Each feature in own directory
- **DTOs**: Data transfer objects for complex requests
- **Future Calls**: Background jobs for async processing
- **Soft Deletes**: Used for meal plan foods
- **Transaction-based Updates**: For data consistency

---

## 📝 Important Notes

### Development Workflow

1. **Making Backend Changes**
   - Modify endpoint/model files
   - Run `dart run serverpod_cli generate`
   - Create migration if schema changed:
     `dart run serverpod_cli create-migration`
   - Client package auto-updates

2. **Making Flutter Changes**
   - Follow Clean Architecture structure
   - Add new features in `features/` directory
   - Register dependencies in `injection_container.dart`
   - Add routes in `app_router.dart`

3. **Database Migrations**
   - Migrations auto-apply on server start
   - Review migration files before committing
   - Test migrations in test environment first

### Gotchas & Warnings

- **Serverpod Client**: Must regenerate after backend model changes
- **Environment Variables**: Flutter app requires `.env` file (not in git)
- **Database Passwords**: In `docker-compose.yaml` (consider moving to secrets)
- **Google OAuth**: Requires separate client IDs for web, Android, iOS
- **Time Zones**: Future calls use Dominican Republic timezone
  (America/Santo_Domingo)
- **Soft Deletes**: Meal plan foods use soft delete pattern
- **Optimistic Updates**: Exercise logs use optimistic UI pattern

### Testing

- **Backend**: `dart test` in `fitbodyrd_server/`
- **Flutter**: `flutter test` in `fitbodyrd_flutter/`
- **Test Database**: Separate PostgreSQL instance on port 9090

---

## 🔗 Key File Locations

### Flutter App

| Purpose              | File Path                                                            |
| -------------------- | -------------------------------------------------------------------- |
| App Entry            | `fitbodyrd_flutter/lib/main.dart`                                    |
| App Configuration    | `fitbodyrd_flutter/lib/src/app/app.dart`                             |
| Dependency Injection | `fitbodyrd_flutter/lib/src/core/injections/injection_container.dart` |
| Routing              | `fitbodyrd_flutter/lib/src/core/routing/app_router.dart`             |
| Environment Config   | `fitbodyrd_flutter/lib/src/core/env/app_env.dart`                    |
| Theme                | `fitbodyrd_flutter/lib/src/core/style/app_theme.dart`                |

### Backend Server

| Purpose              | File Path                                                           |
| -------------------- | ------------------------------------------------------------------- |
| Server Entry         | `fitbodyrd_server/lib/server.dart`                                  |
| Server Main          | `fitbodyrd_server/bin/main.dart`                                    |
| Auth Setup           | `fitbodyrd_server/lib/src/features/auth/utils/auth_setup.dart`      |
| Dependency Injection | `fitbodyrd_server/lib/src/core/injections/injection_container.dart` |

### Configuration

| Purpose         | File Path                                  |
| --------------- | ------------------------------------------ |
| Docker Compose  | `fitbodyrd_server/docker-compose.yaml`     |
| Dev Config      | `fitbodyrd_server/config/development.yaml` |
| Flutter Pubspec | `fitbodyrd_flutter/pubspec.yaml`           |
| Server Pubspec  | `fitbodyrd_server/pubspec.yaml`            |

---

## 📚 Additional Resources

- **Development Roadmap**: `DEVELOPMENT_ROADMAP.md`
- **Server README**: `fitbodyrd_server/README.md`
- **Flutter README**: `fitbodyrd_flutter/README.md`
- **Meal Plan Agent**: `fitbodyrd_agent/meal_plans_agent/README.md`
- **Serverpod Docs**: https://docs.serverpod.dev
- **Flutter Docs**: https://docs.flutter.dev

---

## 🚦 Quick Commands Reference

### Backend

```bash
# Start databases
docker compose up -d

# Run server
dart bin/main.dart

# Generate code
dart run serverpod_cli generate

# Create migration
dart run serverpod_cli create-migration

# Run tests
dart test
```

### Flutter

```bash
# Install dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Run app
flutter run

# Run tests
flutter test
```

---

**Last Updated**: January 2025\
**Project Status**: Active Development\
**Version**: 1.0.3+4
