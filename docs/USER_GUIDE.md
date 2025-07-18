# FoodTrip API - Complete User Guide

## Table of Contents

1. [Getting Started](#getting-started)
2. [Installation Guide](#installation-guide)
3. [Configuration](#configuration)
4. [Database Setup](#database-setup)
5. [Development Workflow](#development-workflow)
6. [API Usage](#api-usage)
7. [Authentication](#authentication)
8. [File Uploads](#file-uploads)
9. [Testing](#testing)
10. [Troubleshooting](#troubleshooting)
11. [Best Practices](#best-practices)

## Getting Started

### What is FoodTrip API?

FoodTrip API is a comprehensive REST API designed for food ordering and restaurant management systems. It provides all the backend functionality needed to build a food delivery application, including:

- User authentication and authorization
- Restaurant and dish management
- Order processing and tracking
- Cart functionality
- Admin controls
- File upload for images
- Multi-database support

### Who Should Use This Guide?

- **Developers** building food delivery applications
- **Students** learning API development
- **QA Engineers** testing REST APIs
- **DevOps Engineers** deploying the application

## Installation Guide

### System Requirements

- **Node.js**: Version 16 or higher
- **Package Manager**: pnpm (recommended), npm, or yarn
- **Database**: One of the following:
  - SQLite (no additional setup required)
  - MySQL (version 5.7+)
  - PostgreSQL (version 10+)
  - MariaDB (version 10.3+)
  - Microsoft SQL Server (version 2012+)

### Step-by-Step Installation

#### 1. Clone the Repository

```bash
# Clone the repository
git clone https://github.com/fredysiswanto/foodtrip-api
cd foodtrip-api
```

#### 2. Install Dependencies

```bash
# Using pnpm (recommended)
pnpm install

# Or using npm
npm install

# Or using yarn
yarn install
```

#### 3. Environment Setup

```bash
# Copy the example environment file
cp .env.example .env

# Edit the .env file with your preferred text editor
nano .env  # or vim .env, code .env, etc.
```

#### 4. Database Configuration

Choose your preferred database and configure accordingly:

**For SQLite (Easiest - Default):**
```env
USE_DB=sqlite
DB_STORAGE=./db/database.sqlite
```

**For MySQL:**
```env
USE_DB=mysql
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASS=your_password
DB_NAME=foodtrip
```

**For PostgreSQL:**
```env
USE_DB=postgresql
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASS=your_password
DB_NAME=foodtrip
```

#### 5. Database Setup

```bash
# Automatic setup (recommended for beginners)
pnpm run db:setup

# Or manual setup
pnpm run db:migrate    # Create tables
pnpm run db:seed       # Add sample data
```

#### 6. Start the Server

```bash
# Development mode with hot reload
pnpm run dev

# Production mode
pnpm start
```

Your API will be available at `http://localhost:5000` (or your configured PORT).

## Configuration

### Environment Variables Explained

| Variable | Description | Example | Required |
|----------|-------------|---------|----------|
| `PORT` | Server port | `5000` | No |
| `API_VERSION` | API version prefix | `/api/v1` | No |
| `NODE_ENV` | Environment mode | `development` | No |
| `USE_DB` | Database type | `sqlite` | Yes |
| `TOKEN_SECRET` | JWT secret key | `your-secret-key` | Yes |
| `SALT_ROUND` | Bcrypt salt rounds | `10` | No |
| `AUTO_SETUP_DB` | Auto database setup | `true` | No |
| `ALLOW_SYNC` | Allow Sequelize sync | `true` | No |

### Security Configuration

⚠️ **Important Security Notes:**

1. **Change the default TOKEN_SECRET** in production
2. **Use strong passwords** for database connections
3. **Set NODE_ENV=production** in production environments
4. **Disable AUTO_SETUP_DB** in production

```env
# Example production configuration
NODE_ENV=production
TOKEN_SECRET=your-super-long-random-secret-key-here
AUTO_SETUP_DB=false
ALLOW_SYNC=false
```

## Database Setup

### Database Choice Guide

| Database | Best For | Pros | Cons |
|----------|----------|------|------|
| **SQLite** | Development, Small apps | Easy setup, No server required | Limited concurrency |
| **MySQL** | Production, Web apps | Fast, Reliable, Popular | Requires server setup |
| **PostgreSQL** | Complex apps, Analytics | Advanced features, ACID compliance | More complex |
| **MariaDB** | MySQL alternative | Open source, Compatible | Smaller community |

### Database CLI Tools

The project includes powerful CLI tools for database management:

```bash
# Check database status
pnpm run db:status

# Interactive database CLI
pnpm run db:cli

# Available CLI commands:
# - setup: Complete database setup
# - migrate: Run migrations
# - seed: Seed sample data
# - reset: Reset database
# - status: Check status
```

### Manual Database Setup

If you prefer manual setup:

```bash
# 1. Create database (MySQL/PostgreSQL only)
pnpm run db:create

# 2. Run migrations to create tables
pnpm run db:migrate

# 3. Seed with sample data
pnpm run db:seed

# 4. Check status
pnpm run db:status
```

### Understanding Migrations

Migrations are version control for your database. They're located in `src/database/migrations/`:

```bash
# Create new migration
npx sequelize-cli migration:generate --name your-migration-name

# Run migrations
pnpm run db:migrate

# Undo last migration
pnpm run db:migrate:undo
```

### Understanding Seeders

Seeders populate your database with sample data. They're in `src/database/seeders/`:

```bash
# Run all seeders
pnpm run db:seed

# Create new seeder
npx sequelize-cli seed:generate --name your-seeder-name
```

## Development Workflow

### Project Structure

```
foodtrip-api/
├── src/
│   ├── config/          # Database configuration
│   ├── controllers/     # Route handlers
│   ├── database/        # Migrations and seeders
│   ├── helpers/         # Utility functions
│   ├── middlewares/     # Express middlewares
│   ├── models/          # Sequelize models
│   └── routes/          # API routes
├── docs/                # Documentation
├── test-case/           # Test examples
├── public/              # Static files
└── db/                  # SQLite database file
```

### Development Commands

```bash
# Development with hot reload
pnpm run dev

# Linting
pnpm run lint              # Check for issues
pnpm run lint:fix          # Fix automatically
pnpm run lint:watch        # Watch mode

# Code formatting
pnpm run format            # Format all files
pnpm run format:check      # Check formatting
```

### Adding New Features

1. **Create Model** (if needed):
   ```bash
   npx sequelize-cli model:generate --name YourModel --attributes name:string,description:text
   ```

2. **Create Migration**:
   ```bash
   npx sequelize-cli migration:generate --name add-your-feature
   ```

3. **Create Controller**:
   Create controller file in `src/controllers/`

4. **Create Routes**:
   Add routes in `src/routes/`

5. **Test Your Changes**:
   ```bash
   pnpm run dev
   ```

## API Usage

### Base URL and Versioning

All API endpoints are prefixed with the API version:

```
Base URL: http://localhost:5000
API Version: /api/v1
Full URL: http://localhost:5000/api/v1
```

### Response Format

All responses follow a consistent format:

```json
{
  "success": true,
  "message": "Operation successful",
  "data": {
    // Response data here
  },
  "meta": {
    // Pagination or additional info
  }
}
```

### Error Responses

```json
{
  "success": false,
  "message": "Error description",
  "error": {
    "code": "ERROR_CODE",
    "details": "Detailed error information"
  }
}
```

### Common HTTP Status Codes

| Code | Meaning | When Used |
|------|---------|-----------|
| 200 | OK | Successful GET, PUT, DELETE |
| 201 | Created | Successful POST |
| 400 | Bad Request | Invalid request data |
| 401 | Unauthorized | Authentication required |
| 403 | Forbidden | Access denied |
| 404 | Not Found | Resource not found |
| 500 | Server Error | Internal server error |

## Authentication

### Registration

```http
POST /api/v1/auth/register
Content-Type: application/json

{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john@example.com",
  "password": "securePassword123",
  "phoneNumber": "+1234567890",
  "role": "customer"
}
```

### Login

```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "securePassword123"
}
```

Response:
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": 1,
      "email": "john@example.com",
      "firstName": "John",
      "lastName": "Doe",
      "role": "customer"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### Using the Token

Include the token in the Authorization header for protected routes:

```http
GET /api/v1/protected-route
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### User Roles

- **customer**: Regular users who place orders
- **restaurant_admin**: Manage restaurants and dishes
- **admin**: Full system access

## File Uploads

### Image Upload Endpoints

The API supports image uploads for restaurants and dishes:

```http
POST /api/v1/restaurants/:id/image
Content-Type: multipart/form-data
Authorization: Bearer <token>

# Form data:
image: [file]
```

### Supported Formats

- **File Types**: PNG, JPG, JPEG, GIF
- **Max Size**: 5MB
- **Storage**: Local filesystem (`public/uploads/`)

### Example Upload

```javascript
const formData = new FormData();
formData.append('image', fileInput.files[0]);

fetch('/api/v1/restaurants/1/image', {
  method: 'POST',
  headers: {
    'Authorization': 'Bearer ' + token
  },
  body: formData
});
```

## Testing

### Using Postman

1. **Import Collection**:
   - Open Postman
   - Click Import
   - Select `FoodTrip.postman_collection.json`

2. **Set Environment**:
   ```json
   {
     "baseUrl": "http://localhost:5000",
     "apiVersion": "/api/v1",
     "token": "your-jwt-token-here"
   }
   ```

3. **Run Tests**:
   - Start with authentication endpoints
   - Get your JWT token
   - Test other endpoints

### Using HTTP Files

The project includes `request/test.http` for VS Code REST Client:

```http
### Login
POST {{baseUrl}}{{apiVersion}}/auth/login
Content-Type: application/json

{
  "email": "admin@foodtrip.com",
  "password": "password123"
}

### Get Restaurants
GET {{baseUrl}}{{apiVersion}}/restaurants
Authorization: Bearer {{token}}
```

### Manual Testing Guide

Follow the test cases in `test-case/` directory:

1. **Admin Resto/**: Restaurant admin operations
2. **Home/**: Public endpoints
3. **List-Api.md**: Complete endpoint list

## Troubleshooting

### Common Issues

#### 1. Database Connection Errors

**Problem**: `ECONNREFUSED` or connection timeout

**Solutions**:
```bash
# Check if database server is running
# For MySQL:
sudo systemctl start mysql
# For PostgreSQL:
sudo systemctl start postgresql

# Verify connection details in .env
# Test connection manually
```

#### 2. Port Already in Use

**Problem**: `EADDRINUSE` error

**Solution**:
```bash
# Find process using the port
lsof -i :5000

# Kill the process
kill -9 <PID>

# Or use different port in .env
PORT=3000
```

#### 3. Migration Errors

**Problem**: Migration fails or tables not created

**Solutions**:
```bash
# Reset database
pnpm run db:cli reset

# Or manual reset
rm -rf src/database/migrations/*
pnpm run db:migrate
```

#### 4. Authentication Issues

**Problem**: JWT token errors

**Solutions**:
- Check `TOKEN_SECRET` in .env
- Ensure token is included in Authorization header
- Check token expiration

#### 5. File Upload Issues

**Problem**: Images not uploading

**Solutions**:
- Check file size (max 5MB)
- Verify file format (PNG, JPG, JPEG, GIF)
- Ensure `public/uploads/` directory exists
- Check write permissions

### Debug Mode

Enable debug logging:

```env
NODE_ENV=development
DB_LOGGING=true
```

### Getting Help

1. **Check Logs**: Review console output for errors
2. **Database Status**: Run `pnpm run db:status`
3. **Documentation**: Check other docs in `/docs` folder
4. **Issues**: Create issue on GitHub repository

## Best Practices

### Development

1. **Environment Management**:
   - Use different .env files for different environments
   - Never commit .env files to version control
   - Use environment-specific configurations

2. **Database**:
   - Always use migrations for schema changes
   - Write rollback migrations
   - Use seeders for consistent test data

3. **Code Quality**:
   - Run linter before committing
   - Follow consistent naming conventions
   - Add comments for complex logic

4. **Security**:
   - Use strong JWT secrets
   - Validate all inputs
   - Implement rate limiting for production

### Production Deployment

1. **Environment Setup**:
   ```env
   NODE_ENV=production
   AUTO_SETUP_DB=false
   ALLOW_SYNC=false
   DB_LOGGING=false
   ```

2. **Database**:
   - Use production database
   - Run migrations before deployment
   - Backup before major changes

3. **Security**:
   - Use HTTPS
   - Set secure headers
   - Implement proper CORS

4. **Monitoring**:
   - Add logging middleware
   - Monitor database performance
   - Set up error tracking

### Testing

1. **API Testing**:
   - Test all endpoints
   - Verify authentication
   - Check edge cases

2. **Database Testing**:
   - Test with different databases
   - Verify migration rollbacks
   - Test seed data consistency

3. **Integration Testing**:
   - Test complete user flows
   - Verify file uploads
   - Test error handling

---

## Need More Help?

- 📖 [API Documentation](./API_DOCUMENTATION.md)
- 🗃️ [Database Management](./DATABASE_MANAGEMENT.md)
- 🌱 [Seeder System Guide](./SEEDER_SYSTEM_GUIDE.md)
- 🐛 [Report Issues](https://github.com/fredysiswanto/foodtrip-api/issues)

Happy coding! 🚀
