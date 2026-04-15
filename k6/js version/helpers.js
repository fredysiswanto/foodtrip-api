// K6 Helper Functions
// Common utilities for load testing

import http from 'k6/http'
import { check } from 'k6'
import { BASE_URL, API_VERSION, TEST_USERS, COMMON_HEADERS } from '../config.js'

/**
 * Login to the application and return the JWT token
 * @param {string} userType - Type of user: 'admin', 'customer', or 'restoAdmin'
 * @returns {object} - { token: string, statusCode: number }
 */
export function login(userType = 'customer') {
  const user = TEST_USERS[userType]

  const payload = JSON.stringify({
    email_address: user.email,
    password: user.password
  })

  const response = http.post(`${BASE_URL}${API_VERSION}/home/login`, payload, {
    headers: COMMON_HEADERS
  })

  check(response, {
    [`${userType} login successful`]: r => r.status === 200,
    'login returns token': r => {
      try {
        const body = JSON.parse(r.body)
        return body.data && body.data.access_token
      } catch {
        return false
      }
    }
  })

  try {
    const body = JSON.parse(response.body)
    return {
      token: body.data?.access_token || '',
      statusCode: response.status,
      userId: body.data?.id,
      userType: body.data?.user_type
    }
  } catch {
    return {
      token: '',
      statusCode: response.status,
      error: 'Failed to parse login response'
    }
  }
}

/**
 * Get authorization header with JWT token
 * @param {string} token - JWT token
 * @returns {object} - Headers object with authorization
 */
export function getAuthHeaders(token) {
  return {
    ...COMMON_HEADERS,
    Authorization: `Bearer ${token}`
  }
}

/**
 * Verify response has expected status and structure
 * @param {object} response - HTTP response object
 * @param {number} expectedStatus - Expected HTTP status code
 * @param {string} checkName - Name for the check
 * @returns {boolean} - True if response matches expectations
 */
export function validateResponse(
  response,
  expectedStatus = 200,
  checkName = 'Response OK'
) {
  return check(response, {
    [checkName]: r => r.status === expectedStatus,
    'response has content': r => r.body.length > 0
  })
}

/**
 * Extract data from API response
 * @param {object} response - HTTP response object
 * @returns {object|array} - Parsed response data or empty object
 */
export function parseResponse(response) {
  try {
    const body = JSON.parse(response.body)
    return body.data || body
  } catch {
    return {}
  }
}

/**
 * Generate random string for testing
 * @param {number} length - Length of string
 * @returns {string} - Random string
 */
export function generateRandomString(length = 10) {
  let result = ''
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
  for (let i = 0; i < length; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length))
  }
  return result
}

/**
 * Sleep for specified duration
 * @param {number} seconds - Duration in seconds
 */
export function sleep(seconds) {
  const start = Date.now()
  while (Date.now() < start + seconds * 1000) {
    // Busy wait
  }
}

/**
 * Generate mock name with random part
 * @param {string} prefix - Prefix for the name
 * @returns {string} - Generated name
 */
export function generateTestName(prefix = 'Test') {
  return `${prefix}_${Date.now()}_${Math.random().toString(36).substring(7)}`
}
