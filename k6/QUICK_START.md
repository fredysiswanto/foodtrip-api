# K6 Load Testing - Quick Start Guide

Panduan cepat untuk mulai menggunakan K6 load testing untuk FoodTrip API.

## ⚡ Quick Commands

### Setup & Installation

```bash
# Install K6
brew install k6  # macOS
# atau download dari https://k6.io/docs/getting-started/installation/

# Verify installation
k6 version
```

---

## 🚀 Mulai Testing dalam 5 Menit

### Step 1: Pastikan API Server Jalan

```bash
cd /path/to/foodtrip-api
pnpm run dev
# Server akan berjalan di http://localhost:5000
```

### Step 2: Run Smoke Test (Pertama Kali)

```bash
cd k6
k6 run 01_auth_test.js --env BASE_URL=http://localhost:5000 --env SCENARIO=smoke
```

**Expected Result:**
✓ Test berhasil dalam ~30 detik
✓ 1 user, multiple login attempts

---

## 📋 Common Commands

### Authentication Tests
```bash
k6 run k6/01_auth_test.js \
  --env BASE_URL=http://localhost:5000 \
  --env SCENARIO=rampUp
```

### Browse/Read Heavy Operations
```bash
k6 run k6/02_browse_test.js \
  --env BASE_URL=http://localhost:5000 \
  --env SCENARIO=rampUp
```

### Customer Operations (Login Required)
```bash
k6 run k6/03_customer_operations_test.js \
  --env BASE_URL=http://localhost:5000 \
  --env SCENARIO=rampUp
```

### Complete User Flow
```bash
k6 run k6/04_complete_user_flow_test.js \
  --env BASE_URL=http://localhost:5000 \
  --env SCENARIO=spike
```

### Stress Test (Cari Breaking Point)
```bash
k6 run k6/05_stress_test.js \
  --env BASE_URL=http://localhost:5000
```

### Soak Test (30 Menit)
```bash
k6 run k6/06_soak_test.js \
  --env BASE_URL=http://localhost:5000
```

### Spike Test (Traffic Surge)
```bash
k6 run k6/07_spike_test.js \
  --env BASE_URL=http://localhost:5000
```

---

## 🎯 Available Scenarios

Setiap test file mendukung beberapa scenario yang bisa dipilih:

### 1. **smoke** (Super Cepat)
```bash
k6 run k6/02_browse_test.js --env SCENARIO=smoke
```
- Duration: 30 detik
- VUs: 1
- Gunakan untuk: Quick sanity check

### 2. **rampUp** (Gradual Load)
```bash
k6 run k6/02_browse_test.js --env SCENARIO=rampUp
```
- Duration: 7 menit
- VUs: 0 → 10 → 20 → 0
- Gunakan untuk: Testing normal load

### 3. **spike** (Sudden Surge)
```bash
k6 run k6/04_complete_user_flow_test.js --env SCENARIO=spike
```
- Duration: ~2.5 menit
- VUs: 10 → 100 → 10
- Gunakan untuk: Testing peak traffic

### 4. **soak** (Long Duration)
```bash
k6 run k6/06_soak_test.js --env SCENARIO=soak
```
- Duration: 10 menit
- VUs: 20 (constant)
- Gunakan untuk: Stability testing

### 5. **stress** (Increasing Load)
```bash
k6 run k6/05_stress_test.js --env SCENARIO=stress
```
- Gradually increase up to 300+ VUs
- Gunakan untuk: Menemukan breaking point

### 6. **peakLoad** (Simulated Peak)
```bash
k6 run k6/02_browse_test.js --env SCENARIO=peakLoad
```
- Duration: 9 menit
- VUs: 0 → 50 → 0
- Gunakan untuk: Testing peak hour traffic

---

## 💾 Save Results untuk Analysis

### JSON Output
```bash
k6 run k6/02_browse_test.js \
  --env BASE_URL=http://localhost:5000 \
  -o json=results.json
```

### Summary Export
```bash
k6 run k6/02_browse_test.js \
  --env BASE_URL=http://localhost:5000 \
  --summary-export=summary.json
```

### CSV Output (untuk Excel)
```bash
k6 run k6/02_browse_test.js \
  --env BASE_URL=http://localhost:5000 \
  -o csv=results.csv
```

---

## 🔍 Monitor Real-Time

### Terminal 1: Run API Server
```bash
cd /path/to/foodtrip-api
pnpm run dev
```

### Terminal 2: Run K6 Test
```bash
cd k6
k6 run 02_browse_test.js --env BASE_URL=http://localhost:5000
```

### Terminal 3: Monitor System
```bash
# macOS
watch -n 1 'top -o %CPU -o %MEM | head -15'

# Linux
watch 'top -b -n 1 | head -15'
```

---

## 📊 Reading the Results

### Typical Output Breakdown

