// backend/index.js
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

// Import our new auth route
const authRoutes = require('./routes/auth');

const app = express();
const PORT = 3000;

// --- Middleware ---
// Use CORS to allow cross-origin requests
app.use(cors());
// Use body-parser to parse JSON bodies
app.use(bodyParser.json());

// --- API Routes ---
// Tell the app to use our auth routes for any request starting with /api/auth
app.use('/api/auth', authRoutes);

// A simple test route to make sure the server is up
app.get('/', (req, res) => {
  res.send('Circle Backend is alive!');
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});