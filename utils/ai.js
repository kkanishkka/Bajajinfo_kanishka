const { GoogleGenerativeAI } = require('@google/generative-ai');

const getAIResponse = async (question) => {
  const apiKey = process.env.GEMINI_API_KEY;
  
  if (!apiKey) {
    throw new Error('GEMINI_API_KEY is not set in environment variables');
  }

  try {
    const genAI = new GoogleGenerativeAI(apiKey);
    const model = genAI.getGenerativeModel({ model: 'gemini2.5 Flash' });
    
    const prompt = `Answer the following question with a single word only. If the answer requires multiple words, provide the most important single word. Question: ${question}`;
    
    const result = await model.generateContent(prompt);
    const response = await result.response;
    let text = response.text().trim();
    
    // Extract single word if multiple words are returned
    const words = text.split(/\s+/);
    if (words.length > 1) {
      // Take the first meaningful word (skip articles, etc.)
      text = words.find(word => 
        word.length > 2 && 
        !['the', 'a', 'an', 'is', 'are', 'was', 'were'].includes(word.toLowerCase())
      ) || words[0];
    }
    
    // Remove punctuation and return single word
    text = text.replace(/[.,!?;:]/g, '');
    
    return text.split(/\s+/)[0];
  } catch (error) {
    console.error('Gemini API Error:', error);
    throw new Error('Failed to get AI response: ' + error.message);
  }
};

module.exports = { getAIResponse };

