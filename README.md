# Student Bootcamp Task Generation System

Automated task generation system using n8n, Ollama AI, PostgreSQL, and Neo4j.

## 🚀 Quick Start

1. **Start the system:**
   ```powershell
   .\start-simple.ps1
   ```

2. **Access n8n:**
   - URL: http://localhost:5678
   - No login required (authentication disabled)

3. **Import workflow:**
   - In n8n, go to Workflows → Import
   - Upload `workflow-final.json`
   - Set up PostgreSQL credentials (see below)
   - Activate the workflow

## 🌐 Public Access (Optional)

To make your services accessible from the internet:

1. **Start ngrok tunnels:**
   ```powershell
   .\start-ngrok.ps1
   ```

2. **Access your public URLs:**
   - Check the ngrok interface for your public URLs
   - Share these URLs to access your system from anywhere

## 📊 System Components

- **n8n**: Workflow automation (port 5678)
- **Ollama**: AI task generation with tinyllama (port 11434)
- **PostgreSQL**: Task storage (port 5432)
- **Neo4j**: Knowledge graph (port 7474)

## ⏰ Automation Schedule

- **Trigger**: Daily at 6:00 AM
- **Process**: 
  1. Get students from database
  2. Generate task with Ollama AI (tinyllama:latest)
  3. Save to PostgreSQL
  4. Create Neo4j knowledge graph nodes
  5. Assign to students

## 🔧 Database Setup

### PostgreSQL Credentials in n8n:
- **Host**: `postgres`
- **Port**: `5432`
- **Database**: `student_management`
- **User**: `postgres`
- **Password**: `niku2223`

### Database Schema:
- `students`: Student information
- `tasks`: Generated tasks
- `student_tasks`: Task assignments

## 🛠️ Management

```powershell
# Start all services
.\start-simple.ps1

# Start ngrok tunnels (optional)
.\start-ngrok.ps1

# Stop all services
docker stop postgres ollama neo4j n8n

# Remove all services
docker rm postgres ollama neo4j n8n

# View logs
docker logs n8n
docker logs postgres
docker logs ollama
```

## 📝 Access Points

### Local Access:
- **n8n**: http://localhost:5678
- **Neo4j**: http://localhost:7474 (neo4j/niku2223)
- **PostgreSQL**: localhost:5432 (postgres/niku2223)
- **Ollama**: http://localhost:11434

### Public Access (with ngrok):
- **n8n**: https://your-ngrok-url.ngrok.io
- **Neo4j**: https://your-ngrok-url.ngrok.io
- **Ollama**: https://your-ngrok-url.ngrok.io

## 🔧 Troubleshooting

### If n8n can't connect to PostgreSQL:
- Make sure all containers are on the same network: `automation-network`
- Check container names: `docker ps`

### If Ollama memory error:
- Using `tinyllama:latest` (637MB RAM)
- If still having issues, try: `docker restart ollama`

### If workflow fails:
- Check n8n logs: `docker logs n8n`
- Verify database schema: `docker exec -i postgres psql -U postgres -d student_management -c "SELECT * FROM students;"`

### If ngrok doesn't work:
- Make sure ngrok.exe is in the directory
- Check if ports are already in use
- Try running ngrok manually: `.\ngrok.exe http 5678`

## 📋 Files

- `start-simple.ps1`: Main startup script for Windows
- `start-ngrok.ps1`: ngrok tunnel startup script
- `workflow-final.json`: Complete n8n workflow
- `schema.sql`: Database schema with sample data
- `ngrok.yml`: ngrok configuration
- `README.md`: This documentation

## 🎯 Features

✅ **Daily Automation**: Runs every day at 6 AM  
✅ **AI Task Generation**: Uses Ollama with tinyllama model  
✅ **Database Storage**: PostgreSQL for tasks and assignments  
✅ **Knowledge Graph**: Neo4j for relationship mapping  
✅ **Student Management**: Automatic task assignment  
✅ **Docker Containerized**: Easy deployment and management  
✅ **Public Access**: ngrok tunnels for remote access  
✅ **No Authentication**: Direct access to n8n interface 