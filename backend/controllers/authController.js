const jwt = require('jsonwebtoken');
const User = require('../models/User');
const ActivityLog = require('../models/ActivityLog');

class AuthController {
    static async register(req, res) {
        try {
            const { username, email, password, role } = req.body;

            const existingUser = await User.findByEmail(email);
            if (existingUser) {
                return res.status(400).json({ error: 'Email already in use' });
            }

            const user = new User({ username, email, password, role });
            await user.save();

            await ActivityLog.create(user.id, 'USER_REGISTERED', 'New user registration');

            const token = jwt.sign({
                id: user.id,
                email: user.email,},
                process.env.JWT_SECRET || 'secret-key',
                { expiresIn: '24h}' }
            );
            res.status(201).json({user: user.toJSON(), token });

        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }
}

module.exports = AuthController;