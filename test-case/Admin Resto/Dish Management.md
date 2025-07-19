# Test Cases: Resto Admin Dish Management API

**Endpoints:**
- `POST {{base_url}}/api/v1/resto-admin/dish` (Create Dish)
- `GET {{base_url}}/api/v1/resto-admin/dishes/:restoID` (Get All Dishes)
- `GET {{base_url}}/api/v1/resto-admin/dish/:dishID` (Get Specific Dish)
- `PUT {{base_url}}/api/v1/resto-admin/dish/:dishID` (Update Dish)
- `DELETE {{base_url}}/api/v1/resto-admin/dish/:dishID` (Delete Dish)

## Test Case Overview
These endpoints handle dish management for restaurant administrators including creation, retrieval, updating, and deletion of menu items.

---

## Authentication Setup
**Required:** Bearer token for Resto_Admin role
```
Authorization: Bearer {{resto_admin_token}}
```

---

## CREATE DISH Test Cases

| No  | Test Case Description | Method | Request Body (Form Data) | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------------------ | ----------------- | ----------- | -------- |
| 1   | Create dish with all required fields | POST | `dish_name: "Chicken Adobo", dish_desc: "Traditional Filipino chicken dish", dish_price: "299.00", status: "Available", dishcatg_id: "valid-category-uuid", resto_id: "valid-resto-uuid", dish_img: [image file]` | `{ "message": "Dish created successfully", "data": { "id": "uuid", "dish_name": "Chicken Adobo", "dish_price": 299.00, "status": "Available", "created_at": "timestamp" } }` | 201 Created | High |
| 2   | Create dish without image | POST | `dish_name: "Beef Steak", dish_desc: "Tender beef with onions", dish_price: "450.00", status: "Available", dishcatg_id: "valid-category-uuid", resto_id: "valid-resto-uuid"` | `{ "message": "Dish created successfully", "data": { ... } }` | 201 Created | Medium |
| 3   | Create dish with invalid price format | POST | `dish_name: "Fish Fillet", dish_desc: "Fresh fish", dish_price: "invalid-price", status: "Available", dishcatg_id: "valid-category-uuid", resto_id: "valid-resto-uuid"` | `{ "message": "Validation failed", "errors": { "dish_price": ["Price must be a valid number"] } }` | 400 Bad Request | High |
| 4   | Create dish with negative price | POST | `dish_name: "Pork Chop", dish_desc: "Grilled pork", dish_price: "-100.00", status: "Available", dishcatg_id: "valid-category-uuid", resto_id: "valid-resto-uuid"` | `{ "message": "Validation failed", "errors": { "dish_price": ["Price must be greater than 0"] } }` | 400 Bad Request | Medium |
| 5   | Create dish with missing required field - dish_name | POST | `dish_desc: "Mystery dish", dish_price: "200.00", status: "Available", dishcatg_id: "valid-category-uuid", resto_id: "valid-resto-uuid"` | `{ "message": "Validation failed", "errors": { "dish_name": ["Dish name is required"] } }` | 400 Bad Request | High |
| 6   | Create dish with invalid category ID | POST | `dish_name: "Pizza", dish_desc: "Cheesy pizza", dish_price: "350.00", status: "Available", dishcatg_id: "invalid-uuid", resto_id: "valid-resto-uuid"` | `{ "message": "Validation failed", "errors": { "dishcatg_id": ["Invalid dish category"] } }` | 400 Bad Request | High |
| 7   | Create dish for restaurant not owned by admin | POST | `dish_name: "Unauthorized Dish", dish_desc: "Should not be created", dish_price: "100.00", status: "Available", dishcatg_id: "valid-category-uuid", resto_id: "other-resto-uuid"` | `{ "message": "Unauthorized access to restaurant" }` | 403 Forbidden | High |
| 8   | Create dish without authentication | POST | `dish_name: "No Auth Dish", ...` | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 9   | Create dish with invalid image format | POST | `dish_name: "Image Test", dish_desc: "Testing image", dish_price: "100.00", status: "Available", dishcatg_id: "valid-category-uuid", resto_id: "valid-resto-uuid", dish_img: [.txt file]` | `{ "message": "Validation failed", "errors": { "dish_img": ["Invalid image format. Only JPG, PNG, GIF allowed"] } }` | 400 Bad Request | Medium |
| 10  | Create dish with oversized image | POST | `dish_name: "Large Image", ..., dish_img: [10MB+ image]` | `{ "message": "Validation failed", "errors": { "dish_img": ["Image size must be less than 5MB"] } }` | 400 Bad Request | Medium |

