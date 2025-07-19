# Test Data Generator & Setup Guide

## Overview
This document provides comprehensive test data generation scripts and setup procedures for the FoodTrip API testing environment.

---

## 1. Database Seeder Data

### 1.1 User Roles & Permissions
```json
{
  "user_roles": [
    {
      "id": "admin-role-uuid",
      "role_name": "Admin",
      "permissions": [
        "user_management",
        "restaurant_management", 
        "order_management",
        "system_settings"
      ]
    },
    {
      "id": "resto-admin-role-uuid", 
      "role_name": "Resto_Admin",
      "permissions": [
        "restaurant_update",
        "dish_management",
        "order_processing",
        "opening_hours"
      ]
    },
    {
      "id": "customer-role-uuid",
      "role_name": "Customer", 
      "permissions": [
        "order_placement",
        "address_management",
        "cart_management"
      ]
    }
  ]
}
```

### 1.2 Restaurant Categories
```json
{
  "restaurant_categories": [
    {
      "id": "fast-food-uuid",
      "category_name": "Fast Food",
      "description": "Quick service restaurants"
    },
    {
      "id": "fine-dining-uuid",
      "category_name": "Fine Dining", 
      "description": "Upscale dining experience"
    },
    {
      "id": "casual-dining-uuid",
      "category_name": "Casual Dining",
      "description": "Relaxed dining atmosphere"
    },
    {
      "id": "cafe-uuid",
      "category_name": "Cafe",
      "description": "Coffee shops and light meals"
    },
    {
      "id": "bakery-uuid",
      "category_name": "Bakery",
      "description": "Baked goods and pastries"
    }
  ]
}
```

### 1.3 Dish Categories
```json
{
  "dish_categories": [
    {
      "id": "appetizer-uuid",
      "category_name": "Appetizers",
      "description": "Starter dishes"
    },
    {
      "id": "main-course-uuid",
      "category_name": "Main Course",
      "description": "Primary dishes"
    },
    {
      "id": "dessert-uuid", 
      "category_name": "Desserts",
      "description": "Sweet treats"
    },
    {
      "id": "beverage-uuid",
      "category_name": "Beverages",
      "description": "Drinks and refreshments"
    },
    {
      "id": "salad-uuid",
      "category_name": "Salads",
      "description": "Fresh vegetables and greens"
    },
    {
      "id": "soup-uuid",
      "category_name": "Soups",
      "description": "Hot liquid dishes"
    }
  ]
}
```

### 1.4 Courier Services
```json
{
  "courier_services": [
    {
      "id": "foodtrip-delivery-uuid",
      "courier_name": "FoodTrip Express",
      "contact_number": "02-12345678",
      "email": "support@foodtripexpress.com",
      "status": "Active"
    },
    {
      "id": "quick-eats-uuid", 
      "courier_name": "Quick Eats Delivery",
      "contact_number": "02-87654321",
      "email": "info@quickeats.com", 
      "status": "Active"
    },
    {
      "id": "metro-delivery-uuid",
      "courier_name": "Metro Food Delivery",
      "contact_number": "02-11223344",
      "email": "delivery@metrofood.com",
      "status": "Active"
    }
  ]
}
```

---

## 2. Test Users Setup

### 2.1 System Admins
```json
{
  "system_admins": [
    {
      "id": "test-admin-1-uuid",
      "first_name": "System",
      "last_name": "Administrator",
      "email_address": "testadmin@foodtrip.com",
      "password": "TestAdmin@123",
      "user_type": "Admin",
      "status": "Active",
      "created_at": "2024-01-01T00:00:00Z"
    },
    {
      "id": "test-admin-2-uuid", 
      "first_name": "Secondary",
      "last_name": "Admin",
      "email_address": "admin2@foodtrip.com",
      "password": "SecondAdmin@123",
      "user_type": "Admin",
      "status": "Active",
      "created_at": "2024-01-02T00:00:00Z"
    }
  ]
}
```

