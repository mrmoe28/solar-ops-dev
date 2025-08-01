# 🚀 SolarOps Backend Setup Guide

## Current Issue
- Frontend: ✅ Working at https://solarops-28.vercel.app
- Backend: ❌ Down at https://solarops-backend.onrender.com/graphql (404 errors)
- Error: "Failed to fetch" on signup form

## Quick Fix Options

### Option 1: Restore Existing Backend
1. Check Render Dashboard: https://dashboard.render.com
2. Find `solarops-backend` service
3. Restart/redeploy the service

### Option 2: Create New Backend (Recommended)

#### Step 1: Create Backend Directory
```bash
mkdir apps/backend
cd apps/backend
```

#### Step 2: Initialize Node.js Project
```bash
npm init -y
npm install express cors bcryptjs jsonwebtoken prisma @prisma/client
npm install --save-dev nodemon
```

#### Step 3: Basic Express Server
Create `server.js`:
```javascript
const express = require('express');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors());
app.use(express.json());

// Basic health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'SolarOps Backend Running' });
});

// Signup endpoint
app.post('/api/auth/signup', async (req, res) => {
  try {
    const { fullName, email, password } = req.body;
    
    // Basic validation
    if (!fullName || !email || !password) {
      return res.status(400).json({ error: 'Missing required fields' });
    }
    
    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);
    
    // Create user (replace with your database logic)
    const user = {
      id: Date.now(),
      fullName,
      email,
      password: hashedPassword,
      createdAt: new Date()
    };
    
    // Generate JWT token
    const token = jwt.sign(
      { userId: user.id, email: user.email },
      process.env.JWT_SECRET || 'your-secret-key',
      { expiresIn: '24h' }
    );
    
    res.status(201).json({
      message: 'User created successfully',
      user: {
        id: user.id,
        fullName: user.fullName,
        email: user.email
      },
      token
    });
  } catch (error) {
    console.error('Signup error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Login endpoint
app.post('/api/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    // Basic validation
    if (!email || !password) {
      return res.status(400).json({ error: 'Missing required fields' });
    }
    
    // Find user (replace with your database logic)
    // For now, return mock response
    res.json({
      message: 'Login successful',
      user: { id: 1, email, fullName: 'Test User' },
      token: 'mock-jwt-token'
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(PORT, () => {
  console.log(`🚀 SolarOps Backend running on port ${PORT}`);
});
```

#### Step 4: Deploy to Render
1. Create new Web Service on Render
2. Connect your GitHub repository
3. Set build command: `npm install`
4. Set start command: `node server.js`
5. Add environment variables:
   - `JWT_SECRET=your-secret-key`
   - `DATABASE_URL=your-database-url`

#### Step 5: Update Frontend Environment
Update your Vercel environment variables:
- `NEXT_PUBLIC_API_URL=https://your-new-backend.onrender.com/api`
- Remove the `/graphql` suffix

### Option 3: Use Alternative Backend Services
- **Supabase**: Free tier with auth and database
- **Firebase**: Google's backend-as-a-service
- **Railway**: Easy deployment platform

## Testing the Fix
1. Deploy new backend
2. Update frontend environment variables
3. Test signup form
4. Check for "Failed to fetch" error resolution

## Next Steps
1. Choose an option above
2. Implement the solution
3. Test the signup functionality
4. Monitor for any remaining issues 