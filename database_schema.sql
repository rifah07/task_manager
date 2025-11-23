-- Create Database--
Create Database IF NOT EXISTS task_management;
Use task_management;

-- Create Table for Users --
Create Table users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('adimin', 'user') DEFAULT 'user',
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
  