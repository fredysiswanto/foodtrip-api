# QA Automation Framework Guide

This guide provides comprehensive instructions for setting up and implementing automated testing for the FoodTrip API, including tools, frameworks, and best practices.

## 🎯 Overview

The QA Automation Framework for FoodTrip API focuses on:
- **API Testing**: Automated endpoint testing
- **Integration Testing**: End-to-end workflow validation
- **Performance Testing**: Response time and load testing
- **Regression Testing**: Automated test execution
- **CI/CD Integration**: Continuous testing pipeline

## 🛠️ Recommended Tech Stack

### Primary Testing Framework
```json
{
  "testing_framework": "Jest",
  "api_client": "Supertest",
  "assertion_library": "Jest (built-in)",
  "test_runner": "Jest",
  "coverage_tool": "Jest Coverage",
  "ci_cd": "GitHub Actions / Jenkins"
}
```

### Alternative Options
- **Newman (Postman CLI)**: For Postman collection automation
- **Playwright**: For API and browser testing
- **Cypress**: For API and E2E testing
- **Artillery**: For performance testing

## 🚀 Setup Instructions

### 1. Project Setup

Create a separate testing directory structure:

```bash
# Create test automation project
mkdir foodtrip-api-tests
cd foodtrip-api-tests

# Initialize Node.js project
npm init -y

# Install testing dependencies
npm install --save-dev jest supertest dotenv
npm install --save-dev @types/jest @types/supertest # For TypeScript support
```

### 2. Directory Structure

```
foodtrip-api-tests/
├── 📁 tests/
│   ├── 📁 auth/                    # Authentication tests
│   ├── 📁 admin/                   # Admin functionality tests
│   ├── 📁 customer/                # Customer functionality tests
│   ├── 📁 restaurant/              # Restaurant management tests
│   ├── 📁 integration/             # End-to-end workflow tests
│   └── 📁 performance/             # Performance tests
├── 📁 utils/
│   ├── api-client.js               # API client configuration
│   ├── test-data.js                # Test data generators
│   ├── helpers.js                  # Test utilities
│   └── database-utils.js           # Database test utilities
├── 📁 config/
│   ├── jest.config.js              # Jest configuration
│   └── test.env                    # Test environment variables
├── 📁 reports/                     # Test reports and coverage
├── 📄 package.json
└── 📄 README.md
```

### 3. Basic Configuration

#### Jest Configuration (`config/jest.config.js`)
```javascript
module.exports = {
  testEnvironment: 'node',
  roots: ['<rootDir>/tests'],
  testMatch: [
    '**/__tests__/**/*.js',
    '**/?(*.)+(spec|test).js'
  ],
  collectCoverageFrom: [
    'tests/**/*.js',
    '!tests/**/*.config.js',
    '!tests/utils/**'
  ],
  coverageDirectory: 'reports/coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  setupFilesAfterEnv: ['<rootDir>/tests/setup.js'],
  testTimeout: 30000,
  verbose: true,
  forceExit: true,
  detectOpenHandles: true
};
```

#### Package.json Scripts
```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:auth": "jest tests/auth",
    "test:integration": "jest tests/integration",
    "test:performance": "jest tests/performance",
    "test:ci": "jest --ci --coverage --watchAll=false"
  }
}
```

## 🔧 Core Testing Utilities

### 1. API Client Setup (`utils/api-client.js`)

