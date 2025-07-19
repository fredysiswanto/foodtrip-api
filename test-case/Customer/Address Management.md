# Test Cases: Customer Address Management API

**Endpoint:** `POST {{base_url}}/api/v1/customer/address/` (Create Address)
**Endpoint:** `GET {{base_url}}/api/v1/customer/address/` (Get All Addresses)
**Endpoint:** `GET {{base_url}}/api/v1/customer/address/:addressID` (Get Specific Address)
**Endpoint:** `PUT {{base_url}}/api/v1/customer/address/:addressID` (Update Address)
**Endpoint:** `DELETE {{base_url}}/api/v1/customer/address/:addressID` (Delete Address)

## Test Case Overview
These endpoints handle customer address management including creation, retrieval, updating, and deletion of delivery addresses.

---

## Authentication Setup
**Required:** Bearer token for Customer role
```
Authorization: Bearer {{customer_token}}
```

---

## CREATE ADDRESS Test Cases

| No  | Test Case Description | Method | Request Body | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------ | ----------------- | ----------- | -------- |
| 1   | Create address with all required fields | POST | `{ "address_1": "123 Main Street", "address_2": "Apartment 4B", "barangay": "Poblacion", "city": "Makati City", "province": "Metro Manila", "region": "NCR", "zip_code": "1200", "phone_number": "09123456789", "full_name": "John Michael Doe", "is_default": "1" }` | `{ "message": "Address created successfully", "data": { "id": "uuid", "address_1": "123 Main Street", "is_default": true, "created_at": "timestamp" } }` | 201 Created | High |
| 2   | Create address without optional address_2 | POST | `{ "address_1": "456 Oak Avenue", "barangay": "San Antonio", "city": "Pasig City", "province": "Metro Manila", "region": "NCR", "zip_code": "1600", "phone_number": "09987654321", "full_name": "Jane Smith", "is_default": "0" }` | `{ "message": "Address created successfully", "data": { ... } }` | 201 Created | Medium |
| 3   | Create first address (should auto-set as default) | POST | `{ "address_1": "789 Pine Road", "barangay": "Bagong Silang", "city": "Quezon City", "province": "Metro Manila", "region": "NCR", "zip_code": "1100", "phone_number": "09111222333", "full_name": "Bob Johnson", "is_default": "0" }` | `{ "message": "Address created successfully", "data": { "is_default": true } }` | 201 Created | High |
| 4   | Create address with missing required field - address_1 | POST | `{ "barangay": "Poblacion", "city": "Makati City", "province": "Metro Manila", "region": "NCR", "zip_code": "1200", "phone_number": "09123456789", "full_name": "John Doe", "is_default": "1" }` | `{ "message": "Validation failed", "errors": { "address_1": ["Address line 1 is required"] } }` | 400 Bad Request | High |
| 5   | Create address with invalid zip code format | POST | `{ "address_1": "123 Main Street", "barangay": "Poblacion", "city": "Makati City", "province": "Metro Manila", "region": "NCR", "zip_code": "invalid", "phone_number": "09123456789", "full_name": "John Doe", "is_default": "1" }` | `{ "message": "Validation failed", "errors": { "zip_code": ["Invalid zip code format"] } }` | 400 Bad Request | Medium |
| 6   | Create address with invalid phone number | POST | `{ "address_1": "123 Main Street", "barangay": "Poblacion", "city": "Makati City", "province": "Metro Manila", "region": "NCR", "zip_code": "1200", "phone_number": "invalid-phone", "full_name": "John Doe", "is_default": "1" }` | `{ "message": "Validation failed", "errors": { "phone_number": ["Invalid phone number format"] } }` | 400 Bad Request | Medium |
| 7   | Create address without authentication | POST | `{ "address_1": "123 Main Street", ... }` | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 8   | Create address with extremely long address text | POST | `{ "address_1": "Very long address...".repeat(100), ... }` | `{ "message": "Validation failed", "errors": { "address_1": ["Address too long"] } }` | 400 Bad Request | Low |

---

## GET ALL ADDRESSES Test Cases

| No  | Test Case Description | Method | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ----------------- | ----------- | -------- |
| 9   | Get all addresses for authenticated customer | GET | `{ "message": "Addresses retrieved successfully", "data": [{ "id": "uuid", "address_1": "123 Main Street", "is_default": true, ... }] }` | 200 OK | High |
| 10  | Get addresses when no addresses exist | GET | `{ "message": "Addresses retrieved successfully", "data": [] }` | 200 OK | Medium |
| 11  | Get addresses without authentication | GET | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |

---

## GET SPECIFIC ADDRESS Test Cases

| No  | Test Case Description | Method | URL Parameter | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ----------------- | ----------- | -------- |
| 12  | Get existing address by valid ID | GET | addressID: valid-uuid | `{ "message": "Address retrieved successfully", "data": { "id": "uuid", "address_1": "123 Main Street", ... } }` | 200 OK | High |
| 13  | Get address with non-existent ID | GET | addressID: non-existent-uuid | `{ "message": "Address not found" }` | 404 Not Found | High |
| 14  | Get address with invalid UUID format | GET | addressID: invalid-uuid | `{ "message": "Invalid address ID format" }` | 400 Bad Request | Medium |
| 15  | Get address belonging to another customer | GET | addressID: other-customer-address-id | `{ "message": "Address not found" }` | 404 Not Found | High |

---

## UPDATE ADDRESS Test Cases

