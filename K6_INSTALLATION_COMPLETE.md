# 🚀 K6 Load Testing - Installation & Usage Guide

## ✅ K6 Status

K6 **v1.3.0** sudah terinstall dan siap digunakan di project Anda! ✨

Verifikasi: K6 di `/opt/homebrew/bin/k6`

---

## 📦 Apa yang Sudah di-Setup

### Files & Struktur
- ✅ **k6/config.js** - Konfigurasi global (scenarios, thresholds, users)
- ✅ **k6/helpers.js** - Fungsi helper untuk testing
- ✅ **k6/01_auth_test.js** - Authentication testing
- ✅ **k6/02_browse_test.js** - Read operations testing
- ✅ **k6/03_customer_operations_test.js** - Customer CRUD testing
- ✅ **k6/04_complete_user_flow_test.js** - End-to-end user flow
- ✅ **k6/05_stress_test.js** - Stress testing (find breaking point)
- ✅ **k6/06_soak_test.js** - Endurance testing (30 minutes)
- ✅ **k6/07_spike_test.js** - Traffic spike testing
- ✅ **k6/README.md** - Dokumentasi lengkap
- ✅ **k6/QUICK_START.md** - Quick reference guide
- ✅ **k6/ARCHITECTURE.md** - Technical architecture docs
- ✅ **k6/.env.example** - Environment configuration template
- ✅ **k6/setup.sh** - Setup verification script
- ✅ **k6/generate-report.js** - Report generator
- ✅ **k6/run_tests.sh** - Interactive test runner menu

### package.json Scripts
Added 8 convenient npm scripts untuk menjalankan k6 tests:

```json
"k6:setup": "bash k6/setup.sh",
"k6:smoke": "k6 run k6/01_auth_test.js --env SCENARIO=smoke",
"k6:auth": "k6 run k6/01_auth_test.js",
"k6:browse": "k6 run k6/02_browse_test.js --env SCENARIO=rampUp",
"k6:customer": "k6 run k6/03_customer_operations_test.js --env SCENARIO=rampUp",
"k6:flow": "k6 run k6/04_complete_user_flow_test.js --env SCENARIO=spike",
"k6:stress": "k6 run k6/05_stress_test.js",
"k6:soak": "k6 run k6/06_soak_test.js",
"k6:spike": "k6 run k6/07_spike_test.js"
```

---

## 🚀 Mulai Testing

### Step 1: Start API Server
```bash
pnpm run dev
# Server akan jalan di http://localhost:5000
```

### Step 2: Verify K6 Setup (Optional)
```bash
pnpm run k6:setup
```

### Step 3: Run Test

**Opsi A - Gunakan npm scripts (RECOMMENDED):**
```bash
# Quick smoke test (30 detik)
pnpm run k6:smoke

# Authentication testing
pnpm run k6:auth

# Browse operations
pnpm run k6:browse

# Customer operations
pnpm run k6:customer

# Complete user flow
pnpm run k6:flow

# Stress test
pnpm run k6:stress

# Soak test (30 menit)
pnpm run k6:soak

# Spike test
pnpm run k6:spike
```

**Opsi B - Gunakan k6 command langsung:**
```bash
# Smoke test
k6 run k6/01_auth_test.js --env BASE_URL=http://localhost:5000 --env SCENARIO=smoke

# Dengan JSON output
k6 run k6/02_browse_test.js --env BASE_URL=http://localhost:5000 -o json=results.json

# Custom scenario
k6 run k6/03_customer_operations_test.js --env BASE_URL=http://localhost:5000 --env SCENARIO=rampUp
```

---

## 📊 Test Durations & Load

| Test | Command | Duration | VUs | Purpose |
|------|---------|----------|-----|---------|
| Smoke | `pnpm run k6:smoke` | 30s | 1 | Quick sanity check |
| Auth | `pnpm run k6:auth` | 7m | 0→20 | Test login endpoints |
| Browse | `pnpm run k6:browse` | 7m | 0→20 | Test read operations |
| Customer | `pnpm run k6:customer` | 7m | 0→20 | Test CRUD operations |
| Flow | `pnpm run k6:flow` | 2-5m | 10→100 | Realistic user journey |
| Stress | `pnpm run k6:stress` | 27m | 0→400 | Find breaking point |
| Soak | `pnpm run k6:soak` | 30m | 20 | Long duration stability |
| Spike | `pnpm run k6:spike` | ~2m | 5→100 | Traffic surge handling |

---

## 🎯 Next Steps

1. **Run Smoke Test First:**
   ```bash
   pnpm run k6:smoke
   ```
   Harus berjalan tanpa error dan selesai dalam 30 detik.

2. **Run Individual Tests:**
   ```bash
   pnpm run k6:auth      # Auth testing
   pnpm run k6:browse    # Browse testing
   pnpm run k6:customer  # Customer ops testing
   ```

3. **Read Documentation:**
   - [k6/README.md](./README.md) - Dokumentasi lengkap dengan troubleshooting
   - [k6/QUICK_START.md](./QUICK_START.md) - Quick reference dengan examples
   - [k6/ARCHITECTURE.md](./ARCHITECTURE.md) - Technical architecture & design

4. **Advanced Usage:**
   ```bash
   # Save hasil test sebagai JSON
   k6 run k6/02_browse_test.js -o json=results.json
   
   # Generate report
   node k6/generate-report.js results.json
   
   # Run interactive menu
   bash k6/run_tests.sh
   ```

---

## 📝 Test User Credentials (Default)

The tests use pre-configured users dalam `k6/config.js`:

```javascript
export const TEST_USERS = {
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
```

> Note: Pastikan user-user ini ada di database Anda!

---

## 🔧 Customization

### Change Base URL
```bash
k6 run k6/02_browse_test.js --env BASE_URL=https://production-api.example.com
```

### Change Scenario
```bash
k6 run k6/02_browse_test.js --env SCENARIO=stress
```

### Different Environment
Create `.env.k6` file:
```bash
cp k6/.env.example k6/.env.k6
# Edit dengan custom values
```

---

## ⚠️ Troubleshooting

### Error: "Connection refused"
```
Solusi: Pastikan API server running
$ pnpm run dev
```

### Error: "Too many open files"
```bash
# Increase file limit (macOS)
ulimit -n 10000
k6 run k6/02_browse_test.js
```

### Test berjalan lambat
- Reduce VUs di config.js
- Check CPU/Memory usage
- Check database performance

### Invalid login
- Verify test users ada di database
- Check credentials di config.js
- Run `pnpm run db:seed` untuk seed data

---

## 📚 Dokumentasi

- **[README.md](./README.md)** - Comprehensive guide dengan interpretasi hasil
- **[QUICK_START.md](./QUICK_START.md)** - Quick reference with examples
- **[ARCHITECTURE.md](./ARCHITECTURE.md)** - Technical design & diagrams
- **[K6 Official Docs](https://k6.io/docs/)** - Official K6 documentation

---

## ✅ Verification Checklist

- [x] K6 v1.3.0 installed
- [x] All 9 test files present
- [x] config.js & helpers.js ready
- [x] Documentation complete
- [x] NPM scripts added to package.json
- [x] Setup script created
- [ ] API server running (do this before testing)
- [ ] Test users seeded in database (check with db:seed)
- [ ] Run first smoke test and verify it passes

---

## 🎉 Ready to Test!

Your K6 load testing suite is fully setup and ready to use. Start with:

```bash
# Terminal 1 - Start API
pnpm run dev

# Terminal 2 - Run smoke test
pnpm run k6:smoke
```

Happy Load Testing! 🚀
