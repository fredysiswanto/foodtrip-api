// K6 Load Testing Configuration
// Central configuration for all test scenarios

interface User {
  email: string
  password: string
}

interface TestUsers {
  admin: User
  customer: User
  restoAdmin: User
}

interface ScenarioStage {
  duration: string
  target: number
  name?: string
}

interface Scenario {
  executor: string
  vus?: number
  duration?: string
  startVUs?: number
  stages?: ScenarioStage[]
  // description: string
}

interface Scenarios {
  [key: string]: Scenario
}

interface Thresholds {
  [key: string]: string[]
}

export const BASE_URL: string = __ENV.BASE_URL || 'http://localhost:5000'
export const API_VERSION: string = '/api/v1'

// Test Users Credentials
export const TEST_USERS: TestUsers = {
  admin: {
    email: 'paultulod@pm.me',
    password: 'Admin@123'
  },
  customer: {
    email: 'princess28@gmail.com',
    password: 'Customer@123'
  },
  restoAdmin: {
    email: 'Roderick@gmail.com',
    password: 'RestoAdmin@123'
  }
}

// Load Test Scenarios Configuration
export const SCENARIOS: Scenarios = {
  // Smoke Test - Basic functionality check
  smoke: {
    executor: 'constant-vus',
    vus: 1,
    duration: '30s'
    // description: 'Smoke test to verify API is working'
  },

  // Ramp Up - Gradually increase load
  rampUp: {
    executor: 'ramp-vus',
    startVUs: 0,
    stages: [
      { duration: '2m', target: 10 }, // Ramp up to 10 users
      { duration: '3m', target: 20 }, // Ramp up to 20 users
      { duration: '2m', target: 0 } // Ramp down
    ]
    // description: 'Ramp-up test to gradually increase load'
  },

  // Spike Test - Sudden spike in traffic
  spike: {
    executor: 'ramping-vus',
    startVUs: 10,
    stages: [
      { duration: '10s', target: 10 }, // Start with 10 users
      { duration: '1m', target: 100 }, // Spike to 100 users
      { duration: '30s', target: 10 }, // Return to 10 users
      { duration: '20s', target: 0 } // Ramp down
    ]
    // description: 'Spike test to check system behavior under sudden load'
  },

  // Soak Test - Long duration at constant load
  soak: {
    executor: 'constant-vus',
    vus: 20,
    duration: '10m'
    // description: 'Soak test with constant load for extended period'
  },

  // Stress Test - Increase load until system breaks
  stress: {
    executor: 'ramping-vus',
    startVUs: 0,
    stages: [
      { duration: '5m', target: 50 }, // Ramp up to 50
      { duration: '5m', target: 100 }, // Ramp up to 100
      { duration: '5m', target: 200 }, // Ramp up to 200
      { duration: '5m', target: 300 }, // Continue increasing
      { duration: '2m', target: 0 } // Ramp down
    ]
    // description: 'Stress test to find breaking point'
  },

  // Peak Load - Simulate peak hour traffic
  peakLoad: {
    executor: 'ramping-vus',
    startVUs: 10,
    stages: [
      { duration: '2m', target: 50 }, // Build up to peak
      { duration: '5m', target: 50 }, // Maintain peak
      { duration: '2m', target: 0 } // Cool down
    ]
    // description: 'Peak load test simulating high traffic period'
  }
}

// Thresholds for performance validation
export const THRESHOLDS: Thresholds = {
  http_req_duration: ['p(95)<500', 'p(99)<1000'], // 95th percentile must be < 500ms, 99th < 1000ms
  http_req_failed: ['rate<0.1'], // Error rate must be < 10%
  http_reqs: ['rate>100'], // At least 100 requests per second
  checks: ['rate>0.95'] // 95% of checks should pass
}

// Common HTTP headers
export const COMMON_HEADERS: Record<string, string> = {
  'Content-Type': 'application/json',
  Accept: 'application/json'
}