### 2.2 Restaurant Admins
```json
{
  "restaurant_admins": [
    {
      "id": "test-resto-admin-1-uuid",
      "first_name": "John",
      "last_name": "Restaurant",
      "email_address": "testrestoadmin@foodtrip.com", 
      "password": "TestRestoAdmin@123",
      "user_type": "Resto_Admin",
      "resto_id": "test-restaurant-1-uuid",
      "status": "Active",
      "created_at": "2024-01-03T00:00:00Z"
    },
    {
      "id": "test-resto-admin-2-uuid",
      "first_name": "Maria",
      "last_name": "Catering",
      "email_address": "maria.catering@foodtrip.com",
      "password": "MariaAdmin@123", 
      "user_type": "Resto_Admin",
      "resto_id": "test-restaurant-2-uuid",
      "status": "Active",
      "created_at": "2024-01-04T00:00:00Z"
    }
  ]
}
```

### 2.3 Test Customers
```json
{
  "test_customers": [
    {
      "id": "test-customer-1-uuid",
      "first_name": "Jane",
      "middle_name": "Marie",
      "last_name": "Customer",
      "email_address": "testcustomer@foodtrip.com",
      "password": "TestCustomer@123",
      "phone_number": "09123456789",
      "gender": "Female",
      "user_type": "Customer",
      "status": "Active",
      "created_at": "2024-01-05T00:00:00Z"
    },
    {
      "id": "test-customer-2-uuid",
      "first_name": "Robert",
      "last_name": "Johnson", 
      "email_address": "robert.johnson@foodtrip.com",
      "password": "RobertCustomer@123",
      "phone_number": "09987654321",
      "gender": "Male",
      "user_type": "Customer",
      "status": "Active",
      "created_at": "2024-01-06T00:00:00Z"
    },
    {
      "id": "test-customer-3-uuid",
      "first_name": "Alex",
      "last_name": "Taylor",
      "email_address": "alex.taylor@foodtrip.com",
      "password": "AlexCustomer@123",
      "phone_number": "09555666777",
      "gender": "Others",
      "user_type": "Customer", 
      "status": "Active",
      "created_at": "2024-01-07T00:00:00Z"
    }
  ]
}
```

---

## 3. Test Restaurants

### 3.1 Restaurant Data
```json
{
  "test_restaurants": [
    {
      "id": "test-restaurant-1-uuid",
      "resto_name": "The Golden Spoon",
      "resto_phone": "02-12345678",
      "resto_email": "info@goldenspoon.com",
      "resto_landline": "02-12345679",
      "resto_website": "www.goldenspoon.com",
      "restocatg_id": "fine-dining-uuid",
      "status": "Open",
      "created_at": "2024-01-03T00:00:00Z",
      "opening_hours": [
        {
          "day": "Monday",
          "open_time": "10:00:00",
          "close_time": "22:00:00"
        },
        {
          "day": "Tuesday", 
          "open_time": "10:00:00",
          "close_time": "22:00:00"
        },
        {
          "day": "Wednesday",
          "open_time": "10:00:00", 
          "close_time": "22:00:00"
        },
        {
          "day": "Thursday",
          "open_time": "10:00:00",
          "close_time": "22:00:00"
        },
        {
          "day": "Friday",
          "open_time": "10:00:00",
          "close_time": "23:00:00"
        },
        {
          "day": "Saturday", 
          "open_time": "09:00:00",
          "close_time": "23:00:00"
        },
        {
          "day": "Sunday",
          "open_time": "09:00:00",
          "close_time": "21:00:00"
        }
      ]
    },
    {
      "id": "test-restaurant-2-uuid",
      "resto_name": "Quick Bite Express",
      "resto_phone": "02-87654321",
      "resto_email": "orders@quickbite.com",
      "resto_landline": "02-87654322",
      "resto_website": "www.quickbite.com",
      "restocatg_id": "fast-food-uuid",
      "status": "Open",
      "created_at": "2024-01-04T00:00:00Z"
    },
    {
      "id": "test-restaurant-3-uuid",
      "resto_name": "Cozy Corner Cafe",
      "resto_phone": "02-11223344",
      "resto_email": "hello@cozycorner.com",
      "resto_landline": "02-11223345",
      "resto_website": "www.cozycorner.com",
      "restocatg_id": "cafe-uuid",
      "status": "Closed",
      "created_at": "2024-01-05T00:00:00Z"
    }
  ]
}
```

