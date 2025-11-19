# Rue Application

A full-stack application with FastAPI backend and React frontend, containerized with Docker.

## Architecture

- **API**: FastAPI application with Celery workers for background tasks
- **UI**: React + TypeScript + Vite application
- **Task Queue**: Celery with Redis as broker
- **Monitoring**: Flower for Celery task monitoring
- **Database**: SQLite (default) or PostgreSQL (optional)

## Prerequisites

- Docker and Docker Compose
- Git
- Make (optional, for simplified commands)

## Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd rue-docker
```

### 2. Initialize Submodules

```bash
git submodule update --init --recursive
```

### 3. Configure Environment Variables

Copy the example environment file and customize it:

```bash
cp rue-api/.env.example deployment/.env
```

Edit `deployment/.env` and update the following variables:

```env
# Security
SECRET_KEY=<your-secret-key>
FIRST_SUPERUSER=admin@example.com
FIRST_SUPERUSER_PASSWORD=<secure-password>

# Database (SQLite by default)
RUE_DB_SCHEME=sqlite
RUE_DB_NAME=rue.db

# Redis
REDIS_HOST=redis
REDIS_PASSWORD=<secure-redis-password>

# Email Configuration (optional)
SMTP_HOST=<smtp-server>
SMTP_USER=<smtp-username>
SMTP_PASSWORD=<smtp-password>
EMAILS_FROM_EMAIL=info@example.com
SMTP_PORT=587
```

### 4. Configure Docker Compose Override (Development Only)

For development mode, create the override file:

```bash
cp deployment/docker-compose.override.template.yml deployment/docker-compose.override.yml
```

## Running the Application

### Production Mode

Build and run the application in production mode:

```bash
# Build containers
make build

# Start services
make up
```

Or using Docker Compose directly:

```bash
docker compose -f deployment/docker-compose.yml build
docker compose -f deployment/docker-compose.yml up -d api ui flower
```

### Development Mode

Run the application in development mode with hot-reloading:

```bash
# Start API in development mode with Flower
make dev

# Start UI in development mode
make dev-ui
```

Or using Docker Compose directly:

```bash
docker compose -f deployment/docker-compose.yml -f deployment/docker-compose.override.yml up -d api-dev flower
docker compose -f deployment/docker-compose.yml -f deployment/docker-compose.override.yml up -d ui-dev
```

### Stop Services

```bash
make down
```

Or:

```bash
docker compose -f deployment/docker-compose.yml down
```

## Accessing the Application

After starting the services:

- **UI**: http://localhost (production) or http://localhost:8002 (development)
- **API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/api/v1/docs
- **Flower (Task Monitor)**: http://localhost:8005

## Available Make Commands

```bash
make build    # Build Docker images for production
make up       # Start production services (API, UI, Flower)
make dev      # Start API in development mode with Flower
make dev-ui   # Start UI in development mode
make down     # Stop and remove all containers
```

## Project Structure

```
rue-docker/
├── deployment/
│   ├── api/                    # API Dockerfile
│   ├── ui/                     # UI Dockerfile
│   ├── docker-compose.yml      # Main compose configuration
│   ├── docker-compose.override.yml  # Development overrides
│   ├── .env                    # Environment variables
│   └── volumes/                # Persistent data
├── rue-api/                    # FastAPI application (submodule)
├── rue-ui/                     # React application (submodule)
└── Makefile                    # Build commands
```

## Development

### API Development

The API runs FastAPI with:
- Auto-reload enabled in development mode
- SSH access on port 8001 (dev mode only)
- Volume mounts for live code updates

Key technologies:
- FastAPI
- SQLModel/SQLAlchemy
- Celery
- Redis
- GDAL (geospatial library)

### UI Development

The UI is built with:
- React 19
- TypeScript
- Vite
- Ant Design & Chakra UI
- Redux Toolkit
- MapLibre GL (mapping)
- Three.js (3D graphics)

Development server runs on port 5173 (exposed as 8002).

## Database Migrations

To run database migrations (Alembic):

```bash
docker compose exec api alembic upgrade head
```

## Troubleshooting

### Port Conflicts

If ports are already in use, modify the port mappings in `deployment/docker-compose.yml`:

```yaml
ports:
  - "8080:8000"  # Change 8080 to an available port
```

### Submodule Issues

If submodules are not initialized:

```bash
git submodule update --init --recursive
```

### Redis Connection Issues

Ensure the REDIS_PASSWORD in your `.env` file matches the password in docker-compose.yml.
