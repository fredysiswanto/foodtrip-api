# Test Cases for Login API

**Endpoint:** `POST {{base_url}}/api/v1/home/login`

| No  | Test Case Description                               | Method | Request Body                                                               | Expected Response                                      | Status Code      |
| --- | --------------------------------------------------- | ------ | -------------------------------------------------------------------------- | ------------------------------------------------------ | ---------------- |
| 1   | Login with valid credentials                        | POST   | `{ "email": "user@example.com", "password": "ValidPass123" }`              | `{ "message": "Login successful", "token": "abc123" }` | 200 OK           |
| 2   | Login with invalid email                            | POST   | `{ "email": "invalid@example.com", "password": "ValidPass123" }`           | `{ "error": "Invalid email or password" }`             | 401 Unauthorized |
| 3   | Login with invalid password                         | POST   | `{ "email": "user@example.com", "password": "WrongPass" }`                 | `{ "error": "Invalid email or password" }`             | 401 Unauthorized |
| 4   | Login with missing email                            | POST   | `{ "password": "ValidPass123" }`                                           | `{ "error": "Email is required" }`                     | 400 Bad Request  |
| 5   | Login with missing password                         | POST   | `{ "email": "user@example.com" }`                                          | `{ "error": "Password is required" }`                  | 400 Bad Request  |
| 6   | Login with empty request body                       | POST   | `{}`                                                                       | `{ "error": "Email and password are required" }`       | 400 Bad Request  |
| 7   | Login with malformed email                          | POST   | `{ "email": "invalidemail", "password": "ValidPass123" }`                  | `{ "error": "Invalid email format" }`                  | 400 Bad Request  |
| 8   | Login with SQL injection attempt                    | POST   | `{ "email": "user@example.com", "password": "' OR '1'='1" }`               | `{ "error": "Invalid email or password" }`             | 401 Unauthorized |
| 9   | Login with XSS attack attempt                       | POST   | `{ "email": "<script>alert('XSS')</script>", "password": "ValidPass123" }` | `{ "error": "Invalid email format" }`                  | 400 Bad Request  |
| 10  | Login with case-sensitive email check               | POST   | `{ "email": "USER@EXAMPLE.COM", "password": "ValidPass123" }`              | `{ "message": "Login successful", "token": "abc123" }` | 200 OK           |
| 11  | Login with account that is locked                   | POST   | `{ "email": "lockeduser@example.com", "password": "ValidPass123" }`        | `{ "error": "Account is locked" }`                     | 403 Forbidden    |
| 12  | Login with account that requires email verification | POST   | `{ "email": "unverified@example.com", "password": "ValidPass123" }`        | `{ "error": "Email not verified" }`                    | 403 Forbidden    |