---

## 4. Test Dishes

### 4.1 Sample Dishes for Restaurant 1 (The Golden Spoon)
```json
{
  "restaurant_1_dishes": [
    {
      "id": "dish-1-uuid",
      "dish_name": "Grilled Salmon Fillet",
      "dish_desc": "Fresh Atlantic salmon grilled to perfection, served with lemon butter sauce and seasonal vegetables",
      "dish_price": 650.00,
      "status": "Available",
      "dishcatg_id": "main-course-uuid",
      "resto_id": "test-restaurant-1-uuid",
      "created_at": "2024-01-10T00:00:00Z"
    },
    {
      "id": "dish-2-uuid",
      "dish_name": "Caesar Salad",
      "dish_desc": "Crisp romaine lettuce, parmesan cheese, croutons, and house-made Caesar dressing",
      "dish_price": 285.00,
      "status": "Available",
      "dishcatg_id": "salad-uuid", 
      "resto_id": "test-restaurant-1-uuid",
      "created_at": "2024-01-10T00:00:00Z"
    },
    {
      "id": "dish-3-uuid",
      "dish_name": "Chocolate Lava Cake",
      "dish_desc": "Decadent chocolate cake with molten chocolate center, served with vanilla ice cream",
      "dish_price": 195.00,
      "status": "Available",
      "dishcatg_id": "dessert-uuid",
      "resto_id": "test-restaurant-1-uuid",
      "created_at": "2024-01-10T00:00:00Z"
    },
    {
      "id": "dish-4-uuid",
      "dish_name": "Seasonal Soup",
      "dish_desc": "Chef's special soup made with fresh seasonal ingredients",
      "dish_price": 145.00,
      "status": "Unavailable",
      "dishcatg_id": "soup-uuid",
      "resto_id": "test-restaurant-1-uuid",
      "created_at": "2024-01-10T00:00:00Z"
    }
  ]
}
```

### 4.2 Sample Dishes for Restaurant 2 (Quick Bite Express)
```json
{
  "restaurant_2_dishes": [
    {
      "id": "dish-5-uuid",
      "dish_name": "Classic Cheeseburger",
      "dish_desc": "Juicy beef patty with cheese, lettuce, tomato, onion, and special sauce",
      "dish_price": 195.00,
      "status": "Available",
      "dishcatg_id": "main-course-uuid",
      "resto_id": "test-restaurant-2-uuid",
      "created_at": "2024-01-11T00:00:00Z"
    },
    {
      "id": "dish-6-uuid",
      "dish_name": "Chicken Wings",
      "dish_desc": "Crispy chicken wings tossed in your choice of sauce",
      "dish_price": 165.00,
      "status": "Available",
      "dishcatg_id": "appetizer-uuid",
      "resto_id": "test-restaurant-2-uuid", 
      "created_at": "2024-01-11T00:00:00Z"
    },
    {
      "id": "dish-7-uuid",
      "dish_name": "Soft Drink",
      "dish_desc": "Choice of cola, lemon-lime, or orange soda",
      "dish_price": 45.00,
      "status": "Available",
      "dishcatg_id": "beverage-uuid",
      "resto_id": "test-restaurant-2-uuid",
      "created_at": "2024-01-11T00:00:00Z"
    }
  ]
}
```

---

## 5. Test Addresses

