const db = require('../config/database');

class ActivityLog {
    static async create(userId, taskId, action, details) {
        return await db.query(
            `INSERT INTO activity_logs (userId, taskId, action, details) VALUES (?, ?, ?, ?)`,
            [userId, taskId, action, details]
        );
    }
    static async getByTaskId(taskId) {
        return await db.query(
            'SELECT al.*, u.username FROM activity_logs al JOIN users u ON al.userId = u.id WHERE task_id = ? ORDER BY created_at DESC',
            [taskId]
        );
    }
    static async getByUserId(userId) {
        return await db.query(
            'SELECT * FROM activity_logs WHERE user_id = ? ORDER BY created_at DESC LIMIT 50',
            [userId]
        );
    }
}

module.exports = ActivityLog;