```javascript
const request = require('supertest');
require('dotenv').config({ path: './config/test.env' });

class ApiClient {
  constructor() {
    this.baseURL = process.env.API_BASE_URL || 'http://localhost:5000';
    this.defaultHeaders = {
      'Content-Type': 'application/json'
    };
    this.authToken = null;
  }

  // Set authentication token
  setAuthToken(token) {
    this.authToken = token;
  }

  // Clear authentication token
  clearAuthToken() {
    this.authToken = null;
  }

  // Get request headers with auth if available
  getHeaders(additionalHeaders = {}) {
    const headers = { ...this.defaultHeaders, ...additionalHeaders };
    
    if (this.authToken) {
      headers.Authorization = `Bearer ${this.authToken}`;
    }
    
    return headers;
  }

  // Generic request method
  async makeRequest(method, endpoint, data = null, headers = {}) {
    const requestHeaders = this.getHeaders(headers);
    
    let req = request(this.baseURL)[method](endpoint);
    
    // Set headers
    Object.keys(requestHeaders).forEach(key => {
      req = req.set(key, requestHeaders[key]);
    });
    
    // Add data for POST/PUT requests
    if (data && ['post', 'put', 'patch'].includes(method)) {
      req = req.send(data);
    }
    
    return req;
  }

  // HTTP methods
  async get(endpoint, headers = {}) {
    return this.makeRequest('get', endpoint, null, headers);
  }

  async post(endpoint, data, headers = {}) {
    return this.makeRequest('post', endpoint, data, headers);
  }

  async put(endpoint, data, headers = {}) {
    return this.makeRequest('put', endpoint, data, headers);
  }

  async delete(endpoint, headers = {}) {
    return this.makeRequest('delete', endpoint, null, headers);
  }

  async patch(endpoint, data, headers = {}) {
    return this.makeRequest('patch', endpoint, data, headers);
  }
}

module.exports = new ApiClient();
```

### 2. Test Data Generator (`utils/test-data.js`)

```javascript
const { faker } = require('@faker-js/faker');

class TestDataGenerator {
  // Generate random user data
  generateUser(role = 'customer') {
    return {
      name: faker.person.fullName(),
      email: faker.internet.email(),
      password: 'TestPassword123!',
      confirmPassword: 'TestPassword123!',
      phone: faker.phone.number('##########'),
      role: role
    };
  }

  // Generate restaurant data
  generateRestaurant() {
    return {
      name: faker.company.name() + ' Restaurant',
      description: faker.lorem.paragraph(),
      address: faker.location.streetAddress({ useFullAddress: true }),
      phone: faker.phone.number('##########'),
      opening_hour: '08:00',
      closing_hour: '22:00',
      restocategory_id: 1
    };
  }

  // Generate dish data
  generateDish() {
    return {
      name: faker.commerce.productName(),
      description: faker.lorem.sentence(),
      price: faker.number.int({ min: 10000, max: 100000 }),
      dishcategory_id: faker.number.int({ min: 1, max: 5 }),
      is_available: true
    };
  }

  // Generate address data
  generateAddress() {
    return {
      title: faker.location.cardinalDirection() + ' Home',
      address: faker.location.streetAddress({ useFullAddress: true }),
      latitude: parseFloat(faker.location.latitude()),
      longitude: parseFloat(faker.location.longitude()),
      is_primary: faker.datatype.boolean()
    };
  }

  // Generate order data
  generateOrder() {
    return {
      address_id: 1,
      payment_method: faker.helpers.arrayElement(['cash', 'card', 'digital_wallet']),
      notes: faker.lorem.sentence()
    };
  }

  // Generate cart item data
  generateCartItem() {
    return {
      dish_id: faker.number.int({ min: 1, max: 10 }),
      quantity: faker.number.int({ min: 1, max: 5 }),
      notes: faker.lorem.sentence()
    };
  }

  // Generate opening hours data
  generateOpeningHour() {
    const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    
    return {
      day: faker.helpers.arrayElement(days),
      opening_time: '08:00',
      closing_time: '22:00',
      is_open: true
    };
  }

  // Generate invalid data for negative testing
  generateInvalidData(type) {
    switch (type) {
      case 'email':
        return 'invalid-email-format';
      case 'phone':
        return '123'; // Too short
      case 'password':
        return '123'; // Too weak
      case 'price':
        return -100; // Negative price
      default:
        return null;
    }
  }
}

module.exports = new TestDataGenerator();
```

### 3. Test Helpers (`utils/helpers.js`)

