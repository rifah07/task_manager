-- Create Database--
Create Database IF NOT EXISTS task_management;
Use task_management;

-- Create Table for Users --
Create Table users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    --Indexes for Performance--
    INDEX idx_email (email),
    INDEX idx_username (username)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create Table for Tasks --
Create Table tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    status ENUM('pending', 'in_progress', 'completed', 'cancelled') DEFAULT 'pending',
    priority ENUM('low', 'medium', 'high') DEFAULT 'medium',
    created_by INT NOT NULL,
    assigned_to INT,
    due_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign Keys (Referential Integrity) --
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL,

    -- Composite Index for common queries --
    INDEX idx_status_priority (status, priority),
    INDEX idx_assigned_to (assigned_to),
    INDEX idx_created_by (created_by),
    INDEX idx_due_date (due_date)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;;

-- Activity Log Table (Audit Trail) --
CREATE TABLE activity_logs(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    task_id INT,
    action VARCHAR(100) NOT NULL,
    details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,

    INDEX idx_user_id (user_id),
    INDEX idx_task_id (task_id),
    INDEX idx_created_at (created_at)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Views for common queries (Performance optimization) --
CREATE VIEW task_view AS
SELECT
    t.id,
    t.title,
    t.description,
    t.status,
    t.priority,
    t.due_date,
    u1.username AS created_by_name,
    u2.username AS assigned_to_name,
    t.created_at,
    t.updated_at
FROM tasks t
LEFT JOIN users u1 ON t.created_by = u1.id
LEFT JOIN users u2 ON t.assigned_to = u2.id;

-- Stored Procedure --
DELIMITER //
CREATE PROCEDURE GetUserTaskStats(IN userId INT)
BEGIN
    SELECT
        status,
        COUNT(*) AS count
    FROM tasks
    WHERE assigned_to = userId
    GROUP BY status;
END //
DELIMITER ;

-- Sample Data Insertion --
INSERT INTO users (username, email, password, role) VALUES
('elsa','elsa@example.com','$2b$10$examplehash1', 'admin'),
('john_doe', 'john@example.com', '$2b$10$examplehash2', 'user'),
('anna', 'anna@example.com', '$2b$10$examplehash2', 'user');

-- Useful MySQL Queries to Remember:

-- 1. Join Query with Aggregation
SELECT 
    u.username,
    COUNT(t.id) as total_tasks,
    SUM(CASE WHEN t.status = 'completed' THEN 1 ELSE 0 END) as completed_tasks
FROM users u
LEFT JOIN tasks t ON u.id = t.assigned_to
GROUP BY u.id, u.username;

-- 2. Subquery Example
SELECT * FROM tasks 
WHERE created_by IN (
    SELECT id FROM users WHERE role = 'admin'
);

-- 3. Date Functions
SELECT * FROM tasks 
WHERE due_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY);

-- 4. Full-Text Search (if needed)
-- ALTER TABLE tasks ADD FULLTEXT(title, description);
-- SELECT * FROM tasks WHERE MATCH(title, description) AGAINST('keyword');