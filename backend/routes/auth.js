// backend/routes/auth.js
const express = require('express');
const router = express.Router();

// @route   POST api/auth/register
// @desc    Register a new user
// @access  Public
router.post('/register', (req, res) => {
  // Get the data from the request body
  const { name, phone, password } = req.body;

  // For now, we will just log the data to the console
  // In the future, we will save this to the database
  console.log('New user registration request:');
  console.log('Name:', name);
  console.log('Phone:', phone);
  console.log('Password:', password); // We will hash this later!

  // Send a success response back to the app
  res.status(201).json({ message: 'User registered successfully!' });
});

module.exports = router;