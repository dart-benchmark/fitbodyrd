# FitBodyRD 💪

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.24.0+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.5.0+-0175C2?logo=dart&logoColor=white)
![Serverpod](https://img.shields.io/badge/Serverpod-2.9.2-FF6B6B?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

**A comprehensive fitness and nutrition tracking application built with Flutter
and Serverpod**

[Features](#-features) • [Quick Start](#-quick-start) •
[Architecture](#-architecture) • [Documentation](#-documentation) •
[Contributing](#-contributing)

</div>

---

## 📖 Overview

**FitBodyRD** is a full-stack mobile application designed to help users achieve
their fitness goals through personalized meal plans, workout routines, and
comprehensive progress tracking. Built with modern technologies, it provides a
seamless experience for managing nutrition, workouts, and overall health.

### Key Highlights

- 🎯 **Personalized Plans**: AI-powered meal and workout plan generation
- 📊 **Progress Tracking**: Comprehensive analytics and visualization
- 🍎 **Nutrition Management**: Food logging, macro tracking, and meal planning
- 🏋️ **Workout Management**: Exercise database, session tracking, and progress
  monitoring
- 🔐 **Secure Authentication**: Email/password and Google OAuth integration
- 📱 **Cross-Platform**: Native iOS and Android support

---

## ✨ Features

### 🍎 Nutrition Features

- **Meal Plan Generation**: AI-powered personalized meal plans based on user
  goals
- **Food Logging**: Track consumed foods with serving sizes and nutritional
  information
- **Macro Tracking**: Real-time monitoring of calories, proteins, carbs, and
  fats
- **Nutrition Dashboard**: Daily nutrition overview with color-coded progress
  indicators
- **Food Search**: Search and add foods from an extensive database
- **Meal Editing**: Edit or delete logged meals with intuitive swipe gestures

### 🏋️ Workout Features

- **Workout Plans**: View and follow personalized workout routines
- **Exercise Database**: Comprehensive exercise library with images, videos, and
  instructions
- **Exercise Logging**: Track completed exercises with sets, reps, and weights
- **Progress Visualization**: Charts and graphs showing exercise progression
  over time
- **Workout History**: Complete workout history with session details
- **Statistics**: Track streaks, averages, and workout frequency

### 📊 Dashboard & Analytics

- **Home Dashboard**: Personalized greeting with weekly summary metrics
- **Today's Progress**: Quick view of nutrition and workout status
- **Weekly Summaries**: Aggregated metrics for workouts and nutrition
- **Progress Charts**: Visual representation of exercise progression
- **Workout Metrics**: Streaks, totals, and frequency analysis

### 👤 User Management

- **Multi-step Onboarding**: Guided setup for body stats, goals, and preferences
- **Profile Management**: View and manage user information
- **Secure Authentication**: Email/password and Google Sign-In
- **Session Management**: Secure token-based authentication

---

## 🏗️ Architecture

FitBodyRD follows a **monorepo structure** with three main components:

```
fitbodyrd/
├── fitbodyrd_flutter/      # Flutter mobile application
├── fitbodyrd_server/       # Serverpod backend server
├── fitbodyrd_client/       # Auto-generated Serverpod client
└── fitbodyrd_agent/        # AI agent documentation
```

### Tech Stack

**Frontend (Flutter)**

- **Framework**: Flutter 3.24.0+
- **Language**: Dart 3.5.0+
- **State Management**: BLoC (flutter_bloc) with Cubit pattern
- **Dependency Injection**: GetIt
- **Routing**: GoRouter
- **Architecture**: Clean Architecture (Data → Domain → Presentation)

**Backend (Serverpod)**

- **Framework**: Serverpod 2.9.2
- **Database**: PostgreSQL 16 with pgvector extension
- **Cache**: Redis 6.2.6
- **Email**: Resend (via easy_resend)
- **Architecture**: Feature-based modular architecture

**Communication**

- Type-safe RPC calls via Serverpod protocol
- Auto-generated client code for type safety

---

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK**: >=3.24.0
- **Dart SDK**: >=3.5.0 <4.0.0
- **Docker & Docker Compose**: For local databases
- **PostgreSQL 16** with pgvector extension
- **Redis 6.2.6+**

### Backend Setup

1. **Navigate to server directory**
   ```bash
   cd fitbodyrd_server
   ```

2. **Start database services**

   ```bash
   docker compose up --build --detach
   ```

3. **Install dependencies**
   ```bash
   dart pub get
   ```

4. **Configure environment**
   - Edit `config/development.yaml`
   - Add `config/passwords.yaml` (not in git)
   - Configure Google OAuth in `config/google_client_secret.json`

5. **Run server**
   ```bash
   dart bin/main.dart
   ```

   Server runs on:
   - API: `http://localhost:8080`
   - Insights: `http://localhost:8081`
   - Web: `http://localhost:8082`

### Flutter App Setup

1. **Navigate to Flutter directory**
   ```bash
   cd fitbodyrd_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment**
   - Create `.env` file (see `fitbodyrd_flutter/README.md` for template)
   - Set `SERVERPOD_URL`, Google OAuth credentials
   - Generate env code:
     ```bash
     reload_env.sh
     ```

4. **Run app**
   ```bash
   flutter run
   ```

### Client Package

The client package is auto-generated by Serverpod. Regenerate after backend
changes:

```bash
cd fitbodyrd_server
serverpod generate
```

---

## 📁 Project Structure

```
fitbodyrd/
│
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
│   │       └── core/           # Shared utilities
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
│   │       └── generated/    # Serverpod generated code
│   ├── config/                # Environment configs (YAML)
│   ├── migrations/            # Database migrations
│   └── docker-compose.yaml    # Local dev database setup
│
├── fitbodyrd_client/          # Auto-generated Serverpod client
│   └── lib/src/protocol/      # Generated protocol code
│
└── fitbodyrd_agent/           # AI agent documentation
    └── meal_plans_agent/       # Meal plan generation agent
```

---

## 📚 Documentation

### Project Documentation

- **[PROJECT_CONTEXT.md](./PROJECT_CONTEXT.md)** - Comprehensive project context
  and architecture guide
- **[DEVELOPMENT_ROADMAP.md](./DEVELOPMENT_ROADMAP.md)** - Development progress
  and roadmap

### Component Documentation

- **[Flutter App README](./fitbodyrd_flutter/README.md)** - Flutter app setup
  and development guide
- **[Server README](./fitbodyrd_server/README.md)** - Backend server setup and
  API documentation
- **[Client README](./fitbodyrd_client/README.md)** - Client package information

### Agent Documentation

- **[Meal Plans Agent](./fitbodyrd_agent/meal_plans_agent/README.md)** - AI meal
  plan generation agent

---

## 🛠️ Development

### Making Backend Changes

1. Modify endpoint/model files
2. Generate code:
   ```bash
   cd fitbodyrd_server
   serverpod generate
   ```
3. Create migration if schema changed:
   ```bash
   serverpod create-migration
   ```
4. Client package auto-updates

### Making Flutter Changes

1. Follow Clean Architecture structure
2. Add new features in `features/` directory
3. Register dependencies in `injection_container.dart`
4. Add routes in `app_router.dart`

### Database Migrations

- Migrations auto-apply on server start
- Review migration files before committing
- Test migrations in test environment first

---

## 🧪 Testing

### Backend Tests

```bash
cd fitbodyrd_server
dart test
```

### Flutter Tests

```bash
cd fitbodyrd_flutter
flutter test
```

### Test Database

- Separate PostgreSQL instance on port `9090`
- Configured via `config/test.yaml`

---

## 📦 Building for Production

### Android

```bash
cd fitbodyrd_flutter
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
cd fitbodyrd_flutter
flutter build ios --release
```

---

## 🔧 Configuration

### Environment Variables

**Flutter App** (`.env` file):

- `ENVIRONMENT` - Environment name
- `SERVERPOD_URL` - Backend API URL
- `GOOGLE_REDIRECT_URL` - OAuth redirect
- `GOOGLE_SERVER_CLIENT_ID` - Server OAuth client ID
- `GOOGLE_CLIENT_ID_ANDROID` - Android OAuth client ID
- `GOOGLE_CLIENT_ID_IOS` - iOS OAuth client ID

**Backend Server** (`config/*.yaml`):

- API server ports and hosts
- Database connection (PostgreSQL)
- Redis connection
- Authentication settings
- Email service (Resend) configuration

---

## 🎨 Design System

The app uses a custom design system with:

- **Material Design 3** theme
- **Google Fonts** for typography
- **Custom color scheme** with brand colors
- **Consistent spacing** utilities
- **Spanish localization** as primary language

---

## 🔐 Security

- **Secure Storage**: User credentials stored with `flutter_secure_storage`
- **JWT Tokens**: Secure session management via Serverpod Auth
- **Password Hashing**: Bcrypt-based secure password hashing
- **SQL Injection Protection**: Parameterized queries via Serverpod ORM
- **Environment Isolation**: Separate configurations for dev/staging/prod

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Clean Architecture principles
- Write tests for new features
- Update documentation as needed
- Follow the existing code style
- Ensure all tests pass before submitting

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file
for details.

---

## 🙏 Acknowledgments

- [Serverpod](https://serverpod.dev) - Backend framework
- [Flutter](https://flutter.dev) - UI framework
- [BLoC](https://bloclibrary.dev) - State management
- [Resend](https://resend.com) - Email service

---

## 📞 Support

For issues and questions:

- [Create an issue](../../issues) in the repository
- Review [PROJECT_CONTEXT.md](./PROJECT_CONTEXT.md) for detailed information

---

<div align="center">

**Made with ❤️ using Flutter and Serverpod**

</div>
