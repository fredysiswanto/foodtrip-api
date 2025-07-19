# Test Cases: Customer Login API

**Endpoint:** `POST {{base_url}}/api/v1/home/login`

## Test Case Overview
This endpoint handles customer authentication and returns JWT token for authorized access.

---

## Test Cases

| No  | Test Case Description | Method | Request Body | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------ | ----------------- | ----------- | -------- |
| 1   | Successful customer login with valid credentials | POST | `{ "email_address": "customer@foodtrip.com", "password": "Customer@123" }` | `{ "message": "Login successful", "data": { "token": "jwt_token_here", "user": { "id": "uuid", "name": "Customer Name", "email": "customer@foodtrip.com", "user_type": "Customer" } } }` | 200 OK | High |
| 2   | Login with invalid email format | POST | `{ "email_address": "invalid-email", "password": "Customer@123" }` | `{ "message": "Validation failed", "errors": { "email_address": ["Invalid email format"] } }` | 400 Bad Request | Medium |
| 3   | Login with non-existent email | POST | `{ "email_address": "nonexistent@foodtrip.com", "password": "Customer@123" }` | `{ "message": "Invalid credentials" }` | 401 Unauthorized | High |
| 4   | Login with incorrect password | POST | `{ "email_address": "customer@foodtrip.com", "password": "WrongPassword" }` | `{ "message": "Invalid credentials" }` | 401 Unauthorized | High |
| 5   | Login with empty email field | POST | `{ "email_address": "", "password": "Customer@123" }` | `{ "message": "Validation failed", "errors": { "email_address": ["Email is required"] } }` | 400 Bad Request | Medium |
| 6   | Login with empty password field | POST | `{ "email_address": "customer@foodtrip.com", "password": "" }` | `{ "message": "Validation failed", "errors": { "password": ["Password is required"] } }` | 400 Bad Request | Medium |
| 7   | Login with both fields empty | POST | `{ "email_address": "", "password": "" }` | `{ "message": "Validation failed", "errors": { "email_address": ["Email is required"], "password": ["Password is required"] } }` | 400 Bad Request | Medium |
| 8   | Login with SQL injection attempt | POST | `{ "email_address": "admin@foodtrip.com'; DROP TABLE users; --", "password": "Customer@123" }` | `{ "message": "Invalid credentials" }` | 401 Unauthorized | High |
| 9   | Login with XSS attempt in email | POST | `{ "email_address": "<script>alert('xss')</script>@foodtrip.com", "password": "Customer@123" }` | `{ "message": "Validation failed", "errors": { "email_address": ["Invalid email format"] } }` | 400 Bad Request | High |
| 10  | Login with extremely long email (> 255 chars) | POST | `{ "email_address": "very_long_email_address_that_exceeds_maximum_length_limit_" + "a".repeat(200) + "@foodtrip.com", "password": "Customer@123" }` | `{ "message": "Validation failed", "errors": { "email_address": ["Email too long"] } }` | 400 Bad Request | Low |
| 11  | Login with extremely long password (> 255 chars) | POST | `{ "email_address": "customer@foodtrip.com", "password": "very_long_password_" + "a".repeat(250) }` | `{ "message": "Validation failed", "errors": { "password": ["Password too long"] } }` | 400 Bad Request | Low |
| 12  | Login request with missing Content-Type header | POST | `{ "email_address": "customer@foodtrip.com", "password": "Customer@123" }` | `{ "message": "Content-Type must be application/json" }` | 400 Bad Request | Medium |
| 13  | Login with malformed JSON | POST | `{ "email_address": "customer@foodtrip.com", "password": "Customer@123" ` | `{ "message": "Invalid JSON format" }` | 400 Bad Request | Medium |
| 14  | Login with additional unexpected fields | POST | `{ "email_address": "customer@foodtrip.com", "password": "Customer@123", "extra_field": "unexpected" }` | `{ "message": "Login successful", "data": { "token": "jwt_token_here", "user": {...} } }` | 200 OK | Low |
| 15  | Login with case-insensitive email | POST | `{ "email_address": "CUSTOMER@FOODTRIP.COM", "password": "Customer@123" }` | `{ "message": "Login successful", "data": { "token": "jwt_token_here", "user": {...} } }` | 200 OK | Medium |

---

## Test Data Setup

### Prerequisites:
1. Ensure test customer user exists in database:
   ```json
   {
     "email_address": "customer@foodtrip.com",
     "password": "Customer@123", // hashed in database
     "user_type": "Customer",
     "status": "Active"
   }
   ```

### Test Environment Variables:
- `{{base_url}}`: API base URL (e.g., `http://localhost:3000` or `https://api.foodtrip.com`)

---

## Response Validation Checklist

### For Successful Login (200 OK):
- ✅ Response contains `message` field
- ✅ Response contains `data` object
- ✅ `data.token` is a valid JWT token
- ✅ `data.user` contains user information
- ✅ `data.user.id` is a valid UUID
- ✅ `data.user.user_type` equals "Customer"
- ✅ `data.user.email` matches request email
- ✅ Password is not included in response
- ✅ Response time < 2 seconds

### For Validation Errors (400 Bad Request):
- ✅ Response contains `message` field
- ✅ Response contains `errors` object
- ✅ Error messages are descriptive
- ✅ No sensitive data in error response

### For Authentication Errors (401 Unauthorized):
- ✅ Response contains `message` field
- ✅ Generic error message (no hint about email existence)
- ✅ No user data in response

---

## Security Considerations

### Authentication Security:
- 🔐 Password is never returned in response
- 🔐 Generic error messages for invalid credentials
- 🔐 Rate limiting implemented for failed attempts
- 🔐 Account lockout after multiple failed attempts
- 🔐 JWT token has reasonable expiration time

### Input Validation:
- 🛡️ SQL injection attempts are blocked
- 🛡️ XSS attempts are sanitized
- 🛡️ Input length limits are enforced
- 🛡️ Email format validation is strict

---

## Performance Benchmarks

| Metric | Target | Notes |
|--------|--------|-------|
| Response Time | < 2 seconds | Under normal load |
| Concurrent Users | 100+ | Without performance degradation |
| Database Queries | ≤ 3 | Per login request |
| Memory Usage | < 50MB | Per request |

---

## Automation Notes

### High Priority for Automation:
- Test cases 1, 3, 4 (core authentication flows)
- Test cases 5, 6 (required field validation)

### Test Data Management:
- Use test user accounts with known credentials
- Implement database cleanup after test runs
- Use separate test database for isolation

### CI/CD Integration:
- Run authentication tests on every commit
- Include in smoke test suite for deployments
- Monitor for authentication performance regression
