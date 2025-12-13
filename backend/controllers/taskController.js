const Task = require('../models/Task');
const ActivityLog = require('../models/ActivityLog');

class TaskController {
    static async createTask(req, res) {
        try {
            const taskData = { ...req.body, created_by: req.user.id };
            const task = new Task(taskData);
            await task.save();

            await ActivityLog.create(req.user.id, task.id, 'TASK_CREATED', `Task "${task.title}" created`)

            res.status(201).json(task)
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getTasks(req, res) {
        try {

        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getTaskById(req, res) {
        try {

        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async updateTask(req, res) {
        try {

        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async deleteTask(req, res) {
        try {

        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getActivityLogs(req, res) {
        try {

        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

}

module.exports = TaskController;