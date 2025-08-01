#!/bin/bash

# Frontend Deployment Script for Vercel
# This script deploys the frontend app to Vercel with proper configuration

echo "🚀 SolarOps Frontend Deployment Script"
echo "====================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Vercel CLI is installed
if ! command_exists vercel; then
    echo -e "${RED}❌ Vercel CLI not found${NC}"
    echo "Installing Vercel CLI..."
    npm install -g vercel
fi

# Check if we're in the project root
if [ ! -d "apps/frontend" ]; then
    echo -e "${RED}❌ Error: apps/frontend directory not found${NC}"
    echo "Please run this script from the project root directory"
    exit 1
fi

# Navigate to frontend directory
echo -e "${BLUE}📂 Navigating to frontend directory...${NC}"
cd apps/frontend

# Check if vercel.json exists
if [ ! -f "vercel.json" ]; then
    echo -e "${YELLOW}⚠️  vercel.json not found. Creating...${NC}"
    cat > vercel.json << 'EOF'
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "installCommand": "cd ../.. && pnpm install --frozen-lockfile",
  "buildCommand": "cd ../.. && pnpm build:packages && cd apps/frontend && pnpm build",
  "framework": "nextjs"
}
EOF
    echo -e "${GREEN}✅ vercel.json created${NC}"
fi

# Deploy to Vercel
echo ""
echo -e "${BLUE}🚀 Deploying to Vercel...${NC}"
echo -e "${YELLOW}Note: Make sure you've set the Root Directory to 'apps/frontend' in Vercel Dashboard${NC}"
echo ""

# Deploy with production flag
vercel --prod

# Check if deployment was successful
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Deployment successful!${NC}"
    echo ""
    echo -e "${BLUE}📋 Next steps:${NC}"
    echo "1. Set environment variables in Vercel Dashboard:"
    echo "   - NEXT_PUBLIC_API_URL=https://solarops-backend.onrender.com/graphql"
    echo "   - NEXT_PUBLIC_WS_URL=wss://solarops-backend.onrender.com/graphql"
    echo ""
    echo "2. Visit your app at: https://solarops-28.vercel.app"
else
    echo ""
    echo -e "${RED}❌ Deployment failed${NC}"
    echo ""
    echo -e "${YELLOW}Troubleshooting steps:${NC}"
    echo "1. Check Root Directory is set to 'apps/frontend' in Vercel Dashboard"
    echo "2. Clear Vercel cache: Dashboard → Settings → Advanced → Clear Build Cache"
    echo "3. Check logs: vercel logs"
    echo "4. Ensure you're logged in: vercel login"
fi

# Return to project root
cd ../..