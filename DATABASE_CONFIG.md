# Database Configuration Guide

## Overview

Proyek FoodTrip API telah dikonfigurasi untuk mendukung berbagai jenis database dengan mudah. Anda dapat beralih antara SQLite, MySQL, PostgreSQL, dan MariaDB hanya dengan mengubah konfigurasi environment.

## Supported Databases

### 1. SQLite (Default)

- **Cocok untuk**: Development, testing, prototype
- **Kelebihan**: Tidak perlu setup server database terpisah
- **File database**: `./db/database.sqlite`

### 2. MySQL

- **Cocok untuk**: Production, aplikasi dengan traffic tinggi
- **Port default**: 3306
- **Driver**: mysql2

### 3. PostgreSQL

- **Cocok untuk**: Aplikasi complex dengan fitur advanced
- **Port default**: 5432
- **Driver**: pg

### 4. MariaDB

- **Cocok untuk**: Alternative MySQL yang open source
- **Port default**: 3306
- **Driver**: mariadb

## Quick Start

### Menggunakan Script Konfigurasi (Recommended)

```bash
npm run db:config
```

Script ini akan:

1. Menampilkan database yang sedang aktif
2. Menampilkan pilihan database yang tersedia
3. Meminta input konfigurasi database
4. Menyimpan konfigurasi ke file `.env`

### Manual Configuration

1. Copy file `.env.example` ke `.env`:

```bash
cp .env.example .env
```

2. Edit file `.env` sesuai database yang ingin digunakan:

#### Untuk SQLite:

```env
USE_DB=sqlite
DB_STORAGE=./db/database.sqlite
```

#### Untuk MySQL:

```env
USE_DB=mysql
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASS=your_password
DB_NAME=foodtrip
```

#### Untuk PostgreSQL:

```env
USE_DB=postgresql
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASS=your_password
DB_NAME=foodtrip
```

#### Untuk MariaDB:

```env
USE_DB=mariadb
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASS=your_password
DB_NAME=foodtrip
```

## Environment Variables

### Server Configuration

- `PORT`: Port untuk server (default: 5000)
- `API_VERSION`: Versi API prefix (default: /api/v1)
- `TOKEN_SECRET`: Secret key untuk JWT
- `ALLOW_SYNC`: Izinkan sync database schema (true/false)

### Database Configuration

- `USE_DB`: Jenis database (sqlite/mysql/postgresql/mariadb)
- `DB_HOST`: Host database server
- `DB_PORT`: Port database server
- `DB_USER`: Username database
- `DB_PASS`: Password database
- `DB_NAME`: Nama database
- `DB_STORAGE`: Path file SQLite (hanya untuk SQLite)

### Connection Pool Options

- `DB_POOL_MAX`: Maximum connections (default: 5)
- `DB_POOL_MIN`: Minimum connections (default: 0)
- `DB_POOL_ACQUIRE`: Connection acquire timeout (default: 30000ms)
- `DB_POOL_IDLE`: Connection idle timeout (default: 10000ms)

### Additional Options

- `DB_LOGGING`: Enable/disable SQL logging (true/false)
- `DB_SSL`: Enable SSL untuk PostgreSQL (true/false)
- `DB_ENCRYPT`: Enable encryption untuk MSSQL (true/false)

## Database Migration & Seeding

### Migrasi Database

```bash
# Jalankan migrasi
npm run db:migrate

# Undo migrasi terakhir
npm run db:migrate:undo
```

### Seeding Database

```bash
# Jalankan semua seeders
npm run db:seed
```

## Installation Dependencies

### SQLite

```bash
npm install @sequelize/sqlite3
```

### MySQL

```bash
npm install mysql2
```

### PostgreSQL

```bash
npm install pg pg-hstore
```

### MariaDB

```bash
npm install mariadb
```

## Production Considerations

### SQLite

- Tidak cocok untuk production dengan traffic tinggi
- Gunakan hanya untuk development atau aplikasi kecil

### MySQL/MariaDB

- Pastikan server database sudah terinstall
- Konfigurasi proper indexing untuk performance
- Setup regular backup

### PostgreSQL

- Cocok untuk aplikasi dengan requirement complex
- Support untuk advanced features (JSON, arrays, etc.)
- Konfigurasi connection pooling dengan baik

## Troubleshooting

### Connection Issues

1. Pastikan database server sudah running
2. Verify username/password yang benar
3. Check firewall dan network connectivity
4. Pastikan database sudah dibuat

### SQLite Issues

1. Pastikan folder `db/` sudah ada
2. Check file permissions
3. Pastikan path ke file database benar

### Migration Issues

1. Jalankan `npx sequelize-cli db:create` untuk membuat database
2. Pastikan konfigurasi di `.sequelizerc` sudah benar
3. Check syntax migration files

## Example Usage

```javascript
// Contoh menggunakan models
const { User, Restaurant } = require('./src/models')

// Create user
const user = await User.create({
  name: 'John Doe',
  email: 'john@example.com'
})

// Find restaurants
const restaurants = await Restaurant.findAll()
```

## Security Notes

- Jangan commit file `.env` ke version control
- Gunakan strong password untuk database
- Untuk production, gunakan environment variables atau secret management
- Enable SSL untuk database connection di production
