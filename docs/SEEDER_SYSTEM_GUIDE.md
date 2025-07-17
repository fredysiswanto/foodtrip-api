# Seeder Management System Documentation

## Overview
This document provides comprehensive information about the seeder management system in the FoodTrip API project. The system includes various tools for managing database seeders, troubleshooting issues, and maintaining data integrity.

## Table of Contents
1. [Seeder Tools](#seeder-tools)
2. [Database Configuration](#database-configuration)
3. [Seeder Management](#seeder-management)
4. [Troubleshooting](#troubleshooting)
5. [Universal Seeder](#universal-seeder)
6. [Usage Examples](#usage-examples)
7. [Best Practices](#best-practices)

## Seeder Tools

### 1. Original Seeders (Fixed)
Location: `src/database/seeders/`

#### Fixed Seeders:
- **20220723095520-user-admin-fixed.js** - System admin and sample users
- **20220723095521-resto-categories-fixed.js** - Restaurant categories
- **20220723095522-dish-categories-fixed.js** - Dish categories

#### Features:
- ✅ Duplicate checking before insertion
- ✅ Proper error handling
- ✅ Idempotent operations
- ✅ UUID generation
- ✅ Password hashing for users
- ✅ Foreign key validation

### 2. Seeder Manager
File: `seeder-manager.js`

#### Purpose:
- Batch run all seeders
- Check seeder status
- Individual seeder execution
- Comprehensive error reporting

#### Commands:
```bash
# Run all seeders
node seeder-manager.js run

# Check status
node seeder-manager.js status

# Run specific seeder
node seeder-manager.js run-single <seeder-name>
```

### 3. Seeder Troubleshooter
File: `seeder-troubleshooter.js`

#### Purpose:
- Data validation
- Constraint checking
- Missing data detection
- Automatic issue fixing

#### Commands:
```bash
# Validate data
node seeder-troubleshooter.js validate

# Check constraints
node seeder-troubleshooter.js constraints

# Check missing data
node seeder-troubleshooter.js missing

# Generate comprehensive report
node seeder-troubleshooter.js report

# Fix common issues
node seeder-troubleshooter.js fix
```

### 4. Universal Seeder
File: `universal-seeder.js`

#### Purpose:
- Complete data seeding system
- Comprehensive data creation
- Database management
- Status monitoring

#### Commands:
```bash
# Seed all data
node universal-seeder.js all

# Seed specific entity
node universal-seeder.js users
node universal-seeder.js resto-categories
node universal-seeder.js dish-categories
node universal-seeder.js restaurants
node universal-seeder.js dishes

# Database operations
node universal-seeder.js status
node universal-seeder.js clear
```

## Database Configuration

### Multi-Database Support
The project supports multiple database types:
- SQLite (default)
- MySQL
- PostgreSQL
- MariaDB

### Configuration Files:
- `src/config/config.js` - Dynamic configuration
- `src/config/config.json` - Static configuration
- `src/helpers/databaseHelper.js` - Database utilities

### Environment Variables:
```env
DB_TYPE=sqlite
DB_HOST=localhost
DB_PORT=3306
DB_NAME=foodtrip_db
DB_USER=root
DB_PASSWORD=password
```

## Seeder Management

### System Admin User
**User ID**: `70ea56c6-407b-4bdf-8cf0-b4e09df50fe8`
- Required for foreign key constraints
- Automatically created by all seeders
- Default credentials: sysadmin@gmail.com / SysAdmin@123

### Data Hierarchy
1. **Users** (System Admin first)
2. **Restaurant Categories**
3. **Dish Categories**
4. **Restaurants** (requires Users and Restaurant Categories)
5. **Dishes** (requires Restaurants and Dish Categories)

### Validation Rules

#### Users
- `user_no`: Max 17 characters, unique
- `email_address`: Unique, valid email format
- `phone_number`: Philippine format (09xxxxxxxxx or +639xxxxxxxxx)
- `user_type`: Customer, Resto_Admin, or Admin
- `password`: Hashed with bcrypt

#### Restaurant Categories
- `restocatg_name`: Unique, not null

#### Dish Categories
- `dishcatg_name`: Unique, not null

#### Restaurants
- `resto_name`: Unique, not null
- `resto_phone`: Valid phone format
- `resto_email`: Valid email format
- `user_id`: Must reference existing user
- `restocatg_id`: Must reference existing category

#### Dishes
- `dish_no`: Max 17 characters, unique
- `dish_name`: Not null
- `dish_desc`: Not null
- `dish_price`: Valid decimal format
- `dish_img`: Not null (image filename)
- `status`: Available or Unavailable
- `dishcatg_id`: Must reference existing category
- `resto_id`: Must reference existing restaurant

## Troubleshooting

### Common Issues

#### 1. Duplicate Data
**Problem**: Seeder fails with unique constraint violation
**Solution**: 
- Run `node seeder-troubleshooter.js validate`
- Use `node seeder-troubleshooter.js fix` to auto-fix
- Fixed seeders include duplicate checking

#### 2. Foreign Key Violations
**Problem**: References to non-existent records
**Solution**:
- Ensure system admin user exists
- Run seeders in correct order
- Check constraints with troubleshooter

#### 3. Validation Errors
**Problem**: Data doesn't meet model validation rules
**Solution**:
- Check field requirements in models
- Validate data format before insertion
- Use troubleshooter to identify issues

#### 4. Missing Required Fields
**Problem**: NotNull violation errors
**Solution**:
- Check model definitions for required fields
- Ensure all required fields are provided
- Use universal seeder for complete data

### Error Handling

#### Seeder Manager Error Codes:
- ✅ **Success**: Seeder executed without errors
- ❌ **Failed**: Seeder execution failed
- ⚠️ **Warning**: Seeder executed with warnings

#### Common Error Messages:
- "Dish Number should not be null" - Missing dish_no field
- "Dish Description should not be null" - Missing dish_desc field
- "Dish Image should not be null" - Missing dish_img field
- "Unique constraint violation" - Duplicate data

## Universal Seeder

### Data Creation

#### Users (Sample Data):
- System Admin (required)
- Regular Admin
- Sample Customers
- Restaurant Owners

#### Restaurant Categories:
- Fast Food, Fine Dining, Casual Dining, Cafe
- Bakery, Street Food, Buffet, Food Truck
- Bar & Grill, Pizza, Asian Cuisine, Mexican
- Italian, American, Seafood

#### Dish Categories:
- Appetizers, Soups, Salads, Main Course
- Desserts, Beverages, Pasta, Rice Dishes
- Noodles, Grilled, Fried, Steamed
- Baked, Vegetarian, Vegan, Gluten-Free
- Spicy, Seafood, Meat, Chicken

#### Restaurants (Sample Data):
- The Golden Spoon (Fine Dining)
- Pizza Palace (Italian)
- Burger Barn (Fast Food)

#### Dishes (Sample Data):
- Grilled Chicken Breast
- Margherita Pizza
- Caesar Salad
- Chocolate Cake
- Beef Burger
- Spaghetti Carbonara
- Fish and Chips
- Chicken Curry
- Vegetable Stir Fry
- Ice Cream Sundae

### Database Operations

#### Status Checking:
```bash
node universal-seeder.js status
```
Output:
```
📊 Database Status:
   Users: 23
   Restaurant Categories: 6
   Dish Categories: 16
   Restaurants: 11
   Dishes: 10
```

#### Clear All Data:
```bash
node universal-seeder.js clear
```
**Warning**: This will delete all data except system admin

## Usage Examples

### Complete Setup (New Database):
```bash
# 1. Run migrations
node db-cli.js migrate

# 2. Seed all data
node universal-seeder.js all

# 3. Check status
node universal-seeder.js status

# 4. Validate data
node seeder-troubleshooter.js validate
```

### Troubleshooting Existing Data:
```bash
# 1. Generate report
node seeder-troubleshooter.js report

# 2. Fix issues
node seeder-troubleshooter.js fix

# 3. Validate fixes
node seeder-troubleshooter.js validate
```

### Adding New Data:
```bash
# Add only missing categories
node universal-seeder.js resto-categories
node universal-seeder.js dish-categories

# Add sample restaurants
node universal-seeder.js restaurants

# Add sample dishes
node universal-seeder.js dishes
```

### Using Fixed Seeders:
```bash
# Run all fixed seeders
node seeder-manager.js run

# Run specific fixed seeder
node seeder-manager.js run-single 20220723095520-user-admin-fixed.js
```

## Best Practices

### 1. Data Seeding
- Always run migrations before seeding
- Use fixed seeders for production-like data
- Check for existing data before insertion
- Maintain referential integrity

### 2. Error Handling
- Validate data before insertion
- Handle unique constraint violations
- Provide meaningful error messages
- Log errors for debugging

### 3. Performance
- Use batch operations when possible
- Avoid N+1 queries
- Create indexes for frequently queried fields
- Use transactions for related operations

### 4. Maintenance
- Regular validation of seeded data
- Monitor for data drift
- Update seeders when models change
- Document all seeder modifications

### 5. Security
- Hash passwords before storing
- Validate input data
- Use parameterized queries
- Avoid exposing sensitive information

## File Structure

```
foodtrip-api/
├── src/
│   ├── database/
│   │   └── seeders/
│   │       ├── 20220723095520-user-admin-fixed.js
│   │       ├── 20220723095521-resto-categories-fixed.js
│   │       └── 20220723095522-dish-categories-fixed.js
│   ├── config/
│   │   ├── config.js
│   │   └── config.json
│   ├── helpers/
│   │   └── databaseHelper.js
│   └── models/
├── docs/
│   └── SEEDER_SYSTEM_GUIDE.md
├── db-cli.js
├── seeder-manager.js
├── seeder-troubleshooter.js
├── universal-seeder.js
└── seeder-report.json
```

## Conclusion

This seeder management system provides comprehensive tools for managing database seeders in the FoodTrip API project. It includes validation, troubleshooting, and universal seeding capabilities to ensure data integrity and smooth database operations.

For additional support or questions, refer to the individual tool help commands or consult the project documentation.

---

*Last updated: January 2025*
*Version: 1.0.0*
