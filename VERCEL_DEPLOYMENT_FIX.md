# 🚀 Vercel Deployment Fix Guide

This guide will help you fix the Vercel deployment issues once and for all.

## 🔧 The Problem
Your Vercel deployments are failing because:
1. The `ignoreCommand` in vercel.json uses git commands that don't work in Vercel's build environment
2. The project structure needs proper configuration for monorepo deployment

## ✅ The Solution

### Step 1: Configure Vercel Project Settings

1. Go to your Vercel Dashboard: https://vercel.com/dashboard
2. Select your `solar-ops` project
3. Go to **Settings** → **General**
4. Set **Root Directory** to: `apps/frontend`
5. Click **Save**

### Step 2: Set Environment Variables

Run this command from your project root:
```bash
cd "/path/to/your/actual/solarops/project"
./scripts/setup-vercel-env.sh
```

Or manually add in Vercel Dashboard → Settings → Environment Variables:
```
NEXT_PUBLIC_API_URL=https://solarops-backend.onrender.com/graphql
NEXT_PUBLIC_WS_URL=wss://solarops-backend.onrender.com/graphql
NEXT_PUBLIC_APP_URL=https://solarops-28.vercel.app
```

### Step 3: Deploy with New Configuration

#### Option A: Deploy from Frontend Directory
```bash
cd apps/frontend
vercel --prod
```

#### Option B: Deploy from Root
```bash
vercel --prod --cwd apps/frontend
```

### Step 4: Verify Deployment

1. Check deployment logs for any errors
2. Visit your deployed app
3. Test the signup functionality

## 📝 Important Notes

### vercel.json Configuration
The `apps/frontend/vercel.json` should contain:
```json
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "installCommand": "cd ../.. && pnpm install --frozen-lockfile",
  "buildCommand": "cd ../.. && pnpm build:packages && cd apps/frontend && pnpm build",
  "framework": "nextjs"
}
```

### Common Issues & Solutions

**Issue**: Build fails with "No Next.js version detected"
**Solution**: Ensure Root Directory is set to `apps/frontend` in Vercel settings

**Issue**: "Failed to fetch" on signup
**Solution**: Check environment variables are set correctly

**Issue**: CORS errors
**Solution**: Ensure backend is deployed and running with updated CORS settings

## 🎯 Quick Deployment Script

Save this as `deploy-frontend.sh`:
```bash
#!/bin/bash
echo "🚀 Deploying frontend to Vercel..."

# Navigate to frontend
cd apps/frontend

# Deploy to production
vercel --prod --yes

echo "✅ Deployment complete!"
echo "Check your app at: https://solarops-28.vercel.app"
```

## 🔄 For Future Deployments

1. Push code to GitHub
2. Vercel will auto-deploy (if connected)
3. Or run: `vercel --prod` from `apps/frontend`

## 🆘 Still Having Issues?

1. Clear Vercel cache: In dashboard → Settings → Advanced → Clear Build Cache
2. Check logs: `vercel logs`
3. Ensure backend is running: https://solarops-backend.onrender.com/graphql

---

**Remember**: The key is having the Root Directory set to `apps/frontend` in Vercel settings!