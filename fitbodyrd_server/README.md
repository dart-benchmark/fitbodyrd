# FitBodyRD Server

A robust Serverpod backend server for the FitBodyRD fitness and nutrition tracking application.

## 📋 Overview

FitBodyRD Server is built with [Serverpod](https://serverpod.dev), a scalable app server framework for Dart. It provides RESTful APIs and real-time capabilities for user authentication, nutrition planning, workout management, and more.

## ✨ Features

- **Authentication & Authorization**
  - Email/Password authentication
  - Google OAuth integration
  - JWT-based session management
  - Secure password hashing

- **User Management**
  - User profile CRUD operations
  - Onboarding data management
  - User preferences and settings

- **Nutrition Services**
  - Food database and search
  - Nutritional information tracking
  - Personalized nutrition plans
  - Meal planning and recommendations

- **Workout Management**
  - Exercise database
  - Custom workout routines
  - Workout tracking and history

- **Email Services**
  - Transactional emails (verification, password reset)
  - Email templates with Resend integration
  - Asynchronous email processing via future calls

## 🏗️ Architecture

The server follows a feature-based modular architecture:

```
lib/
├── server.dart              # Server entry point
└── src/
    ├── common/              # Shared utilities
    ├── core/                # Core functionality
    ├── errors/              # Error handling
    ├── features/            # Feature modules
    │   ├── auth/           # Authentication
    │   ├── email/          # Email services
    │   ├── exercise/       # Exercise management
    │   ├── food/           # Food database
    │   ├── nutrition/      # Nutrition tracking
    │   ├── nutrition_plan/ # Meal planning
    │   ├── user/           # User management
    │   └── workouts/       # Workout management
    ├── generated/          # Serverpod generated code
    └── web/                # Web routes & static files
```

### Key Technologies

- **Framework**: Serverpod 2.9.2
- **Database**: PostgreSQL with pgvector extension
- **Cache**: Redis
- **Email**: Resend (via easy_resend)
- **Dependency Injection**: GetIt
- **HTTP Client**: Dio

## 🚀 Getting Started

### Prerequisites

- Dart SDK `>=3.5.0 <4.0.0`
- Docker & Docker Compose
- PostgreSQL 16 with pgvector
- Redis 6.2.6+

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd fitbodyrd/fitbodyrd_server
   ```

2. **Install dependencies**
   ```bash
   dart pub get
   ```

3. **Start database services**
   
   The project uses Docker Compose to run PostgreSQL and Redis:
   ```bash
   docker compose up --build --detach
   ```
   
   This starts:
   - **PostgreSQL** (development) on port `8090`
   - **Redis** (development) on port `8091`
   - **PostgreSQL** (test) on port `9090`
   - **Redis** (test) on port `9091`

4. **Configure the server**
   
   Server configuration is managed through YAML files in the `config/` directory:
   - `development.yaml` - Development environment
   - `staging.yaml` - Staging environment
   - `production.yaml` - Production environment
   - `test.yaml` - Test environment
   - `passwords.yaml` - Sensitive credentials (not committed to git)

5. **Run database migrations**
   ```bash
   # Migrations are applied automatically on server start
   # Or run manually if needed
   dart run serverpod_cli create-migration
   ```

6. **Start the server**
   ```bash
   dart bin/main.dart
   ```
   
   Or use the watch script for development:
   ```bash
   ./run_serverpod_watch.sh
   ```

The server will start on:
- **API Server**: `http://localhost:8080`
- **Insights**: `http://localhost:8081`
- **Web Server**: `http://localhost:8082`

### Stopping Services

```bash
# Stop the Serverpod server
# Press Ctrl-C in the terminal

# Stop Docker services
docker compose stop

# Or stop and remove containers
docker compose down
```

## 🔧 Configuration

### Environment-Specific Configuration

The server uses YAML configuration files for different environments. Key configuration sections include:

- **API Server**: Port, public host, public scheme
- **Insights**: Port and public host
- **Web Server**: Port and public host
- **Database**: Connection settings for PostgreSQL
- **Redis**: Connection settings for caching
- **Authentication**: Google OAuth credentials
- **Email**: Resend API configuration

### Database Configuration

PostgreSQL connection details (from `docker-compose.yaml`):

**Development Database:**
- Host: `localhost`
- Port: `8090`
- Database: `fitbodyrd`
- User: `postgres`
- Password: See `docker-compose.yaml`

**Test Database:**
- Host: `localhost`
- Port: `9090`
- Database: `fitbodyrd_test`
- User: `postgres`
- Password: See `docker-compose.yaml`

### Google OAuth Setup

1. Create OAuth credentials in [Google Cloud Console](https://console.cloud.google.com)
2. Add credentials to `config/google_client_secret.json`
3. Configure redirect URIs in your Google Cloud project

### Email Configuration

The server uses [Resend](https://resend.com) for transactional emails:

1. Sign up for a Resend account
2. Generate an API key
3. Add the API key to your configuration
4. Configure email templates in `lib/src/features/email/`

## 🗄️ Database

### Schema Management

Serverpod uses migrations for database schema management:

```bash
# Create a new migration
dart run serverpod_cli create-migration

# Apply migrations
# Migrations are automatically applied on server start
```

Migrations are stored in the `migrations/` directory.

### Database Features

- **pgvector Extension**: Enabled for vector similarity search (useful for AI features)
- **Automatic Migrations**: Applied on server startup
- **Connection Pooling**: Managed by Serverpod

## 📡 API Endpoints

The server exposes endpoints organized by feature:

- `/auth/*` - Authentication endpoints
- `/user/*` - User management
- `/food/*` - Food database
- `/nutrition/*` - Nutrition tracking
- `/nutritionPlan/*` - Meal planning
- `/exercise/*` - Exercise database
- `/workouts/*` - Workout management
- `/email/*` - Email services

API documentation is available through Serverpod Insights at `http://localhost:8081`.

## 🔄 Future Calls

The server uses Serverpod's future calls for asynchronous processing:

- **Email Templates**: Periodic email template updates
- Configured in `lib/server.dart`

## 🧪 Testing

```bash
# Run all tests
dart test

# Run specific test file
dart test test/path/to/test_file.dart

# Run tests with coverage
dart test --coverage
```

Test database is automatically configured via `config/test.yaml`.

## 🐳 Docker Deployment

### Building the Docker Image

```bash
docker build -t fitbodyrd-server .
```

### Running with Docker

```bash
docker run -p 8080:8080 -p 8081:8081 -p 8082:8082 \
  -e runmode=production \
  -e serverid=default \
  -e logging=normal \
  -e role=monolith \
  fitbodyrd-server
```

### Environment Variables

- `runmode`: `development`, `staging`, or `production`
- `serverid`: Server identifier (default: `default`)
- `logging`: Logging level (`normal`, `verbose`, etc.)
- `role`: Server role (`monolith`, `api`, `insights`, etc.)

## 📊 Monitoring & Insights

Serverpod Insights provides:
- Real-time server metrics
- API endpoint analytics
- Database query performance
- Error tracking and logs
- Health monitoring

Access Insights at `http://localhost:8081` when the server is running.

## 🔐 Security

- **Password Hashing**: Secure bcrypt-based hashing
- **JWT Tokens**: Secure session management
- **SQL Injection Protection**: Parameterized queries via Serverpod ORM
- **CORS**: Configurable cross-origin resource sharing
- **Rate Limiting**: Can be configured per endpoint
- **Environment Isolation**: Separate configurations for dev/staging/prod

## 🚀 Production Deployment

### Pre-deployment Checklist

- [ ] Update `config/production.yaml` with production settings
- [ ] Configure production database credentials
- [ ] Set up production Redis instance
- [ ] Configure email service credentials
- [ ] Set up SSL/TLS certificates
- [ ] Configure domain and DNS
- [ ] Set up monitoring and logging
- [ ] Review security settings

### Deployment Options

1. **Docker**: Use the provided `Dockerfile`
2. **Cloud Run**: Deploy to Google Cloud Run
3. **Kubernetes**: Use container orchestration
4. **VPS**: Deploy to a virtual private server

See the `deploy/` directory for deployment scripts and configurations.

## 📝 Development Workflow

1. **Make changes** to endpoint or model files
2. **Generate code** (if needed):
   ```bash
   dart run serverpod_cli generate
   ```
3. **Create migration** (if database schema changed):
   ```bash
   dart run serverpod_cli create-migration
   ```
4. **Test changes** locally
5. **Commit and push** to repository

## 🛠️ Useful Commands

```bash
# Watch mode for development
./run_serverpod_watch.sh

# Generate Serverpod code
dart run serverpod_cli generate

# Create database migration
dart run serverpod_cli create-migration

# Repair migration (if needed)
dart run serverpod_cli create-repair-migration

# Start Docker services
docker compose up -d

# View Docker logs
docker compose logs -f

# Stop Docker services
docker compose down
```

## 📚 Resources

- [Serverpod Documentation](https://docs.serverpod.dev)
- [Serverpod GitHub](https://github.com/serverpod/serverpod)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Redis Documentation](https://redis.io/documentation)

## 📞 Support

For issues and questions, please [create an issue](link-to-issues) in the repository.

---

**Note**: This server is designed to work with the FitBodyRD Flutter app. See the [Flutter app README](../fitbodyrd_flutter/README.md) for client setup instructions.
