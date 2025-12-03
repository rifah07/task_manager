const bcrypt = require('bcrypt');
const db = require('../config/database');

class User {
    constructor(data){
        this.id = data.id;
        this.username = data.username;
        this.email = data.email;
        this.password = data.password;
        this.role = data.role || 'user';
    }

    // Encapsulation: Hide password hashing logic
    async hashPassword(){
        this.password = await bcrypt.hash(this.password, 10)
    }

    async comparePassword(candidatePassword){
        return await bcrypt.compare(candidatePassword, this.password);
    }
     
    // Static method (Factory pattern)
    static async findByEmail(email){
        const results = await db.query('SELECT * FROM users WHERE email=?',[email]);
        return results.length > 0 ? new User(results[0]) : null;
    }
     static async findById(id){
        const results = await db.query('SELECT * FROM users WHERE id=?',[id]);
        return results.length > 0 ? new User(results[0]) : null;
    }

}

module.exports = User;