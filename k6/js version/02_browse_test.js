/**
 * Read Operations Load Test
 * Tests GET endpoints (browse restaurants, dishes, categories)
 * These are typically high-frequency operations in production
 *
 * Run: k6 run k6/02_browse_test.js --env BASE_URL=http://localhost:5000 --env SCENARIO=rampUp
 */

import http from 'k6/http'
import { check, group } from 'k6'
import {
  SCENARIOS,
  THRESHOLDS,
  BASE_URL,
  API_VERSION,
  COMMON_HEADERS
} from '../config.js'
import { validateResponse, parseResponse } from '../helpers.js'

const scenario = __ENV.SCENARIO || 'rampUp'

export const options = {
  scenarios: {
    [scenario]: SCENARIOS[scenario]
  },
  thresholds: THRESHOLDS
}

export default function () {
  group('Browse Operations', () => {
    // Get all restaurants
    group('Get All Restaurants', () => {
      const response = http.get(`${BASE_URL}${API_VERSION}/home/restaurants`, {
        headers: COMMON_HEADERS
      })

      validateResponse(response, 200, 'Get restaurants successful')

      check(response, {
        'restaurants response is array': r => {
          try {
            const data = parseResponse(r)
            return Array.isArray(data)
          } catch {
            return false
          }
        }
      })
    })

    // Get specific restaurant
    group('Get Specific Restaurant', () => {
      const restaurants = http.get(
        `${BASE_URL}${API_VERSION}/home/restaurants`,
        { headers: COMMON_HEADERS }
      )

      const data = parseResponse(restaurants)
      if (data && data.length > 0) {
        const restoId = data[0].id

        const response = http.get(
          `${BASE_URL}${API_VERSION}/home/restaurant/${restoId}`,
          { headers: COMMON_HEADERS }
        )

        validateResponse(response, 200, 'Get restaurant by ID successful')
      }
    })

    // Get all dishes
    group('Get All Dishes', () => {
      const response = http.get(`${BASE_URL}${API_VERSION}/home/dishes`, {
        headers: COMMON_HEADERS
      })

      validateResponse(response, 200, 'Get dishes successful')

      check(response, {
        'dishes response is array': r => {
          try {
            const data = parseResponse(r)
            return Array.isArray(data)
          } catch {
            return false
          }
        }
      })
    })

    // Get dish categories
    group('Get Dish Categories', () => {
      const response = http.get(`${BASE_URL}${API_VERSION}/home/dish-cat`, {
        headers: COMMON_HEADERS
      })

      validateResponse(response, 200, 'Get dish categories successful')
    })

    // Get specific dish category
    group('Get Specific Dish Category', () => {
      const categories = http.get(`${BASE_URL}${API_VERSION}/home/dish-cat`, {
        headers: COMMON_HEADERS
      })

      const data = parseResponse(categories)
      if (data && data.length > 0) {
        const catId = data[0].id

        const response = http.get(
          `${BASE_URL}${API_VERSION}/home/dish-cat/${catId}`,
          { headers: COMMON_HEADERS }
        )

        validateResponse(response, 200, 'Get dish category by ID successful')
      }
    })

    // Get restaurant categories
    group('Get Restaurant Categories', () => {
      const response = http.get(
        `${BASE_URL}${API_VERSION}/home/resto-categories`,
        { headers: COMMON_HEADERS }
      )

      validateResponse(response, 200, 'Get restaurant categories successful')
    })

    // Explore - Get popular dishes and restaurants
    group('Explore Features', () => {
      group('Get Popular Dishes', () => {
        const response = http.get(
          `${BASE_URL}${API_VERSION}/customer/pop-dishes`,
          { headers: COMMON_HEADERS }
        )

        validateResponse(response, 200, 'Get popular dishes successful')
      })

      group('Get Popular Restaurants', () => {
        const response = http.get(
          `${BASE_URL}${API_VERSION}/customer/pop-restaurants`,
          { headers: COMMON_HEADERS }
        )

        validateResponse(response, 200, 'Get popular restaurants successful')
      })

      group('Get Some Restaurant Categories', () => {
        const response = http.get(
          `${BASE_URL}${API_VERSION}/customer/some-resto-cat`,
          { headers: COMMON_HEADERS }
        )

        validateResponse(
          response,
          200,
          'Get some restaurant categories successful'
        )
      })
    })
  })
}
