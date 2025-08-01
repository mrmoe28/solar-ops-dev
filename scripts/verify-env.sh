#!/bin/bash

echo "🔍 Verifying environment variables for Vercel deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Required environment variables
REQUIRED_VARS=(
    "DATABASE_URL"
    "NEXT_PUBLIC_API_URL"
    "NEXT_PUBLIC_WS_URL"
    "NEXT_PUBLIC_APP_URL"
    "JWT_SECRET"
)

# Optional but recommended
OPTIONAL_VARS=(
    "NODE_ENV"
)

echo ""
echo "Checking required environment variables..."
echo "========================================="

MISSING_VARS=0

for var in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        echo -e "${RED}❌ $var is not set${NC}"
        MISSING_VARS=$((MISSING_VARS + 1))
    else
        # Hide sensitive values
        if [[ "$var" == *"SECRET"* ]] || [[ "$var" == *"DATABASE_URL"* ]]; then
            echo -e "${GREEN}✓ $var is set (hidden)${NC}"
        else
            echo -e "${GREEN}✓ $var = ${!var}${NC}"
        fi
    fi
done

echo ""
echo "Checking optional environment variables..."
echo "========================================="

for var in "${OPTIONAL_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        echo -e "${YELLOW}⚠ $var is not set (optional)${NC}"
    else
        echo -e "${GREEN}✓ $var = ${!var}${NC}"
    fi
done

echo ""

if [ $MISSING_VARS -gt 0 ]; then
    echo -e "${RED}❌ Missing $MISSING_VARS required environment variables!${NC}"
    echo ""
    echo "To set these variables in Vercel:"
    echo "1. Go to https://vercel.com/dashboard"
    echo "2. Select your project"
    echo "3. Go to Settings → Environment Variables"
    echo "4. Add the missing variables"
    echo ""
    echo "Example values:"
    echo "DATABASE_URL=your-neon-database-url"
    echo "NEXT_PUBLIC_API_URL=https://solarops-backend.onrender.com/graphql"
    echo "NEXT_PUBLIC_WS_URL=wss://solarops-backend.onrender.com/graphql"
    echo "NEXT_PUBLIC_APP_URL=https://solarops-28.vercel.app"
    echo "JWT_SECRET=your-secure-jwt-secret"
    exit 1
else
    echo -e "${GREEN}✅ All required environment variables are set!${NC}"
    echo ""
    echo "You're ready to deploy to Vercel!"
fi