# API Testing Best Practices & Test Data Guide

## Overview
This document provides comprehensive guidelines for creating effective API test cases for the FoodTrip API, including test data suggestions and testing scenarios.

---

## 1. Test Case Structure Best Practices

### Essential Components for Each Test Case:
1. **Test Case ID**: Unique identifier
2. **Test Case Description**: Clear, concise description
3. **Prerequisites**: Required setup (authentication, data setup)
4. **HTTP Method**: GET, POST, PUT, DELETE
5. **Endpoint URL**: Complete endpoint with parameters
6. **Request Headers**: Including authentication tokens
7. **Request Body**: JSON/Form data with realistic values
8. **Expected Response**: Status code, response structure, data validation
9. **Actual Response**: To be filled during execution
10. **Test Result**: Pass/Fail
11. **Notes**: Additional observations

---

## 2. Test Data Categories & Suggestions

### 2.1 User Authentication Data

#### Valid Login Credentials:
```json
{
  "admin_login": {
    "email_address": "admin@foodtrip.com",
    "password": "Admin@123"
  },
  "customer_login": {
    "email_address": "customer@foodtrip.com", 
    "password": "Customer@123"
  },
  "resto_admin_login": {
    "email_address": "restoadmin@foodtrip.com",
    "password": "RestoAdmin@123"
  }
}
```

#### Invalid Login Test Data:
```json
{
  "invalid_email": "invalid-email-format",
  "invalid_password": "123",
  "nonexistent_user": "nonexistent@foodtrip.com",
  "empty_email": "",
  "empty_password": "",
  "sql_injection": "admin@foodtrip.com'; DROP TABLE users; --"
}
```

### 2.2 User Registration Data

#### Valid Registration Data:
```json
{
  "customer_registration": {
    "password": "SecurePass@123",
    "first_name": "John",
    "middle_name": "Michael",
    "last_name": "Doe",
    "email_address": "john.doe@gmail.com",
    "phone_number": "09123456789",
    "gender": "Male",
    "user_type": "Customer"
  }
}
```

#### Edge Cases for Registration:
```json
{
  "minimum_valid_data": {
    "password": "Pass@123",
    "first_name": "A",
    "last_name": "B",
    "email_address": "a@b.co",
    "phone_number": "09111111111",
    "gender": "Others",
    "user_type": "Customer"
  },
  "maximum_length_data": {
    "first_name": "A" * 50,
    "last_name": "B" * 50,
    "email_address": "very.long.email.address@domain.com"
  }
}
```

### 2.3 Restaurant Data

#### Valid Restaurant Creation:
```json
{
  "restaurant_data": {
    "resto_name": "The Golden Spoon",
    "resto_phone": "09123456789",
    "resto_email": "info@goldenspoon.com",
    "resto_landline": "02-12345678",
    "resto_website": "www.goldenspoon.com",
    "restocatg_id": "valid-uuid-here",
    "status": "Open"
  }
}
```

#### Restaurant Categories Test Data:
```json
{
  "restaurant_categories": [
    "Fast Food",
    "Fine Dining",
    "Casual Dining",
    "Cafe",
    "Bakery",
    "Food Truck",
    "Buffet"
  ]
}
```

### 2.4 Dish Data

#### Valid Dish Creation:
```json
{
  "dish_data": {
    "dish_name": "Chicken Adobo",
    "dish_desc": "Traditional Filipino chicken dish marinated in vinegar, soy sauce, and garlic",
    "dish_price": "299.00",
    "status": "Available",
    "dishcatg_id": "valid-category-uuid",
    "resto_id": "valid-restaurant-uuid"
  }
}
```

#### Dish Categories:
```json
{
  "dish_categories": [
    "Appetizers",
    "Main Course", 
    "Desserts",
    "Beverages",
    "Salads",
    "Soups",
    "Pasta",
    "Pizza",
    "Seafood",
    "Vegetarian"
  ]
}
```

### 2.5 Address Data

#### Valid Address:
```json
{
  "address_data": {
    "address_1": "123 Main Street",
    "address_2": "Apartment 4B",
    "barangay": "Poblacion",
    "city": "Makati City",
    "province": "Metro Manila", 
    "region": "NCR",
    "zip_code": "1200",
    "phone_number": "09123456789",
    "full_name": "John Michael Doe",
    "is_default": "1"
  }
}
```

### 2.6 Order Data

#### Valid Order Creation:
```json
{
  "order_data": {
    "order_comment": "Please deliver to the lobby. Call when you arrive.",
    "address_id": "valid-address-uuid"
  }
}
```

---

## 3. Test Scenarios by Category

### 3.1 Positive Test Scenarios

#### Authentication Tests:
- ✅ Valid login with correct credentials
- ✅ Successful registration with valid data
- ✅ Token generation and validation
- ✅ Role-based access verification

#### CRUD Operations:
- ✅ Create resource with valid data
- ✅ Read/retrieve existing resource
- ✅ Update resource with valid changes
- ✅ Delete existing resource
- ✅ List resources with pagination

#### Business Logic:
- ✅ Add item to cart successfully
- ✅ Place order with valid cart
- ✅ Update order status progression
- ✅ Calculate correct totals and taxes

