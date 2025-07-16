# Test Cases for Update Restaurant

**Endpoint:** `PUT {{base_url}}/api/v1/resto-admin/restaurant/:restoID`

| No  | Test Case Description                                       | Method | Request Body                                                                        | Expected Response                                  | Status Code               |
| --- | ----------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------- | -------------------------------------------------- | ------------------------- |
| 1   | Update restaurant with valid data                           | PUT    | `{ "name": "Updated Restaurant", "address": "New Address", "phone": "1234567890" }` | `{ "message": "Restaurant updated successfully" }` | 200 OK                    |
| 2   | Update restaurant with missing required fields              | PUT    | `{ "name": "", "address": "", "phone": "" }`                                        | `{ "error": "Fields cannot be empty" }`            | 400 Bad Request           |
| 3   | Update restaurant with invalid phone number format          | PUT    | `{ "phone": "abc123" }`                                                             | `{ "error": "Invalid phone number format" }`       | 400 Bad Request           |
| 4   | Update restaurant with special characters in name           | PUT    | `{ "name": "@#Invalid Name!" }`                                                     | `{ "error": "Invalid characters in name" }`        | 400 Bad Request           |
| 5   | Update non-existing restaurant                              | PUT    | `{ "name": "New Name", "address": "New Address" }`                                  | `{ "error": "Restaurant not found" }`              | 404 Not Found             |
| 6   | Update restaurant with unauthorized user                    | PUT    | `{ "name": "New Name", "address": "New Address" }`                                  | `{ "error": "Unauthorized" }`                      | 401 Unauthorized          |
| 7   | Update restaurant with forbidden access (insufficient role) | PUT    | `{ "name": "New Name", "address": "New Address" }`                                  | `{ "error": "Forbidden" }`                         | 403 Forbidden             |
| 8   | Update restaurant with large input data                     | PUT    | `{ "name": "A".repeat(300), "address": "B".repeat(500) }`                           | `{ "error": "Input data too large" }`              | 413 Payload Too Large     |
| 9   | Update restaurant when database is down                     | PUT    | `{ "name": "New Name", "address": "New Address" }`                                  | `{ "error": "Internal Server Error" }`             | 500 Internal Server Error |
| 10  | Update restaurant with valid partial data                   | PUT    | `{ "address": "Updated Address Only" }`                                             | `{ "message": "Restaurant updated successfully" }` | 200 OK                    |
