# Quick Database Setup Guide

## 🚀 Quick Start

### 1. Konfigurasi Database

```bash
npm run db:config
```

### 2. Install Dependencies (jika diperlukan)

```bash
# Windows
./install-db-deps.ps1

# Linux/Mac
./install-db-deps.sh
```

### 3. Jalankan Server

```bash
npm run dev
```

## 📋 Supported Databases

| Database      | Status    | Best For          |
| ------------- | --------- | ----------------- |
| SQLite ✅     | Ready     | Development       |
| MySQL ✅      | Ready     | Production        |
| PostgreSQL 🔧 | Need deps | Advanced features |
| MariaDB 🔧    | Need deps | MySQL alternative |

## 🔧 Environment Variables

### Quick SQLite Setup (Default)

```env
USE_DB=sqlite
DB_STORAGE=./db/database.sqlite
```

### Quick MySQL Setup

```env
USE_DB=mysql
DB_HOST=localhost
DB_USER=root
DB_PASS=your_password
DB_NAME=foodtrip
```

## 📚 Full Documentation

Lihat [DATABASE_CONFIG.md](DATABASE_CONFIG.md) untuk dokumentasi lengkap.

## 🆘 Need Help?

- ❓ Configuration issues → Check [DATABASE_CONFIG.md](DATABASE_CONFIG.md)
- 🐛 Connection errors → Verify database server is running
- 📦 Missing dependencies → Run `npm run db:install-deps`
