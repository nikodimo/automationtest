#!/bin/bash

echo "🛑 Stopping Student Bootcamp Task Generation System..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Stop all containers
echo -e "${YELLOW}Stopping containers...${NC}"
docker stop postgres ollama neo4j n8n 2>/dev/null

# Remove containers
echo -e "${YELLOW}Removing containers...${NC}"
docker rm postgres ollama neo4j n8n 2>/dev/null

# Remove network
echo -e "${YELLOW}Removing network...${NC}"
docker network rm automation-network 2>/dev/null

echo -e "${GREEN}All services stopped successfully!${NC}"
echo ""
echo -e "${YELLOW}To start again: ./start-simple.sh${NC}" 