### 3.2 Negative Test Scenarios

#### Authentication Tests:
- ❌ Login with invalid credentials
- ❌ Access protected endpoints without token
- ❌ Use expired/invalid tokens
- ❌ Cross-role access attempts

#### Input Validation:
- ❌ Required fields missing
- ❌ Invalid data formats (email, phone, UUID)
- ❌ Data too long/short
- ❌ SQL injection attempts
- ❌ XSS attack attempts

#### Business Rules:
- ❌ Order from closed restaurant
- ❌ Add unavailable dish to cart
- ❌ Update non-existent resource
- ❌ Delete resource with dependencies

### 3.3 Edge Case Scenarios

#### Boundary Value Tests:
- 🔄 Maximum/minimum string lengths
- 🔄 Extreme numeric values (price: 0.01, 999999.99)
- 🔄 Special characters in names
- 🔄 Unicode characters

#### Concurrent Access:
- 🔄 Multiple users ordering same dish
- 🔄 Restaurant closing during order process
- 🔄 Inventory changes during cart management

---

## 4. Response Validation Checklist

### 4.1 HTTP Status Codes
- **200 OK**: Successful GET/PUT operations
- **201 Created**: Successful POST operations
- **204 No Content**: Successful DELETE operations
- **400 Bad Request**: Invalid input data
- **401 Unauthorized**: Missing/invalid authentication
- **403 Forbidden**: Insufficient permissions
- **404 Not Found**: Resource doesn't exist
- **422 Unprocessable Entity**: Validation errors
- **500 Internal Server Error**: Server errors

### 4.2 Response Structure Validation
```json
{
  "success_response": {
    "message": "Success message",
    "data": {
      "id": "uuid-format",
      "created_at": "ISO-8601-timestamp",
      "updated_at": "ISO-8601-timestamp"
    }
  },
  "error_response": {
    "message": "Error description",
    "errors": {
      "field_name": ["validation error messages"]
    }
  }
}
```

### 4.3 Data Validation Points
- ✅ All required fields present
- ✅ Data types match expectations
- ✅ UUID format validation
- ✅ Timestamp format validation
- ✅ Numeric ranges within bounds
- ✅ String lengths within limits
- ✅ Business logic consistency

---

## 5. Performance Testing Considerations

### 5.1 Load Testing Scenarios
- 📊 Peak ordering hours simulation
- 📊 High concurrent user registration
- 📊 Large menu browsing loads
- 📊 Bulk order processing

### 5.2 Response Time Benchmarks
- 🚀 Authentication: < 2 seconds
- 🚀 Simple queries (GET): < 1 second
- 🚀 Complex queries: < 3 seconds
- 🚀 File uploads: < 10 seconds
- 🚀 Order processing: < 5 seconds

---

## 6. Security Testing Focus Areas

### 6.1 Authentication & Authorization
- 🔐 JWT token security
- 🔐 Password strength enforcement
- 🔐 Session timeout handling
- 🔐 Role-based access control

### 6.2 Input Sanitization
- 🛡️ SQL injection prevention
- 🛡️ XSS attack prevention
- 🛡️ File upload security
- 🛡️ Input length validation

### 6.3 Data Protection
- 🔒 Sensitive data masking in logs
- 🔒 Password hashing verification
- 🔒 PII data handling
- 🔒 HTTPS enforcement

---

## 7. Test Environment Data Setup

### 7.1 Master Data Requirements
```json
{
  "required_master_data": {
    "restaurant_categories": ["Fast Food", "Fine Dining", "Cafe"],
    "dish_categories": ["Main Course", "Desserts", "Beverages"],
    "user_roles": ["Admin", "Resto_Admin", "Customer"],
    "order_statuses": ["Pending", "In Process", "On The Way", "Delivered", "Cancelled"],
    "courier_services": ["Food Delivery Co", "Quick Eats Express"]
  }
}
```

### 7.2 Test Users Setup
```json
{
  "test_users": {
    "system_admin": {
      "email": "testadmin@foodtrip.com",
      "password": "TestAdmin@123",
      "role": "Admin"
    },
    "restaurant_admin": {
      "email": "testrestoadmin@foodtrip.com", 
      "password": "TestRestoAdmin@123",
      "role": "Resto_Admin",
      "restaurant_id": "test-restaurant-uuid"
    },
    "customer": {
      "email": "testcustomer@foodtrip.com",
      "password": "TestCustomer@123", 
      "role": "Customer"
    }
  }
}
```

---

## 8. Automation Considerations

### 8.1 Priority for Automation
1. **High Priority**: Authentication flows, CRUD operations
2. **Medium Priority**: Business logic validation, error handling
3. **Low Priority**: UI integration, performance tests

### 8.2 Test Data Management
- Use factories/builders for test data generation
- Implement database seeding for consistent test state
- Create cleanup procedures for test isolation
- Use UUIDs for unique test identifiers

### 8.3 Continuous Integration
- Automate test execution on code commits
- Generate test reports with coverage metrics
- Set up test environment refresh procedures
- Monitor test execution performance

---

This guide provides a solid foundation for comprehensive API testing of the FoodTrip system. Adapt the specific test data values based on your actual business requirements and validation rules.
