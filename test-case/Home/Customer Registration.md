# Test Cases: Customer Registration API

**Endpoint:** `POST {{base_url}}/api/v1/home/register/customer`

## Test Case Overview
This endpoint handles customer registration and creates a new customer account in the system.

---

## Test Cases

| No  | Test Case Description | Method | Request Body | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------ | ----------------- | ----------- | -------- |
| 1   | Successful customer registration with all required fields | POST | `{ "password": "SecurePass@123", "first_name": "John", "middle_name": "Michael", "last_name": "Doe", "email_address": "john.doe@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Customer registered successfully", "data": { "id": "uuid", "first_name": "John", "last_name": "Doe", "email_address": "john.doe@gmail.com", "user_type": "Customer", "created_at": "timestamp" } }` | 201 Created | High |
| 2   | Registration with minimum required fields only | POST | `{ "password": "Pass@123", "first_name": "Jane", "last_name": "Smith", "email_address": "jane.smith@gmail.com", "phone_number": "09111111111", "gender": "Female", "user_type": "Customer" }` | `{ "message": "Customer registered successfully", "data": { ... } }` | 201 Created | High |
| 3   | Registration with duplicate email address | POST | `{ "password": "SecurePass@123", "first_name": "John", "last_name": "Doe", "email_address": "existing@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Registration failed", "errors": { "email_address": ["Email address already exists"] } }` | 422 Unprocessable Entity | High |
| 4   | Registration with invalid email format | POST | `{ "password": "SecurePass@123", "first_name": "John", "last_name": "Doe", "email_address": "invalid-email-format", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "email_address": ["Invalid email format"] } }` | 400 Bad Request | Medium |
| 5   | Registration with weak password | POST | `{ "password": "123", "first_name": "John", "last_name": "Doe", "email_address": "john.weak@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "password": ["Password must be at least 8 characters with uppercase, lowercase, number and special character"] } }` | 400 Bad Request | High |
| 6   | Registration with missing required field - email | POST | `{ "password": "SecurePass@123", "first_name": "John", "last_name": "Doe", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "email_address": ["Email address is required"] } }` | 400 Bad Request | High |
| 7   | Registration with missing required field - password | POST | `{ "first_name": "John", "last_name": "Doe", "email_address": "john.nopass@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "password": ["Password is required"] } }` | 400 Bad Request | High |
| 8   | Registration with missing required field - first_name | POST | `{ "password": "SecurePass@123", "last_name": "Doe", "email_address": "john.nofirst@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "first_name": ["First name is required"] } }` | 400 Bad Request | Medium |
| 9   | Registration with missing required field - last_name | POST | `{ "password": "SecurePass@123", "first_name": "John", "email_address": "john.nolast@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "last_name": ["Last name is required"] } }` | 400 Bad Request | Medium |
| 10  | Registration with invalid phone number format | POST | `{ "password": "SecurePass@123", "first_name": "John", "last_name": "Doe", "email_address": "john.phone@gmail.com", "phone_number": "invalid-phone", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "phone_number": ["Invalid phone number format"] } }` | 400 Bad Request | Medium |
| 11  | Registration with invalid gender value | POST | `{ "password": "SecurePass@123", "first_name": "John", "last_name": "Doe", "email_address": "john.gender@gmail.com", "phone_number": "09123456789", "gender": "InvalidGender", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "gender": ["Gender must be Male, Female, or Others"] } }` | 400 Bad Request | Medium |
| 12  | Registration with names containing numbers | POST | `{ "password": "SecurePass@123", "first_name": "John123", "last_name": "Doe456", "email_address": "john.numbers@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "first_name": ["Name cannot contain numbers"], "last_name": ["Name cannot contain numbers"] } }` | 400 Bad Request | Medium |
| 13  | Registration with extremely long names | POST | `{ "password": "SecurePass@123", "first_name": "VeryLongFirstNameThatExceedsMaximumLength".repeat(10), "last_name": "VeryLongLastNameThatExceedsMaximumLength".repeat(10), "email_address": "john.long@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "first_name": ["First name too long"], "last_name": ["Last name too long"] } }` | 400 Bad Request | Low |
| 14  | Registration with special characters in names | POST | `{ "password": "SecurePass@123", "first_name": "John@#$", "last_name": "Doe!%^", "email_address": "john.special@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "first_name": ["Name can only contain letters"], "last_name": ["Name can only contain letters"] } }` | 400 Bad Request | Medium |
| 15  | Registration with SQL injection attempt | POST | `{ "password": "SecurePass@123", "first_name": "'; DROP TABLE users; --", "last_name": "Doe", "email_address": "john.sql@gmail.com", "phone_number": "09123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "first_name": ["Name can only contain letters"] } }` | 400 Bad Request | High |
| 16  | Registration with empty string values | POST | `{ "password": "", "first_name": "", "last_name": "", "email_address": "", "phone_number": "", "gender": "", "user_type": "Customer" }` | `{ "message": "Validation failed", "errors": { "password": ["Password is required"], "first_name": ["First name is required"], "last_name": ["Last name is required"], "email_address": ["Email address is required"], "phone_number": ["Phone number is required"], "gender": ["Gender is required"] } }` | 400 Bad Request | Medium |
| 17  | Registration with malformed JSON | POST | `{ "password": "SecurePass@123", "first_name": "John", "last_name": "Doe" ` | `{ "message": "Invalid JSON format" }` | 400 Bad Request | Medium |
| 18  | Registration with valid international phone number | POST | `{ "password": "SecurePass@123", "first_name": "John", "last_name": "Doe", "email_address": "john.intl@gmail.com", "phone_number": "+639123456789", "gender": "Male", "user_type": "Customer" }` | `{ "message": "Customer registered successfully", "data": { ... } }` | 201 Created | Low |
| 19  | Registration with hyphenated names | POST | `{ "password": "SecurePass@123", "first_name": "Mary-Jane", "last_name": "Smith-Johnson", "email_address": "mary.jane@gmail.com", "phone_number": "09123456789", "gender": "Female", "user_type": "Customer" }` | `{ "message": "Customer registered successfully", "data": { ... } }` | 201 Created | Low |
| 20  | Registration with gender as "Others" | POST | `{ "password": "SecurePass@123", "first_name": "Alex", "last_name": "Taylor", "email_address": "alex.taylor@gmail.com", "phone_number": "09123456789", "gender": "Others", "user_type": "Customer" }` | `{ "message": "Customer registered successfully", "data": { ... } }` | 201 Created | Medium |