---

## GET ALL DISHES Test Cases

| No  | Test Case Description | Method | URL Parameter | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ----------------- | ----------- | -------- |
| 11  | Get all dishes for owned restaurant | GET | restoID: owned-resto-uuid | `{ "message": "Dishes retrieved successfully", "data": [{ "id": "uuid", "dish_name": "Chicken Adobo", "dish_price": 299.00, "status": "Available", ... }] }` | 200 OK | High |
| 12  | Get dishes for restaurant with no dishes | GET | restoID: empty-resto-uuid | `{ "message": "Dishes retrieved successfully", "data": [] }` | 200 OK | Medium |
| 13  | Get dishes for non-owned restaurant | GET | restoID: other-resto-uuid | `{ "message": "Unauthorized access to restaurant" }` | 403 Forbidden | High |
| 14  | Get dishes with invalid restaurant ID | GET | restoID: invalid-uuid | `{ "message": "Invalid restaurant ID format" }` | 400 Bad Request | Medium |
| 15  | Get dishes without authentication | GET | restoID: valid-resto-uuid | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |

---

## GET SPECIFIC DISH Test Cases

| No  | Test Case Description | Method | URL Parameter | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ----------------- | ----------- | -------- |
| 16  | Get existing dish by valid ID | GET | dishID: owned-dish-uuid | `{ "message": "Dish retrieved successfully", "data": { "id": "uuid", "dish_name": "Chicken Adobo", "dish_desc": "...", "dish_price": 299.00, "status": "Available", "restaurant": {...}, "category": {...} } }` | 200 OK | High |
| 17  | Get dish not owned by admin | GET | dishID: other-resto-dish-uuid | `{ "message": "Dish not found" }` | 404 Not Found | High |
| 18  | Get non-existent dish | GET | dishID: non-existent-uuid | `{ "message": "Dish not found" }` | 404 Not Found | High |
| 19  | Get dish with invalid UUID format | GET | dishID: invalid-uuid | `{ "message": "Invalid dish ID format" }` | 400 Bad Request | Medium |

---

## UPDATE DISH Test Cases

| No  | Test Case Description | Method | URL Parameter | Request Body (Form Data) | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ------------------------ | ----------------- | ----------- | -------- |
| 20  | Update dish with valid data | PUT | dishID: owned-dish-uuid | `dish_name: "Updated Chicken Adobo", dish_desc: "Updated description", dish_price: "320.00", status: "Available", dishcatg_id: "valid-category-uuid", resto_id: "owned-resto-uuid"` | `{ "message": "Dish updated successfully", "data": { "id": "uuid", "dish_name": "Updated Chicken Adobo", "dish_price": 320.00, "updated_at": "timestamp" } }` | 200 OK | High |
| 21  | Update dish with new image | PUT | dishID: owned-dish-uuid | `dish_name: "Chicken Adobo", ..., dish_img: [new image file]` | `{ "message": "Dish updated successfully", "data": { ... } }` | 200 OK | Medium |
| 22  | Update dish status to unavailable | PUT | dishID: owned-dish-uuid | `dish_name: "Chicken Adobo", ..., status: "Unavailable"` | `{ "message": "Dish updated successfully", "data": { "status": "Unavailable" } }` | 200 OK | High |
| 23  | Update dish with invalid price | PUT | dishID: owned-dish-uuid | `dish_name: "Chicken Adobo", ..., dish_price: "invalid"` | `{ "message": "Validation failed", "errors": { "dish_price": ["Price must be a valid number"] } }` | 400 Bad Request | Medium |
| 24  | Update non-owned dish | PUT | dishID: other-resto-dish-uuid | `dish_name: "Hacked Dish", ...` | `{ "message": "Dish not found" }` | 404 Not Found | High |
| 25  | Update non-existent dish | PUT | dishID: non-existent-uuid | `dish_name: "Ghost Dish", ...` | `{ "message": "Dish not found" }` | 404 Not Found | High |

---

## DELETE DISH Test Cases

| No  | Test Case Description | Method | URL Parameter | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------- | ----------------- | ----------- | -------- |
| 26  | Delete existing owned dish | DELETE | dishID: owned-dish-uuid | `{ "message": "Dish deleted successfully" }` | 204 No Content | High |
| 27  | Delete dish that's in active orders | DELETE | dishID: dish-with-orders-uuid | `{ "message": "Cannot delete dish with active orders" }` | 400 Bad Request | High |
| 28  | Delete non-owned dish | DELETE | dishID: other-resto-dish-uuid | `{ "message": "Dish not found" }` | 404 Not Found | High |
| 29  | Delete non-existent dish | DELETE | dishID: non-existent-uuid | `{ "message": "Dish not found" }` | 404 Not Found | Medium |
| 30  | Delete dish without authentication | DELETE | dishID: valid-dish-uuid | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |

---

## Test Data Setup

### Prerequisites:
1. Resto Admin user authenticated with valid JWT token
2. Restaurant owned by the resto admin
3. Valid dish categories in database
4. Test dishes for update/delete operations
5. Sample images for file upload tests

### Sample Test Data:
```json
{
  "resto_admin_user": {
    "id": "resto-admin-uuid",
    "email": "restoadmin@foodtrip.com",
    "resto_id": "owned-resto-uuid"
  },
  "restaurant": {
    "id": "owned-resto-uuid",
    "resto_name": "Test Restaurant",
    "status": "Open"
  },
  "dish_categories": [
    {
      "id": "main-course-uuid",
      "category_name": "Main Course"
    },
    {
      "id": "dessert-uuid",
      "category_name": "Desserts"
    }
  ],
  "existing_dishes": [
    {
      "id": "existing-dish-uuid",
      "dish_name": "Test Dish",
      "dish_price": 200.00,
      "resto_id": "owned-resto-uuid"
    }
  ]
}
```

---

## Response Validation Checklist

### For Successful Operations (200/201):
- ✅ Response contains `message` field
- ✅ Response contains `data` object
- ✅ Dish ID is valid UUID
- ✅ Price is formatted correctly (2 decimal places)
- ✅ Status values are valid ("Available"/"Unavailable")
- ✅ Timestamps are properly formatted
- ✅ Image URLs are accessible (if uploaded)

### For Validation Errors (400):
- ✅ Specific field validation messages
- ✅ Multiple error fields handled properly
- ✅ File upload error messages are clear

### For Authorization Errors (401/403):
- ✅ Proper authentication verification
- ✅ Restaurant ownership validation
- ✅ No data leakage about other restaurants

---

## Security Considerations

### Access Control:
- 🔐 Resto admin can only manage own restaurant's dishes
- 🔐 JWT token validation on all requests
- 🔐 Restaurant ownership verification
- 🔐 Cross-restaurant data protection

### File Upload Security:
- 🛡️ Image file type validation
- 🛡️ File size limitations
- 🛡️ Virus scanning for uploads
- 🛡️ Secure file storage paths
- 🛡️ Image processing sanitization

### Data Validation:
- 🛡️ Input sanitization for all fields
- 🛡️ Price format validation
- 🛡️ Category ID validation
- 🛡️ Status value validation
- 🛡️ Length limits on text fields

---

## Business Rules Validation

### Dish Management Rules:
- ✅ Cannot delete dishes with active orders
- ✅ Price must be positive number
- ✅ Dish must belong to valid category
- ✅ Status must be "Available" or "Unavailable"
- ✅ Restaurant must be owned by current admin

### Field Requirements:
- **Required:** dish_name, dish_desc, dish_price, status, dishcatg_id, resto_id
- **Optional:** dish_img
- **File Upload:** JPG, PNG, GIF formats only, max 5MB

---

## Performance Benchmarks

| Operation | Target Response Time | Notes |
|-----------|---------------------|--------|
| Create Dish | < 3 seconds | Including image upload/processing |
| Get All Dishes | < 2 seconds | With reasonable pagination |
| Get Single Dish | < 500ms | Direct lookup with joins |
| Update Dish | < 3 seconds | Including image processing |
| Delete Dish | < 1 second | Including relationship checks |

---

## Image Upload Specifications

### Supported Formats:
- JPG/JPEG
- PNG  
- GIF

### File Size Limits:
- Maximum: 5MB per image
- Recommended: 1-2MB for optimal performance

### Image Processing:
- Auto-resize to standard dimensions
- Compression for web optimization
- Generate multiple sizes (thumbnail, medium, large)

---

## Automation Notes

### High Priority for Automation:
- CRUD operations (Test cases 1, 11, 16, 20, 26)
- Authorization checks (Test cases 7, 13, 17, 24, 28)
- Validation errors (Test cases 3, 5, 6, 23)

### Test Data Management:
- Create test dishes for each test run
- Cleanup dishes and images after test completion
- Use test restaurant for isolation
- Generate test images programmatically

### CI/CD Integration:
- Include in restaurant management test suite
- Monitor dish management success rates
- Track image upload performance
- Validate image processing pipeline