```javascript
const apiClient = require('./api-client');
const testData = require('./test-data');

class TestHelpers {
  // Authentication helpers
  async loginUser(email = 'customer@foodtrip.com', password = 'password123') {
    const response = await apiClient.post('/api/home/login', {
      email,
      password
    });
    
    if (response.status === 200) {
      const token = response.body.token;
      apiClient.setAuthToken(token);
      return { success: true, token, user: response.body.user };
    }
    
    return { success: false, error: response.body };
  }

  async loginAdmin() {
    return this.loginUser('admin@foodtrip.com', 'password123');
  }

  async loginRestaurantAdmin() {
    return this.loginUser('resto@foodtrip.com', 'password123');
  }

  async loginCustomer() {
    return this.loginUser('customer@foodtrip.com', 'password123');
  }

  // User registration helper
  async registerUser(userData = null) {
    const user = userData || testData.generateUser();
    
    const response = await apiClient.post('/api/home/register', user);
    return {
      response,
      userData: user,
      success: response.status === 201
    };
  }

  // Restaurant creation helper
  async createRestaurant(restaurantData = null) {
    const restaurant = restaurantData || testData.generateRestaurant();
    
    const response = await apiClient.post('/api/resto_admin/restaurant', restaurant);
    return {
      response,
      restaurantData: restaurant,
      success: response.status === 201
    };
  }

  // Dish creation helper
  async createDish(dishData = null) {
    const dish = dishData || testData.generateDish();
    
    const response = await apiClient.post('/api/resto_admin/dish', dish);
    return {
      response,
      dishData: dish,
      success: response.status === 201
    };
  }

  // Cart management helpers
  async addToCart(dishId = 1, quantity = 1) {
    const cartItem = {
      dish_id: dishId,
      quantity: quantity,
      notes: 'Test notes'
    };
    
    const response = await apiClient.post('/api/customer/cart', cartItem);
    return {
      response,
      cartItem,
      success: response.status === 201
    };
  }

  async clearCart() {
    const cartResponse = await apiClient.get('/api/customer/cart');
    
    if (cartResponse.status === 200 && cartResponse.body.length > 0) {
      for (const item of cartResponse.body) {
        await apiClient.delete(`/api/customer/cart/${item.id}`);
      }
    }
  }

  // Order creation helper
  async createOrder(orderData = null) {
    const order = orderData || testData.generateOrder();
    
    const response = await apiClient.post('/api/customer/order', order);
    return {
      response,
      orderData: order,
      success: response.status === 201
    };
  }

  // Database cleanup helpers
  async cleanupTestData() {
    // This would require database access to clean up test data
    // Implementation depends on your database testing strategy
    console.log('Cleaning up test data...');
  }

  // Response validation helpers
  validateResponse(response, expectedStatus = 200, requiredFields = []) {
    expect(response.status).toBe(expectedStatus);
    
    if (requiredFields.length > 0) {
      requiredFields.forEach(field => {
        expect(response.body).toHaveProperty(field);
      });
    }
    
    return response.body;
  }

  validateErrorResponse(response, expectedStatus = 400) {
    expect(response.status).toBe(expectedStatus);
    expect(response.body).toHaveProperty('message');
    
    return response.body;
  }

  // Wait helper for async operations
  async wait(ms = 1000) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  // Generate unique test identifier
  generateTestId() {
    return `test_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }
}

module.exports = new TestHelpers();
```

## 🧪 Test Implementation Examples

### 1. Authentication Tests (`tests/auth/auth.test.js`)

```javascript
const apiClient = require('../../utils/api-client');
const testHelpers = require('../../utils/helpers');
const testData = require('../../utils/test-data');

