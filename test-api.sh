#!/bin/bash
# Chitkara Qualifier API Test Script
# Make sure the server is running before executing these tests
# Run: npm start (in another terminal)

BASE_URL="http://localhost:3000"

echo "========================================"
echo "Chitkara Qualifier API Tests"
echo "========================================"
echo ""

# Test 1: GET /health
echo "Test 1: GET /health"
echo "Expected: is_success: true, official_email"
curl -s -X GET "$BASE_URL/health" | jq .
echo ""
echo ""

# Test 2: POST /bfhl - Fibonacci
echo "Test 2: POST /bfhl - Fibonacci (n=7)"
echo "Expected: [0,1,1,2,3,5,8]"
curl -s -X POST "$BASE_URL/bfhl" \
  -H "Content-Type: application/json" \
  -d '{"fibonacci": 7}' | jq .
echo ""
echo ""

# Test 3: POST /bfhl - Prime
echo "Test 3: POST /bfhl - Prime ([2,4,7,9,11])"
echo "Expected: [2,7,11]"
curl -s -X POST "$BASE_URL/bfhl" \
  -H "Content-Type: application/json" \
  -d '{"prime": [2,4,7,9,11]}' | jq .
echo ""
echo ""

# Test 4: POST /bfhl - LCM
echo "Test 4: POST /bfhl - LCM ([12,18,24])"
echo "Expected: 72"
curl -s -X POST "$BASE_URL/bfhl" \
  -H "Content-Type: application/json" \
  -d '{"lcm": [12,18,24]}' | jq .
echo ""
echo ""

# Test 5: POST /bfhl - HCF
echo "Test 5: POST /bfhl - HCF ([24,36,60])"
echo "Expected: 12"
curl -s -X POST "$BASE_URL/bfhl" \
  -H "Content-Type: application/json" \
  -d '{"hcf": [24,36,60]}' | jq .
echo ""
echo ""

# Test 6: POST /bfhl - AI
echo "Test 6: POST /bfhl - AI (What is the capital city of Maharashtra?)"
echo "Expected: Mumbai (single word)"
curl -s -X POST "$BASE_URL/bfhl" \
  -H "Content-Type: application/json" \
  -d '{"AI": "What is the capital city of Maharashtra?"}' | jq .
echo ""
echo ""

# Test 7: Error handling - Invalid input
echo "Test 7: POST /bfhl - Error handling (negative fibonacci)"
echo "Expected: is_success: false, error message"
curl -s -X POST "$BASE_URL/bfhl" \
  -H "Content-Type: application/json" \
  -d '{"fibonacci": -5}' | jq .
echo ""
echo ""

# Test 8: Error handling - Multiple keys
echo "Test 8: POST /bfhl - Error handling (multiple keys)"
echo "Expected: is_success: false, error message"
curl -s -X POST "$BASE_URL/bfhl" \
  -H "Content-Type: application/json" \
  -d '{"fibonacci": 5, "prime": [2,3]}' | jq .
echo ""
echo ""

echo "========================================"
echo "All tests completed!"
echo "========================================"

