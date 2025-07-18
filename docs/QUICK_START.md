# FoodTrip API - Quick Setup Guide

## 🚀 Get Started in 5 Minutes

This guide will get you up and running with the FoodTrip API in just a few minutes.

### Prerequisites
- Node.js (v16+)
- pnpm, npm, or yarn

### Quick Setup

1. **Clone and Install**
   ```bash
   git clone https://github.com/fredysiswanto/foodtrip-api
   cd foodtrip-api
   pnpm install
   ```

2. **Setup Environment**
   ```bash
   cp .env.example .env
   ```
   The default SQLite configuration works out of the box!

3. **Setup Database**
   ```bash
   pnpm run db:setup
   ```

4. **Start Development Server**
   ```bash
   pnpm run dev
   ```

5. **Test the API**
   Open your browser and go to: `http://localhost:5000`

### Default Credentials

The seeder creates these test accounts:

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@foodtrip.com | password123 |
| Restaurant Admin | resto@foodtrip.com | password123 |
| Customer | customer@foodtrip.com | password123 |

### Quick API Test

1. **Login** (POST to `/api/v1/auth/login`):
   ```json
   {
     "email": "admin@foodtrip.com",
     "password": "password123"
   }
   ```

2. **Get Restaurants** (GET `/api/v1/restaurants`):
   Use the token from login in Authorization header

### Next Steps

- Import `FoodTrip.postman_collection.json` into Postman
- Read the [Complete User Guide](./USER_GUIDE.md)
- Check out the [API Documentation](./API_DOCUMENTATION.md)

### Need Help?

- 📖 [Full Documentation](./USER_GUIDE.md)
- 🐛 [Report Issues](https://github.com/fredysiswanto/foodtrip-api/issues)
- 💬 [Discussions](https://github.com/fredysiswanto/foodtrip-api/discussions)

Happy coding! 🎉