---

## Test Data Setup

### Prerequisites:
1. Ensure email uniqueness validation is active
2. Setup password strength requirements
3. Configure phone number format validation

### Existing Test Data:
```json
{
  "existing_user": {
    "email_address": "existing@gmail.com",
    "user_type": "Customer"
  }
}
```

### Test Environment Variables:
- `{{base_url}}`: API base URL

---

## Response Validation Checklist

### For Successful Registration (201 Created):
- ✅ Response contains `message` field
- ✅ Response contains `data` object with user info
- ✅ `data.id` is a valid UUID
- ✅ `data.user_type` equals "Customer"
- ✅ `data.email_address` matches request
- ✅ Password is not included in response
- ✅ `created_at` timestamp is present
- ✅ Response time < 3 seconds

### For Validation Errors (400 Bad Request):
- ✅ Response contains `message` field
- ✅ Response contains `errors` object
- ✅ Field-specific error messages
- ✅ No sensitive data exposed

### For Duplicate Email (422 Unprocessable Entity):
- ✅ Response contains appropriate error message
- ✅ Error indicates email conflict
- ✅ No existing user data exposed

---

## Security Considerations

### Data Protection:
- 🔐 Password is hashed before storage
- 🔐 Password never returned in response
- 🔐 Input sanitization for all fields
- 🔐 SQL injection prevention
- 🔐 XSS prevention

### Validation Security:
- 🛡️ Strong password requirements
- 🛡️ Email format validation
- 🛡️ Phone number format validation
- 🛡️ Name character restrictions
- 🛡️ Length limitations enforced

---

## Business Rules Validation

### Required Fields:
- ✅ password, first_name, last_name, email_address, phone_number, gender, user_type

### Optional Fields:
- ✅ middle_name (can be empty or null)

### Format Requirements:
- 📧 Email: Valid email format
- 📱 Phone: Philippine mobile format (09XXXXXXXXX) or international
- 👤 Names: Letters, spaces, hyphens only
- 🔑 Password: Min 8 chars, uppercase, lowercase, number, special char
- ⚧ Gender: "Male", "Female", or "Others"

---

## Performance Benchmarks

| Metric | Target | Notes |
|--------|--------|-------|
| Response Time | < 3 seconds | Including password hashing |
| Concurrent Registrations | 50+ | Without conflicts |
| Database Transactions | ≤ 2 | Per registration |
| Memory Usage | < 100MB | Per request |

---

## Automation Notes

### High Priority for Automation:
- Test cases 1, 2 (successful registration)
- Test cases 3, 6, 7 (duplicate email, required fields)
- Test case 5 (password validation)

### Test Data Management:
- Generate unique emails for each test run
- Cleanup test users after execution
- Use test-specific database or cleanup procedures

### CI/CD Integration:
- Include in regression test suite
- Monitor registration success rates
- Track validation rule effectiveness
