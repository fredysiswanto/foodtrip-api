# Test Cases: Customer Checkout (Create Order) API

**Endpoint:** `POST {{base_url}}/api/v1/customer/order`

## Test Case Overview
This endpoint handles the complete checkout process for customers, creating an order from their cart items and processing the transaction with delivery address information.

---

## Authentication Setup
**Required:** Bearer token for Customer role
```
Authorization: Bearer {{customer_token}}
```

---

## Test Cases

| No  | Test Case Description | Method | Request Body | Expected Response | Status Code | Priority |
| --- | --------------------- | ------ | ------------ | ----------------- | ----------- | -------- |
| 1   | Successful checkout with valid cart and address | POST | `{ "order_comment": "Please deliver to the lobby. Call when you arrive.", "address_id": "valid-address-uuid" }` | `{ "message": "Order created successfully", "data": { "id": "order-uuid", "order_number": "ORD-202407-001", "customer_id": "customer-uuid", "resto_id": "restaurant-uuid", "total_amount": 1250.00, "delivery_fee": 50.00, "grand_total": 1300.00, "order_status": "Pending", "delivery_address": {...}, "order_items": [...], "created_at": "timestamp" } }` | 201 Created | High |
| 2   | Checkout with minimum required data (no comment) | POST | `{ "address_id": "valid-address-uuid" }` | `{ "message": "Order created successfully", "data": { "id": "order-uuid", "order_comment": null, ... } }` | 201 Created | High |
| 3   | Checkout with empty cart | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Checkout failed", "errors": { "cart": ["Cart is empty. Add items before checkout"] } }` | 400 Bad Request | High |
| 4   | Checkout with missing required field - address_id | POST | `{ "order_comment": "Test order without address" }` | `{ "message": "Validation failed", "errors": { "address_id": ["Delivery address is required"] } }` | 400 Bad Request | High |
| 5   | Checkout with invalid address_id format | POST | `{ "order_comment": "Test order", "address_id": "invalid-uuid-format" }` | `{ "message": "Validation failed", "errors": { "address_id": ["Invalid address ID format"] } }` | 400 Bad Request | Medium |
| 6   | Checkout with non-existent address | POST | `{ "order_comment": "Test order", "address_id": "non-existent-uuid" }` | `{ "message": "Validation failed", "errors": { "address_id": ["Address not found"] } }` | 400 Bad Request | High |
| 7   | Checkout with address belonging to another customer | POST | `{ "order_comment": "Test order", "address_id": "other-customer-address-uuid" }` | `{ "message": "Validation failed", "errors": { "address_id": ["Address not found"] } }` | 400 Bad Request | High |
| 8   | Checkout with cart containing unavailable dishes | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Checkout failed", "errors": { "cart": ["Some items in your cart are no longer available"] } }` | 400 Bad Request | High |
| 9   | Checkout with cart from closed restaurant | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Checkout failed", "errors": { "restaurant": ["Restaurant is currently closed"] } }` | 400 Bad Request | High |
| 10  | Checkout without authentication | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Unauthorized access" }` | 401 Unauthorized | High |
| 11  | Checkout with expired token | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Token expired" }` | 401 Unauthorized | Medium |
| 12  | Checkout with admin/resto-admin token | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Insufficient permissions" }` | 403 Forbidden | Medium |
| 13  | Checkout with very long order comment | POST | `{ "order_comment": "Very long comment...".repeat(500), "address_id": "valid-address-uuid" }` | `{ "message": "Validation failed", "errors": { "order_comment": ["Comment too long. Maximum 500 characters"] } }` | 400 Bad Request | Low |
| 14  | Checkout with special characters in comment | POST | `{ "order_comment": "Please deliver 🚚 to lobby! Thanks 😊", "address_id": "valid-address-uuid" }` | `{ "message": "Order created successfully", "data": { "order_comment": "Please deliver 🚚 to lobby! Thanks 😊", ... } }` | 201 Created | Low |
| 15  | Checkout with SQL injection attempt in comment | POST | `{ "order_comment": "'; DROP TABLE orders; --", "address_id": "valid-address-uuid" }` | `{ "message": "Order created successfully", "data": { "order_comment": "'; DROP TABLE orders; --", ... } }` | 201 Created | High |
| 16  | Checkout with XSS attempt in comment | POST | `{ "order_comment": "<script>alert('xss')</script>", "address_id": "valid-address-uuid" }` | `{ "message": "Order created successfully", "data": { "order_comment": "&lt;script&gt;alert('xss')&lt;/script&gt;", ... } }` | 201 Created | High |
| 17  | Checkout during restaurant off-hours | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Checkout failed", "errors": { "restaurant": ["Restaurant is not accepting orders at this time"] } }` | 400 Bad Request | Medium |
| 18  | Checkout with cart items exceeding stock quantity | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Checkout failed", "errors": { "cart": ["Insufficient stock for some items"] } }` | 400 Bad Request | Medium |
| 19  | Checkout with cart containing deleted dishes | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Checkout failed", "errors": { "cart": ["Some items in your cart are no longer available"] } }` | 400 Bad Request | Medium |
| 20  | Checkout with cart from multiple restaurants | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" }` | `{ "message": "Checkout failed", "errors": { "cart": ["Cart can only contain items from one restaurant"] } }` | 400 Bad Request | High |
| 21  | Checkout with malformed JSON | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid" ` | `{ "message": "Invalid JSON format" }` | 400 Bad Request | Medium |
| 22  | Checkout with empty request body | POST | `{}` | `{ "message": "Validation failed", "errors": { "address_id": ["Delivery address is required"] } }` | 400 Bad Request | Medium |
| 23  | Checkout with minimum order amount not met | POST | `{ "order_comment": "Small order", "address_id": "valid-address-uuid" }` | `{ "message": "Checkout failed", "errors": { "order_total": ["Minimum order amount not met. Minimum: ₱200.00"] } }` | 400 Bad Request | Medium |
| 24  | Checkout with delivery outside service area | POST | `{ "order_comment": "Test order", "address_id": "out-of-area-address-uuid" }` | `{ "message": "Checkout failed", "errors": { "delivery": ["Delivery not available to this address"] } }` | 400 Bad Request | Low |
| 25  | Checkout with valid promo code applied | POST | `{ "order_comment": "Test order", "address_id": "valid-address-uuid", "promo_code": "SAVE10" }` | `{ "message": "Order created successfully", "data": { "promo_code": "SAVE10", "discount_amount": 100.00, "total_amount": 1250.00, "discount": 100.00, "grand_total": 1200.00, ... } }` | 201 Created | Low |

