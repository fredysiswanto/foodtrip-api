BaseUrl = http://localhost:3600/api/v1

# List food-api & Test Case

## Home

| No  | Folder | API Name                     | Method | URL                                                 | Link                                                                                                |
| --- | ------ | ---------------------------- | ------ | --------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| 1   | Home   | Admin Login                  | POST   | {{base_url}}/api/v1/home/login                      | [Test Case](https://github.com/fredysiswanto/foodtrip-api/discussions/2#discussion-8112941)         |
| 2   | Home   | Customer Login               | POST   | {{base_url}}/api/v1/home/login                      | [Test Case]                                                                                         |
| 3   | Home   | Resto Admin Login            | POST   | {{base_url}}/api/v1/home/login                      | [Test Case]                                                                                         |
| 4   | Home   | Register Customer            | POST   | {{base_url}}/api/v1/home/register/customer          | [Test Case](https://github.com/fredysiswanto/foodtrip-api/discussions/2#discussioncomment-12620602) |
| 5   | Home   | Create Restaurant            | POST   | {{base_url}}/api/v1/home/register/restaurant        | [Test Case](https://github.com/fredysiswanto/foodtrip-api/discussions/2#discussioncomment-12620620) |
| 6   | Home   | Register Resto Admin         | POST   | {{base_url}}/api/v1/home/register/resto-admin       | [Test Case](https://github.com/fredysiswanto/foodtrip-api/discussions/2#discussioncomment-12620646) |
| 7   | Home   | Register Admin               | POST   | {{base_url}}/api/v1/home/register/admin             | [Test Case]                                                                                         |
| 8   | Home   | Find All Dish                | GET    | {{base_url}}/api/v1/home/dishes/                    | [Test Case](https://github.com/fredysiswanto/foodtrip-api/discussions/2#discussioncomment-12623861) |
| 9   | Home   | Find All Dish Category       | GET    | {{base_url}}/api/v1/home/dish-cat/                  | [Test Case](https://github.com/fredysiswanto/foodtrip-api/discussions/2#discussioncomment-12623879) |
| 10  | Home   | Find Dish Category           | GET    | {{base_url}}/api/v1/home/dish-cat/:dishCatID        | [Test Case]                                                                                         |
| 11  | Home   | Find All Restaurant          | GET    | {{base_url}}/api/v1/home/restaurants                | [Test Case](https://github.com/fredysiswanto/foodtrip-api/discussions/2#discussioncomment-12627383) |
| 12  | Home   | Find Restaurant              | GET    | {{base_url}}/api/v1/home/restaurant/:restoID        | [Test Case]                                                                                         |
| 13  | Home   | Find All Restaurant Category | GET    | {{base_url}}/api/v1/home/resto-categories           | [Test Case](https://github.com/fredysiswanto/foodtrip-api/discussions/2#discussioncomment-12627436) |
| 14  | Home   | Find Restaurant Category     | GET    | {{base_url}}/api/v1/home/resto-category/:restoCatID | [Test Case]                                                                                         |

## Admin

| No  | Folder | API Name                     | Method | URL                                                      | Link |
| --- | ------ | ---------------------------- | ------ | -------------------------------------------------------- | ---- |
| 1   | Admin  | Find All Restaurants         | GET    | {{base_url}}/api/v1/admin/restaurants                    |      |
| 2   | Admin  | Find Restaurant              | GET    | {{base_url}}/api/v1/admin/restaurant/:restoID            |      |
| 3   | Admin  | Find All Dish                | GET    | {{base_url}}/api/v1/admin/dishes/                        |      |
| 4   | Admin  | Find Dish                    | GET    | {{base_url}}/api/v1/admin/dish/:dishID                   |      |
| 5   | Admin  | Find All Orders              | GET    | {{base_url}}/api/v1/admin/orders                         |      |
| 6   | Admin  | Find Order                   | GET    | {{base_url}}/api/v1/admin/order/:orderID                 |      |
| 7   | Admin  | Find All Restaurant Category | GET    | {{base_url}}/api/v1/admin/resto-cat                      |      |
| 8   | Admin  | Find Restaurant Category     | GET    | {{base_url}}/api/v1/admin/resto-cat/:restoCatID          |      |
| 9   | Admin  | Find All Users (Resto Admin) | GET    | {{base_url}}/api/v1/admin/user/resto-admin               |      |
| 10  | Admin  | Find Resto Admin             | GET    | {{base_url}}/api/v1/admin/user/resto-admin/:restoAdminID |      |
| 11  | Admin  | Find All Customers           | GET    | {{base_url}}/api/v1/admin/user/customer                  |      |
| 12  | Admin  | Find Customer                | GET    | {{base_url}}/api/v1/admin/user/customer/:customerID      |      |
| 13  | Admin  | Find All Admin Users         | GET    | {{base_url}}/api/v1/admin/user/admin                     |      |
| 14  | Admin  | Find Admin User              | GET    | {{base_url}}/api/v1/admin/user/admin/:adminID            |      |
| 15  | Admin  | Find All Addresses           | GET    | {{base_url}}/api/v1/admin/address/                       |      |
| 16  | Admin  | Find Address                 | GET    | {{base_url}}/api/v1/admin/address/:addressID             |      |
| 17  | Admin  | Find User Account Info       | GET    | {{base_url}}/api/v1/admin/account/info                   |      |
| 18  | Admin  | Update User Account Info     | PUT    | {{base_url}}/api/v1/admin/account/info                   |      |
| 19  | Admin  | Verify User Password         | POST   | {{base_url}}/api/v1/admin/account/verify-password        |      |
| 20  | Admin  | Update User Password         | PUT    | {{base_url}}/api/v1/admin/account/password               |      |
| 21  | Admin  | Find All Deliveries          | GET    | {{base_url}}/api/v1/admin/deliveries                     |      |
| 22  | Admin  | Find All Couriers            | GET    | {{base_url}}/api/v1/admin/couriers                       |      |

## Customer

| No  | Folder   | API Name                      | Method | URL                                                | Link |
| --- | -------- | ----------------------------- | ------ | -------------------------------------------------- | ---- |
| 1   | Customer | Find Some Restaurant Category | GET    | {{base_url}}/api/v1/customer/some-resto-cat        |      |
| 2   | Customer | Find Popular Dish             | GET    | {{base_url}}/api/v1/customer/pop-dishes            |      |
| 3   | Customer | Find Popular Restaurant       | GET    | {{base_url}}/api/v1/customer/pop-restaurants       |      |
| 4   | Customer | Find All Restaurants          | GET    | {{base_url}}/api/v1/customer/restaurants           |      |
| 5   | Customer | Find Restaurant               | GET    | {{base_url}}/api/v1/customer/restaurant/:restoID   |      |
| 6   | Customer | Find All Restaurant Category  | GET    | {{base_url}}/api/v1/customer/resto-cat             |      |
| 7   | Customer | Find Restaurant Category      | GET    | {{base_url}}/api/v1/customer/resto-cat/:restoCatID |      |
| 8   | Customer | Find All Dishes               | GET    | {{base_url}}/api/v1/customer/dishes/               |      |
| 9   | Customer | Find All Dish Categories      | GET    | {{base_url}}/api/v1/customer/dish-cat/             |      |
| 10  | Customer | Find Dish                     | GET    | {{base_url}}/api/v1/customer/dish/:dishID          |      |
| 11  | Customer | Find Dish Category            | GET    | {{base_url}}/api/v1/customer/dish-cat/:dishCatID   |      |
| 12  | Customer | Create Address                | POST   | {{base_url}}/api/v1/customer/address/              |      |
| 13  | Customer | Find All Addresses            | GET    | {{base_url}}/api/v1/customer/address/              |      |
| 14  | Customer | Find Address                  | GET    | {{base_url}}/api/v1/customer/address/:addressID    |      |
| 15  | Customer | Update Address                | PUT    | {{base_url}}/api/v1/customer/address/:addressID    |      |
| 16  | Customer | Delete Address                | DELETE | {{base_url}}/api/v1/customer/address/:addressID    |      |
