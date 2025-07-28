Write-Host "Starting ngrok tunnels..." -ForegroundColor Green

# Check if ngrok is available
if (-not (Test-Path "ngrok.exe")) {
    Write-Host "ngrok.exe not found. Please make sure ngrok is extracted." -ForegroundColor Red
    exit 1
}

# Start ngrok with configuration
Write-Host "Starting ngrok tunnels for n8n, Neo4j, and Ollama..." -ForegroundColor Yellow
.\ngrok.exe start --config ngrok.yml n8n neo4j ollama

Write-Host ""
Write-Host "ngrok tunnels are running!" -ForegroundColor Green
Write-Host "Check the ngrok interface for your public URLs." -ForegroundColor Cyan
Write-Host ""
Write-Host "To stop ngrok: Press Ctrl+C" -ForegroundColor Yellow 