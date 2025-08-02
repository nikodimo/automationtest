#!/bin/bash

echo "📋 Service Logs Viewer"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Function to show logs for a specific service
show_logs() {
    local service=$1
    local lines=${2:-50}
    
    echo -e "${CYAN}=== $service Logs (last $lines lines) ===${NC}"
    if docker ps | grep -q "$service"; then
        docker logs --tail "$lines" "$service" 2>/dev/null || echo -e "${RED}No logs available${NC}"
    else
        echo -e "${RED}Container $service is not running${NC}"
    fi
    echo ""
}

# Check if any containers are running
if ! docker ps | grep -q "postgres\|ollama\|neo4j\|n8n"; then
    echo -e "${RED}No containers are running. Start the system first:${NC}"
    echo -e "${WHITE}./start-simple.sh${NC}"
    exit 1
fi

echo -e "${CYAN}Available services:${NC}"
echo -e "${WHITE}1. n8n (Workflow automation)${NC}"
echo -e "${WHITE}2. postgres (Database)${NC}"
echo -e "${WHITE}3. ollama (AI model)${NC}"
echo -e "${WHITE}4. neo4j (Knowledge graph)${NC}"
echo -e "${WHITE}5. all (All services)${NC}"
echo ""

# Get user choice
read -p "Enter service number (1-5) or 'all': " choice

case $choice in
    1)
        show_logs "n8n"
        ;;
    2)
        show_logs "postgres"
        ;;
    3)
        show_logs "ollama"
        ;;
    4)
        show_logs "neo4j"
        ;;
    5|"all")
        show_logs "n8n" 20
        show_logs "postgres" 20
        show_logs "ollama" 20
        show_logs "neo4j" 20
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo -e "${CYAN}=== Quick Commands ===${NC}"
echo -e "${WHITE}Follow logs: docker logs -f <service_name>${NC}"
echo -e "${WHITE}All n8n logs: docker logs n8n${NC}"
echo -e "${WHITE}All postgres logs: docker logs postgres${NC}"
echo -e "${WHITE}All ollama logs: docker logs ollama${NC}"
echo -e "${WHITE}All neo4j logs: docker logs neo4j${NC}" 