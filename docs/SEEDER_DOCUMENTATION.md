# Seeder Documentation

## Overview
Database seeders provide sample data for development and testing. This document covers seeder management, troubleshooting, and best practices.

## Seeder Status

### Current Seeders
- ✅ **Users** - 23 records (System admin + sample customers)
- ✅ **Restaurant Categories** - 6 records (Bakery, Cafe, Fast Food, etc.)
- ✅ **Dish Categories** - 16 records (Appetizer, Main Course, Dessert, etc.)

### Fixed Seeders
The following seeders have been created with improved error handling:

1. **20220721175011-user-fixed.js**
   - Handles duplicate user_id issues
   - Generates unique user numbers
   - Validates phone numbers and email addresses
   - Skips insertion if users already exist

2. **20220721190234-resto-categories-fixed.js**
   - Creates restaurant categories
   - Prevents duplicate category names
   - Skips if categories already exist

3. **20220721190251-dish-categories-fixed.js**
   - Creates dish categories
   - Prevents duplicate category names
   - Skips if categories already exist

## Seeder Management

### Using Seeder Manager
```bash
# Check seeder status
node seeder-manager.js status

# Run all fixed seeders
node seeder-manager.js run
```

### Using Database CLI
```bash
# Check database status (includes seeder data)
npm run db:status

# Run all seeders (original)
npm run db:seed

# Run specific seeder
npx sequelize-cli db:seed --seed filename.js

# Undo last seeder
npm run db:cli seed:undo

# Undo all seeders
npm run db:cli seed:undo:all
```

## Seeder Structure

### Basic Seeder Template
```javascript
'use strict'

module.exports = {
  async up(queryInterface, Sequelize) {
    try {
      // Check if data already exists
      const existing = await queryInterface.sequelize.query(
        'SELECT COUNT(*) as count FROM "TableName"',
        { type: Sequelize.QueryTypes.SELECT }
      )
      
      if (existing[0].count > 0) {
        console.log('ℹ️  Data already exists, skipping seeder')
        return
      }

      console.log('🔄 Creating data...')
      
      const data = [
        // Your data here
      ]

      await queryInterface.bulkInsert('TableName', data, {
        ignoreDuplicates: true
      })

      console.log('✅ Seeder completed successfully')
    } catch (error) {
      console.error('❌ Seeder failed:', error.message)
      throw error
    }
  },

  async down(queryInterface, Sequelize) {
    try {
      await queryInterface.bulkDelete('TableName', null, {})
      console.log('✅ Seeder rolled back successfully')
    } catch (error) {
      console.error('❌ Seeder rollback failed:', error.message)
      throw error
    }
  }
}
```

## Common Issues and Solutions

### 1. Duplicate Key Errors
**Problem**: Seeder tries to insert existing data
**Solution**: Check if data exists before inserting
```javascript
const existing = await queryInterface.sequelize.query(
  'SELECT COUNT(*) as count FROM "TableName"',
  { type: Sequelize.QueryTypes.SELECT }
)

if (existing[0].count > 0) {
  console.log('ℹ️  Data already exists, skipping seeder')
  return
}
```

### 2. Validation Errors
**Problem**: Data doesn't meet model constraints
**Solution**: Validate data before insertion
```javascript
// Check string length
if (data.user_no.length > 17) {
  throw new Error('User number too long')
}

// Check enum values
const validTypes = ['Customer', 'Resto_Admin', 'Admin']
if (!validTypes.includes(data.user_type)) {
  throw new Error('Invalid user type')
}
```

### 3. Foreign Key Constraints
**Problem**: Referenced data doesn't exist
**Solution**: Ensure dependent data exists first
```javascript
// Check if referenced user exists
const userExists = await queryInterface.sequelize.query(
  'SELECT user_id FROM "Users" WHERE user_id = :userId',
  {
    replacements: { userId: data.created_by },
    type: Sequelize.QueryTypes.SELECT
  }
)

if (userExists.length === 0) {
  throw new Error('Referenced user does not exist')
}
```

### 4. Large Dataset Performance
**Problem**: Seeder timeout on large datasets
**Solution**: Use batch processing
```javascript
const batchSize = 100
for (let i = 0; i < data.length; i += batchSize) {
  const batch = data.slice(i, i + batchSize)
  await queryInterface.bulkInsert('TableName', batch, {
    ignoreDuplicates: true
  })
  console.log(`✅ Inserted batch ${Math.floor(i / batchSize) + 1}`)
}
```

