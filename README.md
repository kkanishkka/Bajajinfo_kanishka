# Chitkara Qualifier 1 - REST API Implementation

This project implements the required REST APIs for Chitkara Qualifier 1 (10 Feb 2026).

## APIs Implemented

### POST /bfhl
Handles five different operations based on the request key:
- **fibonacci**: Returns Fibonacci series up to n terms
- **prime**: Filters prime numbers from an array
- **lcm**: Calculates LCM (Least Common Multiple) of an array
- **hcf**: Calculates HCF (Highest Common Factor) of an array
- **AI**: Returns single-word AI response using Google Gemini

### GET /health
Health check endpoint that returns server status.

## Features

✅ Strict API response structure  
✅ Correct HTTP status codes  
✅ Robust input validation  
✅ Graceful error handling (no crashes)  
✅ Security guardrails  
✅ Public accessibility of APIs  

## Setup Instructions

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Environment Variables

Copy `.env.example` to `.env` and fill in your details:

```bash
cp .env.example .env
```

Edit `.env`:
```
OFFICIAL_EMAIL=your.email@chitkara.edu.in
GEMINI_API_KEY=your_gemini_api_key_here
PORT=3000
```

### 3. Get Google Gemini API Key

1. Visit https://aistudio.google.com
2. Sign in with your Google account
3. Click "Get API Key"
4. Create API key in a project
5. Copy the key and add it to `.env`

### 4. Run the Server

**Development mode (with auto-reload):**
```bash
npm run dev
```

**Production mode:**
```bash
npm start
```

The server will run on `http://localhost:3000` (or the port specified in `.env`).

## API Examples

### Fibonacci
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"fibonacci": 7}'
```

**Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": [0, 1, 1, 2, 3, 5, 8]
}
```

### Prime Numbers
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"prime": [2, 4, 7, 9, 11]}'
```

**Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": [2, 7, 11]
}
```

### LCM
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"lcm": [12, 18, 24]}'
```

**Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": 72
}
```

### HCF
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"hcf": [24, 36, 60]}'
```

**Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": 12
}
```

### AI Query
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"AI": "What is the capital city of Maharashtra?"}'
```

**Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": "Mumbai"
}
```

### Health Check
```bash
curl http://localhost:3000/health
```

**Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in"
}
```

## Deployment

### Vercel

1. Login to [Vercel](https://vercel.com)
2. New Project → Import repository
3. Configure runtime (Node.js)
4. Add environment variables:
   - `OFFICIAL_EMAIL`
   - `GEMINI_API_KEY`
5. Deploy and copy public URL

### Railway

1. New Project → Deploy from GitHub
2. Select your repository
3. Configure environment variables:
   - `OFFICIAL_EMAIL`
   - `GEMINI_API_KEY`
4. Deploy and copy URL

### Render

1. New Web Service → Select repository
2. Choose runtime (Node)
3. Set build command: `npm install`
4. Set start command: `npm start`
5. Add environment variables:
   - `OFFICIAL_EMAIL`
   - `GEMINI_API_KEY`
6. Deploy and copy URL

### ngrok (Testing)

For local testing with a public URL:

```bash
# Install ngrok
# Then run:
ngrok http 3000
```

**Note:** ngrok URLs expire and require the local server to remain running.

## Project Structure

```
.
├── server.js              # Main server file
├── routes/
│   ├── bfhl.js           # POST /bfhl handler
│   └── health.js         # GET /health handler
├── utils/
│   ├── fibonacci.js      # Fibonacci calculation
│   ├── prime.js          # Prime number filtering
│   ├── lcm.js            # LCM calculation
│   ├── hcf.js            # HCF calculation
│   └── ai.js             # AI integration (Gemini)
├── package.json
├── .env.example
├── .gitignore
└── README.md
```

## Error Handling

The API returns appropriate HTTP status codes:
- `200`: Success
- `400`: Bad Request (validation errors)
- `404`: Not Found (invalid endpoint)
- `500`: Internal Server Error

All error responses follow the structure:
```json
{
  "is_success": false,
  "error": "Error message"
}
```

## Security Features

- Input validation for all endpoints
- Type checking for all inputs
- Array validation for array inputs
- Error handling to prevent crashes
- Environment variables for sensitive data
- CORS enabled for public access

## License

ISC

