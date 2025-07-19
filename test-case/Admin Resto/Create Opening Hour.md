# Test Cases: Create Opening Hours API

**Endpoint:** `POST {{base_url}}/api/v1/resto-admin/restaurant/opening-hour`

## Test Case Overview
This endpoint handles creation of restaurant opening hours for restaurant administrators. Based on the Postman collection, it accepts an array of opening hour objects for multiple days.

---

## Authentication Setup
**Required:** Bearer token for Resto_Admin role
```
Authorization: Bearer {{resto_admin_token}}
```

---

## Test Cases

| No  | Test Case Description | Method | Request Body | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------ | ----------------- | ----------- | -------- |
| 1   | Create opening hours with valid data (single day) | POST | `[{ "day": "Monday", "open_time": "09:00:00", "close_time": "21:00:00" }]` | `{ "message": "Opening hours created successfully", "data": [{ "id": "uuid", "day": "Monday", "open_time": "09:00:00", "close_time": "21:00:00", "resto_id": "uuid", "created_at": "timestamp" }] }` | 201 Created | High |
| 2   | Create opening hours with multiple days | POST | `[{ "day": "Monday", "open_time": "09:00:00", "close_time": "21:00:00" }, { "day": "Thursday", "open_time": "06:00:00", "close_time": "21:00:00" }]` | `{ "message": "Opening hours created successfully", "data": [{ ... }, { ... }] }` | 201 Created | High |
| 3   | Create opening hours with all days of the week | POST | `[{ "day": "Monday", "open_time": "10:00:00", "close_time": "22:00:00" }, { "day": "Tuesday", "open_time": "10:00:00", "close_time": "22:00:00" }, { "day": "Wednesday", "open_time": "10:00:00", "close_time": "22:00:00" }, { "day": "Thursday", "open_time": "10:00:00", "close_time": "22:00:00" }, { "day": "Friday", "open_time": "10:00:00", "close_time": "23:00:00" }, { "day": "Saturday", "open_time": "09:00:00", "close_time": "23:00:00" }, { "day": "Sunday", "open_time": "09:00:00", "close_time": "21:00:00" }]` | `{ "message": "Opening hours created successfully", "data": [...] }` | 201 Created | Medium |
| 4   | Create opening hours with missing required field - day | POST | `[{ "open_time": "09:00:00", "close_time": "21:00:00" }]` | `{ "message": "Validation failed", "errors": { "day": ["Day is required"] } }` | 400 Bad Request | High |
| 5   | Create opening hours with missing required field - open_time | POST | `[{ "day": "Monday", "close_time": "21:00:00" }]` | `{ "message": "Validation failed", "errors": { "open_time": ["Open time is required"] } }` | 400 Bad Request | High |
| 6   | Create opening hours with missing required field - close_time | POST | `[{ "day": "Monday", "open_time": "09:00:00" }]` | `{ "message": "Validation failed", "errors": { "close_time": ["Close time is required"] } }` | 400 Bad Request | High |
| 7   | Create opening hours with invalid time format | POST | `[{ "day": "Monday", "open_time": "25:00:00", "close_time": "21:00:00" }]` | `{ "message": "Validation failed", "errors": { "open_time": ["Invalid time format. Use HH:MM:SS"] } }` | 400 Bad Request | Medium |
| 8   | Create opening hours with close time before open time | POST | `[{ "day": "Monday", "open_time": "22:00:00", "close_time": "08:00:00" }]` | `{ "message": "Validation failed", "errors": { "close_time": ["Close time must be after open time"] } }` | 400 Bad Request | High |
| 9   | Create opening hours with invalid day name | POST | `[{ "day": "Funday", "open_time": "09:00:00", "close_time": "21:00:00" }]` | `{ "message": "Validation failed", "errors": { "day": ["Day must be one of: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday"] } }` | 400 Bad Request | Medium |
| 10  | Create duplicate opening hours for same day | POST | `[{ "day": "Monday", "open_time": "09:00:00", "close_time": "21:00:00" }, { "day": "Monday", "open_time": "10:00:00", "close_time": "22:00:00" }]` | `{ "message": "Validation failed", "errors": { "day": ["Duplicate day entries not allowed"] } }` | 400 Bad Request | High |
| 11  | Create opening hours without authentication | POST | `[{ "day": "Monday", "open_time": "09:00:00", "close_time": "21:00:00" }]` | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 12  | Create opening hours with customer token | POST | `[{ "day": "Monday", "open_time": "09:00:00", "close_time": "21:00:00" }]` | `{ "message": "Insufficient permissions" }` | 403 Forbidden | High |
| 13  | Create opening hours for restaurant not owned by admin | POST | `[{ "day": "Monday", "open_time": "09:00:00", "close_time": "21:00:00" }]` | `{ "message": "Unauthorized access to restaurant" }` | 403 Forbidden | High |
| 14  | Create opening hours with empty array | POST | `[]` | `{ "message": "Validation failed", "errors": { "opening_hours": ["At least one opening hour entry is required"] } }` | 400 Bad Request | Medium |
| 15  | Create opening hours with malformed JSON | POST | `[{ "day": "Monday", "open_time": "09:00:00", "close_time": "21:00:00" ` | `{ "message": "Invalid JSON format" }` | 400 Bad Request | Medium |
| 16  | Create opening hours with same open and close time | POST | `[{ "day": "Monday", "open_time": "12:00:00", "close_time": "12:00:00" }]` | `{ "message": "Validation failed", "errors": { "close_time": ["Close time must be different from open time"] } }` | 400 Bad Request | Medium |
| 17  | Create opening hours spanning midnight (24-hour operation) | POST | `[{ "day": "Friday", "open_time": "00:00:00", "close_time": "23:59:59" }]` | `{ "message": "Opening hours created successfully", "data": [{ ... }] }` | 201 Created | Low |
| 18  | Create opening hours with seconds in time format | POST | `[{ "day": "Monday", "open_time": "09:30:45", "close_time": "21:15:30" }]` | `{ "message": "Opening hours created successfully", "data": [{ ... }] }` | 201 Created | Low |
| 19  | Create opening hours for restaurant that already has hours for that day | POST | `[{ "day": "Monday", "open_time": "09:00:00", "close_time": "21:00:00" }]` | `{ "message": "Validation failed", "errors": { "day": ["Opening hours for Monday already exist"] } }` | 409 Conflict | High |
| 20  | Create opening hours with case-insensitive day names | POST | `[{ "day": "MONDAY", "open_time": "09:00:00", "close_time": "21:00:00" }]` | `{ "message": "Opening hours created successfully", "data": [{ "day": "Monday", ... }] }` | 201 Created | Low |

