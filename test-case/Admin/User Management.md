# Test Cases: Admin User Management API

**Endpoints:**
- `GET {{base_url}}/api/v1/admin/user/resto-admin` (Get All Resto Admins)
- `GET {{base_url}}/api/v1/admin/user/resto-admin/:restoAdminID` (Get Specific Resto Admin)
- `GET {{base_url}}/api/v1/admin/user/customer` (Get All Customers)
- `GET {{base_url}}/api/v1/admin/user/customer/:customerID` (Get Specific Customer)
- `GET {{base_url}}/api/v1/admin/user/admin` (Get All Admins)
- `GET {{base_url}}/api/v1/admin/user/admin/:adminID` (Get Specific Admin)

## Test Case Overview
These endpoints handle user management for system administrators, allowing them to view and manage different types of users in the system.

---

## Authentication Setup
**Required:** Bearer token for Admin role
```
Authorization: Bearer {{admin_token}}
```

---

## GET ALL RESTO ADMINS Test Cases

| No  | Test Case Description | Method | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ----------------- | ----------- | -------- |
| 1   | Get all resto admins with valid admin token | GET | `{ "message": "Resto admins retrieved successfully", "data": [{ "id": "uuid", "first_name": "John", "last_name": "Doe", "email_address": "restoadmin@foodtrip.com", "user_type": "Resto_Admin", "resto_id": "restaurant-uuid", "restaurant": { "resto_name": "Test Restaurant" }, "created_at": "timestamp" }] }` | 200 OK | High |
| 2   | Get resto admins when none exist | GET | `{ "message": "Resto admins retrieved successfully", "data": [] }` | 200 OK | Medium |
| 3   | Get resto admins without authentication | GET | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 4   | Get resto admins with customer token | GET | `{ "message": "Insufficient permissions" }` | 403 Forbidden | High |
| 5   | Get resto admins with expired token | GET | `{ "message": "Token expired" }` | 401 Unauthorized | Medium |

---

## GET SPECIFIC RESTO ADMIN Test Cases

| No  | Test Case Description | Method | URL Parameter | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ----------------- | ----------- | -------- |
| 6   | Get existing resto admin by valid ID | GET | restoAdminID: valid-uuid | `{ "message": "Resto admin retrieved successfully", "data": { "id": "uuid", "first_name": "John", "last_name": "Doe", "email_address": "restoadmin@foodtrip.com", "user_type": "Resto_Admin", "resto_id": "restaurant-uuid", "restaurant": { "resto_name": "Test Restaurant", "status": "Open" }, "created_at": "timestamp", "updated_at": "timestamp" } }` | 200 OK | High |
| 7   | Get resto admin with non-existent ID | GET | restoAdminID: non-existent-uuid | `{ "message": "Resto admin not found" }` | 404 Not Found | High |
| 8   | Get resto admin with invalid UUID format | GET | restoAdminID: invalid-uuid | `{ "message": "Invalid resto admin ID format" }` | 400 Bad Request | Medium |
| 9   | Get resto admin without authentication | GET | restoAdminID: valid-uuid | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 10  | Get resto admin with insufficient permissions | GET | restoAdminID: valid-uuid | `{ "message": "Insufficient permissions" }` | 403 Forbidden | High |

---

## GET ALL CUSTOMERS Test Cases

| No  | Test Case Description | Method | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ----------------- | ----------- | -------- |
| 11  | Get all customers with valid admin token | GET | `{ "message": "Customers retrieved successfully", "data": [{ "id": "uuid", "first_name": "Jane", "last_name": "Smith", "email_address": "customer@foodtrip.com", "user_type": "Customer", "phone_number": "09123456789", "gender": "Female", "created_at": "timestamp", "total_orders": 5, "last_order_date": "timestamp" }] }` | 200 OK | High |
| 12  | Get customers with pagination parameters | GET | `{ "message": "Customers retrieved successfully", "data": [...], "pagination": { "current_page": 1, "total_pages": 10, "total_records": 100, "per_page": 10 } }` | 200 OK | Medium |
| 13  | Get customers when none exist | GET | `{ "message": "Customers retrieved successfully", "data": [] }` | 200 OK | Medium |
| 14  | Get customers without authentication | GET | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 15  | Get customers with non-admin token | GET | `{ "message": "Insufficient permissions" }` | 403 Forbidden | High |

---

## GET SPECIFIC CUSTOMER Test Cases

