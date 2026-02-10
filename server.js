const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const { handleBfhl } = require('./routes/bfhl');
const { handleHealth } = require('./routes/health');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Request logging middleware
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Routes
app.post('/bfhl', handleBfhl);
app.get('/health', handleHealth);

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    is_success: false,
    error: 'Endpoint not found'
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({
    is_success: false,
    error: 'Internal server error'
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

