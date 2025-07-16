# Test Cases for Find Restaurant

**Endpoint:** `GET {{base_url}}/api/v1/resto-admin/restaurant/:restoID`

| No  | Test Case Description                               | Method | Request Params                  | Expected Response                                                              | Status Code               |
| --- | --------------------------------------------------- | ------ | ------------------------------- | ------------------------------------------------------------------------------ | ------------------------- |
| 1   | Get restaurant details with valid ID                | GET    | `:restoID=123`                  | `{ "message": "Success", "data": { "id": 123, "name": "Restaurant A", ... } }` | 200 OK                    |
| 2   | Get restaurant with invalid ID format               | GET    | `:restoID=abc`                  | `{ "error": "Invalid restaurant ID format" }`                                  | 400 Bad Request           |
| 3   | Get restaurant with non-existing ID                 | GET    | `:restoID=99999`                | `{ "error": "Restaurant not found" }`                                          | 404 Not Found             |
| 4   | Get restaurant without authentication               | GET    | `:restoID=123`                  | `{ "error": "Unauthorized" }`                                                  | 401 Unauthorized          |
| 5   | Get restaurant when user does not have permission   | GET    | `:restoID=123`                  | `{ "error": "Forbidden" }`                                                     | 403 Forbidden             |
| 6   | Get restaurant with database connection issue       | GET    | `:restoID=123`                  | `{ "error": "Internal Server Error" }`                                         | 500 Internal Server Error |
| 7   | Get restaurant with SQL injection attempt           | GET    | `:restoID=1 OR 1=1`             | `{ "error": "Invalid request" }`                                               | 400 Bad Request           |
| 8   | Get restaurant with excessive ID length             | GET    | `:restoID=12345678901234567890` | `{ "error": "Invalid restaurant ID format" }`                                  | 400 Bad Request           |
| 9   | Get restaurant when the system is under maintenance | GET    | `:restoID=123`                  | `{ "error": "Service unavailable" }`                                           | 503 Service Unavailable   |
| 10  | Get restaurant with special characters in ID        | GET    | `:restoID=@!$%^&*()`            | `{ "error": "Invalid restaurant ID format" }`                                  | 400 Bad Request           |