```
█ rampUp
      ✓ Get restaurants successful
      ✓ Get dishes successful
      ✓ Get categories successful

     checks.....................: 100% ✓ 150  ✗ 0
     data_received..............: 1.2 MB
     data_sent..................: 234 kB
     http_req_duration..........: avg=245ms  min=45ms  max=532ms  p(95)=420ms ✓
     http_req_failed............: 0%       ✓
     http_reqs..................: 300      10/s
     iterations.................: 100      3.33/s
     vus........................: 20       min=0    max=20
     vus_max....................: 20
```

**What it means:**
- ✓ All 150 checks passed
- Average response time: 245ms
- 95% of requests completed in 420ms or less
- 0% error rate
- 300 total requests at 10 requests/second

---

## ⚠️ Common Issues & Solutions

### Issue 1: "Connection refused"
```
ERRO[0000] Get http://localhost:5000/api/v1/home/login: 
dial tcp 127.0.0.1:5000: connect: connection refused
```

**Solution:**
Make sure API server is running on correct port
```bash
pnpm run dev
```

### Issue 2: "Too many open files"
```
Error: syscall socket: error: EMFILE, too many open files
```

**Solution (macOS):**
```bash
ulimit -n 10000
k6 run k6/02_browse_test.js --env BASE_URL=http://localhost:5000
```

### Issue 3: Test runs out of memory
**Solution:** Reduce VUs or iteration count in config.js

### Issue 4: "Threshold Failed"
```
ERRO[0016] Threshold on group() metrics exceeded: 
http_req_duration p(95)=1200ms, but the threshold was 500ms
```

**Solution:** Either fix performance issues or adjust thresholds in config.js

---

## 🚀 Testing Strategy

### Day 1: Setup & Smoke Test
```bash
# Verify everything works
k6 run k6/01_auth_test.js --env SCENARIO=smoke
```

### Day 2: Individual Endpoint Testing
```bash
# Test each category separately
k6 run k6/02_browse_test.js --env SCENARIO=rampUp
k6 run k6/03_customer_operations_test.js --env SCENARIO=rampUp
```

### Day 3: User Flow Testing
```bash
# Test realistic user behavior
k6 run k6/04_complete_user_flow_test.js --env SCENARIO=spike
```

### Day 4: Stress Testing
```bash
# Find breaking point
k6 run k6/05_stress_test.js
```

### Day 5: Endurance Testing
```bash
# Test stability over time
k6 run k6/06_soak_test.js
```

---

## 🎓 Performance Targets

### Acceptable Performance
- **Response Time p(95):** < 500ms ✓
- **Response Time p(99):** < 1000ms ✓
- **Error Rate:** < 1% ✓
- **Throughput:** > 100 req/s ✓

### Warning Signs
- **Response Time p(95):** > 800ms ⚠️
- **Error Rate:** 5-10% ⚠️
- **Constant errors after 200 VUs:** Need optimization

### Critical Issues
- **Response Time p(95):** > 2000ms 🔴
- **Error Rate:** > 10% 🔴
- **System crashes under load:** 🔴

---

## 📚 Test Files Explained

| File | Purpose | Duration | Best For |
|------|---------|----------|----------|
| 01_auth_test.js | Login testing | 30s-7m | Authentication flows |
| 02_browse_test.js | Read operations | 7m | Browse functionality |
| 03_customer_operations_test.js | CRUD operations | 7m | Data mutations |
| 04_complete_user_flow_test.js | End-to-end journey | 2.5m-5m | Realistic scenarios |
| 05_stress_test.js | Capacity testing | 27m | Finding limits |
| 06_soak_test.js | Endurance | 30m | Long-term stability |
| 07_spike_test.js | Traffic surge | 2.5m | Peak handling |

---

## 🔧 Customization

### Change Test Duration
Edit `config.js` and modify the scenario stages:

```javascript
rampUp: {
  executor: 'ramp-vus',
  startVUs: 0,
  stages: [
    { duration: '5m', target: 50 },  // Change from 2m to 5m
    { duration: '10m', target: 100 }  // Change from 3m to 10m
  ]
}
```

### Change Base URL
```bash
k6 run k6/02_browse_test.js \
  --env BASE_URL=https://production-api.example.com
```

### Change Test User
Edit `config.js`:
```javascript
export const TEST_USERS = {
  customer: {
    email: 'your_test_email@example.com',
    password: 'your_password'
  }
}
```

---

## 📞 Support & Docs

- **K6 Official Docs:** https://k6.io/docs/
- **K6 API Reference:** https://k6.io/docs/javascript-api/
- **Welcome to K6 Cloud:** https://cloud.k6.io (optional)

---

## ✅ Checklist Before Load Testing

- [ ] API server running on correct port ✓
- [ ] Database accessible ✓
- [ ] K6 installed and working ✓
- [ ] Test users exist in database ✓
- [ ] Sufficient disk space for results ✓
- [ ] Network connectivity stable ✓
- [ ] Monitor system resources during test ✓

---

Happy Load Testing! 🎉