describe('Authentication API', () => {
  beforeEach(() => {
    apiClient.clearAuthToken();
  });

  describe('POST /api/home/login', () => {
    test('should login with valid credentials', async () => {
      const response = await apiClient.post('/api/home/login', {
        email: 'customer@foodtrip.com',
        password: 'password123'
      });

      testHelpers.validateResponse(response, 200, ['token', 'user']);
      
      expect(response.body.user).toHaveProperty('email', 'customer@foodtrip.com');
      expect(response.body.token).toBeDefined();
      expect(typeof response.body.token).toBe('string');
    });

    test('should reject invalid credentials', async () => {
      const response = await apiClient.post('/api/home/login', {
        email: 'customer@foodtrip.com',
        password: 'wrongpassword'
      });

      testHelpers.validateErrorResponse(response, 401);
    });

    test('should reject missing email', async () => {
      const response = await apiClient.post('/api/home/login', {
        password: 'password123'
      });

      testHelpers.validateErrorResponse(response, 400);
    });

    test('should reject missing password', async () => {
      const response = await apiClient.post('/api/home/login', {
        email: 'customer@foodtrip.com'
      });

      testHelpers.validateErrorResponse(response, 400);
    });

    test('should reject invalid email format', async () => {
      const response = await apiClient.post('/api/home/login', {
        email: 'invalid-email',
        password: 'password123'
      });

      testHelpers.validateErrorResponse(response, 400);
    });
  });

  describe('POST /api/home/register', () => {
    test('should register new user with valid data', async () => {
      const userData = testData.generateUser();
      
      const response = await apiClient.post('/api/home/register', userData);

      testHelpers.validateResponse(response, 201, ['user']);
      expect(response.body.user).toHaveProperty('email', userData.email);
      expect(response.body.user).toHaveProperty('name', userData.name);
    });

    test('should reject duplicate email', async () => {
      const userData = {
        name: 'Test User',
        email: 'customer@foodtrip.com', // Existing email
        password: 'password123',
        confirmPassword: 'password123',
        phone: '1234567890'
      };

      const response = await apiClient.post('/api/home/register', userData);

      testHelpers.validateErrorResponse(response, 409);
    });

    test('should reject password mismatch', async () => {
      const userData = testData.generateUser();
      userData.confirmPassword = 'differentpassword';

      const response = await apiClient.post('/api/home/register', userData);

      testHelpers.validateErrorResponse(response, 400);
    });

    test('should reject weak password', async () => {
      const userData = testData.generateUser();
      userData.password = '123';
      userData.confirmPassword = '123';

      const response = await apiClient.post('/api/home/register', userData);

      testHelpers.validateErrorResponse(response, 400);
    });
  });

  describe('Token-based Authentication', () => {
    test('should access protected endpoint with valid token', async () => {
      const login = await testHelpers.loginCustomer();
      expect(login.success).toBe(true);

      const response = await apiClient.get('/api/customer/profile');

      testHelpers.validateResponse(response, 200, ['id', 'name', 'email']);
    });

    test('should reject access without token', async () => {
      const response = await apiClient.get('/api/customer/profile');

      testHelpers.validateErrorResponse(response, 401);
    });

    test('should reject access with invalid token', async () => {
      apiClient.setAuthToken('invalid-token');

      const response = await apiClient.get('/api/customer/profile');

      testHelpers.validateErrorResponse(response, 401);
    });
  });
});
```

### 2. Restaurant Management Tests (`tests/restaurant/restaurant.test.js`)

```javascript
const apiClient = require('../../utils/api-client');
const testHelpers = require('../../utils/helpers');
const testData = require('../../utils/test-data');

describe('Restaurant Management API', () => {
  beforeAll(async () => {
    await testHelpers.loginRestaurantAdmin();
  });

  afterAll(() => {
    apiClient.clearAuthToken();
  });

  describe('POST /api/resto_admin/restaurant', () => {
    test('should create restaurant with valid data', async () => {
      const restaurantData = testData.generateRestaurant();

      const response = await apiClient.post('/api/resto_admin/restaurant', restaurantData);

      testHelpers.validateResponse(response, 201, ['id', 'name', 'address']);
      expect(response.body.name).toBe(restaurantData.name);
      expect(response.body.address).toBe(restaurantData.address);
    });

    test('should reject restaurant creation with missing name', async () => {
      const restaurantData = testData.generateRestaurant();
      delete restaurantData.name;

      const response = await apiClient.post('/api/resto_admin/restaurant', restaurantData);

      testHelpers.validateErrorResponse(response, 400);
    });

    test('should reject restaurant creation with invalid phone', async () => {
      const restaurantData = testData.generateRestaurant();
      restaurantData.phone = '123'; // Too short

      const response = await apiClient.post('/api/resto_admin/restaurant', restaurantData);

      testHelpers.validateErrorResponse(response, 400);
    });
  });

  describe('GET /api/resto_admin/restaurant', () => {
    test('should get restaurant details', async () => {
      const response = await apiClient.get('/api/resto_admin/restaurant');

      if (response.status === 200) {
        testHelpers.validateResponse(response, 200, ['id', 'name', 'address']);
      } else {
        // No restaurant exists yet
        expect(response.status).toBe(404);
      }
    });
  });

  describe('PUT /api/resto_admin/restaurant', () => {
    test('should update restaurant details', async () => {
      // First create a restaurant
      const createResult = await testHelpers.createRestaurant();
      expect(createResult.success).toBe(true);

      const updateData = {
        name: 'Updated Restaurant Name',
        description: 'Updated description'
      };

      const response = await apiClient.put('/api/resto_admin/restaurant', updateData);

      testHelpers.validateResponse(response, 200);
      expect(response.body.name).toBe(updateData.name);
      expect(response.body.description).toBe(updateData.description);
    });
  });
});
```

### 3. Integration Tests (`tests/integration/order-flow.test.js`)

```javascript
const apiClient = require('../../utils/api-client');
const testHelpers = require('../../utils/helpers');
const testData = require('../../utils/test-data');

