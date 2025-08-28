# 🚀 Vercel-GitHub Deployment Guide

> **Complete step-by-step guide to deploy the Toni Riera portfolio website using Vercel with GitHub integration**

## 🎆 Prerequisites

- [x] GitHub account
- [x] Vercel account (free tier available)
- [x] Supabase project set up
- [x] Image hosting service API keys
- [x] Website code ready for deployment

---

## 🐈 Step 1: GitHub Repository Setup

### 1.1 Create GitHub Repository

1. **Visit GitHub**: Go to [github.com](https://github.com)
2. **Create New Repository**:
   - Click the "+" icon → "New repository"
   - Repository name: `toni-riera-website` (or your preferred name)
   - Description: `Professional creative portfolio with admin panel`
   - Set to **Public** or **Private** (both work with Vercel)
   - **Don't** initialize with README (we have our own)
   - Click "Create repository"

### 1.2 Push Code to GitHub

```bash
# Navigate to your project directory
cd toni-riera-website-final-with-photo-management

# Initialize git repository (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Complete portfolio website with personal photo management"

# Add GitHub remote (replace with your repository URL)
git remote add origin https://github.com/YOUR_USERNAME/toni-riera-website.git

# Push to GitHub
git push -u origin main
```

> **Note**: Replace `YOUR_USERNAME` with your actual GitHub username

---

## 🔧 Step 2: Vercel Account Setup

### 2.1 Create Vercel Account

1. **Visit Vercel**: Go to [vercel.com](https://vercel.com)
2. **Sign Up**: Click "Sign Up" and choose "Continue with GitHub"
3. **Authorize**: Allow Vercel to access your GitHub account
4. **Complete Setup**: Fill in your profile information

### 2.2 Install Vercel GitHub App

1. **GitHub Integration**: Vercel will prompt you to install the GitHub app
2. **Repository Access**: Choose whether to grant access to:
   - **All repositories** (easier for multiple projects)
   - **Selected repositories** (more secure, select your portfolio repo)
3. **Install & Authorize**: Complete the GitHub app installation

---

## 🌐 Step 3: Project Deployment

### 3.1 Import Project from GitHub

1. **Vercel Dashboard**: Go to your Vercel dashboard
2. **New Project**: Click "New Project" or "Add New..."
3. **Import Git Repository**: Find your repository and click "Import"
4. **Configure Project**:
   ```
   Project Name: toni-riera-website
   Framework Preset: Vite
   Root Directory: ./ (default)
   Build Command: npm run build (default)
   Output Directory: dist (default)
   Install Command: npm install (default)
   ```
5. **Don't Deploy Yet**: Click "Deploy" but it will likely fail - we need environment variables first

### 3.2 Configure Environment Variables

1. **Project Settings**: Go to Project → Settings → Environment Variables
2. **Add Variables**: Add each environment variable:

   **Supabase Configuration**:
   ```
   VITE_SUPABASE_URL = your_supabase_project_url
   VITE_SUPABASE_ANON_KEY = your_supabase_anon_key
   VITE_SUPABASE_SERVICE_ROLE_KEY = your_supabase_service_role_key
   ```

   **Image Hosting Services** (add at least one):
   ```
   VITE_IMGBB_API_KEY = your_imgbb_api_key
   VITE_IMGUR_CLIENT_ID = your_imgur_client_id
   VITE_POSTIMAGE_API_KEY = your_postimage_api_key
   VITE_CLOUDINARY_CLOUD_NAME = your_cloudinary_cloud_name
   VITE_CLOUDINARY_API_KEY = your_cloudinary_api_key
   VITE_CLOUDINARY_API_SECRET = your_cloudinary_api_secret
   ```

   **Admin Authentication**:
   ```
   VITE_ADMIN_EMAIL = admin@example.com
   VITE_ADMIN_PASSWORD = your_secure_password
   ```

3. **Environment**: Set all variables to **Production, Preview, and Development**
4. **Save**: Click "Save" for each variable

### 3.3 Redeploy Project

1. **Deployments Tab**: Go to Project → Deployments
2. **Redeploy**: Click the three dots on the latest deployment → "Redeploy"
3. **Wait**: Monitor the build process (usually takes 2-3 minutes)
4. **Success**: You should see a successful deployment with a live URL

---

## 🎆 Step 4: Database Configuration

### 4.1 Set Up Supabase Tables

**Option A: Using Supabase CLI (Recommended)**:
```bash
# Install Supabase CLI
npm install -g supabase

# Login to Supabase
supabase login

# Link to your project
supabase link --project-ref your-project-ref

# Push all migrations
supabase db push
```

**Option B: Manual SQL Execution**:
1. **Supabase Dashboard**: Go to your Supabase project
2. **SQL Editor**: Navigate to SQL Editor
3. **Run Scripts**: Execute the SQL files in this order:
   ```sql
   -- Core tables (run all files in /supabase/tables/)
   -- Then run migrations (run all files in /supabase/migrations/)
   ```

### 4.2 Set Up Row Level Security (RLS)

Ensure RLS policies are enabled for secure data access. The migration files handle this automatically.

### 4.3 Create Admin User

**Option A: Using Edge Function**:
```bash
# Deploy admin user creation function
supabase functions deploy create-admin-user

# Call the function to create admin user
curl -X POST "https://your-project-ref.supabase.co/functions/v1/create-admin-user" \
  -H "Authorization: Bearer your-service-role-key" \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@example.com", "password": "your-secure-password"}'
```

**Option B: Manual Creation**:
1. Go to Supabase Dashboard → Authentication → Users
2. Click "Add User"
3. Enter admin email and password
4. Confirm the user account

---

## ⚙️ Step 5: Custom Domain Setup (Optional)

### 5.1 Purchase Domain

1. **Domain Registrar**: Purchase domain from providers like:
   - Namecheap, GoDaddy, Google Domains, etc.
2. **Domain Suggestion**: `toniriera.com`, `tonirieracreative.com`, etc.

### 5.2 Configure Domain in Vercel

1. **Project Settings**: Go to Project → Settings → Domains
2. **Add Domain**: Enter your custom domain
3. **DNS Configuration**: Vercel will provide DNS records
4. **Update DNS**: Add the provided records to your domain registrar:
   ```
   Type: A
   Name: @
   Value: 76.76.21.21
   
   Type: CNAME
   Name: www
   Value: cname.vercel-dns.com
   ```
5. **Verify**: Wait for DNS propagation (can take up to 24 hours)
6. **SSL Certificate**: Vercel automatically provides SSL certificates

---

## 🔄 Step 6: Automatic Deployments

### 6.1 GitHub Integration Benefits

Once set up, your deployment is fully automated:
- **Push to Deploy**: Every push to main branch triggers deployment
- **Preview Deployments**: Pull requests create preview URLs
- **Rollback**: Easy rollback to previous deployments
- **Environment Variables**: Shared across all deployments

### 6.2 Branch Configuration

1. **Production Branch**: Set main/master branch for production
2. **Preview Branches**: All other branches create preview deployments
3. **Auto-Deploy**: Configure in Project → Settings → Git

### 6.3 Build Optimization

Vercel automatically optimizes your build:
- **Edge Network**: Global CDN for fast loading
- **Image Optimization**: Automatic image optimization
- **Static Generation**: Pre-built static assets
- **Serverless Functions**: Automatic API routes

---

## 📋 Step 7: Testing & Verification

### 7.1 Test Website Functionality

1. **Homepage**: Verify hero section and navigation
2. **Portfolio**: Check project listings and detail pages
3. **About Page**: Confirm personal photo displays correctly
4. **Contact**: Test contact form functionality
5. **Language Switching**: Test multilingual content
6. **Mobile Responsive**: Test on mobile devices

### 7.2 Test Admin Panel

1. **Admin Login**: Visit `/admin/login` and log in
2. **Personal Photo**: Test photo upload and management
3. **Content Management**: Update content blocks
4. **Project Management**: Add/edit portfolio projects
5. **Image Gallery**: Test image upload functionality
6. **SEO Settings**: Configure meta tags

### 7.3 Performance Testing

1. **PageSpeed Insights**: Test with Google PageSpeed
2. **GTmetrix**: Check loading performance
3. **Mobile Testing**: Use Google Mobile-Friendly Test
4. **Lighthouse**: Run Lighthouse audit in Chrome DevTools

---

## 🔐 Step 8: Security & Maintenance

### 8.1 Security Checklist

- [x] Strong admin passwords
- [x] Supabase RLS policies enabled
- [x] Environment variables secured
- [x] HTTPS certificate active
- [x] Database access restricted
- [x] API keys properly configured

### 8.2 Regular Maintenance

1. **Updates**: Keep dependencies updated
2. **Backups**: Regular database backups via Supabase
3. **Monitoring**: Set up uptime monitoring
4. **Performance**: Regular performance audits
5. **Security**: Monitor security advisories

### 8.3 Monitoring & Analytics

1. **Vercel Analytics**: Enable in Project Settings
2. **Google Analytics**: Add tracking code if desired
3. **Error Monitoring**: Consider Sentry integration
4. **Uptime Monitoring**: Use services like UptimeRobot

---

## 🎆 Step 9: Going Live Checklist

### Pre-Launch
- [x] All content added and reviewed
- [x] Images optimized and uploaded
- [x] Contact information updated
- [x] SEO meta tags configured
- [x] Social media links updated
- [x] All admin functions tested
- [x] Mobile responsiveness verified
- [x] Performance optimized

### Launch Day
- [x] Final deployment successful
- [x] Domain pointing correctly
- [x] SSL certificate active
- [x] All links working
- [x] Contact form tested
- [x] Admin panel accessible

### Post-Launch
- [x] Submit to Google Search Console
- [x] Set up monitoring
- [x] Share on social media
- [x] Update business listings
- [x] Monitor performance metrics

---

## 🔧 Troubleshooting Common Issues

### Build Failures

**Issue**: Build fails during deployment
```bash
# Solution: Check build logs
# Common fixes:
# 1. Environment variables missing
# 2. Node.js version mismatch
# 3. Dependency conflicts
```

**Fix**:
1. Verify all environment variables are set
2. Check Node.js version in build logs
3. Clear cache and redeploy

### Domain Configuration

**Issue**: Domain not working after DNS setup

**Fix**:
1. Wait 24-48 hours for DNS propagation
2. Use DNS checker tools to verify records
3. Clear browser cache
4. Try incognito/private browsing

### Database Connection

**Issue**: Website can't connect to Supabase

**Fix**:
1. Verify Supabase URL and keys
2. Check RLS policies
3. Ensure database tables exist
4. Test connection from local environment

### Admin Panel Access

**Issue**: Can't log into admin panel

**Fix**:
1. Verify admin credentials in environment variables
2. Check if admin user exists in Supabase Auth
3. Clear browser cookies
4. Check browser console for errors

---

## 📈 Performance Optimization Tips

### Image Optimization
- Use WebP format when possible
- Implement lazy loading
- Optimize image sizes for different devices
- Use Vercel's built-in image optimization

### Code Optimization
- Enable code splitting
- Use tree shaking
- Minimize bundle size
- Use production builds only

### Database Optimization
- Add appropriate indexes
- Use connection pooling
- Optimize queries
- Enable database caching

---

## 🎉 Success!

**Congratulations!** Your Toni Riera portfolio website is now live with:

✅ **Professional Portfolio** - Showcasing creative work beautifully  
✅ **Personal Photo Management** - Dynamic photo system with admin control  
✅ **Multilingual Support** - English, Spanish, and Catalan  
✅ **Comprehensive Admin Panel** - Full content management system  
✅ **Responsive Design** - Perfect on all devices  
✅ **SEO Optimized** - Ready for search engines  
✅ **Production Ready** - Deployed and monitored  

**Your website is ready to impress clients and showcase amazing creative work!**

---

*Deployment guide created by MiniMax Agent • Last updated: January 2025*