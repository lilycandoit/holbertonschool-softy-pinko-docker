# Holberton School - Docker Practice Project

This repository contains a progressive Docker learning project with six tasks that demonstrate key Docker concepts and best practices.

## Project Overview

This project teaches Docker containerization through hands-on practice, progressing from simple single containers to complex multi-container applications with load balancing.

## Tasks Overview

### Task 0: Basic Docker Container
- **Objective**: Create a simple "Hello, World!" container
- **Technologies**: Ubuntu base image
- **Files**: `task0/Dockerfile`
- **Run**: `docker build -t softy-pinko:task0 task0/ && docker run softy-pinko:task0`

### Task 1: Flask API Container
- **Objective**: Containerize a Python Flask API
- **Technologies**: Ubuntu, Python, Flask
- **Files**: `task1/Dockerfile`, `task1/api.py`
- **Run**: 
  ```bash
  docker build -t softy-pinko:task1 task1/
  docker run -p 5252:5252 softy-pinko:task1
  ```
- **Test**: `curl http://localhost:5252/api/hello`

### Task 2: Frontend Container
- **Objective**: Serve static web content with Nginx
- **Technologies**: Nginx, HTML, CSS, JavaScript
- **Files**: `task2/Dockerfile`, `task2/index.html`, `task2/styles.css`, `task2/script.js`
- **Run**: 
  ```bash
  docker build -t softy-pinko:task2 task2/
  docker run -p 9000:80 softy-pinko:task2
  ```
- **Access**: http://localhost:9000

### Task 3: Multi-Container Setup
- **Objective**: Connect frontend and backend containers
- **Technologies**: Nginx reverse proxy, Docker networking
- **Files**: `task3/Dockerfile`, `task3/nginx.conf`, `task3/run.sh`
- **Run**: `cd task3 && ./run.sh`
- **Test**: http://localhost:9000 and http://localhost:9000/api/hello

### Task 4: Database Integration
- **Objective**: Add PostgreSQL database container
- **Technologies**: PostgreSQL, Flask with database integration
- **Files**: `task4/Dockerfile`, `task4/api.py`, `task4/run.sh`
- **Run**: `cd task4 && ./run.sh`
- **Endpoints**: 
  - http://localhost:9000/api/messages (GET/POST)
  - http://localhost:9000/api/hello

### Task 5: Docker Compose
- **Objective**: Manage multi-container application with Docker Compose
- **Technologies**: Docker Compose, PostgreSQL, volume persistence
- **Files**: `task5/docker-compose.yml`, `task5/README.md`
- **Run**: 
  ```bash
  cd task5
  docker-compose up --build
  ```
- **Stop**: `docker-compose down`

### Task 6: Load Balancing and Scaling
- **Objective**: Horizontal scaling with load balancer
- **Technologies**: Nginx load balancer, multiple API instances
- **Files**: `task6/docker-compose.yml`, `task6/proxy/nginx.conf`
- **Run**: 
  ```bash
  cd task6
  docker-compose up --build --scale api=3
  ```
- **Features**: 
  - 3 API instances behind load balancer
  - Health monitoring
  - Fault tolerance

## Requirements

- Docker installed (version 20.0+)
- Docker Compose installed (version 2.0+)
- Basic understanding of web development
- Command line familiarity

## Learning Objectives

By completing this project, you will understand:

1. **Docker Fundamentals**
   - Creating Dockerfiles
   - Building and running containers
   - Container lifecycle management

2. **Multi-Container Applications**
   - Container networking
   - Service communication
   - Volume management

3. **Production Concepts**
   - Load balancing
   - Horizontal scaling
   - Health checks
   - Infrastructure as Code with Docker Compose

## Author

This project was created for Holberton School to teach Docker containerization concepts through practical, hands-on exercises.
