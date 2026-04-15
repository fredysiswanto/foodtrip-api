#!/bin/bash

# K6 Load Testing Suite - Quick Commands
# Usage: source run_tests.sh or make it executable with chmod +x

BASE_URL="${BASE_URL:=http://localhost:5000}"

echo "🚀 K6 Load Testing Suite for FoodTrip API"
echo "=========================================="
echo ""

# Function to run a test
run_test() {
  local test_name=$1
  local test_file=$2
  local scenario=${3:-smoke}
  
  echo "📊 Running: $test_name"
  echo "File: $test_file"
  echo "Scenario: $scenario"
  echo "Base URL: $BASE_URL"
  echo "---"
  
  k6 run "$test_file" --env BASE_URL="$BASE_URL" --env SCENARIO="$scenario"
}

# Show menu
show_menu() {
  echo ""
  echo "Select a test to run:"
  echo ""
  echo "  1) Smoke Test (01_auth_test.js) - Quick 30s test"
  echo "  2) Authentication Tests - Various user types"
  echo "  3) Browse Operations - Restaurants, dishes, categories"
  echo "  4) Customer Operations - Cart, orders, addresses"
  echo "  5) Complete User Flow - Full journey with spike"
  echo "  6) Stress Test - Find breaking point"
  echo "  7) Soak Test - 30min endurance test"
  echo "  8) Spike Test - Sudden traffic surge"
  echo "  9) Run All Tests - Complete test suite"
  echo "  0) Exit"
  echo ""
}

# Main menu loop
while true; do
  show_menu
  read -p "Enter your choice [0-9]: " choice
  
  case $choice in
    1)
      run_test "Smoke Test" "k6/01_auth_test.js" "smoke"
      ;;
    2)
      run_test "Authentication Tests" "k6/01_auth_test.js" "rampUp"
      ;;
    3)
      run_test "Browse Operations" "k6/02_browse_test.js" "rampUp"
      ;;
    4)
      run_test "Customer Operations" "k6/03_customer_operations_test.js" "rampUp"
      ;;
    5)
      run_test "Complete User Flow" "k6/04_complete_user_flow_test.js" "spike"
      ;;
    6)
      run_test "Stress Test" "k6/05_stress_test.js" "stress"
      ;;
    7)
      run_test "Soak Test (30min)" "k6/06_soak_test.js" "soak"
      ;;
    8)
      run_test "Spike Test" "k6/07_spike_test.js" "spike"
      ;;
    9)
      echo "🔄 Running all tests..."
      run_test "01 - Auth Test" "k6/01_auth_test.js" "smoke"
      run_test "02 - Browse Test" "k6/02_browse_test.js" "rampUp"
      run_test "03 - Customer Operations" "k6/03_customer_operations_test.js" "rampUp"
      run_test "04 - Complete Flow" "k6/04_complete_user_flow_test.js" "spike"
      run_test "05 - Stress Test" "k6/05_stress_test.js" "stress"
      ;;
    0)
      echo "👋 Goodbye!"
      exit 0
      ;;
    *)
      echo "❌ Invalid option. Please try again."
      ;;
  esac
  
  echo ""
  read -p "Press Enter to continue..."
done
