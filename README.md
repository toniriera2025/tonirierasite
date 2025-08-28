# 🚀 Toni Riera Creative Portfolio Website

> **Professional multilingual portfolio website with comprehensive admin panel featuring personal photo management, dynamic content management, and AI-powered image hosting.**

[![Deployed on Vercel](https://img.shields.io/badge/Deployed%20on-Vercel-black?style=for-the-badge&logo=vercel)](https://your-vercel-url.vercel.app)
[![Built with React](https://img.shields.io/badge/Built%20with-React-61DAFB?style=for-the-badge&logo=react)](https://reactjs.org/)
[![Powered by Supabase](https://img.shields.io/badge/Powered%20by-Supabase-3ECF8E?style=for-the-badge&logo=supabase)](https://supabase.com/)
[![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![TailwindCSS](https://img.shields.io/badge/TailwindCSS-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white)](https://tailwindcss.com/)

## 🎯 Overview

A state-of-the-art creative portfolio website built for professional visual artists and designers. This comprehensive platform features a sophisticated admin panel with personal photo management system, multilingual support, and dynamic content management capabilities.

### 🌟 Key Features

#### ✨ Frontend Features
- **🎨 Modern Design**: Sleek, professional interface with dark theme and gradient accents
- **🌍 Multilingual Support**: English, Spanish, and Catalan language options
- **📱 Fully Responsive**: Optimized for desktop, tablet, and mobile devices
- **⚡ Performance Optimized**: Fast loading times with optimized images and code splitting
- **🎬 Media Integration**: Support for images, videos, and YouTube embeds
- **🔍 SEO Optimized**: Meta tags, structured data, and search engine optimization
- **♿ Accessibility**: WCAG compliant with proper ARIA labels and keyboard navigation

#### 👤 Personal Photo Management System
- **📸 Upload & Crop**: Advanced image upload with cropping tool for perfect circular display
- **🖼️ Dynamic Gallery**: Manage multiple personal photos with visual gallery interface
- **✅ Active Photo Selection**: Set which photo appears on the About page
- **📝 Metadata Management**: Alt text and descriptions for accessibility and SEO
- **🔄 Real-time Updates**: Instant preview and live updates on the website
- **🗑️ Photo Management**: Edit, delete, and reorder photos with confirmation dialogs

#### 🛠️ Comprehensive Admin Panel
- **🏠 Dashboard**: Overview of all content with quick statistics
- **📄 Content Management**: Dynamic content blocks for easy text updates
- **🎨 Project Portfolio**: Complete project management with media galleries
- **🌐 Multilingual Content**: Manage content in multiple languages
- **🖼️ Hero Images**: Dynamic hero section image management
- **💬 Testimonials**: Client testimonial management system
- **🔍 SEO Management**: Complete SEO settings for all pages
- **📊 Image Gallery**: Centralized image management system

#### 🚀 Technical Features
- **⚡ Modern Stack**: React 18, TypeScript, Vite, TailwindCSS
- **🔄 State Management**: React Query for server state management
- **🔐 Authentication**: Secure admin authentication with session management
- **🗄️ Database**: PostgreSQL with Supabase for real-time updates
- **☁️ Cloud Storage**: Multiple image hosting services with fallback support
- **🔧 Developer Tools**: ESLint, TypeScript, Hot Module Replacement

## 🏗️ Architecture

### Frontend Stack
```
React 18 + TypeScript + Vite
├── 🎨 TailwindCSS (Styling)
├── 🔄 React Query (State Management)
├── 🧭 React Router (Navigation)
├── 🎭 Framer Motion (Animations)
├── 📋 React Hook Form (Forms)
└── 🍞 React Hot Toast (Notifications)
```

### Backend & Database
```
Supabase (Backend as a Service)
├── 🗄️ PostgreSQL Database
├── 🔐 Authentication & Authorization
├── ⚡ Edge Functions
├── 📁 File Storage
└── 🔄 Real-time Subscriptions
```

### Image Hosting
```
Multiple Service Support
├── 🖼️ ImgBB (Primary)
├── 🖼️ Imgur (Fallback)
├── 🖼️ PostImage (Fallback)
└── ☁️ Cloudinary (Premium)
```

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and npm/pnpm
- Supabase account and project
- Image hosting service API key (ImgBB recommended)

### 1. Clone & Install
```bash
# Clone the repository
git clone <your-repo-url>
cd toni-riera-website-final-with-photo-management

# Install dependencies
npm install
# or
pnpm install
```

### 2. Environment Setup
Create `.env.local` file in the root directory:
```env
# Supabase Configuration
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
VITE_SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key

# Image Hosting Services (at least one required)
VITE_IMGBB_API_KEY=your_imgbb_api_key
VITE_IMGUR_CLIENT_ID=your_imgur_client_id
VITE_POSTIMAGE_API_KEY=your_postimage_api_key
VITE_CLOUDINARY_CLOUD_NAME=your_cloudinary_cloud_name
VITE_CLOUDINARY_API_KEY=your_cloudinary_api_key
VITE_CLOUDINARY_API_SECRET=your_cloudinary_api_secret

# Admin Authentication
VITE_ADMIN_EMAIL=admin@example.com
VITE_ADMIN_PASSWORD=your_secure_password
```

### 3. Database Setup

#### Run Supabase Migrations
```bash
# Install Supabase CLI
npm install -g supabase

# Login to Supabase
supabase login

# Link to your project
supabase link --project-ref your-project-ref

# Push database migrations
supabase db push
```

#### Manual Database Setup (Alternative)
If you prefer manual setup, execute the SQL files in this order:

1. **Core Tables**:
   ```sql
   -- Run files in /supabase/tables/ directory
   \i supabase/tables/content_blocks.sql
   \i supabase/tables/projects.sql
   \i supabase/tables/project_images.sql
   \i supabase/tables/hero_images.sql
   \i supabase/tables/testimonials.sql
   \i supabase/tables/personal_photos.sql
   \i supabase/tables/seo_settings.sql
   \i supabase/tables/uploaded_images.sql
   \i supabase/tables/upload_service_status.sql
   ```

2. **Migrations**:
   ```bash
   # Run migration files in chronological order
   # Files in /supabase/migrations/ directory
   ```

3. **Edge Functions** (Optional):
   ```bash
   # Deploy edge functions
   supabase functions deploy create-admin-user
   supabase functions deploy reorder-projects
   ```

### 4. Development
```bash
# Start development server
npm run dev
# or
pnpm dev

# Visit http://localhost:5173
```

### 5. Admin Panel Access
1. Visit `/admin/login`
2. Use the credentials from your `.env.local` file
3. Start managing your content!

## 📦 Production Deployment

### Build for Production
```bash
# Create production build
npm run build
# or
pnpm build

# Preview production build
npm run preview
```

### Deploy to Vercel

#### Method 1: Vercel CLI
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel --prod
```

#### Method 2: GitHub Integration
1. Push your code to GitHub
2. Connect your GitHub repository to Vercel
3. Configure environment variables in Vercel dashboard
4. Deploy automatically on every push

#### Method 3: Vercel Dashboard
1. Visit [vercel.com](https://vercel.com)
2. Import your project
3. Configure build settings:
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
   - **Install Command**: `npm install`

### Environment Variables in Vercel
Add all environment variables from `.env.local` to your Vercel project settings.

## 📚 Admin Panel Guide

### 👤 Personal Photo Management
1. **Navigate**: Admin Panel → Personal Photo
2. **Upload**: Click "Upload New Photo" button
3. **Crop**: Use the circular cropping tool for perfect display
4. **Metadata**: Add alt text and description for accessibility
5. **Activate**: Set which photo appears on the About page
6. **Manage**: Edit, delete, or replace photos as needed

### 📄 Content Management
- **Content Blocks**: Edit page content in multiple languages
- **Projects**: Manage portfolio projects with images and videos
- **Hero Images**: Update homepage hero section images
- **Testimonials**: Add and manage client testimonials
- **SEO Settings**: Optimize meta tags and search engine visibility

### 🌐 Multilingual Content
All content can be managed in three languages:
- **English** (Primary)
- **Spanish** (Español)
- **Catalan** (Català)

Users can switch languages using the language selector in the footer.

## 🔧 Configuration

### Image Upload Services
The system supports multiple image hosting services with automatic fallback:

1. **ImgBB** (Recommended)
   - Free tier: 100GB bandwidth
   - No account required for uploads
   - Direct image URLs

2. **Imgur**
   - Free tier with rate limits
   - Requires client ID
   - Popular and reliable

3. **PostImage**
   - Free unlimited uploads
   - No registration required
   - Simple API

4. **Cloudinary** (Premium)
   - Advanced image transformations
   - CDN delivery
   - Free tier available

### Customization

#### Colors & Branding
Edit `/src/index.css` to customize the color scheme:
```css
:root {
  --primary: /* Purple gradient start */;
  --secondary: /* Pink gradient end */;
  --background: /* Dark background */;
}
```

#### Fonts
The site uses the custom "Degular" font family. Font files are located in `/public/fonts/`.

#### Language Configuration
Add new languages in `/src/lib/i18n.ts` and create corresponding translation files in `/public/locales/`.

## 🐛 Troubleshooting

### Common Issues

#### Build Errors
```bash
# Clear cache and reinstall
rm -rf node_modules .vite
npm install
```

#### Database Connection Issues
1. Verify Supabase URL and keys
2. Check database permissions
3. Ensure Row Level Security (RLS) policies are correct

#### Image Upload Problems
1. Verify API keys for image hosting services
2. Check service status and rate limits
3. Ensure proper CORS configuration

#### Admin Login Issues
1. Verify admin credentials in environment variables
2. Check authentication configuration
3. Clear browser cookies and try again

### Performance Optimization

#### Images
- Use WebP format when possible
- Implement lazy loading
- Optimize image sizes for different screen resolutions

#### Database
- Add indexes for frequently queried fields
- Use database functions for complex operations
- Enable database connection pooling

## 📊 Features Overview

| Feature | Status | Description |
|---------|--------|-------------|
| 👤 Personal Photo Management | ✅ Complete | Upload, crop, and manage personal photos |
| 🌐 Multilingual Support | ✅ Complete | EN/ES/CA language support |
| 📱 Responsive Design | ✅ Complete | Mobile-first responsive layout |
| 🎨 Admin Panel | ✅ Complete | Full CMS functionality |
| 🖼️ Image Gallery | ✅ Complete | Advanced image management |
| 📄 Project Management | ✅ Complete | Portfolio project CRUD |
| 💬 Testimonials | ✅ Complete | Client testimonial system |
| 🔍 SEO Management | ✅ Complete | Meta tags and optimization |
| 🎬 Video Integration | ✅ Complete | YouTube embed support |
| ⚡ Performance | ✅ Optimized | Fast loading and caching |
| 🔐 Security | ✅ Secure | Authentication and authorization |
| 🚀 Deployment Ready | ✅ Ready | Vercel deployment configured |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Design Inspiration**: Modern portfolio design trends
- **Typography**: Degular font family
- **Icons**: Lucide React icon library
- **Animations**: Framer Motion library
- **Backend**: Supabase for backend services
- **Deployment**: Vercel for hosting

---

**Built with ❤️ by MiniMax Agent for Toni Riera**

*Professional creative portfolio website with comprehensive admin panel and personal photo management system.*