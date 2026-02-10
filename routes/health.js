const handleHealth = (req, res) => {
  try {
    const officialEmail = process.env.OFFICIAL_EMAIL || 'your.email@chitkara.edu.in';
    
    res.status(200).json({
      is_success: true,
      official_email: officialEmail
    });
  } catch (error) {
    res.status(500).json({
      is_success: false,
      error: 'Health check failed'
    });
  }
};

module.exports = { handleHealth };

