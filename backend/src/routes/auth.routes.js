const express = require("express");
const router = express.Router();
const db = require("../config/db");

// ✅ CREATE USER (admin will call this from Postman or future UI)
router.post("/create-user", async (req, res) => {
  const { name, email, password, role } = req.body;

  try {
    // Check if email exists
    const existing = await db.query(
      "SELECT * FROM users WHERE email = $1",
      [email]
    );

    if (existing.rows.length > 0) {
      return res.status(400).json({ message: "Email already used" });
    }

    // ⚠️ Plain password (OK for hackathon)
    await db.query(
      "INSERT INTO users (name, email, password, role) VALUES ($1, $2, $3, $4)",
      [name, email, password, role]
    );

    return res.json({ message: "User created successfully" });
  } catch (err) {
    console.error("Error in /auth/create-user:", err);
    res.status(500).json({ message: "Server error" });
  }
});

// ✅ LOGIN
router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const result = await db.query(
      "SELECT * FROM users WHERE email = $1",
      [email]
    );

    if (result.rows.length === 0) {
      return res.status(400).json({ message: "User not found" });
    }

    const user = result.rows[0];

    // ⚠️ Plain-text password check (hackathon only)
    if (password !== user.password) {
      return res.status(400).json({ message: "Wrong password" });
    }

    // No JWT for hackathon — return user object
    return res.json({
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
    });

  } catch (err) {
    console.error("Error in /auth/login:", err);
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;
