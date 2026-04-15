# K6 Load Testing Architecture

## Overview

FoodTrip API K6 load testing suite dirancang untuk comprehensive testing dengan berbagai scenario dan user patterns.

## File Structure

```
k6/
├── config.js                        # Global configuration
├── helpers.js                       # Reusable functions
├── 01_auth_test.js                 # Authentication testing
├── 02_browse_test.js               # Read operations
├── 03_customer_operations_test.js  # CRUD operations
├── 04_complete_user_flow_test.js   # End-to-end flows
├── 05_stress_test.js               # Stress testing
├── 06_soak_test.js                 # Endurance testing
├── 07_spike_test.js                # Traffic spike testing
├── generate-report.js              # Report generator
├── run_tests.sh                    # Interactive test runner
├── README.md                       # Full documentation
├── QUICK_START.md                  # Quick start guide
└── ARCHITECTURE.md                 # This file
```

## Component Diagram

```
┌─────────────────────────────────────────────────────────┐
│                    K6 Test Suite                        │
└─────────────────────────────────────────────────────────┘
                           │
          ┌────────────────┼────────────────┐
          │                │                │
      ┌───▼────┐       ┌───▼────┐       ┌──▼────┐
      │ config │       │helpers │       │ tests │
      └───┬────┘       └───┬────┘       └──┬────┘
          │                │               │
    ┌─────▼─────┐    ┌─────▼─────┐   ┌────▼──────┐
    │ Scenarios │    │ Functions │   │ Test Cases│
    │ Thresholds│    │ Utilities │   │ Groups    │
    │ Users     │    │ Auth      │   │ Checks    │
    └─────┬─────┘    └─────┬─────┘   └────┬──────┘
          │                │               │
          └────────────────┼───────────────┘
                           │
                    ┌──────▼──────┐
                    │  FoodTrip   │
                    │     API     │
                    └─────┬───────┘
                          │
              ┌───────────┼───────────┐
              │           │           │
          ┌───▼──┐   ┌───▼──┐   ┌───▼──┐
          │ Auth │   │ Read │   │ CRUD │
          │Routes│   │Routes│   │Routes│
          └──────┘   └──────┘   └──────┘
```

## Test Execution Flow

```
START
  │
  ├─► Smoke Test (30s)
  │   └─ Verify API working
  │
  ├─► Authentication Tests (7m)
  │   ├─ Customer Login
  │   ├─ Admin Login
  │   ├─ Resto Admin Login
  │   └─ Invalid Login (error handling)
  │
  ├─► Browse Operations (7m)
  │   ├─ Get Restaurants
  │   ├─ Get Dishes
  │   ├─ Get Categories
  │   └─ Popular Items
  │
  ├─► Customer Operations (7m)
  │   ├─ Manage Addresses
  │   ├─ Cart Management
  │   ├─ Order Management
  │   └─ Account Info
  │
  ├─► Complete User Flow (varied duration)
  │   ├─ Login
  │   ├─ Browse
  │   ├─ Add to Cart
  │   └─ Checkout
  │
  ├─► Stress Test (27m)
  │   └─ Gradually increase load to breaking point
  │
  ├─► Soak Test (30m)
  │   └─ Long duration at constant load
  │
  ├─► Spike Test (~2-3m)
  │   └─ Sudden traffic surge
  │
  └─► Generate Report
      └─ Export metrics and analysis
```

## Load Scenario Patterns

### 1. Smoke Test
```
VUs
 │
1├─────────────────────
 │
 └─────────────────────► Time
 0              30s
```
- Quick sanity check
- Small duration
- Low VU count

### 2. Ramp-Up Test
```
VUs
 │     ▁▂▃▄▅▆▇█
20├─────────────╱╲
  │       ╱╱      ╲╲
10├─────╱╱         ╲╲
  │  ╱╱             ╲
 1├╱                 ╲___
 └────────────────────────► Time
 0 2m  3m  2m
```
- Gradual load increase
- Realistic traffic pattern
- Better for stability testing

### 3. Spike Test
```
VUs
 │
100├─────╭─────╮
   │     │     │
50 ├─────┤     ├────
   │  ╱╱ │     ╲╲
10 ├╱    │      ╲
 └─┴─────┴──────┴──► Time
 30s 10s  60s 10s 20s
```
- Sudden jump in traffic
- Tests system reaction
- Measures recovery speed

### 4. Soak Test
```
VUs
 │
20├─────────────────────────
  │ (constant for 30 min)
 1├─╱──────────────────────╲
 └─┴──────────────────────┴──► Time
 0s                     30min
```
- Find memory leaks
- Test stability
- Long running processes

### 5. Stress Test
```
VUs
 │   ▁▂▃▄▅▆▇█
400├─────────────┐
   │        ╱╱   │
200├─────╱╱──────┼─╱╲
   │  ╱╱         │    ╲
50 ├╱            │     ╲
 └─┴─────────────┴──────┴──► Time
 5m  5m 5m 5m 5m 2m
```
- Find breaking point
- Gradual increase
- Drop when needed

## Data Flow

