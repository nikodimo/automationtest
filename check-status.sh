#!/bin/bash

echo "📊 Checking System Status..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

echo -e "${CYAN}=== Docker Containers Status ===${NC}"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "(postgres|ollama|neo4j|n8n)" || echo -e "${RED}No containers running${NC}"

echo ""
echo -e "${CYAN}=== Network Status ===${NC}"
docker network ls | grep automation-network || echo -e "${RED}Automation network not found${NC}"

echo ""
echo -e "${CYAN}=== Service Health Checks ===${NC}"

# Check n8n
if curl -s http://localhost:5678 > /dev/null 2>&1; then
    echo -e "${GREEN}✅ n8n: Running (http://localhost:5678)${NC}"
else
    echo -e "${RED}❌ n8n: Not responding${NC}"
fi

# Check Neo4j
if curl -s http://localhost:7474 > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Neo4j: Running (http://localhost:7474)${NC}"
else
    echo -e "${RED}❌ Neo4j: Not responding${NC}"
fi

# Check PostgreSQL
if docker exec postgres pg_isready -U postgres > /dev/null 2>&1; then
    echo -e "${GREEN}✅ PostgreSQL: Running (localhost:5432)${NC}"
else
    echo -e "${RED}❌ PostgreSQL: Not responding${NC}"
fi

# Check Ollama
if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Ollama: Running (http://localhost:11434)${NC}"
else
    echo -e "${RED}❌ Ollama: Not responding${NC}"
fi

echo ""
echo -e "${CYAN}=== Database Information ===${NC}"
if docker exec postgres pg_isready -U postgres > /dev/null 2>&1; then
    echo -e "${WHITE}Students count:${NC}"
    docker exec postgres psql -U postgres -d student_management -c "SELECT COUNT(*) FROM students;" 2>/dev/null || echo -e "${RED}Database query failed${NC}"
    
    echo -e "${WHITE}Tasks count:${NC}"
    docker exec postgres psql -U postgres -d student_management -c "SELECT COUNT(*) FROM tasks;" 2>/dev/null || echo -e "${RED}Database query failed${NC}"
    
    echo -e "${WHITE}Recent tasks:${NC}"
    docker exec postgres psql -U postgres -d student_management -c "SELECT title, difficulty_level, created_at FROM tasks ORDER BY created_at DESC LIMIT 3;" 2>/dev/null || echo -e "${RED}Database query failed${NC}"
else
    echo -e "${RED}Database not accessible${NC}"
fi

echo ""
echo -e "${CYAN}=== ngrok Status ===${NC}"
if curl -s http://localhost:4040/api/tunnels > /dev/null 2>&1; then
    echo -e "${GREEN}✅ ngrok: Running${NC}"
    echo -e "${WHITE}Public URLs:${NC}"
    curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[].public_url' 2>/dev/null || echo -e "${YELLOW}No tunnels found${NC}"
else
    echo -e "${RED}❌ ngrok: Not running${NC}"
    echo -e "${YELLOW}To start ngrok: ./start-ngrok.sh${NC}"
fi

echo ""
echo -e "${CYAN}=== Quick Commands ===${NC}"
echo -e "${WHITE}Start system: ./start-simple.sh${NC}"
echo -e "${WHITE}Start ngrok: ./start-ngrok.sh${NC}"
echo -e "${WHITE}Stop system: ./stop-services.sh${NC}"
echo -e "${WHITE}View logs: docker logs n8n${NC}" 