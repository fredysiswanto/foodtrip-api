// K6 Helper Functions
// Common utilities for load testing

import http from 'k6/http'
import { check, Response } from 'k6'
import { BASE_URL, API_VERSION, TEST_USERS, COMMON_HEADERS } from './config.ts'

interface LoginResponse {
  token: string
  statusCode: number
  userId?: number | string
  userType?: string
  error?: string
}

interface ParsedResponse {
  [key: string]: any
}

interface AuthHeaders extends Record<string, string> {
  Authorization: string
}

type UserType = 'admin' | 'customer' | 'restoAdmin'

/**
 * Login to the application and return the JWT token
 * @param {UserType} userType - Type of user: 'admin', 'customer', or 'restoAdmin'
 * @returns {LoginResponse} - { token: string, statusCode: number }
 */
export function login(userType: UserType = 'customer'): LoginResponse {
  const user = TEST_USERS[userType]

  const payload: string = JSON.stringify({
    email_address: user.email,
    password: user.password
  })

  const response: Response = http.post(
    `${BASE_URL}${API_VERSION}/home/login`,
    payload,
    { headers: COMMON_HEADERS }
  )

  check(response, {
    [`${userType} login successful`]: (r: Response) => r.status === 200,
    'login returns token': (r: Response) => {
      try {
        const body = JSON.parse(r.body)
        return body.data && body.data.access_token
      } catch {
        return false
      }
    }
  })

  try {
    const body: ParsedResponse = JSON.parse(response.body)
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
 * @returns {AuthHeaders} - Headers object with authorization
 */
export function getAuthHeaders(token: string): AuthHeaders {
  return {
    ...COMMON_HEADERS,
    Authorization: `Bearer ${token}`
  }
}

/**
 * Verify response has expected status and structure
 * @param {Response} response - HTTP response object
 * @param {number} expectedStatus - Expected HTTP status code
 * @param {string} checkName - Name for the check
 * @returns {boolean} - True if response matches expectations
 */
export function validateResponse(
  response: Response,
  expectedStatus: number = 200,
  checkName: string = 'Response OK'
): boolean {
  return check(response, {
    [checkName]: (r: Response) => r.status === expectedStatus,
    'response has content': (r: Response) => r.body.length > 0
  })
}

/**
 * Extract data from API response
 * @param {Response} response - HTTP response object
 * @returns {ParsedResponse|any[]} - Parsed response data or empty object
 */
export function parseResponse(response: Response): ParsedResponse | any[] {
  try {
    const body: ParsedResponse = JSON.parse(response.body)
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
export function generateRandomString(length: number = 10): string {
  let result: string = ''
  const chars: string =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
  for (let i = 0; i < length; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length))
  }
  return result
}

/**
 * Sleep for specified duration
 * @param {number} seconds - Duration in seconds
 */
export function sleep(seconds: number): void {
  const start: number = Date.now()
  while (Date.now() < start + seconds * 1000) {
    // Busy wait
  }
}

/**
 * Generate mock name with random part
 * @param {string} prefix - Prefix for the name
 * @returns {string} - Generated name
 */
export function generateTestName(prefix: string = 'Test'): string {
  return `${prefix}_${Date.now()}_${Math.random().toString(36).substring(7)}`
}
