const db = require("../config/db");

module.exports = {
  async findByEmail(email) {
    const res = await db.query("SELECT * FROM users WHERE email = $1", [email]);
    return res.rows[0];
  },

  async createUser(name, email, password, role) {
    await db.query(
      "INSERT INTO users (name, email, password, role) VALUES ($1, $2, $3, $4)",
      [name, email, password, role]   // 👈 plain password for hackathon
    );
  }
};