```
┌────────────────────────────────────────┐
│         K6 Test Instance               │
├────────────────────────────────────────┤
│ VU Iteration:                          │
│                                        │
│  1. Setup (login, get token)          │
│     │                                  │
│     └──► getAuthHeaders()             │
│                                        │
│  2. Main Test Groups                   │
│     │                                  │
│     ├──► group("Browse")              │
│     │    └──► http.get()              │
│     │        └──► check()             │
│     │                                  │
│     └──► group("Cart")                │
│          └──► http.post()             │
│              └──► check()             │
│                                        │
│  3. Cleanup                            │
│     └──► Optional cleanup             │
│                                        │
└────────────────────────────────────────┘
         │
         │
         ▼
┌────────────────────────────────────────┐
│     Metrics Collection                 │
├────────────────────────────────────────┤
│ • http_req_duration                    │
│ • http_req_failed                      │
│ • http_reqs                            │
│ • checks                               │
│ • vus / vus_max                        │
│ • iterations                           │
│ • data_received / data_sent            │
└────────────────────────────────────────┘
         │
         │
         ▼
┌────────────────────────────────────────┐
│     Threshold Validation               │
├────────────────────────────────────────┤
│ ✓ http_req_duration p(95) < 500ms     │
│ ✓ http_req_failed rate < 0.1          │
│ ✓ http_reqs rate > 100                │
│ ✓ checks rate > 0.95                  │
└────────────────────────────────────────┘
         │
         │
         ▼
┌────────────────────────────────────────┐
│     Results & Report                   │
├────────────────────────────────────────┤
│ • JSON output (results.json)           │
│ • Summary export (summary.json)        │
│ • Generated report                     │
│ • Performance analysis                 │
└────────────────────────────────────────┘
```

## Helper Functions Flow

```
┌──────────────────┐
│   Test Script    │
└────────┬─────────┘
         │
    ┌────▼──────────────────────────┐
    │  login(userType)               │
    │  ├─ http.post() login endpoint │
    │  ├─ check() response           │
    │  └─ return token              │
    └────┬───────────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ getAuthHeaders(token)      │
    │ └─ Add Bearer token        │
    └────┬──────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ http.get/post/put/delete() │
    │ └─ Make request            │
    └────┬──────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ validateResponse()          │
    │ └─ check() status & format │
    └────┬──────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ parseResponse()             │
    │ └─ Extract data from JSON  │
    └────────────────────────────┘
```

## Test Coverage Matrix

```
                     │ Auth │Browse│CRUD │Flow │Stress│Soak │Spike
─────────────────────┼──────┼──────┼─────┼─────┼──────┼─────┼──────
Authentication       │  ✓   │      │     │  ✓  │  -   │  -  │  -
Browse/Read          │      │  ✓   │     │  ✓  │  ✓   │  ✓  │  ✓
Create/Update/Delete │      │      │  ✓  │  ✓  │  ✓   │  ✓  │  ✓
Complete Flow        │      │      │     │  ✓  │  ✓   │  ✓  │  ✓
Error Handling       │  ✓   │  ✓   │  ✓  │  ✓  │  ✓   │  ✓  │  ✓
Performance          │  ✓   │  ✓   │  ✓  │  ✓  │  ✓✓✓ │  ✓✓ │  ✓
Stability            │      │      │     │     │  ✓   │  ✓✓✓│  ✓
```

## Performance Targets

```
Target               │ Good │ Warning │ Critical
─────────────────────┼──────┼─────────┼─────────
p(95) Response Time  │<500ms│ >800ms  │ >2000ms
p(99) Response Time  │<1000ms│>1500ms │ >3000ms
Error Rate          │ <1%  │  5-10%  │ >10%
Throughput (req/s)  │>100  │  50-100 │ <50
Uptime              │ 100% │  99-99.9% │ <99%
```

## Configuration Management

```
config.js
│
├─ BASE_URL
│  └─ http://localhost:5000
│
├─ TEST_USERS
│  ├─ Admin credentials
│  ├─ Customer credentials
│  └─ Resto Admin credentials
│
├─ SCENARIOS
│  ├─ smoke
│  ├─ rampUp
│  ├─ spike
│  ├─ soak
│  ├─ stress
│  └─ peakLoad
│
└─ THRESHOLDS
   ├─ http_req_duration
   ├─ http_req_failed
   ├─ http_reqs
   └─ checks
```

## Integration Points

### 1. Pre-Test
- [ ] API server running
- [ ] Database connected
- [ ] Test data seeded
- [ ] Network stable

### 2. During Test
- Monitor CPU/Memory
- Watch error logs
- Track network usage
- Observe response times

### 3. Post-Test
- Collect metrics
- Generate reports
- Analyze bottlenecks
- Plan improvements

## Scaling Strategy

```
Load Testing Progression:

Week 1: Smoke Tests
└─ Basic functionality check

Week 2: Ramp-Up Tests
└─ Identify normal operating range

Week 3: User Flow Tests
└─ Realistic scenario validation

Week 4: Stress/Soak Tests
└─ Find limits and stability

Week 5: Optimization
└─ Fix bottlenecks
└─ Improve performance

Week 6: Production Load Tests
└─ Real traffic patterns
└─ Final validation
```

## Troubleshooting decision tree

```
Test Failed?
│
├─ Connection Error
│  └─ Check API is running
│
├─ High Error Rate (>5%)
│  ├─ Database issues
│  ├─ Memory/CPU limit
│  └─ Network problems
│
├─ Slow Response Times
│  ├─ Database query optimization
│  ├─ Add caching layer
│  └─ Scale horizontally
│
└─ Threshold Failed
   ├─ Relax thresholds
   └─ Optimize code
```

---

For more details, see:
- [README.md](./README.md) - Full documentation
- [QUICK_START.md](./QUICK_START.md) - Quick reference
