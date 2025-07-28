# Student Bootcamp Task Generation System

Automated task generation system using n8n, Ollama AI, PostgreSQL, and Neo4j.

## 🚀 Quick Start

1. **Start the system:**
   ```bash
   chmod +x start.sh
   ./start.sh
   ```

2. **Access n8n:**
   - URL: http://localhost:5678
   - Username: admin
   - Password: niku2223

3. **Import workflow:**
   - In n8n, go to Workflows → Import
   - Upload `workflow.json`
   - Activate the workflow

## 📊 System Components

- **n8n**: Workflow automation (port 5678)
- **Ollama**: AI task generation (port 11434)
- **PostgreSQL**: Task storage (port 5432)
- **Neo4j**: Knowledge graph (port 7474)

## ⏰ Automation Schedule

- **Trigger**: Daily at 6:00 AM
- **Process**: 
  1. Get students from database
  2. Generate task with Ollama AI
  3. Save to PostgreSQL
  4. Store in Neo4j knowledge graph
  5. Assign to students

## 🔧 Database Schema

- `students`: Student information
- `tasks`: Generated tasks
- `student_tasks`: Task assignments
- `knowledge_nodes`: Neo4j nodes
- `knowledge_relationships`: Neo4j relationships

## 🛠️ Management

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Restart specific service
docker-compose restart n8n
```

## 📝 Credentials

- **n8n**: admin/niku2223
- **Neo4j**: neo4j/niku2223
- **PostgreSQL**: postgres/niku2223 