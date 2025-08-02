-- Student Bootcamp Task Management Schema

-- Students table
CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cohort VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tasks table
CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    difficulty_level VARCHAR(20) CHECK (difficulty_level IN ('beginner', 'intermediate', 'advanced')),
    category VARCHAR(50),
    estimated_duration INTEGER, -- in minutes
    learning_objectives JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    generated_by_ai BOOLEAN DEFAULT FALSE
);

-- Student Tasks (assignments)
CREATE TABLE IF NOT EXISTS student_tasks (
    id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(id),
    task_id INTEGER REFERENCES tasks(id),
    assigned_date DATE DEFAULT CURRENT_DATE,
    due_date DATE,
    status VARCHAR(20) DEFAULT 'assigned' CHECK (status IN ('assigned', 'in_progress', 'completed', 'overdue')),
    completed_at TIMESTAMP,
    score INTEGER CHECK (score >= 0 AND score <= 100)
);

-- Knowledge Graph Nodes (for Neo4j integration)
CREATE TABLE IF NOT EXISTS knowledge_nodes (
    id SERIAL PRIMARY KEY,
    node_id VARCHAR(100) UNIQUE NOT NULL,
    node_type VARCHAR(50),
    properties JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Knowledge Graph Relationships
CREATE TABLE IF NOT EXISTS knowledge_relationships (
    id SERIAL PRIMARY KEY,
    source_node_id VARCHAR(100),
    target_node_id VARCHAR(100),
    relationship_type VARCHAR(50),
    properties JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO students (name, email, cohort) VALUES
('John Doe', 'john@bootcamp.com', 'Spring 2024'),
('Jane Smith', 'jane@bootcamp.com', 'Spring 2024'),
('Mike Johnson', 'mike@bootcamp.com', 'Spring 2024');

INSERT INTO tasks (title, description, difficulty_level, category, estimated_duration) VALUES
('Build a REST API', 'Create a simple REST API using Node.js and Express', 'intermediate', 'Backend Development', 120),
('Database Design', 'Design a normalized database schema for an e-commerce platform', 'advanced', 'Database', 90),
('Frontend Component', 'Build a reusable React component with TypeScript', 'beginner', 'Frontend Development', 60); 