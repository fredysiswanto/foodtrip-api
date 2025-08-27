# Development Workflow Guide

This guide establishes standardized development processes, coding standards, and collaboration workflows for the FoodTrip API team.

## 🎯 Overview

Our development workflow emphasizes:
- **Code Quality**: Consistent coding standards and automated checks
- **Collaboration**: Clear branching strategy and review process
- **Reliability**: Comprehensive testing and deployment procedures
- **Documentation**: Up-to-date documentation and clear communication

## 🌲 Git Workflow and Branching Strategy

### Branching Model

We follow a **Git Flow** inspired branching strategy:

```
main                 ──●─────●─────●─────●──── (Production releases)
                       │     │     │     │
develop             ───●─────●─────●─────●──── (Development integration)
                       │     │     │     │
feature/auth-system  ──●─────●─────●────────── (Feature development)
                       │     │
feature/order-mgmt   ──●─────●──────────────── (Feature development)
                             │
hotfix/security-fix  ────────●──────────────── (Critical fixes)
```

### Branch Types

#### 1. Main Branch (`main`)
- **Purpose**: Production-ready code
- **Protection**: Direct pushes disabled
- **Deployment**: Automatic deployment to production
- **Lifetime**: Permanent

#### 2. Develop Branch (`develop`)
- **Purpose**: Integration of new features
- **Source**: Base for all feature branches
- **Merging**: Features merge here first
- **Lifetime**: Permanent

#### 3. Feature Branches (`feature/feature-name`)
- **Purpose**: Individual feature development
- **Naming**: `feature/auth-improvements`, `feature/order-tracking`
- **Source**: Created from `develop`
- **Target**: Merged back to `develop`
- **Lifetime**: Temporary (deleted after merge)

#### 4. Release Branches (`release/v1.2.0`)
- **Purpose**: Prepare releases, final testing
- **Source**: Created from `develop`
- **Target**: Merged to both `main` and `develop`
- **Lifetime**: Temporary

#### 5. Hotfix Branches (`hotfix/critical-fix`)
- **Purpose**: Critical production fixes
- **Source**: Created from `main`
- **Target**: Merged to both `main` and `develop`
- **Lifetime**: Temporary

### Workflow Commands

#### Starting a New Feature
```bash
# Ensure you're on develop and up to date
git checkout develop
git pull origin develop

# Create and switch to feature branch
git checkout -b feature/restaurant-management

# Work on your feature...
git add .
git commit -m "feat: add restaurant CRUD operations"

# Push feature branch
git push origin feature/restaurant-management
```

#### Creating a Pull Request
```bash
# Ensure your branch is up to date with develop
git checkout develop
git pull origin develop
git checkout feature/restaurant-management
git rebase develop

# Push updated branch
git push origin feature/restaurant-management --force-with-lease

# Create PR via GitHub/GitLab interface
```

#### Hotfix Workflow
```bash
# Create hotfix from main
git checkout main
git pull origin main
git checkout -b hotfix/security-vulnerability

# Make critical fix
git add .
git commit -m "fix: resolve security vulnerability in auth"

# Create PR to main
git push origin hotfix/security-vulnerability
```

## 💻 Development Environment Setup

### Required Tools

1. **Core Tools**
   ```bash
   # Node.js (v16+)
   node --version
   
   # Package manager
   npm --version  # or pnpm/yarn
   
   # Git
   git --version
   ```

2. **Development Tools**
   ```bash
   # Code editor (VS Code recommended)
   code --version
   
   # Database client (optional)
   # - SQLite Browser
   # - TablePlus
   # - DBeaver
   ```

3. **VS Code Extensions**
   ```json
   {
     "recommendations": [
       "esbenp.prettier-vscode",
       "dbaeumer.vscode-eslint",
       "bradlc.vscode-tailwindcss",
       "ms-vscode.vscode-json",
       "humao.rest-client"
     ]
   }
   ```

### Environment Configuration

#### 1. Clone and Setup
```bash
# Clone repository
git clone https://github.com/fredysiswanto/foodtrip-api.git
cd foodtrip-api

# Install dependencies
pnpm install

# Setup environment
cp .env.example .env
```

#### 2. Database Setup
```bash
# Initialize database with sample data
pnpm run db:setup

# Check database status
pnpm run db:status
```

#### 3. Development Server
```bash
# Start development server with hot reload
pnpm run dev

# Server should be running at http://localhost:5000
```

#### 4. Verify Setup
```bash
# Test API endpoint
curl http://localhost:5000
# Expected: {"message": "FoodTrip API is running!"}

# Test with Postman collection
# Import: FoodTrip.postman_collection.json
```

## 📝 Coding Standards