---

## Test Data Setup

### Prerequisites:
1. Customer user authenticated with valid JWT token
2. Active cart with valid items from one restaurant
3. Valid delivery addresses for the customer
4. Open restaurant with available dishes
5. Proper delivery zones configured

### Sample Test Data:
```json
{
  "customer": {
    "id": "test-customer-uuid",
    "email": "testcustomer@foodtrip.com",
    "token": "valid-jwt-token"
  },
  "cart": {
    "id": "test-cart-uuid",
    "customer_id": "test-customer-uuid",
    "resto_id": "test-restaurant-uuid",
    "cart_details": [
      {
        "id": "cart-detail-1-uuid",
        "dish_id": "dish-1-uuid",
        "quantity": 2,
        "unit_price": 350.00,
        "total_price": 700.00
      },
      {
        "id": "cart-detail-2-uuid", 
        "dish_id": "dish-2-uuid",
        "quantity": 1,
        "unit_price": 550.00,
        "total_price": 550.00
      }
    ],
    "total_amount": 1250.00
  },
  "addresses": [
    {
      "id": "valid-address-uuid",
      "customer_id": "test-customer-uuid",
      "address_1": "123 Main Street",
      "city": "Makati City",
      "is_default": true,
      "in_delivery_area": true
    },
    {
      "id": "out-of-area-address-uuid",
      "customer_id": "test-customer-uuid",
      "address_1": "999 Remote Street",
      "city": "Remote City",
      "in_delivery_area": false
    }
  ],
  "restaurant": {
    "id": "test-restaurant-uuid",
    "resto_name": "Test Restaurant",
    "status": "Open",
    "is_accepting_orders": true,
    "minimum_order": 200.00,
    "delivery_fee": 50.00
  }
}
```

### Test Environment Variables:
- `{{base_url}}`: API base URL
- `{{customer_token}}`: Valid JWT token for customer

---

## Response Validation Checklist

### For Successful Checkout (201 Created):
- ✅ Response contains `message` field
- ✅ Response contains `data` object with order details
- ✅ Order ID is valid UUID
- ✅ Order number follows format (ORD-YYYYMM-XXX)
- ✅ Customer ID matches authenticated user
- ✅ Restaurant ID matches cart restaurant
- ✅ Total calculations are accurate
- ✅ Delivery fee is included
- ✅ Order status is "Pending"
- ✅ Order items match cart contents
- ✅ Delivery address is complete
- ✅ Timestamps are properly formatted
- ✅ Response time < 5 seconds

