const express = require('express');
const cors = require('cors');
require('dotenv').config();

const authRoutes = require('./routes/authRoutes');
const taskRoutes = require('./routes/taskRoutes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/tasks', taskRoutes);

// Welcome route
app.get("/", (req, res) => {
  res.status(200).json({
    status: "success",
    message: "Welcome to Task-Manager API!",
    version: "1.0.0",
   // documentation: `http://localhost:${process.env.PORT || 5000}/api-docs`
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Something went wrong!' });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
    //console.log(`Server is running on port ${PORT}`);
});

module.exports = app;