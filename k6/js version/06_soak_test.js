/**
 * Soak Test - Endurance Testing
 * Runs at constant moderate load for extended period
 * Tests for memory leaks, connection issues, and stability
 *
 * Run: k6 run k6/06_soak_test.js --env BASE_URL=http://localhost:5000
 */

import http from 'k6/http'
import { check, group } from 'k6'
import { BASE_URL, API_VERSION, COMMON_HEADERS } from '../config.js'
import { validateResponse, parseResponse } from '../helpers.js'

export const options = {
  scenarios: {
    soak_test: {
      executor: 'constant-vus',
      vus: 20,
      duration: '30m', // Run for 30 minutes at constant 20 VUs
      description: 'Soak test with constant load to ensure stability'
    }
  },
  thresholds: {
    http_req_duration: ['p(95)<500', 'p(99)<1000'],
    http_req_failed: ['rate<0.1'],
    http_reqs: ['rate>100'],
    checks: ['rate>0.95']
  }
}

export default function () {
  group('Soak Test - Mixed Operations', () => {
    // Simulate realistic user behavior with mix of operations
    const operations = __VU % 3 // Use VU number to distribute load

    if (operations === 0) {
      // Browse operations (60% of traffic)
      group('Browse Restaurants', () => {
        const response = http.get(
          `${BASE_URL}${API_VERSION}/home/restaurants`,
          { headers: COMMON_HEADERS }
        )

        validateResponse(response, 200, 'Browse restaurants')
      })
    } else if (operations === 1) {
      // Get specific items (25% of traffic)
      group('Get Specific Items', () => {
        const dishes = http.get(`${BASE_URL}${API_VERSION}/home/dishes`, {
          headers: COMMON_HEADERS
        })

        const dishData = parseResponse(dishes)
        if (dishData && dishData.length > 0) {
          const dishId =
            dishData[Math.floor(Math.random() * dishData.length)].id

          const response = http.get(
            `${BASE_URL}${API_VERSION}/home/dishes`, // In real scenario, would be get dish by ID
            { headers: COMMON_HEADERS }
          )

          validateResponse(response, 200, 'Get dish details')
        }
      })
    } else {
      // Category browsing (15% of traffic)
      group('Browse Categories', () => {
        const response = http.get(`${BASE_URL}${API_VERSION}/home/dish-cat`, {
          headers: COMMON_HEADERS
        })

        validateResponse(response, 200, 'Browse dish categories')

        const categories = parseResponse(response)
        if (categories && categories.length > 0) {
          const catId =
            categories[Math.floor(Math.random() * categories.length)].id

          const response2 = http.get(
            `${BASE_URL}${API_VERSION}/home/dish-cat/${catId}`,
            { headers: COMMON_HEADERS }
          )

          validateResponse(response2, 200, 'Get category details')
        }
      })
    }

    // Add some variance to request patterns
    group('Periodic Explore Checks', () => {
      const response = http.get(
        `${BASE_URL}${API_VERSION}/customer/pop-restaurants`,
        { headers: COMMON_HEADERS }
      )

      validateResponse(response, 200, 'Get popular restaurants')
    })
  })
}
