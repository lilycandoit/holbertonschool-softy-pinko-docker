#!/bin/bash

# Task 4: Multi-container setup with frontend, backend, and database
# This script demonstrates running three containers that communicate with each other

# Clean up any existing containers
echo "Cleaning up existing containers..."
docker stop api-server frontend-server db-server 2>/dev/null || true
docker rm api-server frontend-server db-server 2>/dev/null || true

# Create a custom network for container communication
echo "Creating Docker network..."
docker network rm softy-pinko-network 2>/dev/null || true
docker network create softy-pinko-network

# Start the PostgreSQL database container
echo "Starting PostgreSQL database container..."
docker run -d \
  --name db-server \
  --network softy-pinko-network \
  -e POSTGRES_DB=softy_pinko \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  postgres:13

# Wait for database to be ready
echo "Waiting for database to be ready..."
sleep 10

# Build and start the API server container
echo "Building and starting API server container..."
cd /home/runner/work/holbertonschool-softy-pinko-docker/holbertonschool-softy-pinko-docker/task4
docker build -t softy-pinko:task4 .

docker run -d \
  --name api-server \
  --network softy-pinko-network \
  -e DB_HOST=db-server \
  -e DB_NAME=softy_pinko \
  -e DB_USER=postgres \
  -e DB_PASSWORD=password \
  softy-pinko:task4

# Build and start the frontend container (reuse task3 frontend)
echo "Starting frontend container..."
cd /home/runner/work/holbertonschool-softy-pinko-docker/holbertonschool-softy-pinko-docker/task3
docker run -d \
  --name frontend-server \
  --network softy-pinko-network \
  -p 9000:80 \
  softy-pinko:task3

echo "Task 4 setup complete!"
echo "Frontend available at: http://localhost:9000"
echo "API endpoints:"
echo "  - http://localhost:9000/api/hello"
echo "  - http://localhost:9000/api/messages (GET/POST)"
echo ""
echo "To test the database integration:"
echo "curl http://localhost:9000/api/messages"
echo ""
echo "To stop the containers, run:"
echo "docker stop api-server frontend-server db-server"
echo "docker rm api-server frontend-server db-server"
echo "docker network rm softy-pinko-network"