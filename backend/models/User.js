const bcrypt = require('bcrypt');
const db = require('../config/database');

class User {
    constructor(data){
        this.id = data.id;
        this.username = data.username;
        this.email = data.email;
        this.password = data.password; // hashed password
        this.role = data.role || 'user';
    }
}

module.exports = User;