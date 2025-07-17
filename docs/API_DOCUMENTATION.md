# API Documentation

## Overview
This document provides comprehensive information about the API endpoints, authentication, and usage examples for the FoodTrip API project.

## Table of Contents
1. [Base Configuration](#base-configuration)
2. [Authentication](#authentication)
3. [API Endpoints](#api-endpoints)
4. [Database Management API](#database-management-api)
5. [Error Handling](#error-handling)
6. [Request/Response Examples](#requestresponse-examples)
7. [Postman Collection](#postman-collection)

## Base Configuration

### Server Information
- **Base URL**: `http://localhost:3600`
- **API Version**: v1
- **Environment**: Development
- **Database**: SQLite/MySQL/PostgreSQL/MariaDB

### Headers
```json
{
  "Content-Type": "application/json",
  "Authorization": "Bearer <jwt-token>"
}
```

## Authentication

### JWT Token System
The API uses JSON Web Tokens (JWT) for authentication.

#### Login Endpoint
```
POST /api/auth/login
```

#### Request Body:
```json
{
  "email_address": "user@example.com",
  "password": "password123"
}
```

#### Response:
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "user_id": "uuid",
      "email_address": "user@example.com",
      "user_type": "Customer",
      "first_name": "John",
      "last_name": "Doe"
    }
  }
}
```

### User Registration
```
POST /api/auth/register
```

#### Request Body:
```json
{
  "first_name": "John",
  "last_name": "Doe",
  "email_address": "john.doe@example.com",
  "password": "password123",
  "phone_number": "09123456789",
  "user_type": "Customer"
}
```

## API Endpoints

### Home Routes (`/api/home`)

#### 1. Get All Dishes
```
GET /api/home/dishes
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "dish_id": "uuid",
      "dish_name": "Grilled Chicken Breast",
      "dish_desc": "Tender grilled chicken with herbs",
      "dish_price": "250.00",
      "dish_img": "http://localhost:3600/public/dishes/grilled-chicken.png",
      "status": "Available",
      "restaurant": {
        "resto_name": "The Golden Spoon",
        "resto_address": "123 Main Street"
      },
      "dish_category": {
        "dishcatg_name": "Main Course"
      }
    }
  ]
}
```

#### 2. Get All Dish Categories
```
GET /api/home/dish-categories
```

#### 3. Get All Restaurant Categories
```
GET /api/home/restaurant-categories
```

#### 4. Get All Restaurants
```
GET /api/home/restaurants
```

### Customer Routes (`/api/customer`)

#### 1. Get Customer Profile
```
GET /api/customer/profile
Authorization: Bearer <token>
```

#### 2. Update Customer Profile
```
PUT /api/customer/profile
Authorization: Bearer <token>
```

#### 3. Get Customer Orders
```
GET /api/customer/orders
Authorization: Bearer <token>
```

#### 4. Create Order
```
POST /api/customer/orders
Authorization: Bearer <token>
```

#### 5. Cart Management
```
GET /api/customer/cart
POST /api/customer/cart
PUT /api/customer/cart/:id
DELETE /api/customer/cart/:id
```

### Restaurant Admin Routes (`/api/resto-admin`)

#### 1. Get Restaurant Profile
```
GET /api/resto-admin/restaurant
Authorization: Bearer <token>
```

#### 2. Update Restaurant
```
PUT /api/resto-admin/restaurant
Authorization: Bearer <token>
```

#### 3. Dish Management
```
GET /api/resto-admin/dishes
POST /api/resto-admin/dishes
PUT /api/resto-admin/dishes/:id
DELETE /api/resto-admin/dishes/:id
```

#### 4. Order Management
```
GET /api/resto-admin/orders
PUT /api/resto-admin/orders/:id/status
```

#### 5. Opening Hours
```
GET /api/resto-admin/opening-hours
POST /api/resto-admin/opening-hours
PUT /api/resto-admin/opening-hours/:id
DELETE /api/resto-admin/opening-hours/:id
```

### Admin Routes (`/api/admin`)

#### 1. User Management
```
GET /api/admin/users
POST /api/admin/users
PUT /api/admin/users/:id
DELETE /api/admin/users/:id
```

#### 2. Restaurant Management
```
GET /api/admin/restaurants
POST /api/admin/restaurants
PUT /api/admin/restaurants/:id
DELETE /api/admin/restaurants/:id
```

#### 3. Category Management
```
GET /api/admin/dish-categories
POST /api/admin/dish-categories
PUT /api/admin/dish-categories/:id
DELETE /api/admin/dish-categories/:id

GET /api/admin/restaurant-categories
POST /api/admin/restaurant-categories
PUT /api/admin/restaurant-categories/:id
DELETE /api/admin/restaurant-categories/:id
```

#### 4. System Management
```
GET /api/admin/system/status
GET /api/admin/system/stats
POST /api/admin/system/backup
```

## Database Management API

### Database Status
```
GET /api/database/status
```

**Response:**
```json
{
  "success": true,
  "data": {
    "database_type": "sqlite",
    "database_name": "foodtrip_db",
    "connection_status": "connected",
    "tables_count": 12,
    "migrations_pending": 0,
    "seeders_status": "completed",
    "last_backup": "2025-01-01T10:00:00.000Z",
    "statistics": {
      "users": 23,
      "restaurants": 11,
      "dishes": 10,
      "orders": 5,
      "categories": 22
    }
  }
}
```

### Database Operations
```
POST /api/database/migrate
POST /api/database/seed
POST /api/database/reset
```

### Database Health Check
```
GET /api/database/health
```

**Response:**
```json
{
  "success": true,
  "data": {
    "status": "healthy",
    "uptime": "2 hours 30 minutes",
    "memory_usage": "45.2 MB",
    "active_connections": 3,
    "query_performance": {
      "avg_response_time": "12ms",
      "slow_queries": 0,
      "total_queries": 1547
    }
  }
}
```

## Error Handling

### Standard Error Response
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "email_address",
        "message": "Email address is required"
      }
    ]
  }
}
```

### HTTP Status Codes
- **200** - Success
- **201** - Created
- **400** - Bad Request
- **401** - Unauthorized
- **403** - Forbidden
- **404** - Not Found
- **409** - Conflict
- **422** - Validation Error
- **500** - Internal Server Error

### Common Error Types

#### 1. Validation Errors
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Dish Name should not be empty",
    "field": "dish_name"
  }
}
```

#### 2. Authentication Errors
```json
{
  "success": false,
  "error": {
    "code": "AUTH_ERROR",
    "message": "Invalid credentials"
  }
}
```

#### 3. Authorization Errors
```json
{
  "success": false,
  "error": {
    "code": "PERMISSION_ERROR",
    "message": "You don't have permission to access this resource"
  }
}
```

#### 4. Database Errors
```json
{
  "success": false,
  "error": {
    "code": "DATABASE_ERROR",
    "message": "Database connection failed"
  }
}
```

## Request/Response Examples

### Create Dish (Restaurant Admin)
```bash
curl -X POST http://localhost:3600/api/resto-admin/dishes \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <token>" \
  -d '{
    "dish_name": "Chicken Adobo",
    "dish_desc": "Traditional Filipino chicken adobo",
    "dish_price": 180.00,
    "dishcatg_id": "category-uuid",
    "dish_img": "chicken-adobo.jpg"
  }'