### 5.1 Customer Addresses
```json
{
  "customer_addresses": [
    {
      "id": "address-1-uuid",
      "user_id": "test-customer-1-uuid",
      "address_1": "123 Main Street",
      "address_2": "Apartment 4B",
      "barangay": "Poblacion",
      "city": "Makati City",
      "province": "Metro Manila",
      "region": "NCR", 
      "zip_code": "1200",
      "phone_number": "09123456789",
      "full_name": "Jane Marie Customer",
      "is_default": true,
      "created_at": "2024-01-15T00:00:00Z"
    },
    {
      "id": "address-2-uuid", 
      "user_id": "test-customer-1-uuid",
      "address_1": "456 Oak Avenue",
      "address_2": "Unit 201",
      "barangay": "San Antonio",
      "city": "Pasig City",
      "province": "Metro Manila",
      "region": "NCR",
      "zip_code": "1600", 
      "phone_number": "09123456789",
      "full_name": "Jane Marie Customer",
      "is_default": false,
      "created_at": "2024-01-16T00:00:00Z"
    },
    {
      "id": "address-3-uuid",
      "user_id": "test-customer-2-uuid",
      "address_1": "789 Pine Road",
      "barangay": "Bagong Silang",
      "city": "Quezon City",
      "province": "Metro Manila",
      "region": "NCR",
      "zip_code": "1100",
      "phone_number": "09987654321",
      "full_name": "Robert Johnson",
      "is_default": true,
      "created_at": "2024-01-17T00:00:00Z"
    }
  ]
}
```

---

## 6. Test Orders and Order History

### 6.1 Sample Orders
```json
{
  "test_orders": [
    {
      "id": "order-1-uuid",
      "customer_id": "test-customer-1-uuid",
      "resto_id": "test-restaurant-1-uuid",
      "address_id": "address-1-uuid",
      "order_comment": "Please deliver to the lobby. Call when you arrive.",
      "order_status": "Delivered",
      "total_amount": 1130.00,
      "delivery_fee": 50.00,
      "created_at": "2024-01-20T12:00:00Z",
      "delivered_at": "2024-01-20T13:30:00Z",
      "order_details": [
        {
          "id": "order-detail-1-uuid",
          "dish_id": "dish-1-uuid",
          "quantity": 1,
          "unit_price": 650.00,
          "total_price": 650.00
        },
        {
          "id": "order-detail-2-uuid", 
          "dish_id": "dish-2-uuid",
          "quantity": 2,
          "unit_price": 285.00,
          "total_price": 570.00
        }
      ],
      "payment": {
        "id": "payment-1-uuid",
        "payment_method": "Cash on Delivery",
        "payment_status": "Completed",
        "amount_paid": 1130.00
      }
    },
    {
      "id": "order-2-uuid",
      "customer_id": "test-customer-2-uuid",
      "resto_id": "test-restaurant-2-uuid",
      "address_id": "address-3-uuid",
      "order_comment": "Extra sauce please",
      "order_status": "In Process",
      "total_amount": 405.00,
      "delivery_fee": 40.00,
      "created_at": "2024-01-21T18:30:00Z",
      "order_details": [
        {
          "id": "order-detail-3-uuid",
          "dish_id": "dish-5-uuid",
          "quantity": 1,
          "unit_price": 195.00,
          "total_price": 195.00
        },
        {
          "id": "order-detail-4-uuid",
          "dish_id": "dish-6-uuid", 
          "quantity": 1,
          "unit_price": 165.00,
          "total_price": 165.00
        },
        {
          "id": "order-detail-5-uuid",
          "dish_id": "dish-7-uuid",
          "quantity": 1,
          "unit_price": 45.00,
          "total_price": 45.00
        }
      ]
    }
  ]
}
```

---

## 7. Database Setup Scripts

