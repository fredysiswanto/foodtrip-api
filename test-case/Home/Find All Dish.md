<p><strong>Endpoint:</strong> <code inline="">GET {{base_url}}/api/v1/home/dishes</code></p>

| No  | Test Case Description                           | Method | Request Params            | Expected Response                            | Status Code     |
| --- | ----------------------------------------------- | ------ | ------------------------- | -------------------------------------------- | --------------- |
| 1   | Get all dishes successfully                     | GET    | None                      | { "message": "Success", "data": [...] }      | 200 OK          |
| 2   | Get dishes with pagination                      | GET    | ?page=1&limit=10          | { "message": "Success", "data": [...] }      | 200 OK          |
| 3   | Get dishes with invalid pagination values       | GET    | ?page=-1&limit=abc        | { "error": "Invalid pagination parameters" } | 400 Bad Request |
| 4   | Get dishes by category                          | GET    | ?category=seafood         | { "message": "Success", "data": [...] }      | 200 OK          |
| 5   | Get dishes with invalid category                | GET    | ?category=invalidCategory | { "error": "Category not found" }            | 404 Not Found   |
| 6   | Get dishes with search query                    | GET    | ?search=pizza             | { "message": "Success", "data": [...] }      | 200 OK          |
| 7   | Get dishes with no matching search result       | GET    | ?search=unknownfood       | { "message": "No dishes found" }             | 200 OK          |
| 8   | Get dishes sorted by price (ascending)          | GET    | ?sort=price&order=asc     | { "message": "Success", "data": [...] }      | 200 OK          |
| 9   | Get dishes sorted by price (descending)         | GET    | ?sort=price&order=desc    | { "message": "Success", "data": [...] }      | 200 OK          |
| 10  | Get dishes with invalid sorting order           | GET    | ?sort=price&order=invalid | { "error": "Invalid sorting order" }         | 400 Bad Request |
| 11  | Get dishes filtered by availability             | GET    | ?available=true           | { "message": "Success", "data": [...] }      | 200 OK          |
| 12  | Get dishes when no dishes exist in the database | GET    | None                      | { "message": "No dishes available" }         | 200 OK          |
