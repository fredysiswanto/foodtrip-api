/**
 * Authentication Load Test
 * Tests the login endpoints under various load conditions
 *
 * Run: k6 run k6/01_auth_test.js --env BASE_URL=http://localhost:5000
 */

import http from 'k6/http'
import { check, group } from 'k6'
import {
  SCENARIOS,
  THRESHOLDS,
  BASE_URL,
  API_VERSION,
  TEST_USERS,
  COMMON_HEADERS
} from './config.js'
import { login, validateResponse } from './helpers.js'

// Use smoke test scenario by default, can be overridden
const scenario = __ENV.SCENARIO || 'smoke'

export const options = {
  scenarios: {
    [scenario]: SCENARIOS[scenario]
  },
  thresholds: THRESHOLDS
}

export default function () {
  group('Authentication Tests', () => {
    // Test Customer Login
    group('Customer Login', () => {
      const response = login('customer')

      check(response, {
        'customer login token received': r => r.token.length > 0,
        'customer login status 200': r => r.statusCode === 200
      })
    })

    // Test Admin Login
    group('Admin Login', () => {
      const response = login('admin')

      check(response, {
        'admin login token received': r => r.token.length > 0,
        'admin login status 200': r => r.statusCode === 200
      })
    })

    // Test Restaurant Admin Login
    group('Restaurant Admin Login', () => {
      const response = login('restoAdmin')

      check(response, {
        'resto admin login token received': r => r.token.length > 0,
        'resto admin login status 200': r => r.statusCode === 200
      })
    })

    // Test Invalid Login
    group('Invalid Login', () => {
      const invalidPayload = JSON.stringify({
        email_address: 'nonexistent@test.com',
        password: 'wrongpassword'
      })

      const response = http.post(
        `${BASE_URL}${API_VERSION}/home/login`,
        invalidPayload,
        { headers: COMMON_HEADERS }
      )

      check(response, {
        'invalid login rejected': r => r.status !== 200,
        'error response returned': r => r.body.length > 0
      })
    })
  })
}
