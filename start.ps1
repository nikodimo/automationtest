Write-Host "Starting Student Bootcamp Task Generation System..." -ForegroundColor Green

# Pull latest images
Write-Host "Pulling Docker images..." -ForegroundColor Yellow
docker-compose pull

# Start all services
Write-Host "Starting services..." -ForegroundColor Yellow
docker-compose up -d

# Wait for services to be ready
Write-Host "Waiting for services to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# Pull Ollama model
Write-Host "Pulling Llama2 model for Ollama..." -ForegroundColor Yellow
docker exec ollama ollama pull llama2

Write-Host "System is ready!" -ForegroundColor Green
Write-Host ""
Write-Host "Access Points:" -ForegroundColor Cyan
Write-Host "   n8n Workflow: http://localhost:5678 (admin/niku2223)" -ForegroundColor White
Write-Host "   Neo4j Browser: http://localhost:7474 (neo4j/niku2223)" -ForegroundColor White
Write-Host "   PostgreSQL: localhost:5432 (postgres/niku2223)" -ForegroundColor White
Write-Host "   Ollama API: http://localhost:11434" -ForegroundColor White
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "   1. Import workflow.json into n8n" -ForegroundColor White
Write-Host "   2. Activate the workflow" -ForegroundColor White
Write-Host "   3. System will run daily at 6 AM" -ForegroundColor White
Write-Host ""
Write-Host "To stop: docker-compose down" -ForegroundColor Yellow 