### 1. JavaScript/Node.js Standards

#### ESLint Configuration (`.eslintrc.js`)
```javascript
module.exports = {
  env: {
    node: true,
    es2021: true,
    jest: true
  },
  extends: [
    'eslint:recommended',
    'prettier'
  ],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module'
  },
  rules: {
    'indent': ['error', 2],
    'linebreak-style': ['error', 'unix'],
    'quotes': ['error', 'single'],
    'semi': ['error', 'always'],
    'no-unused-vars': ['error', { 'argsIgnorePattern': '^_' }],
    'no-console': 'warn',
    'prefer-const': 'error',
    'no-var': 'error'
  }
};
```

#### Prettier Configuration (`.prettierrc`)
```json
{
  "semi": true,
  "trailingComma": "none",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false
}
```

### 2. Code Structure Standards

#### Controller Pattern
```javascript
// ✅ Good: Clear separation of concerns
const createRestaurant = async (req, res) => {
  try {
    // 1. Input validation
    const validationErrors = validateRestaurantInput(req.body);
    if (validationErrors.length > 0) {
      return res.status(400).json({ 
        message: 'Validation failed', 
        errors: validationErrors 
      });
    }

    // 2. Business logic
    const restaurantData = await RestaurantService.create(req.body, req.user.id);

    // 3. Response
    res.status(201).json({
      message: 'Restaurant created successfully',
      restaurant: restaurantData
    });
  } catch (error) {
    console.error('Error creating restaurant:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

// ❌ Bad: Mixed concerns, no error handling
const createRestaurant = async (req, res) => {
  const restaurant = await Restaurant.create(req.body);
  res.json(restaurant);
};
```

#### Model Definition
```javascript
// ✅ Good: Clear model with validations
const Restaurant = sequelize.define('Restaurant', {
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    validate: {
      notEmpty: true,
      len: [2, 100]
    }
  },
  description: {
    type: DataTypes.TEXT,
    allowNull: true
  },
  address: {
    type: DataTypes.STRING,
    allowNull: false,
    validate: {
      notEmpty: true,
      len: [10, 255]
    }
  },
  phone: {
    type: DataTypes.STRING,
    allowNull: false,
    validate: {
      notEmpty: true,
      isPhone: function(value) {
        if (!/^\d{10,15}$/.test(value)) {
          throw new Error('Phone number must be 10-15 digits');
        }
      }
    }
  }
}, {
  tableName: 'restaurants',
  timestamps: true,
  indexes: [
    { fields: ['name'] },
    { fields: ['user_id'] }
  ]
});
```

#### Route Definition
```javascript
// ✅ Good: Clear route organization
const express = require('express');
const router = express.Router();
const { authenticateToken, authorizeRole } = require('../middlewares/auth');
const restaurantController = require('../controllers/resto_admin/restaurant.controller');

// Restaurant management routes
router.post('/restaurant', 
  authenticateToken,
  authorizeRole(['restaurant_admin']),
  restaurantController.create
);

router.get('/restaurant',
  authenticateToken,
  authorizeRole(['restaurant_admin']),
  restaurantController.findOwn
);

router.put('/restaurant',
  authenticateToken,
  authorizeRole(['restaurant_admin']),
  restaurantController.update
);

module.exports = router;
```

### 3. Error Handling Standards

#### Consistent Error Responses
```javascript
// Standard error response format
const sendErrorResponse = (res, statusCode, message, details = null) => {
  const errorResponse = {
    success: false,
    message,
    timestamp: new Date().toISOString()
  };

  if (details) {
    errorResponse.details = details;
  }

  res.status(statusCode).json(errorResponse);
};

// Usage examples
sendErrorResponse(res, 400, 'Validation failed', validationErrors);
sendErrorResponse(res, 401, 'Authentication required');
sendErrorResponse(res, 403, 'Insufficient permissions');
sendErrorResponse(res, 404, 'Resource not found');
sendErrorResponse(res, 500, 'Internal server error');
```

#### Global Error Handler
```javascript
// Global error handling middleware
const errorHandler = (err, req, res, next) => {
  console.error('Error:', err);

  // Sequelize validation error
  if (err.name === 'SequelizeValidationError') {
    const validationErrors = err.errors.map(error => ({
      field: error.path,
      message: error.message
    }));
    
    return sendErrorResponse(res, 400, 'Validation failed', validationErrors);
  }

  // JWT errors
  if (err.name === 'JsonWebTokenError') {
    return sendErrorResponse(res, 401, 'Invalid token');
  }

  // Default error
  sendErrorResponse(res, 500, 'Internal server error');
};

app.use(errorHandler);
```

### 4. API Response Standards

