#!/bin/bash

echo "🌐 Starting ngrok tunnels..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if ngrok is available
if [ ! -f "./ngrok" ]; then
    echo -e "${RED}ngrok not found. Please make sure ngrok is extracted.${NC}"
    echo -e "${YELLOW}Download from: https://ngrok.com/download${NC}"
    exit 1
fi

# Make ngrok executable
chmod +x ./ngrok

# Start ngrok with configuration
echo -e "${YELLOW}Starting ngrok tunnels for n8n, Neo4j, and Ollama...${NC}"
./ngrok start --config ngrok.yml n8n neo4j ollama

echo ""
echo -e "${GREEN}ngrok tunnels are running!${NC}"
echo -e "${CYAN}Check the ngrok interface for your public URLs.${NC}"
echo ""
echo -e "${YELLOW}To stop ngrok: Press Ctrl+C${NC}" 