| No  | Test Case Description | Method | URL Parameter | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ----------------- | ----------- | -------- |
| 16  | Get existing customer by valid ID | GET | customerID: valid-uuid | `{ "message": "Customer retrieved successfully", "data": { "id": "uuid", "first_name": "Jane", "last_name": "Smith", "email_address": "customer@foodtrip.com", "user_type": "Customer", "phone_number": "09123456789", "gender": "Female", "created_at": "timestamp", "addresses": [...], "order_history": [...], "total_spent": 1500.00 } }` | 200 OK | High |
| 17  | Get customer with non-existent ID | GET | customerID: non-existent-uuid | `{ "message": "Customer not found" }` | 404 Not Found | High |
| 18  | Get customer with invalid UUID format | GET | customerID: invalid-uuid | `{ "message": "Invalid customer ID format" }` | 400 Bad Request | Medium |
| 19  | Get customer without authentication | GET | customerID: valid-uuid | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 20  | Get customer with insufficient permissions | GET | customerID: valid-uuid | `{ "message": "Insufficient permissions" }` | 403 Forbidden | High |

---

## GET ALL ADMINS Test Cases

| No  | Test Case Description | Method | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ----------------- | ----------- | -------- |
| 21  | Get all admins with valid admin token | GET | `{ "message": "Admins retrieved successfully", "data": [{ "id": "uuid", "first_name": "System", "last_name": "Admin", "email_address": "admin@foodtrip.com", "user_type": "Admin", "created_at": "timestamp", "last_login": "timestamp", "status": "Active" }] }` | 200 OK | High |
| 22  | Get admins when none exist | GET | `{ "message": "Admins retrieved successfully", "data": [] }` | 200 OK | Low |
| 23  | Get admins without authentication | GET | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 24  | Get admins with non-admin token | GET | `{ "message": "Insufficient permissions" }` | 403 Forbidden | High |

---

## GET SPECIFIC ADMIN Test Cases

| No  | Test Case Description | Method | URL Parameter | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ----------------- | ----------- | -------- |
| 25  | Get existing admin by valid ID | GET | adminID: valid-uuid | `{ "message": "Admin retrieved successfully", "data": { "id": "uuid", "first_name": "System", "last_name": "Admin", "email_address": "admin@foodtrip.com", "user_type": "Admin", "created_at": "timestamp", "updated_at": "timestamp", "last_login": "timestamp", "status": "Active", "permissions": [...] } }` | 200 OK | High |
| 26  | Get admin with non-existent ID | GET | adminID: non-existent-uuid | `{ "message": "Admin not found" }` | 404 Not Found | High |
| 27  | Get admin with invalid UUID format | GET | adminID: invalid-uuid | `{ "message": "Invalid admin ID format" }` | 400 Bad Request | Medium |
| 28  | Get admin without authentication | GET | adminID: valid-uuid | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 29  | Get admin with insufficient permissions | GET | adminID: valid-uuid | `{ "message": "Insufficient permissions" }` | 403 Forbidden | High |

---

## SEARCH AND FILTER Test Cases

| No  | Test Case Description | Method | Query Parameters | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ---------------- | ----------------- | ----------- | -------- |
| 30  | Search customers by email | GET | `?search=customer@foodtrip.com` | `{ "message": "Customers retrieved successfully", "data": [filtered results] }` | 200 OK | Medium |
| 31  | Filter customers by gender | GET | `?gender=Female` | `{ "message": "Customers retrieved successfully", "data": [filtered results] }` | 200 OK | Low |
| 32  | Filter resto admins by restaurant status | GET | `?restaurant_status=Open` | `{ "message": "Resto admins retrieved successfully", "data": [filtered results] }` | 200 OK | Low |
| 33  | Search with no results | GET | `?search=nonexistent@email.com` | `{ "message": "Customers retrieved successfully", "data": [] }` | 200 OK | Medium |
| 34  | Invalid search parameters | GET | `?search=` | `{ "message": "Customers retrieved successfully", "data": [all results] }` | 200 OK | Low |

---

## Test Data Setup

### Prerequisites:
1. System Admin user authenticated with valid JWT token
2. Sample users of different types in database
3. Restaurants associated with resto admins
4. Customer order history for comprehensive data

