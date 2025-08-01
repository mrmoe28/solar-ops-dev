# 🚀 SolarOps + Neon DB Setup Guide

## 🎯 **Why Neon DB + Vercel is Better Than Render**

### **Advantages:**
- ✅ **No separate backend needed** - API routes in Next.js
- ✅ **Better performance** - Serverless functions scale automatically
- ✅ **Simpler deployment** - Everything in one place
- ✅ **Cost effective** - Pay only for what you use
- ✅ **Better developer experience** - TypeScript, hot reload, etc.

## 📋 **Setup Steps**

### **Step 1: Create Neon Database**
1. Go to [Neon Console](https://console.neon.tech)
2. Create new project: `solarops-db`
3. Copy your connection string (looks like: `postgresql://user:pass@host/db`)

### **Step 2: Install Dependencies**
```bash
cd apps/frontend
npm install
```

### **Step 3: Set Environment Variables**
Create `.env.local` in `apps/frontend/`:
```env
# Neon Database
DATABASE_URL="postgresql://your-neon-connection-string"

# JWT Secret
JWT_SECRET="your-super-secret-jwt-key"

# App URLs
NEXT_PUBLIC_APP_URL="https://solarops-28.vercel.app"
```

### **Step 4: Initialize Database**
```bash
cd apps/frontend
npx prisma generate
npx prisma db push
```

### **Step 5: Update Vercel Environment**
In Vercel Dashboard → Settings → Environment Variables:
```env
DATABASE_URL="postgresql://your-neon-connection-string"
JWT_SECRET="your-super-secret-jwt-key"
NEXT_PUBLIC_APP_URL="https://solarops-28.vercel.app"
```

### **Step 6: Update Frontend API Calls**
Your signup form should now call:
```javascript
// Instead of: https://solarops-backend.onrender.com/graphql
// Use: /api/auth/signup (relative URL)
const response = await fetch('/api/auth/signup', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ fullName, email, password })
});
```

## 🔧 **API Endpoints Available**

### **Authentication**
- `POST /api/auth/signup` - Create new user
- `POST /api/auth/login` - User login

### **Projects** (to be added)
- `GET /api/projects` - Get user's projects
- `POST /api/projects` - Create new project
- `PUT /api/projects/[id]` - Update project
- `DELETE /api/projects/[id]` - Delete project

### **Tasks** (to be added)
- `GET /api/tasks` - Get user's tasks
- `POST /api/tasks` - Create new task
- `PUT /api/tasks/[id]` - Update task
- `DELETE /api/tasks/[id]` - Delete task

## 🚀 **Deploy to Vercel**

### **Option A: Deploy from Frontend Directory**
```bash
cd apps/frontend
vercel --prod
```

### **Option B: Deploy from Root**
```bash
vercel --prod --cwd apps/frontend
```

## ✅ **Benefits of This Approach**

1. **Single Deployment**: Frontend + API in one place
2. **Better Performance**: Serverless functions scale automatically
3. **Cost Effective**: Pay only for API calls, not 24/7 server
4. **Type Safety**: Full TypeScript support
5. **Database**: Neon DB with Prisma ORM
6. **Authentication**: JWT-based auth with bcrypt

## 🔍 **Testing**

1. **Local Development**:
   ```bash
   cd apps/frontend
   npm run dev
   ```

2. **Test Signup**: Visit `http://localhost:3000` and try signup

3. **Check Database**: 
   ```bash
   npx prisma studio
   ```

## 🆘 **Troubleshooting**

### **"Failed to fetch" Error**
- ✅ Check `DATABASE_URL` is set correctly
- ✅ Ensure Neon DB is running
- ✅ Verify API routes are in correct location

### **Database Connection Issues**
- ✅ Check Neon connection string
- ✅ Run `npx prisma generate`
- ✅ Run `npx prisma db push`

### **Deployment Issues**
- ✅ Set Root Directory to `apps/frontend` in Vercel
- ✅ Add all environment variables
- ✅ Check build logs for errors

## 🎉 **You're All Set!**

This approach eliminates the need for:
- ❌ Separate backend server
- ❌ Render hosting
- ❌ CORS configuration
- ❌ Complex deployment setup

Everything runs on Vercel with Neon DB! 🚀 