#### Success Response Format
```javascript
// Standard success response
const sendSuccessResponse = (res, statusCode, message, data = null) => {
  const response = {
    success: true,
    message,
    timestamp: new Date().toISOString()
  };

  if (data) {
    response.data = data;
  }

  res.status(statusCode).json(response);
};

// Usage examples
sendSuccessResponse(res, 200, 'Data retrieved successfully', restaurants);
sendSuccessResponse(res, 201, 'Restaurant created successfully', restaurant);
sendSuccessResponse(res, 200, 'Restaurant updated successfully', updatedRestaurant);
```

#### Pagination Response
```javascript
// Paginated response format
const sendPaginatedResponse = (res, data, pagination) => {
  res.status(200).json({
    success: true,
    message: 'Data retrieved successfully',
    data,
    pagination: {
      page: pagination.page,
      limit: pagination.limit,
      total: pagination.total,
      totalPages: Math.ceil(pagination.total / pagination.limit),
      hasNext: pagination.page < Math.ceil(pagination.total / pagination.limit),
      hasPrev: pagination.page > 1
    },
    timestamp: new Date().toISOString()
  });
};
```

## 🧪 Testing Workflow

### 1. Testing Strategy

#### Test Types
1. **Unit Tests**: Individual function testing
2. **Integration Tests**: API endpoint testing
3. **End-to-End Tests**: Complete workflow testing
4. **Performance Tests**: Response time validation

#### Testing Commands
```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:coverage

# Run specific test category
npm run test:auth
npm run test:restaurant
npm run test:integration

# Watch mode for development
npm run test:watch
```

### 2. Pre-commit Testing

#### Git Hooks Setup
```bash
# Install husky for git hooks
npm install --save-dev husky

# Setup pre-commit hook
npx husky add .husky/pre-commit "npm run lint && npm run test"

# Setup pre-push hook
npx husky add .husky/pre-push "npm run test:coverage"
```

#### Lint-staged Configuration
```json
{
  "lint-staged": {
    "*.js": [
      "eslint --fix",
      "prettier --write",
      "git add"
    ],
    "*.{json,md}": [
      "prettier --write",
      "git add"
    ]
  }
}
```

### 3. Manual Testing Checklist

Before creating a pull request:

- [ ] **API Endpoints**: Test all modified endpoints with Postman
- [ ] **Authentication**: Verify token-based authentication works
- [ ] **Authorization**: Test role-based access control
- [ ] **Database**: Verify data persistence and relationships
- [ ] **Error Handling**: Test error scenarios and responses
- [ ] **Performance**: Check response times are acceptable

## 🔄 Code Review Process

### 1. Pull Request Guidelines

#### PR Title Format
```
<type>(<scope>): <description>

Examples:
feat(auth): add JWT token refresh functionality
fix(restaurant): resolve restaurant creation validation issue
docs(api): update API documentation with new endpoints
refactor(order): improve order processing performance
test(integration): add complete order workflow tests
```

#### PR Description Template
```markdown
## Description
Brief description of changes and motivation.

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed
- [ ] Performance impact assessed

## Checklist
- [ ] Code follows project coding standards
- [ ] Self-review completed
- [ ] Documentation updated if needed
- [ ] No sensitive information exposed
```

### 2. Code Review Standards

#### Review Checklist for Reviewers

**Code Quality**
- [ ] Code is readable and well-commented
- [ ] Function and variable names are descriptive
- [ ] Code follows established patterns
- [ ] No code duplication
- [ ] Error handling is appropriate

**Security**
- [ ] Input validation is implemented
- [ ] Authentication/authorization is correct
- [ ] No sensitive data in logs
- [ ] SQL injection prevention
- [ ] XSS prevention measures

**Performance**
- [ ] Database queries are optimized
- [ ] No unnecessary API calls
- [ ] Appropriate caching strategies
- [ ] Resource cleanup is handled

**Testing**
- [ ] Tests cover the new functionality
- [ ] Edge cases are tested
- [ ] Error scenarios are tested
- [ ] Test data cleanup is handled

#### Review Comments Guidelines

```javascript
// ✅ Good review comment
// Consider extracting this validation logic into a separate utility function
// for reusability across other controllers.

// ✅ Good review comment
// This query could benefit from an index on the 'status' column 
// for better performance with large datasets.

// ❌ Bad review comment
// This is wrong.

// ❌ Bad review comment
// Please fix this.
```

### 3. Review Process Flow

```
Developer              Reviewer               Maintainer
    │                     │                      │
    │ Create PR            │                      │
    ├────────────────────► │                      │
    │                     │ Review code          │
    │                     ├─────────────────────► │
    │ Address feedback    │                      │
    │◄─────────────────── │                      │
    │                     │ Approve PR           │
    │                     ├─────────────────────► │
    │                     │                      │ Merge PR
    │                     │                      ├─────────►
```

