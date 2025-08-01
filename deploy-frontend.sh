#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Solar Ops Frontend Deployment Script${NC}"
echo "======================================"

# Get the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR"

# Change to project root
cd "$PROJECT_ROOT" || exit 1

# Step 1: Verify environment variables
echo -e "\n${YELLOW}Step 1: Verifying environment variables...${NC}"
if [ -f "./scripts/verify-env.sh" ]; then
    ./scripts/verify-env.sh
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Environment verification failed. Please set the required variables.${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠ Environment verification script not found. Skipping...${NC}"
fi

# Step 2: Check if we're in a git repository
echo -e "\n${YELLOW}Step 2: Checking git status...${NC}"
if git rev-parse --git-dir > /dev/null 2>&1; then
    # Check for uncommitted changes
    if ! git diff-index --quiet HEAD --; then
        echo -e "${YELLOW}⚠ Warning: You have uncommitted changes${NC}"
        read -p "Do you want to continue with deployment? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${RED}Deployment cancelled.${NC}"
            exit 1
        fi
    fi
    
    # Show current branch
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    echo -e "${GREEN}✓ Current branch: $CURRENT_BRANCH${NC}"
else
    echo -e "${YELLOW}⚠ Not in a git repository${NC}"
fi

# Step 3: Install dependencies
echo -e "\n${YELLOW}Step 3: Installing dependencies...${NC}"
npm install
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Dependencies installed${NC}"

# Step 4: Generate Prisma client
echo -e "\n${YELLOW}Step 4: Generating Prisma client...${NC}"
cd apps/frontend || exit 1
npx prisma generate
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to generate Prisma client${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Prisma client generated${NC}"

# Step 5: Run build locally to check for errors
echo -e "\n${YELLOW}Step 5: Running local build test...${NC}"
npm run build
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build failed! Fix the errors before deploying.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Local build successful${NC}"

# Step 6: Deploy to Vercel
echo -e "\n${YELLOW}Step 6: Deploying to Vercel...${NC}"
echo -e "${BLUE}Deploying from: apps/frontend${NC}"

# Check if vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo -e "${RED}❌ Vercel CLI not found. Please install it:${NC}"
    echo "npm i -g vercel"
    exit 1
fi

# Deploy with production flag
vercel --prod --yes

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}✅ Deployment successful!${NC}"
    echo -e "${GREEN}🎉 Your app should be live at: https://solarops-28.vercel.app${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Check the deployment logs in Vercel dashboard"
    echo "2. Test all functionality on the live site"
    echo "3. Monitor for any runtime errors"
else
    echo -e "\n${RED}❌ Deployment failed!${NC}"
    echo ""
    echo "Troubleshooting steps:"
    echo "1. Check the error messages above"
    echo "2. Run 'vercel logs' to see detailed logs"
    echo "3. Verify your Vercel project settings"
    echo "4. Make sure all environment variables are set in Vercel"
    exit 1
fi