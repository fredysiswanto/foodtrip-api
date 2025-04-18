# Test Cases for Create Opening Hour  

**Endpoint:** `POST {{base_url}}/api/v1/resto-admin/restaurant/opening-hour`  

| No | Test Case Description | Method | Request Body | Expected Response | Status Code |
|----|-----------------------|--------|--------------|--------------------|-------------|
| 1  | Create opening hours with valid data | POST | `{ "restaurant_id": 123, "day": "Monday", "open_time": "08:00", "close_time": "22:00" }` | `{ "message": "Opening hours added successfully" }` | 201 Created |
| 2  | Create opening hours with missing required fields | POST | `{ "restaurant_id": 123, "day": "Monday" }` | `{ "error": "Open and close time are required" }` | 400 Bad Request |
| 3  | Create opening hours with invalid time format | POST | `{ "restaurant_id": 123, "day": "Monday", "open_time": "25:00", "close_time": "22:00" }` | `{ "error": "Invalid time format" }` | 400 Bad Request |
| 4  | Create opening hours with closing time earlier than opening time | POST | `{ "restaurant_id": 123, "day": "Monday", "open_time": "22:00", "close_time": "08:00" }` | `{ "error": "Closing time must be after opening time" }` | 400 Bad Request |
| 5  | Create opening hours for a non-existing restaurant | POST | `{ "restaurant_id": 99999, "day": "Monday", "open_time": "08:00", "close_time": "22:00" }` | `{ "error": "Restaurant not found" }` | 404 Not Found |
| 6  | Create opening hours with unauthorized user | POST | `{ "restaurant_id": 123, "day": "Monday", "open_time": "08:00", "close_time": "22:00" }` | `{ "error": "Unauthorized" }` | 401 Unauthorized |
| 7  | Create opening hours with forbidden access (insufficient role) | POST | `{ "restaurant_id": 123, "day": "Monday", "open_time": "08:00", "close_time": "22:00" }` | `{ "error": "Forbidden" }` | 403 Forbidden |
| 8  | Create duplicate opening hours for the same day | POST | `{ "restaurant_id": 123, "day": "Monday", "open_time": "08:00", "close_time": "22:00" }` | `{ "error": "Opening hours for this day already exist" }` | 409 Conflict |
| 9  | Create opening hours when database is down | POST | `{ "restaurant_id": 123, "day": "Monday", "open_time": "08:00", "close_time": "22:00" }` | `{ "error": "Internal Server Error" }` | 500 Internal Server Error |
| 10 | Create opening hours with an invalid day name | POST | `{ "restaurant_id": 123, "day": "Funday", "open_time": "08:00", "close_time": "22:00" }` | `{ "error": "Invalid day format" }` | 400 Bad Request |