### 7.1 SQL Seeder Script (PostgreSQL/MySQL)
```sql
-- Clear existing test data
DELETE FROM order_details WHERE order_id IN (SELECT id FROM orders WHERE customer_id LIKE 'test-%');
DELETE FROM orders WHERE customer_id LIKE 'test-%';
DELETE FROM cart_details WHERE cart_id IN (SELECT id FROM carts WHERE customer_id LIKE 'test-%');
DELETE FROM carts WHERE customer_id LIKE 'test-%';
DELETE FROM addresses WHERE user_id LIKE 'test-%';
DELETE FROM dishes WHERE resto_id LIKE 'test-%';
DELETE FROM opening_hours WHERE resto_id LIKE 'test-%';
DELETE FROM restaurants WHERE id LIKE 'test-%';
DELETE FROM users WHERE id LIKE 'test-%';

-- Insert restaurant categories
INSERT INTO restaurant_categories (id, category_name, description) VALUES 
('fast-food-uuid', 'Fast Food', 'Quick service restaurants'),
('fine-dining-uuid', 'Fine Dining', 'Upscale dining experience'),
('casual-dining-uuid', 'Casual Dining', 'Relaxed dining atmosphere'),
('cafe-uuid', 'Cafe', 'Coffee shops and light meals');

-- Insert dish categories  
INSERT INTO dish_categories (id, category_name, description) VALUES
('appetizer-uuid', 'Appetizers', 'Starter dishes'),
('main-course-uuid', 'Main Course', 'Primary dishes'),
('dessert-uuid', 'Desserts', 'Sweet treats'),
('beverage-uuid', 'Beverages', 'Drinks and refreshments'),
('salad-uuid', 'Salads', 'Fresh vegetables and greens'),
('soup-uuid', 'Soups', 'Hot liquid dishes');

-- Insert test users
INSERT INTO users (id, first_name, last_name, email_address, password, user_type, status, created_at) VALUES
('test-admin-1-uuid', 'System', 'Administrator', 'testadmin@foodtrip.com', '$2b$10$hashed_password', 'Admin', 'Active', '2024-01-01 00:00:00'),
('test-customer-1-uuid', 'Jane', 'Customer', 'testcustomer@foodtrip.com', '$2b$10$hashed_password', 'Customer', 'Active', '2024-01-05 00:00:00'),
('test-resto-admin-1-uuid', 'John', 'Restaurant', 'testrestoadmin@foodtrip.com', '$2b$10$hashed_password', 'Resto_Admin', 'Active', '2024-01-03 00:00:00');

-- Continue with restaurants, dishes, etc...
```

### 7.2 Environment Variables
```env
# Test Environment Configuration
NODE_ENV=test
DB_HOST=localhost
DB_PORT=5432
DB_NAME=foodtrip_test
DB_USER=test_user
DB_PASS=test_password

# JWT Configuration
JWT_SECRET=test_jwt_secret_key
JWT_EXPIRES_IN=24h

# File Upload Configuration  
UPLOAD_PATH=/tmp/test_uploads
MAX_FILE_SIZE=5242880

# API Configuration
API_BASE_URL=http://localhost:3000
API_VERSION=v1

# Test Data Configuration
CLEANUP_TEST_DATA=true
GENERATE_TEST_IMAGES=true
TEST_IMAGE_PATH=/tmp/test_images
```

---

## 8. Automated Test Data Generation