```

**Response:**
```json
{
  "success": true,
  "message": "Dish created successfully",
  "data": {
    "dish_id": "new-dish-uuid",
    "dish_no": "DSH-1234567890123",
    "dish_name": "Chicken Adobo",
    "dish_desc": "Traditional Filipino chicken adobo",
    "dish_price": "180.00",
    "dish_img": "http://localhost:3600/public/dishes/chicken-adobo.jpg",
    "status": "Available",
    "created_at": "2025-01-01T10:00:00.000Z"
  }
}
```

### Get Restaurant Orders
```bash
curl -X GET http://localhost:3600/api/resto-admin/orders \
  -H "Authorization: Bearer <token>"
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "order_id": "order-uuid",
      "order_no": "ORD-1234567890123",
      "order_status": "Pending",
      "order_total": "450.00",
      "created_at": "2025-01-01T10:00:00.000Z",
      "customer": {
        "first_name": "John",
        "last_name": "Doe",
        "email_address": "john.doe@example.com"
      },
      "order_details": [
        {
          "dish_name": "Chicken Adobo",
          "quantity": 2,
          "price": "180.00",
          "subtotal": "360.00"
        }
      ]
    }
  ]
}
```

### Update Order Status
```bash
curl -X PUT http://localhost:3600/api/resto-admin/orders/order-uuid/status \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <token>" \
  -d '{
    "order_status": "Preparing"
  }'
