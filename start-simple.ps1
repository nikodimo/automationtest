Write-Host "Starting Student Bootcamp Task Generation System..." -ForegroundColor Green

# Stop any existing containers
Write-Host "Stopping existing containers..." -ForegroundColor Yellow
docker stop postgres ollama neo4j n8n 2>$null
docker rm postgres ollama neo4j n8n 2>$null

# Start PostgreSQL
Write-Host "Starting PostgreSQL..." -ForegroundColor Yellow
docker run -d --name postgres `
  -e POSTGRES_DB=student_management `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=niku2223 `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:latest

# Start Neo4j
Write-Host "Starting Neo4j..." -ForegroundColor Yellow
docker run -d --name neo4j `
  -e NEO4J_AUTH=neo4j/niku2223 `
  -p 7474:7474 `
  -p 7687:7687 `
  -v neo4j_data:/data `
  neo4j:latest

# Start Ollama
Write-Host "Starting Ollama..." -ForegroundColor Yellow
docker run -d --name ollama `
  -p 11434:11434 `
  -v ollama_data:/root/.ollama `
  ollama/ollama:latest

# Start n8n
Write-Host "Starting n8n..." -ForegroundColor Yellow
docker run -d --name n8n `
  -p 5678:5678 `
  -e N8N_BASIC_AUTH_ACTIVE=false `
  -e N8N_HOST=0.0.0.0 `
  -e N8N_PORT=5678 `
  -v n8n_data:/home/node/.n8n `
  n8nio/n8n:latest

# Wait for services to start
Write-Host "Waiting for services to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# Pull Ollama model
Write-Host "Pulling Llama2 model..." -ForegroundColor Yellow
docker exec ollama ollama pull llama2

Write-Host "System is ready!" -ForegroundColor Green
Write-Host ""
Write-Host "Access Points:" -ForegroundColor Cyan
Write-Host "   n8n: http://localhost:5678" -ForegroundColor White
Write-Host "   Neo4j: http://localhost:7474 (neo4j/niku2223)" -ForegroundColor White
Write-Host "   PostgreSQL: localhost:5432 (postgres/niku2223)" -ForegroundColor White
Write-Host "   Ollama: http://localhost:11434" -ForegroundColor White
Write-Host ""
Write-Host "To stop all: docker stop postgres ollama neo4j n8n" -ForegroundColor Yellow 