### 8.1 Node.js Test Data Generator
```javascript
// test-data-generator.js
const { v4: uuidv4 } = require('uuid');
const bcrypt = require('bcrypt');
const fs = require('fs');

class TestDataGenerator {
  constructor() {
    this.saltRounds = 10;
  }

  async generateUsers(count = 10) {
    const users = [];
    const userTypes = ['Customer', 'Resto_Admin', 'Admin'];
    
    for (let i = 0; i < count; i++) {
      const userType = userTypes[i % userTypes.length];
      const hashedPassword = await bcrypt.hash('TestPassword@123', this.saltRounds);
      
      users.push({
        id: uuidv4(),
        first_name: `Test${userType}${i}`,
        last_name: `User${i}`,
        email_address: `test${userType.toLowerCase()}${i}@foodtrip.com`,
        password: hashedPassword,
        user_type: userType,
        phone_number: `0912345${String(i).padStart(4, '0')}`,
        gender: ['Male', 'Female', 'Others'][i % 3],
        status: 'Active',
        created_at: new Date()
      });
    }
    
    return users;
  }

  generateRestaurants(restoAdminIds, categoryIds) {
    return restoAdminIds.map((adminId, index) => ({
      id: uuidv4(),
      resto_name: `Test Restaurant ${index + 1}`,
      resto_phone: `0287654${String(index).padStart(3, '0')}`,
      resto_email: `restaurant${index + 1}@foodtrip.com`,
      resto_landline: `0212345${String(index).padStart(3, '0')}`,
      resto_website: `www.testrestaurant${index + 1}.com`,
      restocatg_id: categoryIds[index % categoryIds.length],
      status: ['Open', 'Closed'][index % 2],
      created_at: new Date()
    }));
  }

  generateDishes(restaurantIds, dishCategoryIds) {
    const dishes = [];
    const dishNames = [
      'Grilled Chicken', 'Beef Steak', 'Fish Fillet', 'Vegetable Salad',
      'Mushroom Soup', 'Chocolate Cake', 'Iced Tea', 'Garlic Bread'
    ];
    
    restaurantIds.forEach(restoId => {
      dishNames.forEach((name, index) => {
        dishes.push({
          id: uuidv4(),
          dish_name: name,
          dish_desc: `Delicious ${name.toLowerCase()} prepared by our expert chefs`,
          dish_price: Math.floor(Math.random() * 500) + 100,
          status: ['Available', 'Unavailable'][Math.floor(Math.random() * 2)],
          dishcatg_id: dishCategoryIds[index % dishCategoryIds.length],
          resto_id: restoId,
          created_at: new Date()
        });
      });
    });
    
    return dishes;
  }

  async saveTestData() {
    const testData = {
      users: await this.generateUsers(50),
      restaurants: [],
      dishes: [],
      addresses: [],
      generated_at: new Date().toISOString()
    };

    fs.writeFileSync(
      './test-data/generated-test-data.json', 
      JSON.stringify(testData, null, 2)
    );
    
    console.log('Test data generated successfully!');
    return testData;
  }
}

// Usage
const generator = new TestDataGenerator();
generator.saveTestData();
```

---

## 9. Test Data Cleanup Scripts

### 9.1 Database Cleanup
```javascript
// cleanup-test-data.js
const db = require('./database');

async function cleanupTestData() {
  try {
    // Delete in correct order to respect foreign key constraints
    await db.query('DELETE FROM order_details WHERE order_id IN (SELECT id FROM orders WHERE customer_id LIKE $1)', ['test-%']);
    await db.query('DELETE FROM orders WHERE customer_id LIKE $1', ['test-%']);
    await db.query('DELETE FROM cart_details WHERE cart_id IN (SELECT id FROM carts WHERE customer_id LIKE $1)', ['test-%']);
    await db.query('DELETE FROM carts WHERE customer_id LIKE $1', ['test-%']);
    await db.query('DELETE FROM addresses WHERE user_id LIKE $1', ['test-%']);
    await db.query('DELETE FROM dishes WHERE resto_id LIKE $1', ['test-%']);
    await db.query('DELETE FROM opening_hours WHERE resto_id LIKE $1', ['test-%']);
    await db.query('DELETE FROM restaurants WHERE id LIKE $1', ['test-%']);
    await db.query('DELETE FROM users WHERE id LIKE $1', ['test-%']);
    
    console.log('Test data cleanup completed successfully');
  } catch (error) {
    console.error('Error during cleanup:', error);
    throw error;
  }
}

module.exports = { cleanupTestData };
```

---

## 10. Usage Instructions

### 10.1 Setup Test Environment
1. Create test database
2. Run database migrations
3. Execute seeder scripts
4. Generate test images
5. Configure environment variables

### 10.2 Generate Fresh Test Data
```bash
# Generate new test data
node scripts/test-data-generator.js

# Seed database with test data
node scripts/seed-test-data.js

# Generate test images
node scripts/generate-test-images.js
```

### 10.3 Cleanup After Testing
```bash
# Clean database
node scripts/cleanup-test-data.js

# Remove test files
rm -rf /tmp/test_uploads/*
rm -rf /tmp/test_images/*
```

This comprehensive test data setup ensures consistent, realistic data for thorough API testing across all endpoints and scenarios.
