const User = require("../model/user.model");

module.exports = {
  async login(req, res) {
    const { email, password } = req.body;

    try {
      const user = await User.findByEmail(email);
      if (!user) return res.status(400).json({ message: "User not found" });

      // plain-text check for hackathon
      if (password !== user.password) {
        return res.status(400).json({ message: "Invalid password" });
      }

      return res.json({
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Server error" });
    }
  },

  async createUser(req, res) {
    const { name, email, password, role } = req.body;

    try {
      const existing = await User.findByEmail(email);
      if (existing) {
        return res.status(400).json({ message: "Email already used" });
      }

      // plain password (OK for hackathon)
      await User.createUser(name, email, password, role);

      return res.json({ message: "User created successfully" });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Server error" });
    }
  },
};