## 🚀 Deployment Workflow

### 1. Environment Strategy

#### Development Environment
- **Branch**: `develop`
- **Database**: SQLite (local)
- **Auto-deploy**: On every push to develop
- **URL**: `https://dev-api.foodtrip.com`

#### Staging Environment
- **Branch**: `release/*`
- **Database**: PostgreSQL (staging)
- **Deploy**: Manual trigger
- **URL**: `https://staging-api.foodtrip.com`

#### Production Environment
- **Branch**: `main`
- **Database**: PostgreSQL (production)
- **Deploy**: Manual approval required
- **URL**: `https://api.foodtrip.com`

### 2. Deployment Checklist

#### Pre-deployment
- [ ] All tests passing
- [ ] Code review approved
- [ ] Database migrations tested
- [ ] Environment variables updated
- [ ] Backup created (production)

#### Deployment Steps
1. **Merge to target branch**
2. **Run database migrations**
3. **Deploy application**
4. **Run smoke tests**
5. **Monitor application health**

#### Post-deployment
- [ ] API endpoints responding correctly
- [ ] Database connectivity confirmed
- [ ] Error rates within normal range
- [ ] Performance metrics acceptable
- [ ] Documentation updated

### 3. Rollback Procedures

#### Immediate Rollback Triggers
- API error rate > 5%
- Response time > 5 seconds
- Database connection failures
- Authentication system failures

#### Rollback Steps
```bash
# Quick rollback to previous version
git checkout main
git reset --hard HEAD~1
git push origin main --force-with-lease

# Database rollback (if needed)
npm run db:migrate:undo

# Verify rollback success
curl https://api.foodtrip.com/health
```

## 📋 Project Management Workflow

### 1. Issue Tracking

#### Issue Types
- **Bug**: Something isn't working
- **Feature**: New functionality
- **Enhancement**: Improve existing feature
- **Documentation**: Documentation updates
- **Technical Debt**: Code quality improvements

#### Issue Template
```markdown
## Description
Clear description of the issue or feature request.

## Acceptance Criteria
- [ ] Specific, measurable criteria
- [ ] User story format when applicable
- [ ] Definition of done

## Technical Notes
- Implementation considerations
- Dependencies
- Potential challenges

## Priority
- [ ] Critical (production issues)
- [ ] High (important features)
- [ ] Medium (nice to have)
- [ ] Low (future considerations)
```

### 2. Sprint Planning

#### Sprint Structure
- **Duration**: 2 weeks
- **Planning**: Monday (start of sprint)
- **Review**: Friday (end of sprint)
- **Retrospective**: Friday (after review)

#### Sprint Goals
1. **Clear objectives** for the sprint
2. **Achievable scope** based on team capacity
3. **Prioritized backlog** items
4. **Definition of done** for each item

### 3. Communication Standards

#### Daily Standups
- **What did you work on yesterday?**
- **What will you work on today?**
- **Any blockers or challenges?**

#### Documentation Updates
- Update relevant documentation with code changes
- Keep API documentation current
- Update README files as needed
- Maintain changelog for releases

## 🔧 Development Tools and Scripts

### Available Scripts

```bash
# Development
npm run dev                    # Start development server
npm run dev:debug              # Start with debugger
npm run lint                   # Run ESLint
npm run lint:fix               # Fix ESLint issues
npm run format                 # Format code with Prettier

# Database
npm run db:setup               # Initialize database
npm run db:migrate             # Run migrations
npm run db:seed                # Seed database
npm run db:reset               # Reset database
npm run db:status              # Check migration status

# Testing
npm test                       # Run all tests
npm run test:watch             # Run tests in watch mode
npm run test:coverage          # Run tests with coverage
npm run test:integration       # Run integration tests

# Build and Deployment
npm run build                  # Build for production
npm run start                  # Start production server
npm run pm2:start              # Start with PM2
npm run pm2:stop               # Stop PM2 process
```

### Development Utilities

#### Database CLI
```bash
# Interactive database management
npm run db:cli

# Available commands:
# - status: Check migration status
# - setup: Initialize database
# - migrate: Run pending migrations
# - seed: Add sample data
# - reset: Reset database
```

#### Code Generation
```bash
# Generate new controller
npm run generate:controller <name>

# Generate new model
npm run generate:model <name>

# Generate new migration
npm run generate:migration <name>
```

This development workflow guide ensures consistent, high-quality development practices across the FoodTrip API team, promoting collaboration, code quality, and reliable deployment processes.