describe('Complete Order Flow Integration', () => {
  let customerToken;
  let restaurantAdminToken;
  let dishId;
  let addressId;

  beforeAll(async () => {
    // Setup test environment
    console.log('Setting up integration test environment...');
    
    // Login as restaurant admin and create restaurant/dishes
    await testHelpers.loginRestaurantAdmin();
    restaurantAdminToken = apiClient.authToken;
    
    // Create restaurant
    const restaurantResult = await testHelpers.createRestaurant();
    expect(restaurantResult.success).toBe(true);
    
    // Create dish
    const dishResult = await testHelpers.createDish();
    expect(dishResult.success).toBe(true);
    dishId = dishResult.response.body.id;
    
    // Login as customer
    await testHelpers.loginCustomer();
    customerToken = apiClient.authToken;
    
    // Create customer address
    const addressData = testData.generateAddress();
    const addressResponse = await apiClient.post('/api/customer/address', addressData);
    expect(addressResponse.status).toBe(201);
    addressId = addressResponse.body.id;
  });

  afterAll(async () => {
    await testHelpers.cleanupTestData();
    apiClient.clearAuthToken();
  });

  describe('End-to-End Order Process', () => {
    test('should complete full order workflow', async () => {
      // Step 1: Add items to cart
      console.log('Step 1: Adding items to cart...');
      
      const cartItem1 = await testHelpers.addToCart(dishId, 2);
      expect(cartItem1.success).toBe(true);
      
      const cartItem2 = await testHelpers.addToCart(dishId, 1);
      expect(cartItem2.success).toBe(true);
      
      // Step 2: View cart contents
      console.log('Step 2: Viewing cart contents...');
      
      const cartResponse = await apiClient.get('/api/customer/cart');
      testHelpers.validateResponse(cartResponse, 200);
      expect(cartResponse.body.length).toBeGreaterThan(0);
      
      // Step 3: Update cart item
      console.log('Step 3: Updating cart item...');
      
      const firstCartItem = cartResponse.body[0];
      const updateResponse = await apiClient.put(`/api/customer/cart/${firstCartItem.id}`, {
        quantity: 3,
        notes: 'Extra spicy please'
      });
      testHelpers.validateResponse(updateResponse, 200);
      
      // Step 4: Create order
      console.log('Step 4: Creating order...');
      
      const orderData = {
        address_id: addressId,
        payment_method: 'cash',
        notes: 'Please call when arrived'
      };
      
      const orderResponse = await apiClient.post('/api/customer/order', orderData);
      testHelpers.validateResponse(orderResponse, 201, ['id', 'total_price', 'status']);
      
      const orderId = orderResponse.body.id;
      
      // Step 5: Verify order details
      console.log('Step 5: Verifying order details...');
      
      const orderDetailsResponse = await apiClient.get(`/api/customer/order/${orderId}`);
      testHelpers.validateResponse(orderDetailsResponse, 200, ['id', 'order_details']);
      
      expect(orderDetailsResponse.body.order_details.length).toBeGreaterThan(0);
      expect(orderDetailsResponse.body.status).toBe('pending');
      
      // Step 6: Verify cart is empty after order
      console.log('Step 6: Verifying cart is empty...');
      
      const emptyCartResponse = await apiClient.get('/api/customer/cart');
      testHelpers.validateResponse(emptyCartResponse, 200);
      expect(emptyCartResponse.body.length).toBe(0);
      
      console.log('✅ Order flow integration test completed successfully!');
    });

    test('should handle order creation with invalid address', async () => {
      // Add item to cart first
      await testHelpers.addToCart(dishId, 1);
      
      const orderData = {
        address_id: 99999, // Non-existent address
        payment_method: 'cash',
        notes: 'Test order'
      };
      
      const response = await apiClient.post('/api/customer/order', orderData);
      testHelpers.validateErrorResponse(response, 400);
    });

    test('should handle order creation with empty cart', async () => {
      // Ensure cart is empty
      await testHelpers.clearCart();
      
      const orderData = {
        address_id: addressId,
        payment_method: 'cash',
        notes: 'Test order'
      };
      
      const response = await apiClient.post('/api/customer/order', orderData);
      testHelpers.validateErrorResponse(response, 400);
    });
  });
});
```

## 📊 Performance Testing

### Performance Test Setup (`tests/performance/load.test.js`)

```javascript
const apiClient = require('../../utils/api-client');
const testHelpers = require('../../utils/helpers');

