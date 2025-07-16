# Test Cases for Find Dish Category

**Endpoint:** `GET {{base_url}}/api/v1/home/dish-cat`

| No  | Test Case Description                                        | Method | Request Params           | Expected Response                            | Status Code     |
| --- | ------------------------------------------------------------ | ------ | ------------------------ | -------------------------------------------- | --------------- |
| 1   | Get all dish categories successfully                         | GET    | None                     | { "message": "Success", "data": [...] }      | 200 OK          |
| 2   | Get dish categories with pagination                          | GET    | ?page=1&limit=10         | { "message": "Success", "data": [...] }      | 200 OK          |
| 3   | Get dish categories with invalid pagination values           | GET    | ?page=-1&limit=abc       | { "error": "Invalid pagination parameters" } | 400 Bad Request |
| 4   | Get a specific dish category by ID                           | GET    | /{dishCatID}             | { "message": "Success", "data": { ... } }    | 200 OK          |
| 5   | Get a non-existent dish category                             | GET    | /{invalidDishCatID}      | { "error": "Dish category not found" }       | 404 Not Found   |
| 6   | Get dish categories sorted by name (ascending)               | GET    | ?sort=name&order=asc     | { "message": "Success", "data": [...] }      | 200 OK          |
| 7   | Get dish categories sorted by name (descending)              | GET    | ?sort=name&order=desc    | { "message": "Success", "data": [...] }      | 200 OK          |
| 8   | Get dish categories with an invalid sorting order            | GET    | ?sort=name&order=invalid | { "error": "Invalid sorting order" }         | 400 Bad Request |
| 9   | Get dish categories when no categories exist in the database | GET    | None                     | { "message": "No categories available" }     | 200 OK          |
