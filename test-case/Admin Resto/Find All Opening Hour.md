# Test Cases for Find All Opening Hour

**Endpoint:** `GET {{base_url}}/api/v1/resto-admin/restaurant/opening-hour`

| No  | Test Case Description                                       | Method | Request Params              | Expected Response                             | Status Code               |
| --- | ----------------------------------------------------------- | ------ | --------------------------- | --------------------------------------------- | ------------------------- |
| 1   | Get all opening hours successfully                          | GET    | None                        | `{ "message": "Success", "data": [...] }`     | 200 OK                    |
| 2   | Get opening hours with pagination                           | GET    | `?page=1&limit=10`          | `{ "message": "Success", "data": [...] }`     | 200 OK                    |
| 3   | Get opening hours for a specific restaurant                 | GET    | `?restaurant_id=123`        | `{ "message": "Success", "data": [...] }`     | 200 OK                    |
| 4   | Get opening hours for a non-existing restaurant             | GET    | `?restaurant_id=99999`      | `{ "error": "Restaurant not found" }`         | 404 Not Found             |
| 5   | Get opening hours with an invalid restaurant ID format      | GET    | `?restaurant_id=abc`        | `{ "error": "Invalid restaurant ID format" }` | 400 Bad Request           |
| 6   | Get opening hours when no records exist                     | GET    | None                        | `{ "message": "No opening hours available" }` | 200 OK                    |
| 7   | Get opening hours with unauthorized user                    | GET    | None                        | `{ "error": "Unauthorized" }`                 | 401 Unauthorized          |
| 8   | Get opening hours with forbidden access (insufficient role) | GET    | None                        | `{ "error": "Forbidden" }`                    | 403 Forbidden             |
| 9   | Get opening hours sorted by open time                       | GET    | `?sort=open_time&order=asc` | `{ "message": "Success", "data": [...] }`     | 200 OK                    |
| 10  | Get opening hours when database is down                     | GET    | None                        | `{ "error": "Internal Server Error" }`        | 500 Internal Server Error |
