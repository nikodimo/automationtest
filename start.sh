#!/bin/bash

echo "🚀 Starting Student Bootcamp Task Generation System..."

# Pull latest images
echo "📦 Pulling Docker images..."
docker-compose pull

# Start all services
echo "🔧 Starting services..."
docker-compose up -d

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 30

# Pull Ollama model
echo "🤖 Pulling Llama2 model for Ollama..."
docker exec ollama ollama pull llama2

echo "✅ System is ready!"
echo ""
echo "📊 Access Points:"
echo "   n8n Workflow: http://localhost:5678 (admin/niku2223)"
echo "   Neo4j Browser: http://localhost:7474 (neo4j/niku2223)"
echo "   PostgreSQL: localhost:5432 (postgres/niku2223)"
echo "   Ollama API: http://localhost:11434"
echo ""
echo "📋 Next Steps:"
echo "   1. Import workflow.json into n8n"
echo "   2. Activate the workflow"
echo "   3. System will run daily at 6 AM"
echo ""
echo "🔧 To stop: docker-compose down" 