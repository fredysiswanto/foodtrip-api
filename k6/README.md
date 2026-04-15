# FoodTrip API - K6 Load Testing Guide

Panduan lengkap untuk melakukan load testing pada FoodTrip API menggunakan K6.

## 📋 Daftar Isi

1. [Prerequisit](#prerequisit)
2. [Instalasi & Setup](#instalasi--setup)
3. [Struktur Test](#struktur-test)
4. [Menjalankan Test](#menjalankan-test)
5. [Interpretasi Hasil](#interpretasi-hasil)
6. [Best Practices](#best-practices)

## Prerequisit

- Node.js v16 atau lebih tinggi
- K6 CLI terinstall
- API server FoodTrip sedang berjalan
- pnpm atau npm

## Instalasi & Setup

### 1. Instalasi K6

**macOS:**
```bash
brew install k6
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install k6

# CentOS/RHEL
sudo dnf install k6
```

**Windows:**
```bash
choco install k6
```

**atau download dari:** https://k6.io/docs/getting-started/installation/

### 2. Verifikasi Instalasi

```bash
k6 version
```

### 3. Jalankan Server API

```bash
# Terminal 1 - Start API server
cd /path/to/foodtrip-api
pnpm run dev
```

## Struktur Test

### Test Files Overview

```
k6/
├── config.js                        # Konfigurasi global (scenarios, thresholds, users)
├── helpers.js                       # Helper functions (login, utilities)
├── 01_auth_test.js                 # Authentication load test
├── 02_browse_test.js               # Read operations (browsing restaurants, dishes)
├── 03_customer_operations_test.js  # Customer operations (addresses, cart, orders)
├── 04_complete_user_flow_test.js   # End-to-end user journey
├── 05_stress_test.js               # Stress test (find breaking point)
├── 06_soak_test.js                 # Endurance test (long duration)
├── 07_spike_test.js                # Spike test (sudden traffic surge)
└── README.md                        # Documentasi ini
```

## Menjalankan Test

### 1. Test Setup Awal (Smoke Test)

Lakukan test sederhana untuk memastikan API berfungsi:

```bash
# Quick smoke test
k6 run k6/01_auth_test.js --env BASE_URL=http://localhost:5000 --env SCENARIO=smoke
```

**Expected Output:**
- ✓ All checks passed
- Durasi: ~30 detik
- VUs: 1

---

### 2. Authentication Testing

Test semua jenis login (customer, admin, resto admin):

```bash
# Gentle ramp-up test
k6 run k6/01_auth_test.js \
  --env BASE_URL=http://localhost:5000 \
  --env SCENARIO=rampUp
```

**Durasi:** ~7 menit  
**VUs:** 0 → 10 → 20 → 0

---

### 3. Browse/Read Operations Testing

Test endpoint GET yang paling sering diakses:

```bash
# Test with ramp-up scenario
k6 run k6/02_browse_test.js \
  --env BASE_URL=http://localhost:5000 \
  --env SCENARIO=rampUp
```

**Endpoint yang ditest:**
- GET /restaurants
- GET /dishes
- GET /dish-categories
- GET /resto-categories
- GET /popular-dishes
- GET /popular-restaurants

---

### 4. Customer Operations Testing

Test operasi yang memerlukan autentikasi:

```bash
k6 run k6/03_customer_operations_test.js \
  --env BASE_URL=http://localhost:5000 \
  --env SCENARIO=rampUp
```

**Operasi yang ditest:**
- Create/Update/Delete Address
- Add to Cart
- Get Cart
- Get Account Info
- Get Orders

---

### 5. Complete User Flow Testing

Simulasi perjalanan user lengkap: login → browse → add cart → checkout:

```bash
# Test dengan spike scenario (paling realistic)
k6 run k6/04_complete_user_flow_test.js \
  --env BASE_URL=http://localhost:5000 \
  --env SCENARIO=spike
```

**User Journey:**
1. Login
2. Browse restaurants
3. View restaurant details
4. Browse dishes & categories
5. Add items to cart
6. View cart
7. Prepare checkout (setup address)
8. Create order
9. View order history

---

### 6. Stress Testing

Temukan breaking point sistem:

```bash
# Full stress test (long duration)
k6 run k6/05_stress_test.js \
  --env BASE_URL=http://localhost:5000
```

**Load Progression:**
- 5 menit: 0 → 50 VUs
- 5 menit: 50 → 100 VUs
- 5 menit: 100 → 200 VUs
- 5 menit: 200 → 300 VUs
- 5 menit: 300 → 400 VUs
- 2 menit: 400 → 0 (cooldown)

**Total:** 27 menit

---

### 7. Soak Testing

Test stabilitas dalam durasi lama:

```bash
# 30-minute endurance test
k6 run k6/06_soak_test.js \
  --env BASE_URL=http://localhost:5000
```

**Configuration:**
- Durasi: 30 menit
- VUs: 20 (constant)
- Mix operasi: 60% browse, 25% detail, 15% categories

---

### 8. Spike Testing

Test behavior saat traffic spike:

```bash
# Test dengan sudden traffic surge
k6 run k6/07_spike_test.js \
  --env BASE_URL=http://localhost:5000
```

**Load Pattern:**
1. 30s: 5 VUs (baseline)
2. 10s: Spike ke 100 VUs
3. 1m: Maintain 100 VUs
4. 10s: Drop ke 5 VUs
5. 30s: Cooldown ke 0

---

## Dengan Output File JSON

Simpan hasil test untuk analisis lebih lanjut:

```bash
k6 run k6/02_browse_test.js \
  --env BASE_URL=http://localhost:5000 \
  -o json=results.json
```

Hasil akan disimpan di `results.json` untuk dianalisis lebih lanjut.

---

## Menggunakan Multiple Metrics

Monitor metrics tertentu dengan lebih detail:

```bash
k6 run k6/04_complete_user_flow_test.js \
  --env BASE_URL=http://localhost:5000 \
  -o json=flow_results.json \
  --summary-export=summary.json
```

---

## Interpretasi Hasil

### Key Metrics

#### 1. **http_req_duration** (Response Time)
```
      avg     : 250ms (waktu response rata-rata)
      min     : 50ms
      max     : 2500ms
      p(95)   : 450ms (95% request di bawah 450ms) ✓ BAIK
      p(99)   : 950ms (99% request di bawah 950ms)
```

**Target:**
- p(95) < 500ms ✓
- p(99) < 1000ms ✓
- avg < 200ms ✓

#### 2. **http_req_failed** (Error Rate)
```
      rate    : 0.05 (5% error rate) ✗ PERLU DIPERBAIKI
```

**Target:**
- rate < 0.1 (10%) ✓
- Target ideal: < 0.01 (1%)

**Penyebab tingginya error:**
- Database connection pool exhausted
- Timeout pada server
- Insufficient resources (CPU/Memory)

#### 3. **http_reqs** (Throughput)
```
      rate    : 250/s (250 request per detik)
```

**Target:** rate > 100/s ✓

**Meaning:** Sistem mampu handle 250 requests per detik dengan baik.

#### 4. **checks** (Test Assertions)
```
      rate    : 0.98 (98% checks passed)
```

**Target:** rate > 0.95 ✓

### Contoh Output

```
█ smoke
      ✓ customer login successful
      ✓ customer login token received
      ✗ admin login successful
      ✗ admin login token received
      ✓ resto admin login token received
      ✓ invalid login rejected
      ✓ error response returned

     checks.....................: 85.71% ✓ 6   ✗ 1
     data_received..............: 25 kB  
     data_sent..................: 4.2 kB  
     http_req_blocked...........: avg=15ms    min=12ms max=48ms   p(90)=20ms p(95)=22ms
     http_req_connecting........: avg=5ms     min=3ms  max=15ms   p(90)=8ms  p(95)=9ms
     http_req_duration..........: avg=120ms   min=85ms max=180ms  p(90)=145ms p(95)=155ms ✓
     http_req_failed............: 14.28%   ✓ 2   ✗ 12
     http_req_receiving.........: avg=5ms     min=2ms  max=8ms    p(90)=7ms  p(95)=7ms
     http_req_sending...........: avg=3ms     min=1ms  max=10ms   p(90)=4ms  p(95)=5ms
     http_req_tls_handshaking...: avg=0s      min=0s   max=0s     p(90)=0s   p(95)=0s
     http_req_waiting...........: avg=112ms   min=80ms max=170ms  p(90)=135ms p(95)=145ms
     http_reqs..................: 14      2.333/s
     iteration_duration.........: avg=2.45s   min=2.2s max=2.8s   p(90)=2.7s p(95)=2.8s
     iterations.................: 14      2.333/s
     vus........................: 1       min=1   max=1
     vus_max....................: 1       min=1   max=1
```

### Interpretasi Hasil Stress Test

**Jika di tengah stress test terjadi spike pada error:**
```
At 350 VUs:
- http_req_failed: 5%
- http_req_duration p(99): 3000ms (timeout)
- Database error messages observed
```

**Kesimpulan:**
- Sistem mulai mengalami stress di ~350 VUs
- Ada bottleneck di database
- Harus scale database atau optimize queries

---

## Best Practices

### 1. Test Scenarios Progression

Jalankan test secara bertahap:

```bash
# Hari 1: Smoke test
k6 run k6/01_auth_test.js --env SCENARIO=smoke

# Hari 2: Ramp-up tests
k6 run k6/02_browse_test.js --env SCENARIO=rampUp
k6 run k6/03_customer_operations_test.js --env SCENARIO=rampUp

# Hari 3: Complete flow dengan spike
k6 run k6/04_complete_user_flow_test.js --env SCENARIO=spike

# Hari 4: Full stress test
k6 run k6/05_stress_test.js

# Hari 5: Soak test
k6 run k6/06_soak_test.js

# Final: Spike test
k6 run k6/07_spike_test.js
```

### 2. Monitor System Resources

Jalankan di terminal lain:

```bash
# macOS
watch -n 1 'ps aux | grep node'

# Linux
watch 'top -b -n 1 | head -20'

# Monitor database
mysql -u root -p -e "SHOW PROCESSLIST;"
```

### 3. Analyse Bottlenecks

Jika error meningkat:

1. **Check Web Server Logs:**
   ```bash
   tail -f logs/app.log
   ```

2. **Check Database:**
   ```bash
   # Connections
   SHOW STATUS WHERE variable_name = 'Threads_connected';
   
   # Slow queries
   SHOW VARIABLES LIKE 'slow_query_log%';
   ```

3. **Check Node.js Memory:**
   ```bash
   node --max-old-space-size=4096 app.js
   ```

### 4. Test Data Cleanup

Karena load test membuat banyak data:

```bash
# Reset database setelah test
pnpm run db:setup
```

### 5. Custom Scenarios

Edit `config.js` untuk membuat custom scenario:

```javascript
customScenario: {
  executor: 'ramp-vus',
  startVUs: 0,
  stages: [
    { duration: '1m', target: 15 },  // Custom load
    { duration: '2m', target: 30 },
    { duration: '1m', target: 0 }
  ]
}
```

Jalankan dengan:
```bash
k6 run k6/02_browse_test.js \
  --env BASE_URL=http://localhost:5000 \
  --env SCENARIO=customScenario
```

---

## Troubleshooting

### Error: "command not found: k6"
**Solusi:** Pastikan K6 sudah terinstall dengan benar
```bash
k6 version
```

### Error: "Connection refused"
**Solusi:** Pastikan API server sedang running
```bash
# Terminal 1
cd /path/to/foodtrip-api
pnpm run dev
```

### Error: "Too many open files"
**Solusi untuk macOS:**
```bash
ulimit -n 10000
```

### Test berjalan terlalu lambat
**Solusi:**
- Reduce VUs dan duration
- Check CPU/Memory usage
- Optimize database queries
- Add caching layer (Redis)

### "Threshold Failed"
Ini berarti performance metrics tidak memenuhi threshold yang didefinisikan:

```bash
# Run dengan relaxed thresholds untuk debug
k6 run k6/02_browse_test.js \
  --no-thresholds
```

---

## Integration dengan CI/CD

### GitHub Actions Example

```yaml
name: Load Testing

on: [schedule]

jobs:
  k6-load-test:
    runs-on: ubuntu-latest
    
    services:
      mysql:
        image: mysql:8
        env:
          MYSQL_ROOT_PASSWORD: root
        options: >-
          --health-cmd="mysqladmin ping"
          --health-interval=10s
    
    steps:
      - uses: actions/checkout@v2
      
      - name: Install K6
        run: sudo apt-get install k6
      
      - name: Setup API Server
        run: |
          npm install
          npm run start &
          sleep 10
      
      - name: Run K6 Load Tests
        run: |
          k6 run k6/02_browse_test.js \
            --env BASE_URL=http://localhost:5000
```

---

## Tips & Tricks

### 1. Generate Report HTML

Gunakan cloud reporting:

```bash
# Butuh K6 Cloud account
k6 cloud k6/02_browse_test.js
```

### 2. Run Multiple Tests Sequentially

```bash
#!/bin/bash
for file in k6/0{1..7}_*.js; do
  echo "Running $file..."
  k6 run "$file" --env BASE_URL=http://localhost:5000
done
```

### 3. Real-time Monitoring

Monitor live metrics:

```bash
k6 run k6/06_soak_test.js \
  --env BASE_URL=http://localhost:5000 \
  --insecure-skip-tls-verify
```

---

## Kesimpulan

Dengan K6 load testing framework, Anda dapat:

✓ Identify bottlenecks dan performance issues  
✓ Plan server capacity  
✓ Ensure API reliability  
✓ Optimize database queries  
✓ Monitor system behavior under stress  

Selamat melakukan load testing! 🚀
