# Database Management Documentation

## Overview
This document provides comprehensive information about the database management system in the FoodTrip API project, including configuration, CLI tools, and database operations.

## Table of Contents
1. [Database Configuration](#database-configuration)
2. [Database CLI Tool](#database-cli-tool)
3. [Database Helper](#database-helper)
4. [Migration Management](#migration-management)
5. [Environment Setup](#environment-setup)
6. [Usage Examples](#usage-examples)
7. [Troubleshooting](#troubleshooting)

## Database Configuration

### Multi-Database Support
The project supports multiple database systems:
- **SQLite** (default) - File-based, no server required
- **MySQL** - Popular relational database
- **PostgreSQL** - Advanced relational database
- **MariaDB** - MySQL fork with additional features

### Configuration Files

#### 1. Dynamic Configuration (`src/config/config.js`)
```javascript
const config = {
  development: {
    dialect: process.env.DB_TYPE || 'sqlite',
    storage: process.env.DB_TYPE === 'sqlite' ? './db/database.sqlite' : undefined,
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT) || getDefaultPort(),
    database: process.env.DB_NAME || 'foodtrip_dev',
    username: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    logging: process.env.NODE_ENV !== 'production' ? console.log : false
  }
}
```

#### 2. Static Configuration (`src/config/config.json`)
```json
{
  "development": {
    "dialect": "sqlite",
    "storage": "./db/database.sqlite",
    "logging": false
  },
  "test": {
    "dialect": "sqlite",
    "storage": ":memory:",
    "logging": false
  },
  "production": {
    "use_env_variable": "DATABASE_URL",
    "dialect": "postgres",
    "logging": false
  }
}
```

### Environment Variables

#### Required Variables:
```env
# Database Configuration
DB_TYPE=sqlite          # sqlite, mysql, postgresql, mariadb
DB_HOST=localhost       # Database host
DB_PORT=3306           # Database port
DB_NAME=foodtrip_db    # Database name
DB_USER=root           # Database username
DB_PASSWORD=password   # Database password

# Application Configuration
NODE_ENV=development   # Environment (development, test, production)
JWT_SECRET=your-secret-key
```

#### Default Ports:
- SQLite: N/A (file-based)
- MySQL: 3306
- PostgreSQL: 5432
- MariaDB: 3306

## Database CLI Tool

### File: `db-cli.js`

#### Purpose:
- Database migration management
- Seeder execution
- Database status monitoring
- Model generation
- Interactive database operations

#### Commands:

##### Migration Commands:
```bash
# Run all pending migrations
node db-cli.js migrate

# Undo last migration
node db-cli.js migrate:undo

# Check migration status
node db-cli.js migrate:status

# Create new migration
node db-cli.js migration:create <name>
```

##### Seeder Commands:
```bash
# Run all seeders
node db-cli.js seed

# Run specific seeder
node db-cli.js seed:run <seeder-name>

# Undo last seeder
node db-cli.js seed:undo

# Check seeder status
node db-cli.js seed:status

# Create new seeder
node db-cli.js seeder:create <name>
```

##### Database Commands:
```bash
# Check database status
node db-cli.js status

# Test database connection
node db-cli.js test

# Initialize database (migrate + seed)
node db-cli.js init

# Reset database (fresh start)
node db-cli.js reset
```

##### Model Commands:
```bash
# Create new model
node db-cli.js model:create <name>

# List all models
node db-cli.js model:list

# Validate models
node db-cli.js model:validate
```

### CLI Features:

#### 1. Interactive Mode
```bash
node db-cli.js
```
Provides menu-driven interface for database operations.

#### 2. Auto-Setup
Automatically detects missing database and initializes it.

#### 3. Error Handling
Comprehensive error messages and recovery suggestions.

#### 4. Colored Output
Status indicators and colored console output for better readability.

## Database Helper

### File: `src/helpers/databaseHelper.js`

#### Purpose:
- Database initialization automation
- Migration and seeder management
- Database status checking
- Error handling and recovery

#### Key Methods:

##### `autoSetupDatabase()`
```javascript
// Automatically set up database if not exists
const helper = new DatabaseHelper()
await helper.autoSetupDatabase()
```

##### `checkTablesExist()`
```javascript
// Check if database tables exist
const tablesExist = await helper.checkTablesExist()
console.log('Tables exist:', tablesExist)
```

##### `runMigrations()`
```javascript
// Run all pending migrations
const result = await helper.runMigrations()
console.log('Migrations completed:', result)
```

##### `runSeeders()`
```javascript
// Run all seeders
const result = await helper.runSeeders()
console.log('Seeders completed:', result)
```

##### `getDatabaseStatus()`
```javascript
// Get comprehensive database status
const status = await helper.getDatabaseStatus()
console.log('Database status:', status)
```

### Integration with Express App

#### In `app.js`:
```javascript
const DatabaseHelper = require('./src/helpers/databaseHelper')

async function initializeDatabase() {
  const helper = new DatabaseHelper()
  await helper.autoSetupDatabase()
  
  const status = await helper.getDatabaseStatus()
  console.log('Database initialized:', status)
}

// Initialize database on startup
initializeDatabase()
```

## Migration Management

### Creating Migrations

#### Using CLI:
```bash
node db-cli.js migration:create add-new-column
```

#### Using Sequelize CLI:
```bash
npx sequelize-cli migration:generate --name add-new-column
```

### Migration Structure:
```javascript
'use strict'

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Changes to apply
    await queryInterface.addColumn('Users', 'new_column', {
      type: Sequelize.STRING,
      allowNull: true
    })
  },

  down: async (queryInterface, Sequelize) => {
    // Changes to revert
    await queryInterface.removeColumn('Users', 'new_column')
  }
}
```

### Migration Best Practices:

1. **Reversible Operations**: Always provide `down` method
2. **Data Safety**: Backup data before destructive operations
3. **Testing**: Test migrations in development first
4. **Atomic Operations**: Use transactions for complex migrations
5. **Documentation**: Comment complex migration logic

### Common Migration Operations:

#### Add Column:
```javascript
await queryInterface.addColumn('Users', 'middle_name', {
  type: Sequelize.STRING,
  allowNull: true
})
```

#### Remove Column:
```javascript
await queryInterface.removeColumn('Users', 'middle_name')
```

#### Add Index:
```javascript
await queryInterface.addIndex('Users', ['email_address'], {
  unique: true,
  name: 'users_email_unique'
})
```

#### Create Table:
```javascript
await queryInterface.createTable('NewTable', {
  id: {
    type: Sequelize.UUID,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4
  },
  name: {
    type: Sequelize.STRING,
    allowNull: false
  },
  createdAt: {
    type: Sequelize.DATE,
    allowNull: false
  },
  updatedAt: {
    type: Sequelize.DATE,
    allowNull: false
  }
})
```

## Environment Setup

### Development Environment

#### SQLite Setup (Default):
```env
DB_TYPE=sqlite
# No additional configuration needed
```

#### MySQL Setup:
```env
DB_TYPE=mysql
DB_HOST=localhost
DB_PORT=3306
DB_NAME=foodtrip_dev
DB_USER=root
DB_PASSWORD=your-password
```

#### PostgreSQL Setup:
```env
DB_TYPE=postgresql
DB_HOST=localhost
DB_PORT=5432
DB_NAME=foodtrip_dev
DB_USER=postgres
DB_PASSWORD=your-password
```

### Production Environment

#### Environment Variables:
```env
NODE_ENV=production
DATABASE_URL=postgres://user:password@host:port/database
DB_TYPE=postgresql
```

#### SSL Configuration:
```javascript
// In config.js for production
ssl: process.env.NODE_ENV === 'production' ? {
  require: true,
  rejectUnauthorized: false
} : false
```

### Docker Setup

#### Docker Compose Example:
```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3600:3600"
    environment:
      - DB_TYPE=postgresql
      - DB_HOST=postgres
      - DB_NAME=foodtrip_db
      - DB_USER=postgres
      - DB_PASSWORD=password
    depends_on:
      - postgres

  postgres:
    image: postgres:13
    environment:
      - POSTGRES_DB=foodtrip_db
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

## Usage Examples

### Complete Database Setup:
```bash
# 1. Set environment variables
export DB_TYPE=mysql
export DB_HOST=localhost
export DB_NAME=foodtrip_db
export DB_USER=root
export DB_PASSWORD=password

# 2. Initialize database
node db-cli.js init

# 3. Check status
node db-cli.js status

# 4. Run additional seeders
node universal-seeder.js all
```

### Switching Database Types:
```bash
# From SQLite to MySQL
export DB_TYPE=mysql
export DB_HOST=localhost
export DB_NAME=foodtrip_db
export DB_USER=root
export DB_PASSWORD=password

# Reset and reinitialize
node db-cli.js reset
node db-cli.js init
```

### Migration Workflow:
```bash
# Create migration
node db-cli.js migration:create add-user-preferences

# Edit migration file
# vim src/database/migrations/YYYYMMDDHHMMSS-add-user-preferences.js

# Run migration
node db-cli.js migrate

# Check migration status
node db-cli.js migrate:status
```

### Database Maintenance:
```bash
# Check database health
node db-cli.js status

# Validate all models
node db-cli.js model:validate

# Run troubleshooter
node seeder-troubleshooter.js report

# Fix common issues
node seeder-troubleshooter.js fix
```

## Troubleshooting

### Common Issues

#### 1. Connection Errors
**Error**: `ECONNREFUSED` or `Connection refused`
**Solutions**:
- Check database server is running
- Verify host and port settings
- Check firewall settings
- Validate credentials

#### 2. Migration Failures
**Error**: Migration file not found or syntax errors
**Solutions**:
- Check migration file exists
- Validate migration syntax
- Review migration logs
- Use `migrate:undo` if needed

#### 3. Authentication Issues
**Error**: `Access denied` or `Authentication failed`
**Solutions**:
- Verify username and password
- Check user permissions
- Validate database exists
- Review connection string

#### 4. SQLite Issues
**Error**: `SQLITE_CANTOPEN` or permission errors
**Solutions**:
- Check file permissions
- Verify directory exists
- Ensure no file locks
- Check disk space

#### 5. Model Validation Errors
**Error**: Model associations or validation failures
**Solutions**:
- Review model definitions
- Check foreign key constraints
- Validate data types
- Run model validation

### Debugging Tips

#### 1. Enable Logging:
```javascript
// In config.js
logging: console.log
```

#### 2. Check Database Status:
```bash
node db-cli.js status
```

#### 3. Test Connection:
```bash
node db-cli.js test
```

#### 4. Review Migration Status:
```bash
node db-cli.js migrate:status
```

#### 5. Check Seeder Status:
```bash
node seeder-manager.js status
```

### Recovery Procedures

#### 1. Database Reset:
```bash
# Complete reset (destroys all data)
node db-cli.js reset

# Reinitialize
node db-cli.js init
```

#### 2. Migration Recovery:
```bash
# Undo last migration
node db-cli.js migrate:undo

# Fix migration file
# Re-run migration
node db-cli.js migrate
```

#### 3. Seeder Recovery:
```bash
# Fix seeder issues
node seeder-troubleshooter.js fix

# Re-run seeders
node seeder-manager.js run
```

## Performance Optimization

### Database Optimization

#### 1. Indexing:
```javascript
// Add indexes for frequently queried fields
await queryInterface.addIndex('Users', ['email_address'])
await queryInterface.addIndex('Dishes', ['resto_id'])
await queryInterface.addIndex('Orders', ['user_id', 'created_at'])
```

#### 2. Connection Pooling:
```javascript
// In config.js
pool: {
  max: 20,
  min: 0,
  acquire: 30000,
  idle: 10000
}
```

#### 3. Query Optimization:
```javascript
// Use includes for associations
const dishes = await Dish.findAll({
  include: [
    { model: DishCategory, as: 'dish_category' },
    { model: Restaurant, as: 'restaurant' }
  ]
})
```

### Monitoring

#### 1. Query Logging:
```javascript
// Log slow queries
logging: (sql, timing) => {
  if (timing > 1000) {
    console.log(`Slow query (${timing}ms):`, sql)
  }
}
```

#### 2. Performance Metrics:
```javascript
// Track database performance
const startTime = Date.now()
const result = await Model.findAll()
const duration = Date.now() - startTime
console.log(`Query took ${duration}ms`)
```

## Conclusion

This database management system provides comprehensive tools for managing database operations in the FoodTrip API project. It includes flexible configuration, migration management, and troubleshooting capabilities to ensure smooth database operations across different environments.

For additional support or questions, refer to the CLI help commands or consult the project documentation.

---

*Last updated: January 2025*
*Version: 1.0.0*
