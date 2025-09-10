#!/bin/bash

# Task 3: Multi-container setup with frontend and backend
# This script demonstrates running two containers that communicate with each other

# Clean up any existing containers
echo "Cleaning up existing containers..."
docker stop api-server frontend-server 2>/dev/null || true
docker rm api-server frontend-server 2>/dev/null || true

# Create a custom network for container communication
echo "Creating Docker network..."
docker network rm softy-pinko-network 2>/dev/null || true
docker network create softy-pinko-network

# Build the images if they don't exist
echo "Building API image..."
cd /home/runner/work/holbertonschool-softy-pinko-docker/holbertonschool-softy-pinko-docker/task1
docker build -t softy-pinko:task1 .

echo "Building Frontend image..."
cd /home/runner/work/holbertonschool-softy-pinko-docker/holbertonschool-softy-pinko-docker/task3
docker build -t softy-pinko:task3 .

# Start the API server container
echo "Starting API server container..."
docker run -d --name api-server --network softy-pinko-network softy-pinko:task1

# Start the frontend container
echo "Starting frontend container..."
docker run -d --name frontend-server --network softy-pinko-network -p 9000:80 softy-pinko:task3

echo "Task 3 setup complete!"
echo "Frontend available at: http://localhost:9000"
echo "API accessible through frontend proxy at: http://localhost:9000/api/hello"
echo ""
echo "To stop the containers, run:"
echo "docker stop api-server frontend-server"
echo "docker rm api-server frontend-server"
echo "docker network rm softy-pinko-network"