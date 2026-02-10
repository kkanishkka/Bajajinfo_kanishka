const { generateFibonacci } = require('../utils/fibonacci');
const { findPrimes } = require('../utils/prime');
const { calculateLCM } = require('../utils/lcm');
const { calculateHCF } = require('../utils/hcf');
const { getAIResponse } = require('../utils/ai');

const handleBfhl = async (req, res) => {
  try {
    const officialEmail = process.env.OFFICIAL_EMAIL || 'your.email@chitkara.edu.in';
    const body = req.body;

    // Validate that exactly one key is present
    const keys = ['fibonacci', 'prime', 'lcm', 'hcf', 'AI'];
    const presentKeys = keys.filter(key => body.hasOwnProperty(key));

    if (presentKeys.length === 0) {
      return res.status(400).json({
        is_success: false,
        error: 'Request must contain exactly one of: fibonacci, prime, lcm, hcf, AI'
      });
    }

    if (presentKeys.length > 1) {
      return res.status(400).json({
        is_success: false,
        error: 'Request must contain exactly one key, found multiple'
      });
    }

    const key = presentKeys[0];
    let data;

    // Handle each operation
    switch (key) {
      case 'fibonacci':
        const fibInput = body.fibonacci;
        if (typeof fibInput !== 'number' || !Number.isInteger(fibInput) || fibInput < 0) {
          return res.status(400).json({
            is_success: false,
            error: 'fibonacci must be a non-negative integer'
          });
        }
        data = generateFibonacci(fibInput);
        break;

      case 'prime':
        const primeInput = body.prime;
        if (!Array.isArray(primeInput)) {
          return res.status(400).json({
            is_success: false,
            error: 'prime must be an array of integers'
          });
        }
        if (primeInput.length === 0) {
          return res.status(400).json({
            is_success: false,
            error: 'prime array cannot be empty'
          });
        }
        if (!primeInput.every(num => Number.isInteger(num) && num > 0)) {
          return res.status(400).json({
            is_success: false,
            error: 'prime array must contain only positive integers'
          });
        }
        data = findPrimes(primeInput);
        break;

      case 'lcm':
        const lcmInput = body.lcm;
        if (!Array.isArray(lcmInput)) {
          return res.status(400).json({
            is_success: false,
            error: 'lcm must be an array of integers'
          });
        }
        if (lcmInput.length === 0) {
          return res.status(400).json({
            is_success: false,
            error: 'lcm array cannot be empty'
          });
        }
        if (!lcmInput.every(num => Number.isInteger(num) && num > 0)) {
          return res.status(400).json({
            is_success: false,
            error: 'lcm array must contain only positive integers'
          });
        }
        data = calculateLCM(lcmInput);
        break;

      case 'hcf':
        const hcfInput = body.hcf;
        if (!Array.isArray(hcfInput)) {
          return res.status(400).json({
            is_success: false,
            error: 'hcf must be an array of integers'
          });
        }
        if (hcfInput.length === 0) {
          return res.status(400).json({
            is_success: false,
            error: 'hcf array cannot be empty'
          });
        }
        if (!hcfInput.every(num => Number.isInteger(num) && num > 0)) {
          return res.status(400).json({
            is_success: false,
            error: 'hcf array must contain only positive integers'
          });
        }
        data = calculateHCF(hcfInput);
        break;

      case 'AI':
        const aiInput = body.AI;
        if (typeof aiInput !== 'string' || aiInput.trim().length === 0) {
          return res.status(400).json({
            is_success: false,
            error: 'AI must be a non-empty string'
          });
        }
        try {
          data = await getAIResponse(aiInput);
        } catch (aiError) {
          return res.status(500).json({
            is_success: false,
            error: 'AI service error: ' + aiError.message
          });
        }
        break;

      default:
        return res.status(400).json({
          is_success: false,
          error: 'Invalid key in request'
        });
    }

    // Success response
    res.status(200).json({
      is_success: true,
      official_email: officialEmail,
      data: data
    });

  } catch (error) {
    console.error('Error in handleBfhl:', error);
    res.status(500).json({
      is_success: false,
      error: 'Internal server error'
    });
  }
};

module.exports = { handleBfhl };

