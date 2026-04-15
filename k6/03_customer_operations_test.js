/**
 * Customer Operations Load Test
 * Tests customer-specific operations: addresses, cart management, orders
 * Requires authentication
 *
 * Run: k6 run k6/03_customer_operations_test.js --env BASE_URL=http://localhost:5000 --env SCENARIO=rampUp
 */

import http from 'k6/http'
import { check, group } from 'k6'
import {
  SCENARIOS,
  THRESHOLDS,
  BASE_URL,
  API_VERSION,
  COMMON_HEADERS
} from './config.js'
import {
  login,
  getAuthHeaders,
  validateResponse,
  parseResponse,
  generateTestName
} from './helpers.js'

const scenario = __ENV.SCENARIO || 'rampUp'

export const options = {
  scenarios: {
    [scenario]: SCENARIOS[scenario]
  },
  thresholds: THRESHOLDS
}

export default function () {
  // Login first to get token
  const loginResponse = login('customer')

  if (!loginResponse.token) {
    console.error('Failed to login customer')
    return
  }

  const authHeaders = getAuthHeaders(loginResponse.token)

  group('Customer Address Operations', () => {
    let addressId = null

    // Create address
    group('Create Address', () => {
      const addressPayload = JSON.stringify({
        label: generateTestName('Address'),
        address: '123 Test Street',
        city: 'Test City',
        province: 'Test Province',
        postal_code: '12345',
        latitude: '0.0',
        longitude: '0.0',
        is_default: false
      })

      const response = http.post(
        `${BASE_URL}${API_VERSION}/customer/address`,
        addressPayload,
        { headers: authHeaders }
      )

      validateResponse(response, 201, 'Create address successful')

      const data = parseResponse(response)
      addressId = data.id

      check(response, {
        'address id returned': r => {
          try {
            return parseResponse(r).id > 0
          } catch {
            return false
          }
        }
      })
    })

    // Get all addresses
    group('Get All Addresses', () => {
      const response = http.get(`${BASE_URL}${API_VERSION}/customer/address`, {
        headers: authHeaders
      })

      validateResponse(response, 200, 'Get addresses successful')
    })

    // Get specific address
    if (addressId) {
      group('Get Specific Address', () => {
        const response = http.get(
          `${BASE_URL}${API_VERSION}/customer/address/${addressId}`,
          { headers: authHeaders }
        )

        validateResponse(response, 200, 'Get address by ID successful')
      })

      // Update address
      group('Update Address', () => {
        const updatePayload = JSON.stringify({
          label: generateTestName('Updated Address'),
          address: '456 Updated Street',
          city: 'Updated City',
          province: 'Updated Province',
          postal_code: '54321'
        })

        const response = http.put(
          `${BASE_URL}${API_VERSION}/customer/address/${addressId}`,
          updatePayload,
          { headers: authHeaders }
        )

        validateResponse(response, 200, 'Update address successful')
      })

      // Set as default
      group('Set Default Address', () => {
        const response = http.put(
          `${BASE_URL}${API_VERSION}/customer/address/default/${addressId}`,
          '',
          { headers: authHeaders }
        )

        validateResponse(response, 200, 'Set default address successful')
      })
    }
  })

  group('Customer Cart Operations', () => {
    // Get all restaurants to find a dish
    const restaurants = http.get(
      `${BASE_URL}${API_VERSION}/customer/restaurants`,
      { headers: authHeaders }
    )

    const restoData = parseResponse(restaurants)
    let dishId = null

    if (restoData && restoData.length > 0) {
      // Try to get dishes
      const dishes = http.get(`${BASE_URL}${API_VERSION}/customer/dishes`, {
        headers: authHeaders
      })

      const dishData = parseResponse(dishes)
      if (dishData && dishData.length > 0) {
        dishId = dishData[0].id
      }
    }

    if (dishId) {
      // Add to cart
      group('Add to Cart', () => {
        const cartPayload = JSON.stringify({
          quantity: 2,
          special_instructions: 'No spicy'
        })

        const response = http.post(
          `${BASE_URL}${API_VERSION}/customer/dish/${dishId}/add-to-cart`,
          cartPayload,
          { headers: authHeaders }
        )

        validateResponse(response, 201, 'Add to cart successful')
      })

      // Get cart
      group('Get Cart', () => {
        const response = http.get(`${BASE_URL}${API_VERSION}/customer/cart`, {
          headers: authHeaders
        })

        validateResponse(response, 200, 'Get cart successful')

        const data = parseResponse(response)

        check(response, {
          'cart items present': r => {
            try {
              const cartData = parseResponse(r)
              return cartData.items && cartData.items.length >= 0
            } catch {
              return false
            }
          }
        })
      })
    }
  })

  group('Customer Account Info', () => {
    // Get account info
    group('Get Account Info', () => {
      const response = http.get(
        `${BASE_URL}${API_VERSION}/customer/account/info`,
        { headers: authHeaders }
      )

      validateResponse(response, 200, 'Get account info successful')
    })

    // Update account info
    group('Update Account Info', () => {
      const updatePayload = JSON.stringify({
        first_name: 'Test',
        last_name: 'User',
        phone_number: '1234567890'
      })

      const response = http.put(
        `${BASE_URL}${API_VERSION}/customer/account/info`,
        updatePayload,
        { headers: authHeaders }
      )

      validateResponse(response, 200, 'Update account info successful')
    })
  })

  group('Customer Orders', () => {
    // Get all orders
    group('Get All Orders', () => {
      const response = http.get(`${BASE_URL}${API_VERSION}/customer/orders`, {
        headers: authHeaders
      })

      validateResponse(response, 200, 'Get orders successful')
    })

    // Get order details (if orders exist)
    group('Get Order Details', () => {
      const ordersResponse = http.get(
        `${BASE_URL}${API_VERSION}/customer/orders`,
        { headers: authHeaders }
      )

      const orders = parseResponse(ordersResponse)
      if (orders && orders.length > 0) {
        const orderId = orders[0].id

        const response = http.get(
          `${BASE_URL}${API_VERSION}/customer/order/${orderId}`,
          { headers: authHeaders }
        )

        validateResponse(response, 200, 'Get order detail successful')
      }
    })
  })
}
