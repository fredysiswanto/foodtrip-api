/**
 * Customer Operations Load Test
 * Tests customer-specific operations: addresses, cart management, orders
 * Requires authentication
 *
 * Run: k6 run k6/03_customer_operations_test.ts --env BASE_URL=http://localhost:5000 --env SCENARIO=rampUp
 */

import http from 'k6/http'
import { check, group, Response } from 'k6'
import {
  SCENARIOS,
  THRESHOLDS,
  BASE_URL,
  API_VERSION,
  COMMON_HEADERS
} from './config.ts'
import {
  login,
  getAuthHeaders,
  validateResponse,
  parseResponse,
  generateTestName
} from './helpers.ts'

const scenario: string = __ENV.SCENARIO || 'rampUp'

export const options = {
  scenarios: {
    [scenario]: SCENARIOS[scenario]
  },
  thresholds: THRESHOLDS
}

export default function (): void {
  // Login first to get token
  const loginResponse = login('customer')

  if (!loginResponse.token) {
    console.error('Failed to login customer')
    return
  }

  const authHeaders = getAuthHeaders(loginResponse.token)

  group('Customer Address Operations', (): void => {
    let addressId: number | string | undefined = undefined

    // Create address
    group('Create Address', (): void => {
      const addressPayload: string = JSON.stringify({
        label: generateTestName('Address'),
        address: '123 Test Street',
        city: 'Test City',
        province: 'Test Province',
        postal_code: '12345',
        latitude: '0.0',
        longitude: '0.0',
        is_default: false
      })

      const response: Response = http.post(
        `${BASE_URL}${API_VERSION}/customer/address`,
        addressPayload,
        { headers: authHeaders }
      )

      validateResponse(response, 201, 'Create address successful')

      const data = parseResponse(response)
      addressId = (data as any).id

      check(response, {
        'address id returned': (r: Response) => {
          try {
            return parseResponse(r).id > 0
          } catch {
            return false
          }
        }
      })
    })

    // Get all addresses
    group('Get All Addresses', (): void => {
      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/address`,
        { headers: authHeaders }
      )

      validateResponse(response, 200, 'Get addresses successful')
    })

    // Get specific address
    if (addressId) {
      group('Get Specific Address', (): void => {
        const response: Response = http.get(
          `${BASE_URL}${API_VERSION}/customer/address/${addressId}`,
          { headers: authHeaders }
        )

        validateResponse(response, 200, 'Get address by ID successful')
      })

      // Update address
      group('Update Address', (): void => {
        const updatePayload: string = JSON.stringify({
          label: generateTestName('Updated Address'),
          address: '456 Updated Street',
          city: 'Updated City',
          province: 'Updated Province',
          postal_code: '54321'
        })

        const response: Response = http.put(
          `${BASE_URL}${API_VERSION}/customer/address/${addressId}`,
          updatePayload,
          { headers: authHeaders }
        )

        validateResponse(response, 200, 'Update address successful')
      })

      // Set as default
      group('Set Default Address', (): void => {
        const response: Response = http.put(
          `${BASE_URL}${API_VERSION}/customer/address/default/${addressId}`,
          '',
          { headers: authHeaders }
        )

        validateResponse(response, 200, 'Set default address successful')
      })
    }
  })

  group('Customer Cart Operations', (): void => {
    // Get all restaurants to find a dish
    const restaurants: Response = http.get(
      `${BASE_URL}${API_VERSION}/customer/restaurants`,
      { headers: authHeaders }
    )

    const restoData = parseResponse(restaurants)
    let dishId: number | undefined = undefined

    if (restoData && (restoData as any[]).length > 0) {
      // Try to get dishes
      const dishes: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/dishes`,
        { headers: authHeaders }
      )

      const dishData = parseResponse(dishes)
      if (dishData && (dishData as any[]).length > 0) {
        dishId = (dishData as any[])[0].id
      }
    }

    if (dishId) {
      // Add to cart
      group('Add to Cart', (): void => {
        const cartPayload: string = JSON.stringify({
          quantity: 2,
          special_instructions: 'No spicy'
        })

        const response: Response = http.post(
          `${BASE_URL}${API_VERSION}/customer/dish/${dishId}/add-to-cart`,
          cartPayload,
          { headers: authHeaders }
        )

        validateResponse(response, 201, 'Add to cart successful')
      })

      // Get cart
      group('Get Cart', (): void => {
        const response: Response = http.get(
          `${BASE_URL}${API_VERSION}/customer/cart`,
          { headers: authHeaders }
        )

        validateResponse(response, 200, 'Get cart successful')

        const data = parseResponse(response)

        check(response, {
          'cart items present': (r: Response) => {
            try {
              const cartData = parseResponse(r)
              return (
                (cartData as any).items && (cartData as any).items.length >= 0
              )
            } catch {
              return false
            }
          }
        })
      })
    }
  })

  group('Customer Account Info', (): void => {
    // Get account info
    group('Get Account Info', (): void => {
      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/account/info`,
        { headers: authHeaders }
      )

      validateResponse(response, 200, 'Get account info successful')
    })

    // Update account info
    group('Update Account Info', (): void => {
      const updatePayload: string = JSON.stringify({
        first_name: 'Test',
        last_name: 'User',
        phone_number: '1234567890'
      })

      const response: Response = http.put(
        `${BASE_URL}${API_VERSION}/customer/account/info`,
        updatePayload,
        { headers: authHeaders }
      )

      validateResponse(response, 200, 'Update account info successful')
    })
  })

  group('Customer Orders', (): void => {
    // Get all orders
    group('Get All Orders', (): void => {
      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/orders`,
        { headers: authHeaders }
      )

      validateResponse(response, 200, 'Get orders successful')
    })

    // Get order details (if orders exist)
    group('Get Order Details', (): void => {
      const ordersResponse: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/orders`,
        { headers: authHeaders }
      )

      const orders = parseResponse(ordersResponse)
      if (orders && (orders as any[]).length > 0) {
        const orderId: number = (orders as any[])[0].id
        const response: Response = http.get(
          `${BASE_URL}${API_VERSION}/customer/order/${orderId}`,
          { headers: authHeaders }
        )

        validateResponse(response, 200, 'Get order detail successful')
      }
    })
  })
}