## Data Guidelines

### User Data
- **user_id**: Must be valid UUID
- **user_no**: Max 17 characters (format: USR-XXXXXXXXXXXXX)
- **email_address**: Must be valid email format
- **phone_number**: Must match regex `/^(09|\\+639)\\d{9}$/`
- **user_type**: Must be 'Customer', 'Resto_Admin', or 'Admin'
- **gender**: Must be 'Male', 'Female', or 'Others'

### Category Data
- **category_id**: Must be valid UUID
- **category_name**: Must be unique
- **created_by**: Must reference existing user

### Common Fields
- **date_created**: Use `new Date()`
- **date_updated**: Use `new Date()`
- **created_by**: Should reference system admin user

## Best Practices

### 1. Idempotent Seeders
Make seeders safe to run multiple times:
```javascript
// Check if data exists
const existing = await queryInterface.sequelize.query(...)
if (existing[0].count > 0) return
```

### 2. Error Handling
Always wrap seeder logic in try-catch:
```javascript
try {
  // Seeder logic
} catch (error) {
  console.error('❌ Seeder failed:', error.message)
  throw error
}
```

### 3. Logging
Provide clear feedback about seeder progress:
```javascript
console.log('🔄 Creating data...')
console.log('✅ Seeder completed successfully')
console.log('ℹ️  Data already exists, skipping seeder')
```

### 4. Data Validation
Validate data before insertion:
```javascript
// Validate required fields
if (!data.first_name || !data.last_name) {
  throw new Error('First name and last name are required')
}

// Validate data types
if (typeof data.email_address !== 'string') {
  throw new Error('Email address must be a string')
}
```

### 5. Use Transactions
For complex seeders with multiple tables:
```javascript
const transaction = await queryInterface.sequelize.transaction()
try {
  await queryInterface.bulkInsert('Table1', data1, { transaction })
  await queryInterface.bulkInsert('Table2', data2, { transaction })
  await transaction.commit()
} catch (error) {
  await transaction.rollback()
  throw error
}
```

## Testing Seeders

### Manual Testing
```bash
# 1. Clear existing data
npm run db:cli seed:undo:all

# 2. Run seeder
node seeder-manager.js run

# 3. Check results
npm run db:status
```

### Automated Testing
```javascript
// test-seeder.js
const db = require('./src/models')

async function testSeeder() {
  // Clear data
  await db.User.destroy({ where: {}, force: true })
  
  // Run seeder
  const seeder = require('./src/database/seeders/user-fixed.js')
  await seeder.up(db.sequelize.getQueryInterface(), db.Sequelize)
  
  // Verify results
  const users = await db.User.findAll()
  console.log(`Created ${users.length} users`)
}
```

## Troubleshooting

### Common Error Messages

**"Validation error"**
- Check model constraints
- Verify data types and formats
- Ensure required fields are present

**"user_id must be unique"**
- Data already exists in database
- Use `ignoreDuplicates: true` option
- Check for existing data first

**"Phone number validation failed"**
- Ensure phone format matches `/^(09|\\+639)\\d{9}$/`
- Examples: "09123456789", "+639123456789"

**"User type validation failed"**
- Use only: 'Customer', 'Resto_Admin', 'Admin'
- Check for typos in user_type values

### Debug Steps
1. Check database status: `npm run db:status`
2. Verify model constraints in `/src/models/`
3. Test individual seeder: `node seeder-manager.js run`
4. Check logs for specific error messages
5. Validate data format before insertion

## Production Considerations

### 1. Environment-specific Data
```javascript
const isProduction = process.env.NODE_ENV === 'production'

if (isProduction) {
  // Only create essential data in production
  data = data.filter(item => item.essential === true)
}
```

### 2. Data Privacy
- Don't use real personal data in seeders
- Use fake/dummy data for testing
- Consider data protection regulations

### 3. Performance
- Use batch processing for large datasets
- Consider running seeders during off-peak hours
- Monitor database performance during seeding

### 4. Backup
- Always backup database before running seeders in production
- Test seeders in staging environment first
- Have rollback plan ready
