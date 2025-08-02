#!/bin/bash

echo "🔧 Setting up Student Bootcamp Task Generation System..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo -e "${CYAN}=== Checking Prerequisites ===${NC}"

# Check Docker
if command_exists docker; then
    echo -e "${GREEN}✅ Docker: Installed${NC}"
    docker_version=$(docker --version)
    echo -e "${WHITE}   Version: $docker_version${NC}"
else
    echo -e "${RED}❌ Docker: Not installed${NC}"
    echo -e "${YELLOW}Please install Docker from: https://docs.docker.com/get-docker/${NC}"
    exit 1
fi

# Check Docker Compose
if command_exists docker-compose; then
    echo -e "${GREEN}✅ Docker Compose: Installed${NC}"
else
    echo -e "${YELLOW}⚠️  Docker Compose: Not found (optional)${NC}"
fi

# Check if Docker daemon is running
if docker info >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Docker daemon: Running${NC}"
else
    echo -e "${RED}❌ Docker daemon: Not running${NC}"
    echo -e "${YELLOW}Please start Docker and try again${NC}"
    exit 1
fi

# Check curl
if command_exists curl; then
    echo -e "${GREEN}✅ curl: Installed${NC}"
else
    echo -e "${RED}❌ curl: Not installed${NC}"
    echo -e "${YELLOW}Please install curl${NC}"
    exit 1
fi

# Check jq (optional)
if command_exists jq; then
    echo -e "${GREEN}✅ jq: Installed${NC}"
else
    echo -e "${YELLOW}⚠️  jq: Not installed (optional for JSON parsing)${NC}"
fi

echo ""
echo -e "${CYAN}=== Checking Required Files ===${NC}"

# Check for required files
required_files=("schema.sql" "workflow-final.json" "ngrok.yml")
missing_files=()

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file: Found${NC}"
    else
        echo -e "${RED}❌ $file: Missing${NC}"
        missing_files+=("$file")
    fi
done

if [ ${#missing_files[@]} -ne 0 ]; then
    echo -e "${RED}Missing required files: ${missing_files[*]}${NC}"
    exit 1
fi

echo ""
echo -e "${CYAN}=== Setting File Permissions ===${NC}"

# Make scripts executable
chmod +x start-simple.sh
chmod +x start-ngrok.sh
chmod +x stop-services.sh
chmod +x check-status.sh

echo -e "${GREEN}✅ Scripts made executable${NC}"

# Check for ngrok
if [ -f "./ngrok" ]; then
    echo -e "${GREEN}✅ ngrok: Found${NC}"
    chmod +x ./ngrok
elif [ -f "./ngrok.exe" ]; then
    echo -e "${GREEN}✅ ngrok.exe: Found${NC}"
else
    echo -e "${YELLOW}⚠️  ngrok: Not found${NC}"
    echo -e "${WHITE}Download from: https://ngrok.com/download${NC}"
    echo -e "${WHITE}Extract to this directory${NC}"
fi

echo ""
echo -e "${CYAN}=== Creating Docker Volumes ===${NC}"

# Create Docker volumes if they don't exist
docker volume create postgres_data 2>/dev/null
docker volume create neo4j_data 2>/dev/null
docker volume create ollama_data 2>/dev/null
docker volume create n8n_data 2>/dev/null

echo -e "${GREEN}✅ Docker volumes created${NC}"

echo ""
echo -e "${CYAN}=== System Information ===${NC}"
echo -e "${WHITE}OS: $(uname -s) $(uname -r)${NC}"
echo -e "${WHITE}Architecture: $(uname -m)${NC}"
echo -e "${WHITE}Available Memory: $(free -h | grep Mem | awk '{print $2}')${NC}"
echo -e "${WHITE}Available Disk: $(df -h . | tail -1 | awk '{print $4}')${NC}"

echo ""
echo -e "${GREEN}🎉 Setup Complete!${NC}"
echo ""
echo -e "${CYAN}=== Next Steps ===${NC}"
echo -e "${WHITE}1. Start the system: ./start-simple.sh${NC}"
echo -e "${WHITE}2. Check status: ./check-status.sh${NC}"
echo -e "${WHITE}3. Start ngrok (optional): ./start-ngrok.sh${NC}"
echo -e "${WHITE}4. Stop system: ./stop-services.sh${NC}"
echo ""
echo -e "${CYAN}=== Access Points ===${NC}"
echo -e "${WHITE}n8n: http://localhost:5678${NC}"
echo -e "${WHITE}Neo4j: http://localhost:7474${NC}"
echo -e "${WHITE}PostgreSQL: localhost:5432${NC}"
echo -e "${WHITE}Ollama: http://localhost:11434${NC}"
echo ""
echo -e "${YELLOW}Ready to start! Run: ./start-simple.sh${NC}" 