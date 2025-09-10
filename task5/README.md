# Task 5: Docker Compose Multi-Container Application

This task demonstrates using Docker Compose to manage a multi-container application with:
- Frontend (Nginx serving static files with reverse proxy)
- Backend (Flask API with database integration)
- Database (PostgreSQL)

## How to run

1. Make sure Docker Compose is installed
2. From this directory, run:
   ```bash
   docker-compose up --build
   ```

3. Access the application:
   - Frontend: http://localhost:9000
   - API endpoints:
     - http://localhost:9000/api/hello
     - http://localhost:9000/api/messages

## How to stop

```bash
docker-compose down
```

To also remove volumes:
```bash
docker-compose down -v
```

## Architecture

- **Frontend Container**: Nginx reverse proxy serving static files
- **API Container**: Flask application with PostgreSQL integration
- **Database Container**: PostgreSQL with persistent volume
- **Network**: Custom bridge network for container communication
- **Volume**: Persistent storage for database data