```

### Search Dishes
```bash
curl -X GET "http://localhost:3600/api/home/dishes?search=chicken&category=main-course&limit=10" \
  -H "Content-Type: application/json"
```

**Response:**
```json
{
  "success": true,
  "data": {
    "dishes": [
      {
        "dish_id": "uuid",
        "dish_name": "Grilled Chicken Breast",
        "dish_desc": "Tender grilled chicken with herbs",
        "dish_price": "250.00",
        "restaurant": {
          "resto_name": "The Golden Spoon"
        }
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 1,
      "totalPages": 1
    }
  }
}
```

## Postman Collection

### Import Collection
The project includes a Postman collection file: `FoodTrip.postman_collection.json`

### Collection Contents
- **Authentication**: Login, Register, Token validation
- **Home**: Public endpoints for dishes, categories, restaurants
- **Customer**: Customer-specific endpoints
- **Restaurant Admin**: Restaurant management endpoints
- **Admin**: System administration endpoints
- **Database**: Database management endpoints

### Environment Variables
Set up these variables in Postman:
- `base_url`: `http://localhost:3600`
- `auth_token`: JWT token from login response
- `user_id`: Current user ID
- `restaurant_id`: Current restaurant ID

### Testing Workflow
1. **Setup**: Import collection and set environment variables
2. **Authentication**: Run login request to get token
3. **User Management**: Test user registration and profile updates
4. **Restaurant Management**: Test restaurant CRUD operations
5. **Dish Management**: Test dish CRUD operations
6. **Order Management**: Test order creation and status updates
7. **Database Management**: Test database operations

### Sample Test Scripts
```javascript
// Test login response
pm.test("Login successful", function () {
    pm.response.to.have.status(200);
    const response = pm.response.json();
    pm.expect(response.success).to.be.true;
    pm.expect(response.data.token).to.exist;
    
    // Set token for subsequent requests
    pm.environment.set("auth_token", response.data.token);
});

// Test dish creation
pm.test("Dish created successfully", function () {
    pm.response.to.have.status(201);
    const response = pm.response.json();
    pm.expect(response.success).to.be.true;
    pm.expect(response.data.dish_id).to.exist;
    
    // Set dish ID for subsequent requests
    pm.environment.set("dish_id", response.data.dish_id);
});
```

## Rate Limiting

### Default Limits
- **General API**: 1000 requests per hour
- **Authentication**: 100 requests per hour
- **File Upload**: 10 requests per minute
- **Database Operations**: 50 requests per hour

### Headers
```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640995200
```

### Error Response
```json
{
  "success": false,
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests. Please try again later.",
    "retry_after": 3600
  }
}
```

## File Upload

### Dish Images
```
POST /api/resto-admin/dishes/upload-image
Content-Type: multipart/form-data
Authorization: Bearer <token>
```

### Request Body
```
dish_image: [file]
dish_id: uuid
```

### Response
```json
{
  "success": true,
  "message": "Image uploaded successfully",
  "data": {
    "filename": "dish_img-1234567890123.png",
    "url": "http://localhost:3600/public/dishes/dish_img-1234567890123.png",
    "size": 1024576
  }
}
```

### File Constraints
- **Max Size**: 5MB
- **Allowed Types**: PNG, JPG, JPEG
- **Dimensions**: Max 2048x2048px

## API Versioning

### Current Version
- **Version**: v1
- **Base Path**: `/api/v1`

### Future Versions
- **Version**: v2 (planned)
- **Base Path**: `/api/v2`
- **Changes**: Enhanced filtering, GraphQL support

### Backward Compatibility
- v1 endpoints will remain supported
- Deprecation notices will be provided
- Migration guides will be available

## Conclusion

This API documentation provides comprehensive information about the FoodTrip API endpoints, authentication, and usage examples. The API is designed to be RESTful, well-documented, and easy to integrate with various clients.

For additional support or questions, refer to the Postman collection or consult the project documentation.

---

*Last updated: January 2025*
*Version: 1.0.0*
