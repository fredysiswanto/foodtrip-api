# Test Cases for Find Opening Hour

**Endpoint:** `GET {{base_url}}/api/v1/resto-admin/restaurant/opening-hour/:id`

| No  | Test Case Description                                      | Method | Request Params | Expected Response                                                                                                                   | Status Code               |
| --- | ---------------------------------------------------------- | ------ | -------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| 1   | Get opening hour by valid ID                               | GET    | `:id = 123`    | `{ "message": "Success", "data": { "id": 123, "restaurant_id": 1, "day": "Monday", "open_time": "08:00", "close_time": "22:00" } }` | 200 OK                    |
| 2   | Get opening hour with non-existing ID                      | GET    | `:id = 99999`  | `{ "error": "Opening hour not found" }`                                                                                             | 404 Not Found             |
| 3   | Get opening hour with invalid ID format                    | GET    | `:id = abc`    | `{ "error": "Invalid ID format" }`                                                                                                  | 400 Bad Request           |
| 4   | Get opening hour without authentication                    | GET    | `:id = 123`    | `{ "error": "Unauthorized" }`                                                                                                       | 401 Unauthorized          |
| 5   | Get opening hour with forbidden access (insufficient role) | GET    | `:id = 123`    | `{ "error": "Forbidden" }`                                                                                                          | 403 Forbidden             |
| 6   | Get opening hour for a deleted record                      | GET    | `:id = 456`    | `{ "error": "Opening hour not found" }`                                                                                             | 404 Not Found             |
| 7   | Get opening hour when database is down                     | GET    | `:id = 123`    | `{ "error": "Internal Server Error" }`                                                                                              | 500 Internal Server Error |
