# Test Cases for Get All Dishes

**Endpoint:** `GET {{base_url}}/api/v1/resto-admin/dishes/:restoID`

| No  | Test Case Description                                     | Method | Request Params                     | Expected Response                                    | Status Code               |
| --- | --------------------------------------------------------- | ------ | ---------------------------------- | ---------------------------------------------------- | ------------------------- |
| 1   | Successfully retrieve all dishes for a restaurant         | GET    | `:restoID = 1`                     | `{ "message": "Success", "data": [ {...}, {...} ] }` | 200 OK                    |
| 2   | Retrieve dishes for a non-existing restaurant             | GET    | `:restoID = 99999`                 | `{ "error": "Restaurant not found" }`                | 404 Not Found             |
| 3   | Retrieve dishes for a restaurant with no dishes           | GET    | `:restoID = 2`                     | `{ "message": "No dishes found" }`                   | 200 OK                    |
| 4   | Retrieve dishes with invalid restaurant ID format         | GET    | `:restoID = abc`                   | `{ "error": "Invalid restaurant ID format" }`        | 400 Bad Request           |
| 5   | Retrieve dishes without authentication                    | GET    | `:restoID = 1`                     | `{ "error": "Unauthorized" }`                        | 401 Unauthorized          |
| 6   | Retrieve dishes with forbidden access (insufficient role) | GET    | `:restoID = 1`                     | `{ "error": "Forbidden" }`                           | 403 Forbidden             |
| 7   | Retrieve dishes with pagination                           | GET    | `:restoID = 1, ?page=1&limit=10`   | `{ "message": "Success", "data": [ {...}, {...} ] }` | 200 OK                    |
| 8   | Retrieve dishes with invalid pagination parameters        | GET    | `:restoID = 1, ?page=-1&limit=abc` | `{ "error": "Invalid pagination parameters" }`       | 400 Bad Request           |
| 9   | Retrieve dishes when database is down                     | GET    | `:restoID = 1`                     | `{ "error": "Internal Server Error" }`               | 500 Internal Server Error |
