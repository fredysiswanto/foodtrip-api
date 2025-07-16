# Test Cases for Update Opening Hour

**Endpoint:** `PUT {{base_url}}/api/v1/restaurant/opening-hour/:id`

| No  | Test Case Description                                         | Method | Request Body                                                                      | Expected Response                                      | Status Code               |
| --- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------- | ------------------------------------------------------ | ------------------------- |
| 1   | Successfully update opening hour                              | PUT    | `{ "day": "Monday", "open_time": "09:00", "close_time": "23:00" }`                | `{ "message": "Opening hour updated successfully" }`   | 200 OK                    |
| 2   | Update opening hour with missing fields                       | PUT    | `{ "day": "Monday" }`                                                             | `{ "error": "Open time and close time are required" }` | 400 Bad Request           |
| 3   | Update opening hour with invalid time format                  | PUT    | `{ "day": "Monday", "open_time": "invalid", "close_time": "22:00" }`              | `{ "error": "Invalid time format" }`                   | 400 Bad Request           |
| 4   | Update opening hour with non-existing ID                      | PUT    | `:id = 99999`, `{ "day": "Monday", "open_time": "08:00", "close_time": "22:00" }` | `{ "error": "Opening hour not found" }`                | 404 Not Found             |
| 5   | Update opening hour with invalid ID format                    | PUT    | `:id = abc`, `{ "day": "Monday", "open_time": "08:00", "close_time": "22:00" }`   | `{ "error": "Invalid ID format" }`                     | 400 Bad Request           |
| 6   | Update opening hour with unauthorized access                  | PUT    | `:id = 123`, `{ "day": "Monday", "open_time": "08:00", "close_time": "22:00" }`   | `{ "error": "Unauthorized" }`                          | 401 Unauthorized          |
| 7   | Update opening hour with forbidden access (insufficient role) | PUT    | `:id = 123`, `{ "day": "Monday", "open_time": "08:00", "close_time": "22:00" }`   | `{ "error": "Forbidden" }`                             | 403 Forbidden             |
| 8   | Update opening hour for a deleted record                      | PUT    | `:id = 456`, `{ "day": "Monday", "open_time": "08:00", "close_time": "22:00" }`   | `{ "error": "Opening hour not found" }`                | 404 Not Found             |
| 9   | Update opening hour when database is down                     | PUT    | `:id = 123`, `{ "day": "Monday", "open_time": "08:00", "close_time": "22:00" }`   | `{ "error": "Internal Server Error" }`                 | 500 Internal Server Error |