| No  | Test Case Description | Method | URL Parameter | Request Body | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ------------ | ----------------- | ----------- | -------- |
| 16  | Update address with valid data | PUT | addressID: valid-uuid | `{ "address_1": "Updated Main Street", "address_2": "Unit 5C", "barangay": "Updated Barangay", "city": "Updated City", "province": "Updated Province", "region": "NCR", "zip_code": "1234", "phone_number": "09999888777", "full_name": "Updated Name" }` | `{ "message": "Address updated successfully", "data": { "id": "uuid", "address_1": "Updated Main Street", "updated_at": "timestamp" } }` | 200 OK | High |
| 17  | Update address with partial data | PUT | addressID: valid-uuid | `{ "address_1": "Partially Updated Street", "phone_number": "09888777666" }` | `{ "message": "Address updated successfully", "data": { ... } }` | 200 OK | Medium |
| 18  | Update non-existent address | PUT | addressID: non-existent-uuid | `{ "address_1": "Updated Street" }` | `{ "message": "Address not found" }` | 404 Not Found | High |
| 19  | Update address with invalid data | PUT | addressID: valid-uuid | `{ "zip_code": "invalid-zip" }` | `{ "message": "Validation failed", "errors": { "zip_code": ["Invalid zip code format"] } }` | 400 Bad Request | Medium |
| 20  | Update another customer's address | PUT | addressID: other-customer-address-id | `{ "address_1": "Hacked Street" }` | `{ "message": "Address not found" }` | 404 Not Found | High |

---

## DELETE ADDRESS Test Cases

| No  | Test Case Description | Method | URL Parameter | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ----------------- | ----------- | -------- |
| 21  | Delete non-default address | DELETE | addressID: non-default-address-uuid | `{ "message": "Address deleted successfully" }` | 204 No Content | High |
| 22  | Delete default address when other addresses exist | DELETE | addressID: default-address-uuid | `{ "message": "Cannot delete default address. Set another address as default first." }` | 400 Bad Request | High |
| 23  | Delete last remaining address | DELETE | addressID: last-address-uuid | `{ "message": "Address deleted successfully" }` | 204 No Content | Medium |
| 24  | Delete non-existent address | DELETE | addressID: non-existent-uuid | `{ "message": "Address not found" }` | 404 Not Found | High |
| 25  | Delete another customer's address | DELETE | addressID: other-customer-address-id | `{ "message": "Address not found" }` | 404 Not Found | High |

---

## SET DEFAULT ADDRESS Test Cases

| No  | Test Case Description | Method | URL Parameter | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ----------------- | ----------- | -------- |
| 26  | Set existing address as default | PUT | addressID: valid-address-uuid | `{ "message": "Default address updated successfully", "data": { "id": "uuid", "is_default": true } }` | 200 OK | High |
| 27  | Set non-existent address as default | PUT | addressID: non-existent-uuid | `{ "message": "Address not found" }` | 404 Not Found | High |
| 28  | Set another customer's address as default | PUT | addressID: other-customer-address-id | `{ "message": "Address not found" }` | 404 Not Found | High |

---

## Test Data Setup

### Prerequisites:
1. Customer user authenticated with valid JWT token
2. Test addresses in database for update/delete operations
3. Multiple customers for cross-customer access tests

### Sample Test Addresses:
```json
{
  "customer_addresses": [
    {
      "id": "default-address-uuid",
      "address_1": "123 Test Street",
      "city": "Test City",
      "is_default": true,
      "customer_id": "test-customer-uuid"
    },
    {
      "id": "non-default-address-uuid", 
      "address_1": "456 Another Street",
      "city": "Another City",
      "is_default": false,
      "customer_id": "test-customer-uuid"
    }
  ]
}
```

---

## Response Validation Checklist

### For Successful Operations (200/201):
- ✅ Response contains `message` field
- ✅ Response contains `data` object
- ✅ Address ID is valid UUID
- ✅ Default address logic works correctly
- ✅ Timestamps are properly formatted
- ✅ Customer ID matches authenticated user

### For Validation Errors (400):
- ✅ Specific field validation messages
- ✅ Multiple error fields handled
- ✅ No sensitive data exposed

### For Authorization Errors (401/404):
- ✅ Generic error messages
- ✅ No data leakage about other customers
- ✅ Proper authentication verification

---

## Security Considerations

### Access Control:
- 🔐 Customer can only access own addresses
- 🔐 JWT token validation on all requests
- 🔐 Address ID ownership verification
- 🔐 Cross-customer data protection

### Data Validation:
- 🛡️ Input sanitization for all fields
- 🛡️ Address format validation
- 🛡️ Phone number format validation
- 🛡️ ZIP code format validation
- 🛡️ Length limits on all text fields

---

## Business Rules Validation

### Default Address Rules:
- ✅ First address automatically becomes default
- ✅ Cannot delete default address if others exist
- ✅ Setting new default removes previous default
- ✅ Must have at least one address if any exist

### Field Requirements:
- **Required:** address_1, barangay, city, province, region, zip_code, phone_number, full_name
- **Optional:** address_2, is_default

---

## Performance Benchmarks

| Operation | Target Response Time | Notes |
|-----------|---------------------|--------|
| Create Address | < 2 seconds | Including validation |
| Get All Addresses | < 1 second | With reasonable pagination |
| Get Single Address | < 500ms | Direct lookup |
| Update Address | < 2 seconds | Including validation |
| Delete Address | < 1 second | Including cascade checks |

---

## Automation Notes

### High Priority for Automation:
- CRUD operations (Test cases 1, 9, 12, 16, 21)
- Authentication checks (Test cases 7, 11, 15, 20, 25)
- Default address logic (Test cases 3, 22, 26)

### Test Data Management:
- Create test addresses for each test run
- Cleanup addresses after test completion
- Ensure test isolation between customers

### CI/CD Integration:
- Include in customer journey test suite
- Monitor address management success rates
- Track performance metrics for address operations
