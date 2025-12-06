const db = require('../config/database');

class BaseModel {
    constructor(tableName) {
        this.tableName = tableName;
    }

    async findAll() {
        return await db.query(`SELECT * FROM ${this.tableName}`);
    }

    async findById(id) {
        const results = await db.query(
            `SELECT * FROM ${this.tableName} WHERE id = ?`,
            [id]
        );
        return results[0];
    }

    async deleteById(id) {
        return await db.query(
            `DELETE FROM ${this.tableName} WHERE id = ?`,
            [id]
        );
    }
}

class Task extends BaseModel {
    constructor(data = {}) {
        super('tasks'); // Call the parent constructor
        this.id = data.id;
        this.title = data.title;
        this.description = data.description;
        this.status = data.status || 'pending';
        this.priority = data.priority || 'medium';
        this.created_by = data.created_by;
        this.assigned_to = data.assigned_to;
        this.due_date = data.due_date;
    }

    async save() {
        const result = await db.query(
            'INSERT INTO tasks (title, description, status, priority, created_by, assigned_to, due_date) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [this.title, this.description, this.status, this.priority, this.created_by, this.assigned_to, this.due_date]
        );
        this.id = result.insertId;
        return this;
    }

    async update() {
        return await db.query(
            'UPDATE tasks SET title = ?, description = ?, status = ?, priority = ?, created_by = ?, assigned_to = ?, due_date = ? WHERE id = ?',
            [this.title, this.description, this.status, this.priority, this.created_by, this.assigned_to, this.due_date, this.id]
        );
    }

    static async findUserById(id) {
        return await db.query(
            `SELECT * FROM task_details WHERE assigned_to_name = (SELECT username FROM users WHERE id = ?)`,
            [userId]
        );
    }

    static async findWithFilters(filters) {
        let query = `SELECT * FROM tasks WHERE 1=1`;
        const params = [];

        if (filters.status) {
            query += ` AND status = ?`;
            params.push(filters.status);
        }
        if (filters.priority) {
            query += ` AND priority = ?`;
            params.push(filters.priority);
        }
        if (filters.assigned_to) {
            query += ` AND assigned_to = ?`;
            params.push(filters.assigned_to);
        }
        return await db.query(query, params);
    }
}

module.exports = Task;