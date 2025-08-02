# 🐧 Bash Scripts for Student Bootcamp Task Generation System

Complete bash script collection for managing the automated task generation system on Linux/macOS.

## 📋 Available Scripts

### 🔧 **setup.sh** - Initial Setup
```bash
./setup.sh
```
- Checks all prerequisites (Docker, curl, etc.)
- Validates required files
- Sets proper permissions
- Creates Docker volumes
- Provides system information

### 🚀 **start-simple.sh** - Start All Services
```bash
./start-simple.sh
```
- Stops existing containers
- Creates Docker network
- Starts PostgreSQL, Neo4j, Ollama, and n8n
- Sets up database schema
- Pulls AI model if needed

### 🌐 **start-ngrok.sh** - Start ngrok Tunnels
```bash
./start-ngrok.sh
```
- Checks for ngrok binary
- Starts tunnels for n8n, Neo4j, and Ollama
- Provides public URLs

### 🛑 **stop-services.sh** - Stop All Services
```bash
./stop-services.sh
```
- Stops all containers
- Removes containers and network
- Clean shutdown

### 📊 **check-status.sh** - System Status
```bash
./check-status.sh
```
- Shows container status
- Health checks for all services
- Database information
- ngrok tunnel status

### 📋 **logs.sh** - View Service Logs
```bash
./logs.sh
```
- Interactive log viewer
- Choose specific service or view all
- Real-time log following options

## 🚀 Quick Start

### 1. Make Scripts Executable
```bash
chmod +x *.sh
```

### 2. Initial Setup
```bash
./setup.sh
```

### 3. Start the System
```bash
./start-simple.sh
```

### 4. Check Status
```bash
./check-status.sh
```

### 5. Start ngrok (Optional)
```bash
./start-ngrok.sh
```

## 📊 System Access Points

| Service | Local URL | Credentials |
|---------|-----------|-------------|
| **n8n** | http://localhost:5678 | No login required |
| **Neo4j** | http://localhost:7474 | neo4j/niku2223 |
| **PostgreSQL** | localhost:5432 | postgres/niku2223 |
| **Ollama** | http://localhost:11434 | No auth required |

## 🔧 Prerequisites

### Required Software
- **Docker** (with Docker daemon running)
- **curl** (for health checks)
- **bash** (for script execution)

### Optional Software
- **jq** (for JSON parsing in status checks)
- **ngrok** (for public tunneling)

### Required Files
- `schema.sql` - Database schema
- `workflow-final.json` - n8n workflow
- `ngrok.yml` - ngrok configuration

## 🛠️ Management Commands

### Start System
```bash
./start-simple.sh
```

### Stop System
```bash
./stop-services.sh
```

### Check Status
```bash
./check-status.sh
```

### View Logs
```bash
./logs.sh
```

### Start ngrok
```bash
./start-ngrok.sh
```

## 🔍 Troubleshooting

### Docker Issues
```bash
# Check Docker status
docker info

# Restart Docker daemon
sudo systemctl restart docker

# Check container logs
docker logs <container_name>
```

### Permission Issues
```bash
# Make scripts executable
chmod +x *.sh

# Check file permissions
ls -la *.sh
```

### Network Issues
```bash
# Check Docker network
docker network ls

# Remove and recreate network
docker network rm automation-network
docker network create automation-network
```

### Database Issues
```bash
# Check PostgreSQL connection
docker exec postgres pg_isready -U postgres

# Reset database
docker exec -i postgres psql -U postgres -d student_management -f /schema.sql
```

### AI Model Issues
```bash
# Check Ollama models
docker exec ollama ollama list

# Pull model manually
docker exec ollama ollama pull tinyllama:latest
```

## 📈 Monitoring

### Real-time Logs
```bash
# Follow n8n logs
docker logs -f n8n

# Follow all containers
docker logs -f postgres ollama neo4j n8n
```

### System Resources
```bash
# Check container resource usage
docker stats

# Check disk usage
df -h

# Check memory usage
free -h
```

## 🔐 Security Notes

- **No Authentication**: n8n is configured without authentication for easy access
- **Local Network**: Services are only accessible locally by default
- **Public Access**: Use ngrok for public access (optional)
- **Database**: Default credentials are used for development

## 📝 Customization

### Change Ports
Edit the scripts to change default ports:
- n8n: 5678
- Neo4j: 7474
- PostgreSQL: 5432
- Ollama: 11434

### Change Credentials
Update environment variables in the scripts:
- PostgreSQL: postgres/niku2223
- Neo4j: neo4j/niku2223

### Add Services
To add new services, modify `start-simple.sh` and add:
- Docker run command
- Network configuration
- Health checks

## 🎯 Features

✅ **Cross-platform** - Works on Linux, macOS, WSL  
✅ **Color-coded output** - Easy to read status messages  
✅ **Error handling** - Graceful failure handling  
✅ **Health checks** - Service status verification  
✅ **Log management** - Easy log viewing  
✅ **Status monitoring** - Real-time system status  
✅ **Clean shutdown** - Proper resource cleanup  
✅ **Setup validation** - Prerequisites checking  

## 📞 Support

### Common Issues
1. **Docker not running**: Start Docker daemon
2. **Port conflicts**: Check if ports are already in use
3. **Permission denied**: Make scripts executable
4. **Network issues**: Recreate Docker network

### Debug Mode
Add `set -x` to any script for debug output:
```bash
#!/bin/bash
set -x  # Add this line for debug output
```

## 🎉 Success Indicators

When everything is working correctly, you should see:
- ✅ All containers running
- ✅ All health checks passing
- ✅ Database accessible
- ✅ n8n workflow active
- ✅ AI model loaded
- ✅ ngrok tunnels active (if enabled)

Your automated task generation system is now ready to run daily at 6 AM! 🚀 