# Chitkara Qualifier API Test Script
# Make sure the server is running before executing these tests
# Run: npm start (in another terminal)

$baseUrl = "http://localhost:3000"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Chitkara Qualifier API Tests" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test 1: GET /health
Write-Host "Test 1: GET /health" -ForegroundColor Yellow
Write-Host "Expected: is_success: true, official_email" -ForegroundColor Gray
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/health" -Method Get
    $response | ConvertTo-Json -Depth 10
    Write-Host "✓ Health check passed" -ForegroundColor Green
} catch {
    Write-Host "✗ Health check failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 2: POST /bfhl - Fibonacci
Write-Host "Test 2: POST /bfhl - Fibonacci (n=7)" -ForegroundColor Yellow
Write-Host "Expected: [0,1,1,2,3,5,8]" -ForegroundColor Gray
try {
    $body = @{
        fibonacci = 7
    } | ConvertTo-Json
    $response = Invoke-RestMethod -Uri "$baseUrl/bfhl" -Method Post -Body $body -ContentType "application/json"
    $response | ConvertTo-Json -Depth 10
    Write-Host "✓ Fibonacci test passed" -ForegroundColor Green
} catch {
    Write-Host "✗ Fibonacci test failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 3: POST /bfhl - Prime
Write-Host "Test 3: POST /bfhl - Prime ([2,4,7,9,11])" -ForegroundColor Yellow
Write-Host "Expected: [2,7,11]" -ForegroundColor Gray
try {
    $body = @{
        prime = @(2, 4, 7, 9, 11)
    } | ConvertTo-Json
    $response = Invoke-RestMethod -Uri "$baseUrl/bfhl" -Method Post -Body $body -ContentType "application/json"
    $response | ConvertTo-Json -Depth 10
    Write-Host "✓ Prime test passed" -ForegroundColor Green
} catch {
    Write-Host "✗ Prime test failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 4: POST /bfhl - LCM
Write-Host "Test 4: POST /bfhl - LCM ([12,18,24])" -ForegroundColor Yellow
Write-Host "Expected: 72" -ForegroundColor Gray
try {
    $body = @{
        lcm = @(12, 18, 24)
    } | ConvertTo-Json
    $response = Invoke-RestMethod -Uri "$baseUrl/bfhl" -Method Post -Body $body -ContentType "application/json"
    $response | ConvertTo-Json -Depth 10
    Write-Host "✓ LCM test passed" -ForegroundColor Green
} catch {
    Write-Host "✗ LCM test failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 5: POST /bfhl - HCF
Write-Host "Test 5: POST /bfhl - HCF ([24,36,60])" -ForegroundColor Yellow
Write-Host "Expected: 12" -ForegroundColor Gray
try {
    $body = @{
        hcf = @(24, 36, 60)
    } | ConvertTo-Json
    $response = Invoke-RestMethod -Uri "$baseUrl/bfhl" -Method Post -Body $body -ContentType "application/json"
    $response | ConvertTo-Json -Depth 10
    Write-Host "✓ HCF test passed" -ForegroundColor Green
} catch {
    Write-Host "✗ HCF test failed: $_" -ForegroundColor Red
}
Write-Host ""

# Test 6: POST /bfhl - AI
Write-Host "Test 6: POST /bfhl - AI (What is the capital city of Maharashtra?)" -ForegroundColor Yellow
Write-Host "Expected: Mumbai (single word)" -ForegroundColor Gray
try {
    $body = @{
        AI = "What is the capital city of Maharashtra?"
    } | ConvertTo-Json
    $response = Invoke-RestMethod -Uri "$baseUrl/bfhl" -Method Post -Body $body -ContentType "application/json"
    $response | ConvertTo-Json -Depth 10
    Write-Host "✓ AI test passed" -ForegroundColor Green
} catch {
    Write-Host "✗ AI test failed: $_" -ForegroundColor Red
    Write-Host "Note: Make sure GEMINI_API_KEY is set in .env file" -ForegroundColor Yellow
}
Write-Host ""

# Test 7: Error handling - Invalid input
Write-Host "Test 7: POST /bfhl - Error handling (negative fibonacci)" -ForegroundColor Yellow
Write-Host "Expected: is_success: false, error message" -ForegroundColor Gray
try {
    $body = @{
        fibonacci = -5
    } | ConvertTo-Json
    $response = Invoke-RestMethod -Uri "$baseUrl/bfhl" -Method Post -Body $body -ContentType "application/json"
    $response | ConvertTo-Json -Depth 10
    Write-Host "✗ Error handling test failed (should have returned error)" -ForegroundColor Red
} catch {
    $errorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
    $errorResponse | ConvertTo-Json -Depth 10
    Write-Host "✓ Error handling test passed" -ForegroundColor Green
}
Write-Host ""

# Test 8: Error handling - Multiple keys
Write-Host "Test 8: POST /bfhl - Error handling (multiple keys)" -ForegroundColor Yellow
Write-Host "Expected: is_success: false, error message" -ForegroundColor Gray
try {
    $body = @{
        fibonacci = 5
        prime = @(2, 3)
    } | ConvertTo-Json
    $response = Invoke-RestMethod -Uri "$baseUrl/bfhl" -Method Post -Body $body -ContentType "application/json"
    $response | ConvertTo-Json -Depth 10
    Write-Host "✗ Error handling test failed (should have returned error)" -ForegroundColor Red
} catch {
    $errorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
    $errorResponse | ConvertTo-Json -Depth 10
    Write-Host "✓ Error handling test passed" -ForegroundColor Green
}
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "All tests completed!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

