# Test Cases for Delete Opening Hour

**Endpoint:** `DELETE {{base_url}}/api/v1/resto-admin/restaurant/opening-hour/:id`

| No  | Test Case Description                                            | Method | Request Params | Expected Response                                    | Status Code               |
| --- | ---------------------------------------------------------------- | ------ | -------------- | ---------------------------------------------------- | ------------------------- |
| 1   | Successfully delete an opening hour                              | DELETE | `:id = 123`    | `{ "message": "Opening hour deleted successfully" }` | 200 OK                    |
| 2   | Delete an opening hour with non-existing ID                      | DELETE | `:id = 99999`  | `{ "error": "Opening hour not found" }`              | 404 Not Found             |
| 3   | Delete an opening hour with invalid ID format                    | DELETE | `:id = abc`    | `{ "error": "Invalid ID format" }`                   | 400 Bad Request           |
| 4   | Delete an opening hour without authentication                    | DELETE | `:id = 123`    | `{ "error": "Unauthorized" }`                        | 401 Unauthorized          |
| 5   | Delete an opening hour with forbidden access (insufficient role) | DELETE | `:id = 123`    | `{ "error": "Forbidden" }`                           | 403 Forbidden             |
| 6   | Delete an already deleted opening hour                           | DELETE | `:id = 456`    | `{ "error": "Opening hour not found" }`              | 404 Not Found             |
| 7   | Delete an opening hour when database is down                     | DELETE | `:id = 123`    | `{ "error": "Internal Server Error" }`               | 500 Internal Server Error |
