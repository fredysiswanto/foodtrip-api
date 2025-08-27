# Developer Onboarding Guide

Welcome to the FoodTrip API development team! This guide will get you from zero to your first contribution in about 30 minutes.

## 🎯 Prerequisites

Before starting, ensure you have:

### Required Software
- **Node.js** (v16 or higher) - [Download](https://nodejs.org/)
- **Git** - [Download](https://git-scm.com/)
- **Code Editor** - VS Code recommended
- **API Testing Tool** - Postman, Insomnia, or REST Client extension

### Optional but Recommended
- **Database Client** - SQLite Browser, TablePlus, or similar
- **Terminal/Shell** - WSL for Windows users recommended

## 🚀 Quick Setup (15 minutes)

### Step 1: Clone and Setup Repository

```bash
# Clone the repository
git clone https://github.com/fredysiswanto/foodtrip-api.git
cd foodtrip-api

# Install dependencies
pnpm install
# or npm install / yarn install
```

### Step 2: Environment Configuration

```bash
# Create environment file
cp .env.example .env
```

The default configuration uses SQLite database which works out of the box. No additional database setup required for development!

### Step 3: Database Initialization

```bash
# Setup database with sample data
pnpm run db:setup
```

This command will:
- Create SQLite database file
- Run all migrations
- Seed the database with test data

### Step 4: Start Development Server

```bash
# Start development server with hot reload
pnpm run dev
```

The server will start at `http://localhost:5000`

### Step 5: Verify Installation

1. **Check API Response**
   ```bash
   curl http://localhost:5000
   # Should return: {"message": "FoodTrip API is running!"}
   ```

2. **Test Authentication**
   ```bash
   curl -X POST http://localhost:5000/api/home/login \
     -H "Content-Type: application/json" \
     -d '{"email": "admin@foodtrip.com", "password": "password123"}'
   ```

3. **Import Postman Collection**
   - Import `FoodTrip.postman_collection.json` into Postman
   - Test endpoints with pre-configured requests

## 📁 Understanding the Codebase

### Project Structure Overview

```
src/
├── config/          # Database configuration
├── controllers/     # Request handlers
│   ├── admin/       # Admin endpoints
│   ├── customer/    # Customer endpoints
│   ├── resto_admin/ # Restaurant admin endpoints
│   └── home/        # Public endpoints
├── database/        # Migrations and seeders
├── helpers/         # Utility functions
├── middlewares/     # Express middlewares
├── models/          # Sequelize models
└── routes/          # Route definitions
```

### Key Files to Know

| File | Purpose |
|------|---------|
| `app.js` | Main application entry point |
| `src/models/index.js` | Database models registration |
| `src/routes/*.routes.js` | API route definitions |
| `src/config/config.js` | Database configuration |
| `db-cli.js` | Database management CLI |

### Development Flow

1. **Routes** (`src/routes/`) define API endpoints
2. **Controllers** (`src/controllers/`) handle business logic
3. **Models** (`src/models/`) define data structure
4. **Middlewares** (`src/middlewares/`) handle cross-cutting concerns

## 🔧 Development Workflow

### Code Standards

```bash
# Run linting
pnpm run lint

# Fix linting issues
pnpm run lint:fix

# Format code
pnpm run format
```

### Database Operations

```bash
# Check database status
pnpm run db:status

# Create new migration
npx sequelize-cli migration:generate --name create-new-table

# Run migrations
pnpm run db:migrate

# Run seeders
pnpm run db:seed

# Reset database (development only)
pnpm run db:setup
```

### Common Development Tasks

#### Adding a New Endpoint

1. **Define Route** (`src/routes/`)
   ```javascript
   router.get('/new-endpoint', controller.newEndpoint);
   ```

2. **Create Controller** (`src/controllers/`)
   ```javascript
   const newEndpoint = async (req, res) => {
     // Implementation
   };
   ```

3. **Test Endpoint**
   ```bash
   curl http://localhost:5000/api/new-endpoint
   ```

#### Working with Database

1. **Create Model**
   ```bash
   npx sequelize-cli model:generate --name ModelName --attributes field1:string,field2:integer
   ```

2. **Update Associations** in `src/models/index.js`

3. **Run Migration**
   ```bash
   pnpm run db:migrate
   ```

## 🧪 Testing Your Changes

### Manual Testing

1. **Use Postman Collection**
   - Import `FoodTrip.postman_collection.json`
   - Test endpoints with sample data

2. **Check Test Cases**
   - Review `test-case/` directory
   - Follow existing test patterns

### Test Accounts

Default seeded accounts for testing:

| Role | Email | Password | Purpose |
|------|-------|----------|---------|
| Admin | admin@foodtrip.com | password123 | Admin functions |
| Restaurant Admin | resto@foodtrip.com | password123 | Restaurant management |
| Customer | customer@foodtrip.com | password123 | Customer features |

### API Testing Workflow

1. **Authentication**
   ```bash
   # Login and get token
   POST /api/home/login
   ```

2. **Test Protected Endpoints**
   ```bash
   # Use Bearer token in Authorization header
   Authorization: Bearer <your-token>
   ```

3. **Test CRUD Operations**
   - Create → Read → Update → Delete
   - Verify data persistence
   - Check error handling

## 🚨 Common Issues & Solutions

### Database Issues

**Issue**: Database connection error
```bash
# Solution: Reset database
pnpm run db:setup
```

**Issue**: Migration fails
```bash
# Solution: Check migration file and run
pnpm run db:migrate:undo
# Fix migration file
pnpm run db:migrate
```

### Development Server Issues

**Issue**: Port already in use
```bash
# Solution: Change port in .env or kill process
PORT=5001 pnpm run dev
```

**Issue**: Module not found
```bash
# Solution: Reinstall dependencies
rm -rf node_modules package-lock.json
pnpm install
```

### Authentication Issues

**Issue**: Invalid token
```bash
# Solution: Login again to get new token
POST /api/home/login
```

## 📚 Next Steps

### Essential Reading

1. [API Documentation](API_DOCUMENTATION.md) - Complete API reference
2. [Project Structure](PROJECT_STRUCTURE.md) - Detailed codebase guide
3. [Development Workflow](DEVELOPMENT_WORKFLOW.md) - Team processes
4. [API Integration Examples](API_INTEGRATION_EXAMPLES.md) - Implementation patterns

### Development Best Practices

1. **Always run linting** before committing
2. **Test endpoints** manually before creating PR
3. **Follow existing patterns** in codebase
4. **Update documentation** when adding features
5. **Use meaningful commit messages**

### Getting Help

- **Code Issues**: Check [Troubleshooting Guide](TROUBLESHOOTING_GUIDE.md)
- **API Questions**: Refer to [API Documentation](API_DOCUMENTATION.md)
- **Database Questions**: Check [Database Management](DATABASE_MANAGEMENT.md)
- **Team Questions**: Reach out to senior developers

## ✅ Onboarding Checklist

- [ ] Prerequisites installed (Node.js, Git, Editor)
- [ ] Repository cloned and dependencies installed
- [ ] Environment configured (.env file)
- [ ] Database setup completed
- [ ] Development server running
- [ ] API endpoints tested
- [ ] Postman collection imported
- [ ] Test accounts verified
- [ ] Code linting working
- [ ] First API call successful
- [ ] Documentation reviewed

**Congratulations!** You're ready to start contributing to FoodTrip API. Welcome to the team! 🎉

---

**Questions?** Check our [troubleshooting guide](TROUBLESHOOTING_GUIDE.md) or ask the team.
