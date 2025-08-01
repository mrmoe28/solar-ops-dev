# Vercel Environment Variables Setup

## Required Environment Variables

Add the following environment variables to your Vercel project dashboard:

### 1. Database Configuration (Neon)

```
DATABASE_URL=postgres://neondb_owner:npg_ZOi0HdUchmp1@ep-patient-scene-adjwcxiq-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require
DATABASE_URL_UNPOOLED=postgresql://neondb_owner:npg_ZOi0HdUchmp1@ep-patient-scene-adjwcxiq.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require
PGHOST=ep-patient-scene-adjwcxiq-pooler.c-2.us-east-1.aws.neon.tech
PGHOST_UNPOOLED=ep-patient-scene-adjwcxiq.c-2.us-east-1.aws.neon.tech
PGUSER=neondb_owner
PGDATABASE=neondb
PGPASSWORD=npg_ZOi0HdUchmp1
```

### 2. Vercel Postgres Templates

```
POSTGRES_URL=postgres://neondb_owner:npg_ZOi0HdUchmp1@ep-patient-scene-adjwcxiq-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require
POSTGRES_URL_NON_POOLING=postgres://neondb_owner:npg_ZOi0HdUchmp1@ep-patient-scene-adjwcxiq.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require
POSTGRES_USER=neondb_owner
POSTGRES_HOST=ep-patient-scene-adjwcxiq-pooler.c-2.us-east-1.aws.neon.tech
POSTGRES_PASSWORD=npg_ZOi0HdUchmp1
POSTGRES_DATABASE=neondb
POSTGRES_URL_NO_SSL=postgres://neondb_owner:npg_ZOi0HdUchmp1@ep-patient-scene-adjwcxiq-pooler.c-2.us-east-1.aws.neon.tech/neondb
POSTGRES_PRISMA_URL=postgres://neondb_owner:npg_ZOi0HdUchmp1@ep-patient-scene-adjwcxiq-pooler.c-2.us-east-1.aws.neon.tech/neondb?connect_timeout=15&sslmode=require
```

### 3. Neon Auth Configuration

```
NEXT_PUBLIC_STACK_PROJECT_ID=e55c27fe-44eb-413d-94a3-ea67f345f8d8
NEXT_PUBLIC_STACK_PUBLISHABLE_CLIENT_KEY=pck_6es6q2kvaa3gb47btdnd9q8s5xpyqsmj0ws4mkksb0ta8
STACK_SECRET_SERVER_KEY=ssk_g5fckprh6crmg301ye9sanht630evnwahrxhcfjbxvbpg
```

### 4. JWT Configuration

```
JWT_SECRET=<your-generated-jwt-secret>
```

**Important:** Generate a new JWT_SECRET for production using:
```bash
openssl rand -base64 32
```

## How to Add Environment Variables in Vercel

1. Go to your Vercel project dashboard
2. Navigate to Settings → Environment Variables
3. Add each variable with its corresponding value
4. Select the environments where each variable should be available:
   - Production
   - Preview
   - Development

## Security Notes

- **NEVER** commit `.env.local` or any `.env` files to version control
- The `.gitignore` files have been configured to exclude all environment files
- Rotate your database credentials if they've been exposed
- Use different JWT_SECRET values for different environments
- Consider using Vercel's integration with Neon for automatic environment variable setup

## Local Development

For local development, ensure you have the `.env.local` file in `apps/frontend/` with all the required environment variables.