describe('Performance Tests', () => {
  beforeAll(async () => {
    await testHelpers.loginCustomer();
  });

  describe('Response Time Tests', () => {
    test('login endpoint should respond within 2 seconds', async () => {
      const startTime = Date.now();
      
      const response = await apiClient.post('/api/home/login', {
        email: 'customer@foodtrip.com',
        password: 'password123'
      });
      
      const responseTime = Date.now() - startTime;
      
      expect(response.status).toBe(200);
      expect(responseTime).toBeLessThan(2000);
      
      console.log(`Login response time: ${responseTime}ms`);
    });

    test('restaurant list should respond within 3 seconds', async () => {
      const startTime = Date.now();
      
      const response = await apiClient.get('/api/home/restaurants');
      
      const responseTime = Date.now() - startTime;
      
      expect(response.status).toBe(200);
      expect(responseTime).toBeLessThan(3000);
      
      console.log(`Restaurant list response time: ${responseTime}ms`);
    });
  });

  describe('Concurrent Request Tests', () => {
    test('should handle multiple concurrent login requests', async () => {
      const concurrentRequests = 10;
      const requests = [];
      
      for (let i = 0; i < concurrentRequests; i++) {
        requests.push(
          apiClient.post('/api/home/login', {
            email: 'customer@foodtrip.com',
            password: 'password123'
          })
        );
      }
      
      const responses = await Promise.all(requests);
      
      responses.forEach(response => {
        expect(response.status).toBe(200);
      });
      
      console.log(`Successfully handled ${concurrentRequests} concurrent login requests`);
    });
  });
});
```

## 🚀 CI/CD Integration

### GitHub Actions Workflow (`.github/workflows/api-tests.yml`)

```yaml
name: FoodTrip API Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [16.x, 18.x]

    steps:
    - uses: actions/checkout@v3

    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v3
      with:
        node-version: ${{ matrix.node-version }}

    - name: Cache dependencies
      uses: actions/cache@v3
      with:
        path: ~/.npm
        key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}

    - name: Install API dependencies
      run: |
        cd foodtrip-api
        npm install

    - name: Setup test database
      run: |
        cd foodtrip-api
        npm run db:setup

    - name: Start API server
      run: |
        cd foodtrip-api
        npm run dev &
        sleep 10
      
    - name: Install test dependencies
      run: |
        cd foodtrip-api-tests
        npm install

    - name: Run API tests
      run: |
        cd foodtrip-api-tests
        npm run test:ci

    - name: Upload coverage reports
      uses: codecov/codecov-action@v3
      with:
        file: ./foodtrip-api-tests/reports/coverage/lcov.info

    - name: Upload test results
      uses: actions/upload-artifact@v3
      if: always()
      with:
        name: test-results
        path: foodtrip-api-tests/reports/
```

### Jenkins Pipeline Example

```groovy
pipeline {
    agent any
    
    environment {
        NODE_VERSION = '18'
        API_BASE_URL = 'http://localhost:5000'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup API') {
            steps {
                dir('foodtrip-api') {
                    sh 'npm install'
                    sh 'npm run db:setup'
                    sh 'nohup npm run dev &'
                    sh 'sleep 10'
                }
            }
        }
        
        stage('Install Test Dependencies') {
            steps {
                dir('foodtrip-api-tests') {
                    sh 'npm install'
                }
            }
        }
        
        stage('Run Tests') {
            steps {
                dir('foodtrip-api-tests') {
                    sh 'npm run test:ci'
                }
            }
            post {
                always {
                    publishHTML([
                        allowMissing: false,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: 'foodtrip-api-tests/reports/coverage',
                        reportFiles: 'index.html',
                        reportName: 'Coverage Report'
                    ])
                    
                    publishTestResults testResultsPattern: 'foodtrip-api-tests/reports/junit.xml'
                }
            }
        }
    }
}
```

## 📋 Test Strategy and Best Practices

### 1. Test Pyramid Strategy

```
        /\
       /  \
      /    \
     /  E2E  \  ← Integration Tests (20%)
    /________\
   /          \
  /Integration \  ← API Integration Tests (30%)
 /______________\
