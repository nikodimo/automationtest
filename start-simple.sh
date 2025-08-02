#!/bin/bash

echo "🚀 Starting Student Bootcamp Task Generation System..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Stop any existing containers
echo -e "${YELLOW}Stopping existing containers...${NC}"
docker stop postgres ollama neo4j n8n 2>/dev/null
docker rm postgres ollama neo4j n8n 2>/dev/null

# Create network if it doesn't exist
echo -e "${YELLOW}Setting up Docker network...${NC}"
docker network create automation-network 2>/dev/null

# Start PostgreSQL
echo -e "${YELLOW}Starting PostgreSQL...${NC}"
docker run -d --name postgres --network automation-network \
  -e POSTGRES_DB=student_management \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=niku2223 \
  -p 5432:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:latest

# Start Neo4j
echo -e "${YELLOW}Starting Neo4j...${NC}"
docker run -d --name neo4j --network automation-network \
  -e NEO4J_AUTH=neo4j/niku2223 \
  -p 7474:7474 \
  -p 7687:7687 \
  -v neo4j_data:/data \
  neo4j:latest

# Start Ollama
echo -e "${YELLOW}Starting Ollama...${NC}"
docker run -d --name ollama --network automation-network \
  -p 11434:11434 \
  -v ollama_data:/root/.ollama \
  ollama/ollama:latest

# Start n8n
echo -e "${YELLOW}Starting n8n...${NC}"
docker run -d --name n8n --network automation-network \
  -p 5678:5678 \
  -e N8N_BASIC_AUTH_ACTIVE=false \
  -e N8N_HOST=0.0.0.0 \
  -e N8N_PORT=5678 \
  -v n8n_data:/home/node/.n8n \
  n8nio/n8n:latest

# Wait for services to start
echo -e "${YELLOW}Waiting for services to start...${NC}"
sleep 30

# Setup database schema
echo -e "${YELLOW}Setting up database schema...${NC}"
docker cp schema.sql postgres:/schema.sql
docker exec -i postgres psql -U postgres -d student_management -f /schema.sql 2>/dev/null

# Pull Ollama model if not already available
echo -e "${YELLOW}Checking Ollama models...${NC}"
models=$(docker exec ollama ollama list 2>/dev/null)
if [[ $models != *"tinyllama"* ]]; then
    echo -e "${YELLOW}Pulling tinyllama model...${NC}"
    docker exec ollama ollama pull tinyllama:latest
fi

echo -e "${GREEN}System is ready!${NC}"
echo ""
echo -e "${CYAN}Local Access Points:${NC}"
echo -e "${WHITE}   n8n: http://localhost:5678${NC}"
echo -e "${WHITE}   Neo4j: http://localhost:7474 (neo4j/niku2223)${NC}"
echo -e "${WHITE}   PostgreSQL: localhost:5432 (postgres/niku2223)${NC}"
echo -e "${WHITE}   Ollama: http://localhost:11434${NC}"
echo ""
echo -e "${CYAN}To start ngrok tunnels (optional):${NC}"
echo -e "${WHITE}   ./start-ngrok.sh${NC}"
echo ""
echo -e "${CYAN}Next Steps:${NC}"
echo -e "${WHITE}   1. Import workflow-final.json into n8n${NC}"
echo -e "${WHITE}   2. Set up PostgreSQL credentials in n8n${NC}"
echo -e "${WHITE}   3. Activate the workflow${NC}"
echo -e "${WHITE}   4. System will run daily at 6 AM${NC}"
echo ""
echo -e "${YELLOW}To stop: docker stop postgres ollama neo4j n8n${NC}" 