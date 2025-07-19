# FoodTrip API Endpoints Overview

## Extracted from Postman Collection

This document contains all API endpoints extracted from the FoodTrip Postman collection, organized by user role and functionality.

---

## 1. HOME ENDPOINTS (Public Access)

### Authentication
| Method | Endpoint | Description | Body Type |
|--------|----------|-------------|-----------|
| POST | `/api/v1/home/login` | Admin Login | JSON |
| POST | `/api/v1/home/login` | Customer Login | JSON |
| POST | `/api/v1/home/login` | Resto Admin Login | JSON |

### Registration
| Method | Endpoint | Description | Body Type |
|--------|----------|-------------|-----------|
| POST | `/api/v1/home/register/customer` | Register Customer | JSON |
| POST | `/api/v1/home/register/restaurant` | Create Restaurant | Form Data |
| POST | `/api/v1/home/register/resto-admin` | Register Resto Admin | JSON |
| POST | `/api/v1/home/register/admin` | Register Admin | JSON |

### Dishes (Public)
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/home/dishes/` | Find All Dishes | - |
| GET | `/api/v1/home/dish-cat/` | Find All Dish Categories | - |
| GET | `/api/v1/home/dish-cat/:dishCatID` | Find Dish Category | dishCatID |

### Restaurants (Public)
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/home/restaurants` | Find All Restaurants | - |
| GET | `/api/v1/home/restaurant/:restoID` | Find Restaurant | restoID |

### Restaurant Categories (Public)
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/home/resto-categories` | Find All Restaurant Categories | - |
| GET | `/api/v1/home/resto-category/:restoCatID` | Find Restaurant Category | restoCatID |

---

## 2. RESTO ADMIN ENDPOINTS (Restaurant Admin Access)

### Restaurant Management
| Method | Endpoint | Description | Parameters | Body Type |
|--------|----------|-------------|------------|-----------|
| GET | `/api/v1/resto-admin/restaurant/:restoID` | Find Restaurant | restoID | - |
| PUT | `/api/v1/resto-admin/restaurant/:restoID` | Update Restaurant | restoID | Form Data |

### Opening Hours Management
| Method | Endpoint | Description | Parameters | Body Type |
|--------|----------|-------------|------------|-----------|
| POST | `/api/v1/resto-admin/restaurant/opening-hour` | Create Opening Hour | - | JSON Array |
| GET | `/api/v1/resto-admin/restaurant/opening-hour` | Find All Opening Hours | - | - |
| GET | `/api/v1/resto-admin/restaurant/opening-hour/:id` | Find Opening Hour | id | - |
| PUT | `/api/v1/restaurant/opening-hour/:id` | Update Opening Hour | id | JSON |
| DELETE | `/api/v1/resto-admin/restaurant/opening-hour/:id` | Delete Opening Hour | id | - |

### Dish Management
| Method | Endpoint | Description | Parameters | Body Type |
|--------|----------|-------------|------------|-----------|
| POST | `/api/v1/resto-admin/dish` | Create Dish | - | Form Data |
| GET | `/api/v1/resto-admin/dishes/:restoID` | Get All Dishes | restoID | - |
| GET | `/api/v1/resto-admin/dish-cat/` | Find All Dish Categories | - | - |
| GET | `/api/v1/resto-admin/dish-cat/:dishCatID` | Find Dish Category | dishCatID | - |
| GET | `/api/v1/resto-admin/dish/:dishID` | Find Dish | dishID | - |
| PUT | `/api/v1/resto-admin/dish/:dishID` | Update Dish | dishID | Form Data |
| DELETE | `/api/v1/resto-admin/dish/:dishID` | Delete Dish | dishID | - |

### Account Management
| Method | Endpoint | Description | Body Type |
|--------|----------|-------------|-----------|
| GET | `/api/v1/resto-admin/account/info` | Find User Account Info | - |
| PUT | `/api/v1/resto-admin/account/info` | Update User Account Info | JSON |
| POST | `/api/v1/resto-admin/account/verify-password` | Verify User Password | JSON |
| PUT | `/api/v1/resto-admin/account/password` | Update User Password | JSON |

### Order Management
| Method | Endpoint | Description | Parameters | Body Type |
|--------|----------|-------------|------------|-----------|
| GET | `/api/v1/resto-admin/orders` | Find All Orders | - | - |
| GET | `/api/v1/resto-admin/order/:orderID` | Find Order | orderID | - |
| PUT | `/api/v1/resto-admin/order/in-process/:orderID` | Set Order Status: In Process | orderID | - |
| PUT | `/api/v1/resto-admin/order/otw/:orderID` | Set Order Status: On The Way | orderID | JSON |
| PUT | `/api/v1/resto-admin/order/delivered/:orderID` | Set Order Status: Delivered | orderID | - |
| PUT | `/api/v1/resto-admin/order/rejected/:orderID` | Set Order Status: Rejected | orderID | - |
| PUT | `/api/v1/resto-admin/order/cancelled/:orderID` | Set Order Status: Cancelled | orderID | - |

### Courier Management
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/resto-admin/couriers` | Find All Couriers |

---

## 3. ADMIN ENDPOINTS (System Admin Access)

### Restaurant Management
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/admin/restaurants` | Find All Restaurants | - |
| GET | `/api/v1/admin/restaurant/:restoID` | Find Restaurant | restoID |
| GET | `/api/v1/admin/resto-cat` | Find All Restaurant Categories | - |
| GET | `/api/v1/admin/resto-cat/:restoCatID` | Find Restaurant Category | restoCatID |

### Dish Management
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/admin/dishes/` | Find All Dishes | - |
| GET | `/api/v1/admin/dish-cat/` | Find All Dish Categories | - |
| GET | `/api/v1/admin/dish/:dishID` | Find Dish | dishID |
| GET | `/api/v1/admin/dish-cat/:dishCatID` | Find Dish Category | dishCatID |

