const db = require('../config/database');

class ActivityLog {
    static async create(userId, taskId, action, details){
        return await db.query(
            `INSERT INTO activity_logs (userId, taskId, action, details) VALUES (?, ?, ?, ?)`,
            [userId, taskId, action, details]
        );
    }
}

module.exports = ActivityLog;