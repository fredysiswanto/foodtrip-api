# QA Testing Guide

This guide provides comprehensive testing workflows, procedures, and best practices for the FoodTrip API QA team.

## 🎯 Overview

The FoodTrip API supports three main user roles:
- **Admin**: System administration and user management
- **Restaurant Admin**: Restaurant and menu management
- **Customer**: Food ordering and account management

## 🚀 Test Environment Setup

### Prerequisites

1. **API Testing Tool**
   - Postman (recommended)
   - VS Code REST Client extension

2. **Database Client** (optional)
   - PhpmyAdmin
   - DBeaver (recommended)

### Quick Setup

1. **Clone and Setup**
   ```bash
   git clone https://github.com/fredysiswanto/foodtrip-api.git
   cd foodtrip-api
   pnpm install
   ```

2. **Initialize Test Environment**
   ```bash
   # Setup database with test data
   pnpm run db:setup
   
   # Start API server
   pnpm run dev
   ```

3. **Import Test Collection**
   - Import `FoodTrip.postman_collection.json` into Postman
   - This includes all API endpoints with sample requests

4. **Verify Setup**
   ```bash
   # Test API is running
   curl http://localhost:5000
   # Expected: {"message": "FoodTrip API is running!"}
   ```

## 🔐 Test Accounts

Default accounts created by database seeder:

| Role | Email | Password | User ID | Purpose |
|------|-------|----------|---------|---------|
| Admin | admin@foodtrip.com | password123 | 1 | System administration |
| Restaurant Admin | resto@foodtrip.com | password123 | 2 | Restaurant management |
| Customer | customer@foodtrip.com | password123 | 3 | Customer operations |

### Getting Authentication Tokens

```bash
# Admin login
POST http://localhost:5000/api/home/login
{
  "email": "admin@foodtrip.com",
  "password": "password123"
}

# Customer login
POST http://localhost:5000/api/home/login
{
  "email": "customer@foodtrip.com", 
  "password": "password123"
}

# Restaurant admin login
POST http://localhost:5000/api/home/login
{
  "email": "resto@foodtrip.com",
  "password": "password123"
}
```

## 📋 Testing Workflows

### 1. Authentication Flow Testing

#### Test Scenario: User Login
```bash
# Valid login
POST /api/home/login
Body: {"email": "customer@foodtrip.com", "password": "password123"}
Expected: 200, token returned

# Invalid credentials
POST /api/home/login  
Body: {"email": "customer@foodtrip.com", "password": "wrongpassword"}
Expected: 401, error message

# Missing fields
POST /api/home/login
Body: {"email": "customer@foodtrip.com"}
Expected: 400, validation error
```

#### Test Scenario: User Registration
```bash
# Valid registration
POST /api/home/register
Body: {
  "name": "Test User",
  "email": "test@example.com", 
  "password": "password123",
  "confirmPassword": "password123",
  "phone": "1234567890"
}
Expected: 201, user created

# Duplicate email
POST /api/home/register
Body: {same email as existing user}
Expected: 400, duplicate email error

# Password mismatch
POST /api/home/register
Body: {"password": "pass123", "confirmPassword": "pass456"}
Expected: 400, password mismatch error
```

### 2. Authorization Testing

#### Test Protected Endpoints

```bash
# Without token
GET /api/customer/profile
Expected: 401, unauthorized

# With valid token
GET /api/customer/profile
Headers: Authorization: Bearer <valid-token>
Expected: 200, user profile data

# With expired token
GET /api/customer/profile  
Headers: Authorization: Bearer <expired-token>
Expected: 401, token expired

# With invalid token
GET /api/customer/profile
Headers: Authorization: Bearer invalid-token
Expected: 401, invalid token
```

#### Role-Based Access Testing

```bash
# Admin accessing admin endpoint (valid)
GET /api/admin/users
Headers: Authorization: Bearer <admin-token>
Expected: 200, users list

# Customer accessing admin endpoint (invalid)
GET /api/admin/users
Headers: Authorization: Bearer <customer-token>
Expected: 403, forbidden

# Restaurant admin accessing customer endpoint (invalid)
GET /api/customer/profile
Headers: Authorization: Bearer <resto-admin-token>
Expected: 403, forbidden
```

### 3. CRUD Operations Testing

#### Restaurant Management (Restaurant Admin)

**Create Restaurant**
```bash
POST /api/resto_admin/restaurant
Headers: Authorization: Bearer <resto-admin-token>
Body: {
  "name": "Test Restaurant",
  "description": "Test Description",
  "address": "Test Address",
  "phone": "1234567890",
  "opening_hour": "08:00",
  "closing_hour": "22:00"
}
Expected: 201, restaurant created
```

