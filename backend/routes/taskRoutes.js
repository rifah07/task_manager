const express = require('express');
const TaskController = require('../controllers/taskController');
const AuthMiddleware = require('../middlewares/authMiddleware');

const router = express.Router();

router.use(AuthMiddleware.authenticate);

router.post('/', TaskController.createTask);
router.get('/', TaskController.getTasks);
router.get('/:id', TaskController.getTaskById);
router.put('/:id', TaskController.updateTask);
router.delete('/:id', TaskController.deleteTask);
router.get('/:id/logs', TaskController.getActivityLogs);

module.exports = router;