/**
 * Spike Test
 * Tests system behavior when traffic suddenly spikes
 * Useful for identifying connection pool exhaustion, queue handling, etc.
 *
 * Run: k6 run k6/07_spike_test.ts --env BASE_URL=http://localhost:5000
 */

import http from 'k6/http'
import { check, group, Response } from 'k6'
import { BASE_URL, API_VERSION, COMMON_HEADERS } from './config.ts'
import { validateResponse } from './helpers.ts'

export const options = {
  scenarios: {
    spike_test: {
      executor: 'ramping-vus',
      startVUs: 5,
      stages: [
        { duration: '30s', target: 5, name: 'Initial load' }, // Start at 5 users
        { duration: '10s', target: 100, name: 'Spike!' }, // Spike to 100 users
        { duration: '1m', target: 100, name: 'Maintain spike' }, // Keep 100 users
        { duration: '10s', target: 5, name: 'Drop back' }, // Drop to 5 users
        { duration: '30s', target: 0, name: 'Complete cooldown' } // Ramp down
      ]
    }
  },
  thresholds: {
    http_req_duration: ['p(95)<1500', 'p(99)<3000'],
    http_req_failed: ['rate<0.2'],
    http_reqs: ['rate>50']
  }
}

export default function (): void {
  group('Spike Test - High Load Surge', (): void => {
    group('Browse Operations', (): void => {
      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/home/restaurants`,
        { headers: COMMON_HEADERS }
      )

      check(response, {
        'restaurants - status OK or timeout': (r: Response) =>
          r.status === 200 || r.status === 0
      })
    })

    group('Search Operations', (): void => {
      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/home/dishes`,
        { headers: COMMON_HEADERS }
      )

      check(response, {
        'dishes - status OK or timeout': (r: Response) =>
          r.status === 200 || r.status === 0
      })
    })

    group('Category Operations', (): void => {
      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/home/dish-cat`,
        { headers: COMMON_HEADERS }
      )

      check(response, {
        'categories - status OK or timeout': (r: Response) =>
          r.status === 200 || r.status === 0
      })
    })

    group('Explore Operations', (): void => {
      const response: Response = http.get(
        `${BASE_URL}${API_VERSION}/customer/pop-dishes`,
        { headers: COMMON_HEADERS }
      )

      check(response, {
        'popular - status OK or timeout': (r: Response) =>
          r.status === 200 || r.status === 0
      })
    })
  })
}
