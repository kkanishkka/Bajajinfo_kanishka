# API Testing Commands

## Prerequisites

1. **Start the server first:**
   ```bash
   npm install
   npm start
   ```

2. **Open a new terminal** to run the test commands

---

## Quick Test Scripts

### Windows PowerShell
```powershell
.\test-api.ps1
```

### Linux/Mac/Git Bash
```bash
chmod +x test-api.sh
./test-api.sh
```

---

## Manual Testing Commands

### 1. GET /health

**PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:3000/health" -Method Get | ConvertTo-Json
```

**curl (Linux/Mac/Git Bash):**
```bash
curl -X GET http://localhost:3000/health
```

**Expected Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in"
}
```

---

### 2. POST /bfhl - Fibonacci

**PowerShell:**
```powershell
$body = @{fibonacci = 7} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:3000/bfhl" -Method Post -Body $body -ContentType "application/json" | ConvertTo-Json
```

**curl:**
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"fibonacci": 7}'
```

**Expected Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": [0, 1, 1, 2, 3, 5, 8]
}
```

---

### 3. POST /bfhl - Prime

**PowerShell:**
```powershell
$body = @{prime = @(2, 4, 7, 9, 11)} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:3000/bfhl" -Method Post -Body $body -ContentType "application/json" | ConvertTo-Json
```

**curl:**
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"prime": [2,4,7,9,11]}'
```

**Expected Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": [2, 7, 11]
}
```

---

### 4. POST /bfhl - LCM

**PowerShell:**
```powershell
$body = @{lcm = @(12, 18, 24)} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:3000/bfhl" -Method Post -Body $body -ContentType "application/json" | ConvertTo-Json
```

**curl:**
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"lcm": [12,18,24]}'
```

**Expected Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": 72
}
```

---

### 5. POST /bfhl - HCF

**PowerShell:**
```powershell
$body = @{hcf = @(24, 36, 60)} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:3000/bfhl" -Method Post -Body $body -ContentType "application/json" | ConvertTo-Json
```

**curl:**
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"hcf": [24,36,60]}'
```

**Expected Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": 12
}
```

---

### 6. POST /bfhl - AI

**PowerShell:**
```powershell
$body = @{AI = "What is the capital city of Maharashtra?"} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:3000/bfhl" -Method Post -Body $body -ContentType "application/json" | ConvertTo-Json
```

**curl:**
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"AI": "What is the capital city of Maharashtra?"}'
```

**Expected Response:**
```json
{
  "is_success": true,
  "official_email": "your.email@chitkara.edu.in",
  "data": "Mumbai"
}
```

**Note:** Make sure `GEMINI_API_KEY` is set in your `.env` file for AI to work.

---

## Error Handling Tests

### Test 7: Invalid Input (Negative Fibonacci)

**PowerShell:**
```powershell
$body = @{fibonacci = -5} | ConvertTo-Json
try {
    Invoke-RestMethod -Uri "http://localhost:3000/bfhl" -Method Post -Body $body -ContentType "application/json" | ConvertTo-Json
} catch {
    $_.ErrorDetails.Message | ConvertFrom-Json | ConvertTo-Json
}
```

**curl:**
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"fibonacci": -5}'
```

**Expected Response:**
```json
{
  "is_success": false,
  "error": "fibonacci must be a non-negative integer"
}
```

---

### Test 8: Multiple Keys (Should Fail)

**PowerShell:**
```powershell
$body = @{fibonacci = 5; prime = @(2, 3)} | ConvertTo-Json
try {
    Invoke-RestMethod -Uri "http://localhost:3000/bfhl" -Method Post -Body $body -ContentType "application/json" | ConvertTo-Json
} catch {
    $_.ErrorDetails.Message | ConvertFrom-Json | ConvertTo-Json
}
```

**curl:**
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{"fibonacci": 5, "prime": [2,3]}'
```

**Expected Response:**
```json
{
  "is_success": false,
  "error": "Request must contain exactly one key, found multiple"
}
```

---

### Test 9: No Key Provided

**PowerShell:**
```powershell
$body = @{} | ConvertTo-Json
try {
    Invoke-RestMethod -Uri "http://localhost:3000/bfhl" -Method Post -Body $body -ContentType "application/json" | ConvertTo-Json
} catch {
    $_.ErrorDetails.Message | ConvertFrom-Json | ConvertTo-Json
}
```

**curl:**
```bash
curl -X POST http://localhost:3000/bfhl \
  -H "Content-Type: application/json" \
  -d '{}'
```

**Expected Response:**
```json
{
  "is_success": false,
  "error": "Request must contain exactly one of: fibonacci, prime, lcm, hcf, AI"
}
```

---

### Test 10: Invalid Endpoint (404)

**PowerShell:**
```powershell
try {
    Invoke-RestMethod -Uri "http://localhost:3000/invalid" -Method Get
} catch {
    $_.ErrorDetails.Message | ConvertFrom-Json | ConvertTo-Json
}
```

**curl:**
```bash
curl -X GET http://localhost:3000/invalid
```

**Expected Response:**
```json
{
  "is_success": false,
  "error": "Endpoint not found"
}
```

---

## Using Postman or Insomnia

If you prefer GUI tools:

1. **Base URL:** `http://localhost:3000`

2. **Endpoints:**
   - `GET /health`
   - `POST /bfhl` (with JSON body)

3. **Headers:**
   - `Content-Type: application/json` (for POST requests)

4. **Body Examples:**
   - Fibonacci: `{"fibonacci": 7}`
   - Prime: `{"prime": [2,4,7,9,11]}`
   - LCM: `{"lcm": [12,18,24]}`
   - HCF: `{"hcf": [24,36,60]}`
   - AI: `{"AI": "What is the capital city of Maharashtra?"}`

---

## Troubleshooting

1. **Server not running:** Make sure you ran `npm start` in a separate terminal
2. **Port already in use:** Change `PORT` in `.env` file
3. **AI not working:** Check that `GEMINI_API_KEY` is set in `.env`
4. **Connection refused:** Verify server is running on the correct port