### Sample Test Data:
```json
{
  "admin_user": {
    "id": "admin-uuid",
    "email": "testadmin@foodtrip.com",
    "user_type": "Admin",
    "status": "Active"
  },
  "resto_admins": [
    {
      "id": "resto-admin-1-uuid",
      "first_name": "John",
      "last_name": "Doe",
      "email": "restoadmin1@foodtrip.com",
      "resto_id": "restaurant-1-uuid"
    }
  ],
  "customers": [
    {
      "id": "customer-1-uuid",
      "first_name": "Jane",
      "last_name": "Smith",
      "email": "customer1@foodtrip.com",
      "phone_number": "09123456789",
      "gender": "Female"
    }
  ],
  "other_admins": [
    {
      "id": "admin-2-uuid",
      "first_name": "System",
      "last_name": "Administrator",
      "email": "admin2@foodtrip.com"
    }
  ]
}
```

---

## Response Validation Checklist

### For Successful List Operations (200 OK):
- ✅ Response contains `message` field
- ✅ Response contains `data` array
- ✅ Each user object has required fields
- ✅ User IDs are valid UUIDs
- ✅ Email formats are valid
- ✅ User types match expected values
- ✅ Timestamps are properly formatted
- ✅ Sensitive data (passwords) not included
- ✅ Related data (restaurants, orders) included where appropriate

### For Successful Single User Operations (200 OK):
- ✅ Response contains `message` field
- ✅ Response contains `data` object
- ✅ Complete user profile information
- ✅ Related entities properly populated
- ✅ Calculated fields (total_orders, total_spent) accurate

### For Authorization Errors (401/403):
- ✅ Proper authentication verification
- ✅ Role-based access control
- ✅ Generic error messages
- ✅ No sensitive data exposure

### For Not Found Errors (404):
- ✅ Clear error messages
- ✅ No data leakage
- ✅ Consistent response format

---

## Security Considerations

### Access Control:
- 🔐 Only system admins can access user management endpoints
- 🔐 JWT token validation on all requests
- 🔐 Role-based permission checking
- 🔐 No cross-role data access

### Data Protection:
- 🛡️ Passwords never included in responses
- 🛡️ Sensitive personal data properly masked
- 🛡️ Audit logging for admin actions
- 🛡️ Rate limiting for admin endpoints
- 🛡️ Input validation for search parameters

### Privacy Compliance:
- 🔒 Customer data access logging
- 🔒 Data minimization in responses
- 🔒 Proper data retention policies
- 🔒 GDPR compliance considerations

---

## Business Rules Validation

### User Management Rules:
- ✅ Admin can view all user types
- ✅ User types properly categorized
- ✅ Restaurant relationships maintained
- ✅ User status tracking accurate
- ✅ Order history calculations correct

### Data Relationships:
- ✅ Resto admins linked to restaurants
- ✅ Customers linked to addresses and orders
- ✅ Admin permissions properly defined
- ✅ Cascading data relationships maintained

---

## Performance Benchmarks

| Operation | Target Response Time | Notes |
|-----------|---------------------|--------|
| Get All Users (any type) | < 2 seconds | With pagination |
| Get Single User | < 500ms | Direct lookup with joins |
| Search Users | < 3 seconds | Full-text search |
| Filter Users | < 2 seconds | Indexed field filtering |

---

## Pagination and Sorting

### Pagination Parameters:
- `page`: Page number (default: 1)
- `limit`: Items per page (default: 10, max: 100)
- `sort`: Sort field (default: created_at)
- `order`: Sort direction (asc/desc, default: desc)

### Search Parameters:
- `search`: Text search across name and email fields
- `status`: Filter by user status
- `created_from`: Filter by creation date range
- `created_to`: Filter by creation date range

---

## Automation Notes

### High Priority for Automation:
- Basic retrieval operations (Test cases 1, 6, 11, 16, 21, 25)
- Authentication checks (Test cases 3, 9, 14, 19, 23, 28)
- Permission validation (Test cases 4, 10, 15, 20, 24, 29)

### Test Data Management:
- Create test users of each type
- Establish proper relationships (resto admins ↔ restaurants)
- Generate realistic order history for customers
- Cleanup test data after execution

### CI/CD Integration:
- Include in admin functionality test suite
- Monitor user management performance
- Track data consistency across user types
- Validate security controls regularly

### Mock Data Requirements:
- Minimum 10 users of each type for list testing
- Various user statuses (Active, Inactive, Suspended)
- Different creation dates for sorting tests
- Realistic names and emails for search tests