---

## Test Data Setup

### Prerequisites:
1. Resto Admin user authenticated with valid JWT token
2. Restaurant owned by the resto admin
3. No existing opening hours for test days (for conflict testing)

### Sample Test Data:
```json
{
  "resto_admin_user": {
    "id": "resto-admin-uuid",
    "email": "testrestoadmin@foodtrip.com",
    "resto_id": "owned-resto-uuid"
  },
  "restaurant": {
    "id": "owned-resto-uuid",
    "resto_name": "Test Restaurant",
    "status": "Open"
  },
  "valid_days": [
    "Monday", "Tuesday", "Wednesday", "Thursday", 
    "Friday", "Saturday", "Sunday"
  ]
}
```

### Test Environment Variables:
- `{{base_url}}`: API base URL
- `{{resto_admin_token}}`: Valid JWT token for resto admin

---

## Response Validation Checklist

### For Successful Creation (201 Created):
- ✅ Response contains `message` field
- ✅ Response contains `data` array
- ✅ Each opening hour has valid UUID `id`
- ✅ Day names are properly formatted
- ✅ Time format is HH:MM:SS
- ✅ `resto_id` matches authenticated user's restaurant
- ✅ `created_at` timestamp is present
- ✅ Response time < 3 seconds

### For Validation Errors (400 Bad Request):
- ✅ Response contains `message` field
- ✅ Response contains `errors` object
- ✅ Field-specific error messages
- ✅ Multiple validation errors handled properly

### For Authorization Errors (401/403):
- ✅ Proper authentication verification
- ✅ Restaurant ownership validation
- ✅ Role-based access control
- ✅ Generic error messages for security

---

## Security Considerations

### Access Control:
- 🔐 Only resto admin can create opening hours
- 🔐 Resto admin can only manage own restaurant's hours
- 🔐 JWT token validation on all requests
- 🔐 Restaurant ownership verification

### Data Validation:
- 🛡️ Day name validation against allowed values
- 🛡️ Time format validation (HH:MM:SS)
- 🛡️ Logical time validation (close > open)
- 🛡️ Duplicate day prevention
- 🛡️ Input sanitization for all fields

---

## Business Rules Validation

### Opening Hours Rules:
- ✅ Days must be valid weekday names
- ✅ Time format must be HH:MM:SS (24-hour)
- ✅ Close time must be after open time
- ✅ No duplicate days in single request
- ✅ Cannot create duplicate opening hours for existing days
- ✅ Must belong to authenticated admin's restaurant

### Data Constraints:
- **Required Fields:** day, open_time, close_time
- **Day Values:** Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
- **Time Format:** HH:MM:SS (00:00:00 to 23:59:59)
- **Array:** Minimum 1 opening hour entry

---

## Performance Benchmarks

| Operation | Target Response Time | Notes |
|-----------|---------------------|--------|
| Create Single Day | < 1 second | Simple validation and insert |
| Create Multiple Days | < 2 seconds | Batch processing |
| Create Full Week | < 3 seconds | 7 day entries with validation |

---

## Automation Notes

### High Priority for Automation:
- Test cases 1, 2 (successful creation scenarios)
- Test cases 4, 5, 6 (required field validation)
- Test cases 8, 10, 19 (business logic validation)
- Test cases 11, 12, 13 (authorization checks)

### Test Data Management:
- Clean existing opening hours before each test
- Use test restaurant for isolation
- Generate unique test scenarios
- Cleanup after test completion

### CI/CD Integration:
- Include in restaurant management test suite
- Validate opening hours business logic
- Monitor creation performance
- Test timezone handling if applicable
