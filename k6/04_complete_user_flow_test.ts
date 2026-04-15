/**
 * Complete User Flow Load Test
 * Simulates a real user journey: login -> browse -> add to cart -> checkout
 * This is a more realistic scenario that tests the full user experience
 *
 * Run: k6 run k6/04_complete_user_flow_test.ts --env BASE_URL=http://localhost:5000 --env SCENARIO=spike
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
  parseResponse
} from './helpers.ts'

const scenario: string = __ENV.SCENARIO || 'spike'

export const options = {
  scenarios: {
    [scenario]: SCENARIOS[scenario]
  },
  thresholds: THRESHOLDS
}

export default function (): void {
  group('Complete User Flow', (): void => {
    // Step 1: Login
    group('Step 1: User Login', (): void => {
      const loginResponse = login('customer')

      if (!loginResponse || !loginResponse.token) {
        throw new Error('Failed to login')
      }
    })

    // Step 2: Browse restaurants
    group('Step 2: Browse Restaurants', (): void => {
      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/restaurants`,
        { headers: COMMON_HEADERS }
      )

      validateResponse(response, 200, 'Browse restaurants successful')
    })

    // Step 3: View restaurant details
    group('Step 3: View Restaurant Details', (): void => {
      const restos: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/restaurants`,
        { headers: COMMON_HEADERS }
      )

      const restoData = parseResponse(restos)
      if (restoData && (restoData as any[]).length > 0) {
        const restoId: number = (restoData as any[])[0].id
        const response: Response = http.get(
          `${BASE_URL}${API_VERSION}/customer/restaurant/${restoId}`,
          { headers: COMMON_HEADERS }
        )

        validateResponse(response, 200, 'Get restaurant details successful')
      }
    })

    // Step 4: Browse popular dishes and categories
    group('Step 4: Explore Dishes and Categories', (): void => {
      group('Get Popular Dishes', (): void => {
        const response: Response = http.get(
          `${BASE_URL}${API_VERSION}/customer/pop-dishes`,
          { headers: COMMON_HEADERS }
        )

        validateResponse(response, 200, 'Get popular dishes successful')
      })

      group('Get Dish Categories', (): void => {
        const response: Response = http.get(
          `${BASE_URL}${API_VERSION}/customer/dish-cat`,
          { headers: COMMON_HEADERS }
        )

        validateResponse(response, 200, 'Get dish categories successful')
      })
    })

    // Step 5: Login and add items to cart
    group('Step 5: Add Items to Cart', (): void => {
      const loginData = login('customer')

      if (!loginData.token) {
        console.error('Failed to login for cart operations')
        return
      }

      const authHeaders = getAuthHeaders(loginData.token)

      // Get dishes
      const dishes: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/dishes`,
        { headers: authHeaders }
      )

      const dishData = parseResponse(dishes)

      if (dishData && (dishData as any[]).length > 0) {
        // Add first dish to cart
        const firstDishId: number = (dishData as any[])[0].id
        const cartPayload: string = JSON.stringify({
          quantity: 1,
          special_instructions: ''
        })

        const response: Response = http.post(
          `${BASE_URL}${API_VERSION}/customer/dish/${firstDishId}/add-to-cart`,
          cartPayload,
          { headers: authHeaders }
        )

        validateResponse(response, 201, 'Add item to cart successful')

        // Add second dish if available
        if ((dishData as any[]).length > 1) {
          const secondDishId: number = (dishData as any[])[1].id
          const cartPayload2: string = JSON.stringify({
            quantity: 2,
            special_instructions: 'Extra spicy'
          })

          const response2: Response = http.post(
            `${BASE_URL}${API_VERSION}/customer/dish/${secondDishId}/add-to-cart`,
            cartPayload2,
            { headers: authHeaders }
          )

          validateResponse(response2, 201, 'Add second item to cart successful')
        }
      }
    })

    // Step 6: View cart
    group('Step 6: View Cart', (): void => {
      const loginData = login('customer')

      if (!loginData.token) return

      const authHeaders = getAuthHeaders(loginData.token)

      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/cart`,
        { headers: authHeaders }
      )

      validateResponse(response, 200, 'Get cart successful')

      check(response, {
        'cart response is valid': (r: Response) => {
          try {
            const data = parseResponse(r)
            return data !== null
          } catch {
            return false
          }
        }
      })
    })

    // Step 7: Prepare checkout (create address if needed)
    group('Step 7: Prepare Checkout', (): void => {
      const loginData = login('customer')

      if (!loginData.token) return

      const authHeaders = getAuthHeaders(loginData.token)

      // Get addresses
      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/address`,
        { headers: authHeaders }
      )

      validateResponse(response, 200, 'Get addresses successful')
    })

    // Step 8: Process order
    group('Step 8: Create Order', (): void => {
      const loginData = login('customer')

      if (!loginData.token) return

      const authHeaders = getAuthHeaders(loginData.token)

      // Get cart details first
      const cartResponse: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/cart`,
        { headers: authHeaders }
      )

      const cartData = parseResponse(cartResponse)

      // Get an address
      const addressResponse: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/address`,
        { headers: authHeaders }
      )

      const addresses = parseResponse(addressResponse)

      if (Array.isArray(addresses) && addresses.length > 0) {
        const addressId: number = addresses[0].id
        const orderPayload: string = JSON.stringify({
          delivery_address_id: addressId,
          delivery_method: 'delivery',
          special_instructions: 'Please ring the doorbell',
          payment_method: 'cash'
        })

        const response: Response = http.post(
          `${BASE_URL}${API_VERSION}/customer/order`,
          orderPayload,
          { headers: authHeaders }
        )

        check(response, {
          'order created or failed gracefully': (r: Response) => {
            return r.status === 201 || r.status === 400 || r.status === 422
          }
        })
      }
    })

    // Step 9: View order history
    group('Step 9: View Order History', (): void => {
      const loginData = login('customer')

      if (!loginData.token) return

      const authHeaders = getAuthHeaders(loginData.token)

      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/orders`,
        { headers: authHeaders }
      )

      validateResponse(response, 200, 'Get order history successful')
    })
  })
}
