/**
 * Stress Test - Finding Breaking Point
 * Gradually increases load to find the maximum capacity of the API
 *
 * Run: k6 run k6/05_stress_test.js --env BASE_URL=http://localhost:5000
 */

import http from 'k6/http'
import { check, group } from 'k6'
import { BASE_URL, API_VERSION, COMMON_HEADERS, THRESHOLDS } from '../config.js'
import { validateResponse, parseResponse } from '../helpers.js'

export const options = {
  scenarios: {
    stress_test: {
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: '5m', target: 50, name: 'Ramp-up 1' }, // Test with 50 VUs
        { duration: '5m', target: 100, name: 'Ramp-up 2' }, // Test with 100 VUs
        { duration: '5m', target: 200, name: 'Ramp-up 3' }, // Test with 200 VUs
        { duration: '5m', target: 300, name: 'Ramp-up 4' }, // Test with 300 VUs
        { duration: '5m', target: 400, name: 'Ramp-up 5' }, // Test with 400 VUs
        { duration: '2m', target: 0, name: 'Cool down' } // Ramp down
      ]
    }
  },
  thresholds: {
    http_req_duration: ['p(95)<800', 'p(99)<2000'],
    http_req_failed: ['rate<0.5'],
    http_reqs: ['rate>50']
  }
}

export default function () {
  group('Stress Test - Read Heavy Operations', () => {
    group('Get Restaurants', () => {
      const response = http.get(`${BASE_URL}${API_VERSION}/home/restaurants`, {
        headers: COMMON_HEADERS
      })

      validateResponse(response, 200, 'Get restaurants successful')
    })

    group('Get Dishes', () => {
      const response = http.get(`${BASE_URL}${API_VERSION}/home/dishes`, {
        headers: COMMON_HEADERS
      })

      validateResponse(response, 200, 'Get dishes successful')
    })

    group('Get Dish Categories', () => {
      const response = http.get(`${BASE_URL}${API_VERSION}/home/dish-cat`, {
        headers: COMMON_HEADERS
      })

      validateResponse(response, 200, 'Get dish categories successful')
    })

    group('Get Restaurant Categories', () => {
      const response = http.get(
        `${BASE_URL}${API_VERSION}/home/resto-categories`,
        { headers: COMMON_HEADERS }
      )

      validateResponse(response, 200, 'Get resto categories successful')
    })

    group('Get Popular Items', () => {
      const response = http.get(
        `${BASE_URL}${API_VERSION}/customer/pop-dishes`,
        { headers: COMMON_HEADERS }
      )

      validateResponse(response, 200, 'Get popular dishes successful')
    })
  })
}