**Get Restaurant**
```bash
GET /api/resto_admin/restaurant
Headers: Authorization: Bearer <resto-admin-token>
Expected: 200, restaurant data
```

**Update Restaurant**
```bash
PUT /api/resto_admin/restaurant
Headers: Authorization: Bearer <resto-admin-token>
Body: {
  "name": "Updated Restaurant Name",
  "description": "Updated Description"
}
Expected: 200, restaurant updated
```

#### Dish Management

**Create Dish**
```bash
POST /api/resto_admin/dish
Headers: Authorization: Bearer <resto-admin-token>
Body: {
  "name": "Test Dish",
  "description": "Test Description", 
  "price": 25000,
  "dishcategory_id": 1
}
Expected: 201, dish created
```

**Get All Dishes**
```bash
GET /api/resto_admin/dishes
Headers: Authorization: Bearer <resto-admin-token>
Expected: 200, dishes list
```

**Update Dish**
```bash
PUT /api/resto_admin/dish/{dishId}
Headers: Authorization: Bearer <resto-admin-token>
Body: {
  "name": "Updated Dish Name",
  "price": 30000
}
Expected: 200, dish updated
```

**Delete Dish**
```bash
DELETE /api/resto_admin/dish/{dishId}
Headers: Authorization: Bearer <resto-admin-token>
Expected: 200, dish deleted
```

### 4. Customer Order Flow Testing

#### Complete Order Process

1. **Add Items to Cart**
   ```bash
   POST /api/customer/cart
   Headers: Authorization: Bearer <customer-token>
   Body: {
     "dish_id": 1,
     "quantity": 2,
     "notes": "Extra spicy"
   }
   Expected: 201, item added to cart
   ```

2. **View Cart**
   ```bash
   GET /api/customer/cart
   Headers: Authorization: Bearer <customer-token>
   Expected: 200, cart items list
   ```

3. **Update Cart Item**
   ```bash
   PUT /api/customer/cart/{cartId}
   Headers: Authorization: Bearer <customer-token>
   Body: {
     "quantity": 3,
     "notes": "Medium spicy"
   }
   Expected: 200, cart item updated
   ```

4. **Checkout Order**
   ```bash
   POST /api/customer/order
   Headers: Authorization: Bearer <customer-token>
   Body: {
     "address_id": 1,
     "payment_method": "cash",
     "notes": "Please call when arrived"
   }
   Expected: 201, order created
   ```

5. **View Orders**
   ```bash
   GET /api/customer/orders
   Headers: Authorization: Bearer <customer-token>
   Expected: 200, orders list
   ```

## 🧪 Test Data Management

### Database Reset for Testing

```bash
# Reset to clean state with fresh test data
pnpm run db:setup
```

### Creating Custom Test Data

#### Custom Test Users
```bash
POST /api/home/register
Body: {
  "name": "QA Test User",
  "email": "qa.test@foodtrip.com",
  "password": "testpass123",
  "confirmPassword": "testpass123", 
  "phone": "9876543210"
}
```

#### Custom Test Restaurants
```bash
POST /api/resto_admin/restaurant
Headers: Authorization: Bearer <resto-admin-token>
Body: {
  "name": "QA Test Restaurant",
  "description": "Restaurant for QA testing",
  "address": "123 Test Street",
  "phone": "1234567890"
}
```

### Test Data Validation

1. **Verify Seeded Data**
   ```bash
   # Check default users exist
   GET /api/admin/users
   
   # Check default restaurants exist  
   GET /api/home/restaurants
   
   # Check default dishes exist
   GET /api/home/dishes
   ```

2. **Data Integrity Checks**
   - User passwords are properly hashed
   - Foreign key relationships are maintained
   - Required fields are not null
   - Data types match schema

## 🔍 Error Handling Testing

### Common Error Scenarios

#### 400 Bad Request
```bash
# Missing required fields
POST /api/home/register
Body: {"email": "test@example.com"} # missing name, password
Expected: 400, validation error

# Invalid data format
POST /api/resto_admin/dish  
Body: {"price": "not-a-number"}
Expected: 400, invalid price format
```

#### 401 Unauthorized
```bash
# No authorization header
GET /api/customer/profile
Expected: 401, missing token

# Invalid token format
GET /api/customer/profile
Headers: Authorization: invalid-format
Expected: 401, invalid token
```

