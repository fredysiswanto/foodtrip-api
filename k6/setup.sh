#!/bin/bash

# K6 Installation & Setup Guide
# Run this script to verify and setup k6 properly

echo "🚀 K6 Load Testing Setup Verification"
echo "======================================"
echo ""

# Check K6 installation
echo "1️⃣  Checking K6 Installation..."
if command -v k6 &> /dev/null; then
    K6_VERSION=$(k6 version)
    echo "   ✅ K6 is installed: $K6_VERSION"
else
    echo "   ❌ K6 is not installed"
    echo ""
    echo "   Install K6 using Homebrew:"
    echo "   $ brew install k6"
    echo ""
    exit 1
fi

echo ""
echo "2️⃣  Checking Project Structure..."
if [ -d "k6" ]; then
    echo "   ✅ K6 folder exists"
    K6_FILES=$(ls k6/*.js 2>/dev/null | wc -l)
    echo "   ✅ Found $K6_FILES test files"
else
    echo "   ❌ K6 folder not found"
    exit 1
fi

echo ""
echo "3️⃣  Verifying Test Files..."
TEST_FILES=(
    "k6/config.js"
    "k6/helpers.js"
    "k6/01_auth_test.js"
    "k6/02_browse_test.js"
    "k6/03_customer_operations_test.js"
    "k6/04_complete_user_flow_test.js"
    "k6/05_stress_test.js"
    "k6/06_soak_test.js"
    "k6/07_spike_test.js"
)

MISSING=0
for file in "${TEST_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✅ $file"
    else
        echo "   ❌ $file (MISSING)"
        MISSING=$((MISSING + 1))
    fi
done

if [ $MISSING -gt 0 ]; then
    echo ""
    echo "   ⚠️  Some test files are missing!"
    exit 1
fi

echo ""
echo "4️⃣  Checking Documentation..."
DOC_FILES=(
    "k6/README.md"
    "k6/QUICK_START.md"
    "k6/ARCHITECTURE.md"
)

for doc in "${DOC_FILES[@]}"; do
    if [ -f "$doc" ]; then
        echo "   ✅ $doc"
    else
        echo "   ⚠️  $doc (not found)"
    fi
done

echo ""
echo "5️⃣  Checking API Server..."
if pgrep -f "node app.js" > /dev/null || pgrep -f "nodemon" > /dev/null; then
    echo "   ✅ API server is running"
else
    echo "   ⚠️  API server is not running"
    echo "   Start it with: pnpm run dev"
fi

echo ""
echo "======================================"
echo "✅ Setup verification complete!"
echo ""
echo "📖 Next Steps:"
echo ""
echo "1. Start the API server (if not running):"
echo "   $ pnpm run dev"
echo ""
echo "2. Run a quick smoke test:"
echo "   $ k6 run k6/01_auth_test.js --env BASE_URL=http://localhost:5000 --env SCENARIO=smoke"
echo ""
echo "3. For more tests and scenarios, see k6/QUICK_START.md"
echo ""