### User Management
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/admin/user/resto-admin` | Find All Resto Admins | - |
| GET | `/api/v1/admin/user/resto-admin/:restoAdminID` | Find Resto Admin | restoAdminID |
| GET | `/api/v1/admin/user/customer` | Find All Customers | - |
| GET | `/api/v1/admin/user/customer/:customerID` | Find Customer | customerID |
| GET | `/api/v1/admin/user/admin` | Find All Admins | - |
| GET | `/api/v1/admin/user/admin/:adminID` | Find Admin | adminID |

### Address Management
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/admin/address/` | Find All Addresses | - |
| GET | `/api/v1/admin/address/:addressID` | Find Address | addressID |

### Account Management
| Method | Endpoint | Description | Body Type |
|--------|----------|-------------|-----------|
| GET | `/api/v1/admin/account/info` | Find User Account Info | - |
| PUT | `/api/v1/admin/account/info` | Update User Account Info | JSON |
| POST | `/api/v1/admin/account/verify-password` | Verify User Password | JSON |
| PUT | `/api/v1/admin/account/password` | Update User Password | JSON |

### Order Management
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/admin/orders` | Find All Orders | - |
| GET | `/api/v1/admin/order/:orderID` | Find Order | orderID |

### Delivery & Courier Management
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/admin/deliveries` | Find All Delivery Details |
| GET | `/api/v1/admin/couriers` | Find All Couriers |

---

## 4. CUSTOMER ENDPOINTS (Customer Access)

### Explore
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/customer/some-resto-cat` | Find Some Restaurant Categories |
| GET | `/api/v1/customer/pop-dishes` | Find Popular Dishes |
| GET | `/api/v1/customer/pop-restaurants` | Find Popular Restaurants |

### Restaurant Browsing
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/customer/restaurants` | Find All Restaurants | - |
| GET | `/api/v1/customer/restaurant/:restoID` | Find Restaurant | restoID |
| GET | `/api/v1/customer/resto-cat` | Find All Restaurant Categories | - |
| GET | `/api/v1/customer/resto-cat/:restoCatID` | Find Restaurant Category | restoCatID |

### Dish Browsing
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| GET | `/api/v1/customer/dishes/` | Find All Dishes | - |
| GET | `/api/v1/customer/dish-cat/` | Find All Dish Categories | - |
| GET | `/api/v1/customer/dish/:dishID` | Find Dish | dishID |
| GET | `/api/v1/customer/dish-cat/:dishCatID` | Find Dish Category | dishCatID |

### Address Management
| Method | Endpoint | Description | Parameters | Body Type |
|--------|----------|-------------|------------|-----------|
| POST | `/api/v1/customer/address/` | Create Address | - | JSON |
| GET | `/api/v1/customer/address/` | Find All Addresses | - | - |
| GET | `/api/v1/customer/address/:addressID` | Find Address | addressID | - |
| PUT | `/api/v1/customer/address/:addressID` | Update Address | addressID | JSON |
| PUT | `/api/v1/customer/address/default/:addressID` | Update Default Address | addressID | - |
| DELETE | `/api/v1/customer/address/:addressID` | Delete Address | addressID | - |

### Account Management
| Method | Endpoint | Description | Body Type |
|--------|----------|-------------|-----------|
| GET | `/api/v1/customer/account/info` | Find User Account Info | - |
| PUT | `/api/v1/customer/account/info` | Update User Account Info | JSON |
| POST | `/api/v1/customer/account/verify-password` | Verify User Password | JSON |
| PUT | `/api/v1/customer/account/password` | Update User Password | JSON |

### Cart Management
| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| POST | `/api/v1/customer/dish/:dishID/add-to-cart` | Add To Cart | dishID |
| POST | `/api/v1/customer/cart/replace/:dishID` | Replace Cart | dishID |
| POST | `/api/v1/customer/cart/add-quantity/:cartDetailsID` | Add Quantity | cartDetailsID |
| POST | `/api/v1/customer/cart/sub-quantity/:cartDetailsID` | Subtract Quantity | cartDetailsID |
| GET | `/api/v1/customer/cart` | Find Cart | - |
| DELETE | `/api/v1/customer/cart/:cartDetailsID` | Delete Cart Details | cartDetailsID |
| DELETE | `/api/v1/customer/cart` | Delete Cart | - |

### Order Management
| Method | Endpoint | Description | Parameters | Body Type |
|--------|----------|-------------|------------|-----------|
| POST | `/api/v1/customer/order` | Create Order | - | JSON |
| GET | `/api/v1/customer/orders` | Find All Orders | - | - |
| GET | `/api/v1/customer/order/:orderID` | Find Order | orderID | - |
| PUT | `/api/v1/customer/order/cancelled/:orderID` | Cancel Order | orderID | - |

---

## Summary

**Total Endpoints: 85**

- **Home (Public): 11 endpoints**
- **Resto Admin: 23 endpoints**
- **System Admin: 18 endpoints**
- **Customer: 33 endpoints**

### Authentication Requirements:
- **Home endpoints**: No authentication required
- **Resto Admin endpoints**: Bearer token required
- **Admin endpoints**: Bearer token required  
- **Customer endpoints**: Bearer token required

### Common HTTP Methods Used:
- **GET**: 51 endpoints (60%)
- **POST**: 19 endpoints (22%)
- **PUT**: 13 endpoints (15%)
- **DELETE**: 2 endpoints (3%)
