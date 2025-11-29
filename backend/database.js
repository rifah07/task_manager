const mysql = require('mysql2/promise');

class Database {
    constructor(){
        this.pool = mysql.createPool({
            host: process.env.DB_HOST || 'localhost',
            user: process.env.DB_USER || 'root',
            password: process.env.DB_PASSWORD || '',
            database: process.env.DB_NAME || 'task_management',
            waitForConnections: true,
            connectionLimit: 10,
            queueLimit: 0
        });
    }
}