#### 403 Forbidden
```bash
# Wrong role accessing endpoint
GET /api/admin/users
Headers: Authorization: Bearer <customer-token>
Expected: 403, insufficient permissions
```

#### 404 Not Found
```bash
# Non-existent resource
GET /api/resto_admin/dish/99999
Headers: Authorization: Bearer <resto-admin-token>
Expected: 404, dish not found

# Invalid endpoint
GET /api/invalid/endpoint
Expected: 404, endpoint not found
```

#### 409 Conflict
```bash
# Duplicate email registration
POST /api/home/register
Body: {email: "admin@foodtrip.com"} # existing email
Expected: 409, email already exists
```

#### 500 Internal Server Error
```bash
# Database connection issues
# Server configuration problems
# Unexpected application errors
Expected: 500, server error message
```

## 📊 Test Case Execution

### Existing Test Cases

Review these comprehensive test cases in the `test-case/` directory:

1. **[Test Cases Summary](../test-case/Test_Cases_Summary.md)** - Overview of all test cases
2. **[API Testing Best Practices](../test-case/API_Testing_Best_Practices.md)** - Testing guidelines
3. **Role-specific test cases**:
   - `test-case/Admin/` - Admin functionality tests
   - `test-case/Admin Resto/` - Restaurant admin tests  
   - `test-case/Customer/` - Customer functionality tests
   - `test-case/Home/` - Public endpoint tests

### Test Execution Checklist

#### Pre-Testing
- [ ] Test environment setup completed
- [ ] Database initialized with test data
- [ ] API server running on correct port
- [ ] Postman collection imported
- [ ] Test accounts verified

#### Authentication Testing
- [ ] Valid login scenarios
- [ ] Invalid credential handling
- [ ] User registration flow
- [ ] Token validation
- [ ] Role-based access control

#### Functional Testing
- [ ] Admin user management
- [ ] Restaurant management (CRUD)
- [ ] Dish management (CRUD)
- [ ] Customer profile management
- [ ] Order flow (cart → checkout → order)
- [ ] Address management

#### Error Handling
- [ ] 400 Bad Request scenarios
- [ ] 401 Unauthorized scenarios
- [ ] 403 Forbidden scenarios
- [ ] 404 Not Found scenarios
- [ ] 409 Conflict scenarios
- [ ] 500 Server Error handling

#### Data Integrity
- [ ] Foreign key constraints
- [ ] Required field validation
- [ ] Data type validation
- [ ] Business rule validation

### Test Reporting

#### Test Results Documentation

1. **Create Test Report**
   - Test case ID and description
   - Test steps executed
   - Expected vs actual results
   - Pass/Fail status
   - Screenshots for UI-related issues
   - Environment details

2. **Bug Reporting**
   - Clear bug description
   - Steps to reproduce
   - Expected vs actual behavior
   - API request/response details
   - Environment information
   - Severity and priority

#### Test Metrics

Track these metrics:
- Test cases executed
- Pass/fail ratio
- Bugs found per module
- Test coverage percentage
- Response time measurements

## 🔄 Continuous Testing

### Regression Testing

When new features are added:

1. **Core Functionality Tests**
   - Authentication flow
   - User registration
   - CRUD operations for all entities

2. **Integration Tests**
   - End-to-end user flows
   - Cross-module interactions
   - Database consistency

3. **Performance Tests**
   - Response time validation
   - Load testing with multiple requests
   - Database query optimization

### Automation Preparation

For test automation setup, see:
- [QA Automation Framework](QA_AUTOMATION_FRAMEWORK.md)
- [API Integration Examples](API_INTEGRATION_EXAMPLES.md)

## 🚨 Troubleshooting

### Common Issues

**Issue**: API returns 500 error
```bash
# Check server logs
# Verify database connection
# Reset database if needed
pnpm run db:setup
```

**Issue**: Authentication token expired
```bash
# Login again to get fresh token
POST /api/home/login
```

**Issue**: Test data inconsistency
```bash
# Reset database to clean state
pnpm run db:setup
```

**Issue**: Port conflicts
```bash
# Change port in .env file
PORT=5001 pnpm run dev
```

### Getting Help

- **Technical Issues**: [Troubleshooting Guide](TROUBLESHOOTING_GUIDE.md)
- **API Questions**: [API Documentation](API_DOCUMENTATION.md)
- **Test Automation**: [QA Automation Framework](QA_AUTOMATION_FRAMEWORK.md)
- **Team Support**: Reach out to development team

---

**Happy Testing!** 🧪 This guide provides the foundation for comprehensive API testing. Follow the workflows, document your findings, and help ensure FoodTrip API quality.