/                \
/   Unit Tests    \  ← Unit Tests (50%)
\__________________/
```

### 2. Test Organization

#### Test Categories
1. **Unit Tests**: Individual API endpoints
2. **Integration Tests**: Complete user workflows
3. **Contract Tests**: API contract validation
4. **Performance Tests**: Response time and load testing
5. **Security Tests**: Authentication and authorization
6. **Regression Tests**: Existing functionality validation

#### Test Data Strategy
1. **Static Test Data**: Seeded database data
2. **Dynamic Test Data**: Generated test data
3. **Mock Data**: For external service testing
4. **Cleanup Strategy**: Test data cleanup after tests

### 3. Best Practices

#### Test Writing Guidelines
```javascript
// ✅ Good test structure
describe('User Authentication', () => {
  // Arrange
  beforeEach(async () => {
    await setupTestData();
  });

  test('should authenticate user with valid credentials', async () => {
    // Arrange
    const userData = { email: 'test@example.com', password: 'password123' };
    
    // Act
    const response = await apiClient.post('/api/login', userData);
    
    // Assert
    expect(response.status).toBe(200);
    expect(response.body).toHaveProperty('token');
  });

  // Cleanup
  afterEach(async () => {
    await cleanupTestData();
  });
});
```

#### Error Testing
```javascript
// Test error scenarios
test('should return 400 for invalid email format', async () => {
  const response = await apiClient.post('/api/login', {
    email: 'invalid-email',
    password: 'password123'
  });
  
  expect(response.status).toBe(400);
  expect(response.body.message).toContain('email');
});
```

#### Async Testing
```javascript
// Proper async/await usage
test('should handle async operations', async () => {
  const promise1 = apiClient.get('/api/restaurants');
  const promise2 = apiClient.get('/api/dishes');
  
  const [restaurants, dishes] = await Promise.all([promise1, promise2]);
  
  expect(restaurants.status).toBe(200);
  expect(dishes.status).toBe(200);
});
```

## 📊 Reporting and Monitoring

### Test Reports

1. **Coverage Reports**: HTML and LCOV format
2. **Test Results**: JUnit XML format
3. **Performance Metrics**: Response time tracking
4. **Failure Analysis**: Detailed error reporting

### Monitoring Dashboard

Track these metrics:
- Test execution success rate
- Average response times
- Test coverage percentage
- Failed test trends
- Performance regression detection

## 🔧 Advanced Testing Features

### 1. Database Testing

```javascript
// Database state testing
const databaseUtils = require('../../utils/database-utils');

test('should maintain data consistency', async () => {
  // Create test data
  const user = await databaseUtils.createTestUser();
  const restaurant = await databaseUtils.createTestRestaurant(user.id);
  
  // Test API operation
  const response = await apiClient.delete(`/api/admin/restaurant/${restaurant.id}`);
  
  // Verify database state
  const deletedRestaurant = await databaseUtils.findRestaurant(restaurant.id);
  expect(deletedRestaurant).toBeNull();
});
```

### 2. Mock External Services

```javascript
// Mock external API calls
const nock = require('nock');

beforeEach(() => {
  nock('https://external-api.com')
    .get('/data')
    .reply(200, { success: true });
});
```

### 3. Visual API Testing

```javascript
// Test API response schema
const Ajv = require('ajv');
const ajv = new Ajv();

const userSchema = {
  type: 'object',
  properties: {
    id: { type: 'number' },
    name: { type: 'string' },
    email: { type: 'string', format: 'email' }
  },
  required: ['id', 'name', 'email']
};

test('should return valid user schema', async () => {
  const response = await apiClient.get('/api/customer/profile');
  
  const validate = ajv.compile(userSchema);
  const valid = validate(response.body);
  
  expect(valid).toBe(true);
});
```

This comprehensive QA Automation Framework guide provides everything needed to implement robust automated testing for the FoodTrip API, ensuring quality and reliability through systematic testing approaches.
