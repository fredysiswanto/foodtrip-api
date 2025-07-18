# Database CLI & Commands Guide

## Overview

Database CLI menyediakan berbagai perintah untuk mengelola database dengan mudah. Proyek ini dilengkapi dengan auto-setup database dan berbagai helper commands.

## Quick Start

### 1. Auto Setup Database

```bash
npm run db:setup
```

Perintah ini akan:

- Membuat database (jika belum ada)
- Menjalankan migrasi (jika diperlukan)
- Menjalankan seeder (jika diperlukan)

### 2. Check Database Status

```bash
npm run db:status
```

Menampilkan status database lengkap

### 3. Start Development Server

```bash
npm run dev
```

Server akan otomatis setup database jika `AUTO_SETUP_DB=true` di `.env`

## Database CLI Commands

### Database Status

```bash
npm run db:status
# atau
node db-cli.js status
```

### Migration Commands

```bash
# Jalankan migrasi
npm run db:migrate
node db-cli.js migrate

# Buat migration baru
node db-cli.js migrate:create add-user-table

# Undo migration terakhir
node db-cli.js migrate:undo
```

### Seeder Commands

```bash
# Jalankan seeder
npm run db:seed
node db-cli.js seed

# Buat seeder baru
node db-cli.js seed:create demo-users

# Undo seeder terakhir
node db-cli.js seed:undo

# Undo semua seeder
node db-cli.js seed:undo:all
```

### Model Generation

```bash
# Buat model baru dengan migration
node db-cli.js model:create User

# Dengan Sequelize CLI langsung
npx sequelize-cli model:generate --name User --attributes name:string,email:string
```

### Database Creation

```bash
# Buat database (untuk non-SQLite)
node db-cli.js create
```

## Environment Variables untuk Database Auto Setup

```env
# Auto setup database on server start
AUTO_SETUP_DB=true

# Allow sync database schema
ALLOW_SYNC=true

# Database configuration
USE_DB=sqlite
DB_STORAGE=./db/database.sqlite
```

## API Endpoints untuk Database Management

### Get Database Status

```http
GET /api/database/status
```

Response:

```json
{
  "success": true,
  "data": {
    "connected": true,
    "tablesExist": true,
    "migrationsExist": true,
    "seedersExist": false,
    "migrationFilesExist": true,
    "seederFilesExist": false
  }
}
```

### Run Migrations

```http
POST /api/database/migrate
```

### Run Seeders

```http
POST /api/database/seed
```

### Auto Setup Database

```http
POST /api/database/setup
```

## Common Sequelize CLI Commands

### Migration Management

```bash
# Buat migration baru
npx sequelize-cli migration:generate --name migration-name

# Jalankan migrasi
npx sequelize-cli db:migrate

# Undo migration terakhir
npx sequelize-cli db:migrate:undo

# Undo semua migrasi
npx sequelize-cli db:migrate:undo:all

# Lihat status migrasi
npx sequelize-cli db:migrate:status
```

### Seeder Management

```bash
# Buat seeder baru
npx sequelize-cli seed:generate --name seeder-name

# Jalankan semua seeder
npx sequelize-cli db:seed:all

# Jalankan seeder tertentu
npx sequelize-cli db:seed --seed seeder-file.js

# Undo seeder terakhir
npx sequelize-cli db:seed:undo

# Undo semua seeder
npx sequelize-cli db:seed:undo:all
```

### Model & Migration Generation

```bash
# Buat model dengan migration
npx sequelize-cli model:generate --name ModelName --attributes attr1:type,attr2:type

# Contoh: User model
npx sequelize-cli model:generate --name User --attributes name:string,email:string,password:string,role:enum

# Buat migration standalone
npx sequelize-cli migration:generate --name add-column-to-table
```

## Migration Examples

### Create Table Migration

```javascript
'use strict'

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Users', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      name: {
        type: Sequelize.STRING,
        allowNull: false
      },
      email: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    })
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Users')
  }
}
```

### Add Column Migration

```javascript
'use strict'

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.addColumn('Users', 'phone', {
      type: Sequelize.STRING,
      allowNull: true
    })
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.removeColumn('Users', 'phone')
  }
}
```

## Seeder Examples

### Basic Seeder

```javascript
'use strict'

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert(
      'Users',
      [
        {
          name: 'John Doe',
          email: 'john@example.com',
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          name: 'Jane Smith',
          email: 'jane@example.com',
          createdAt: new Date(),
          updatedAt: new Date()
        }
      ],
      {}
    )
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Users', null, {})
  }
}
```

## Database Helper Class Usage

```javascript
const DatabaseHelper = require('./src/helpers/databaseHelper')

// Check database status
const status = await DatabaseHelper.getDatabaseStatus()

// Auto setup database
const success = await DatabaseHelper.autoSetupDatabase()

// Run migrations
const migrationSuccess = await DatabaseHelper.runMigrations()

// Run seeders
const seederSuccess = await DatabaseHelper.runSeeders()
```

## Troubleshooting

### Database Connection Issues

```bash
# Check database status
npm run db:status

# Verify environment variables
cat .env

# Test database connection
node -e "require('./src/models').sequelize.authenticate().then(() => console.log('Connected!')).catch(console.error)"
```

### Migration Issues

```bash
# Check migration status
npx sequelize-cli db:migrate:status

# Reset migrations (DANGER!)
npx sequelize-cli db:migrate:undo:all
npm run db:migrate
```

### Seeder Issues

```bash
# Check if seeders ran
npm run db:status

# Reset seeders
npx sequelize-cli db:seed:undo:all
npm run db:seed
```

## Best Practices

1. **Always backup database before running migrations in production**
2. **Test migrations in development first**
3. **Use descriptive migration names**
4. **Keep migrations reversible (implement `down` method)**
5. **Use transactions for complex migrations**
6. **Test seeders independently**
7. **Don't modify existing migrations after they've been deployed**

## Production Deployment

```bash
# 1. Setup environment
cp .env.example .env
# Edit .env with production values

# 2. Install dependencies
npm install

# 3. Setup database
npm run db:setup

# 4. Start server
npm start
```

Dengan setup ini, database management menjadi lebih mudah dan otomatis! 🚀