### For Validation Errors (400 Bad Request):
- ✅ Response contains `message` field
- ✅ Response contains `errors` object
- ✅ Field-specific error messages
- ✅ Multiple validation errors handled
- ✅ No sensitive data exposed

### For Authorization Errors (401/403):
- ✅ Proper authentication verification
- ✅ Role-based access control
- ✅ Generic error messages for security

---

## Security Considerations

### Access Control:
- 🔐 Only authenticated customers can checkout
- 🔐 Customer can only use own addresses
- 🔐 Customer can only checkout own cart
- 🔐 JWT token validation on request

### Data Protection:
- 🛡️ Input sanitization for order comments
- 🛡️ XSS prevention in user input
- 🛡️ SQL injection prevention
- 🛡️ Address ownership verification
- 🛡️ Cart ownership verification

### Transaction Security:
- 🔒 Order creation is atomic transaction
- 🔒 Cart clearing after successful order
- 🔒 Inventory validation before order creation
- 🔒 Price integrity verification

---

## Business Rules Validation

### Checkout Rules:
- ✅ Cart must not be empty
- ✅ All cart items must be available
- ✅ Restaurant must be open and accepting orders
- ✅ Cart items must be from single restaurant
- ✅ Delivery address must be valid and owned by customer
- ✅ Minimum order amount must be met
- ✅ Delivery must be available to address
- ✅ All dish prices must be current

### Order Creation Process:
1. **Validate cart contents** (not empty, items available)
2. **Validate restaurant status** (open, accepting orders)
3. **Validate delivery address** (exists, owned by customer, in service area)
4. **Calculate totals** (subtotal, delivery fee, taxes, discounts)
5. **Create order record** (with pending status)
6. **Create order details** (copy cart items with current prices)
7. **Clear customer cart** (after successful order creation)
8. **Send notifications** (to customer and restaurant)

### Field Requirements:
- **Required:** address_id
- **Optional:** order_comment, promo_code
- **Computed:** total_amount, delivery_fee, grand_total, order_number

---

## Performance Benchmarks

| Operation | Target Response Time | Notes |
|-----------|---------------------|--------|
| Successful Checkout | < 3 seconds | Including all validations |
| Validation Failures | < 1 second | Quick validation checks |
| Cart Validation | < 2 seconds | Database lookups required |
| Order Creation | < 5 seconds | Complete transaction processing |

---

## Integration Dependencies

### Required Services:
- **Cart Service**: Validate and retrieve cart contents
- **Restaurant Service**: Check status and operating hours
- **Address Service**: Validate delivery address
- **Inventory Service**: Check dish availability
- **Pricing Service**: Validate current prices
- **Delivery Service**: Check service area coverage
- **Notification Service**: Send order confirmations

### Database Transactions:
- **Orders table**: Create new order record
- **Order_details table**: Create order item records
- **Cart tables**: Clear customer cart
- **Inventory table**: Update stock levels (if applicable)
- **Audit table**: Log order creation

---

## Error Scenarios & Recovery

### Common Failure Points:
1. **Empty Cart**: Clear error message, redirect to menu
2. **Closed Restaurant**: Show operating hours, suggest alternatives
3. **Unavailable Items**: Show which items, allow cart update
4. **Invalid Address**: Show address form, allow selection
5. **Payment Issues**: Show payment options, retry mechanism
6. **System Errors**: Graceful degradation, contact support

### Recovery Actions:
- **Cart preservation** during validation failures
- **Address suggestions** for delivery issues
- **Alternative restaurants** for closed establishments
- **Stock notifications** for unavailable items

---

## Automation Notes

### High Priority for Automation:
- Test cases 1, 2 (successful checkout scenarios)
- Test cases 3, 4, 6 (validation failures)
- Test cases 8, 9, 20 (business logic validation)
- Test cases 10, 15, 16 (security testing)

### Test Data Management:
- Create fresh cart for each test
- Use valid addresses for customer
- Ensure restaurant is open during tests
- Clean up orders after test completion

### CI/CD Integration:
- Include in customer journey test suite
- Critical path for e-commerce functionality
- Monitor checkout success rates
- Track performance metrics for order creation
- Validate payment integration (if applicable)

### Monitoring & Alerts:
- **Checkout failure rate** > 5%
- **Response time** > 5 seconds
- **Cart abandonment** tracking
- **Restaurant availability** issues
