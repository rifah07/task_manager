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

  