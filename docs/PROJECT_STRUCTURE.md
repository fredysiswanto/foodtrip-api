# Project Structure Guide

This document explains the organization and structure of the FoodTrip API project.

## 📁 Root Directory Structure

```
foodtrip-api/
├── 📁 src/                     # Source code
├── 📁 docs/                    # Documentation
├── 📁 test-case/              # Test examples and cases
├── 📁 public/                 # Static files and uploads
├── 📁 db/                     # SQLite database files
├── 📁 request/                # HTTP request examples
├── 📄 app.js                  # Main application entry point
├── 📄 package.json            # Dependencies and scripts
├── 📄 .env.example            # Environment variables template
├── 📄 README.md               # Main project documentation
└── 📄 nodemon.json            # Nodemon configuration
```

## 📂 Source Code (`/src`)

### 🔧 Configuration (`/src/config`)
```
config/
├── config.js          # Database configuration logic
└── config.json        # Sequelize configuration file
```

**Purpose**: Database connection settings and environment-specific configurations.

### 🎮 Controllers (`/src/controllers`)
```
controllers/
├── test.controller.js  # Test endpoint controller
├── 📁 admin/          # Admin-specific controllers
├── 📁 all/            # Shared controllers
├── 📁 customer/       # Customer-specific controllers
├── 📁 home/           # Public/home controllers
└── 📁 resto_admin/    # Restaurant admin controllers
```

**Purpose**: Handle HTTP requests, process business logic, and return responses.

**Examples**:
- `customer/auth.controller.js` - User authentication
- `resto_admin/dish.controller.js` - Dish management
- `admin/user.controller.js` - User administration

### 🗃️ Database (`/src/database`)
```
database/
├── 📁 migrations/     # Database schema migrations
└── 📁 seeders/        # Sample data seeders
```

**Purpose**: Version control for database schema and sample data.

**Migration Example**:
```javascript
// 20240101000000-create-restaurant.js
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Restaurants', {
      id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
        primaryKey: true
      },
      name: {
        type: Sequelize.STRING,
        allowNull: false
      }
    })
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Restaurants')
  }
}
```

### 🛠️ Helpers (`/src/helpers`)
```
helpers/
├── controller.helper.js   # Common controller utilities
├── databaseHelper.js      # Database management utilities
├── imageHelper.js         # Image processing utilities
└── ollamaHelper.js        # AI integration utilities
```

**Purpose**: Reusable utility functions and helper methods.

### 🛡️ Middlewares (`/src/middlewares`)
```
middlewares/
├── uploadImage.js      # File upload middleware
└── validateCart.js     # Cart validation middleware
```

**Purpose**: Express middleware for authentication, validation, and processing.

**Example Middleware**:
```javascript
// Authentication middleware
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization']
  const token = authHeader && authHeader.split(' ')[1]
  
  if (!token) {
    return res.status(401).json({ message: 'Access token required' })
  }
  
  jwt.verify(token, process.env.TOKEN_SECRET, (err, user) => {
    if (err) return res.status(403).json({ message: 'Invalid token' })
    req.user = user
    next()
  })
}
```

### 📊 Models (`/src/models`)
```
models/
├── index.js            # Model initialization and associations
├── user.js             # User model
├── restaurant.js       # Restaurant model
├── dish.js             # Dish model
├── order.js            # Order model
├── cart.js             # Cart model
├── address.js          # Address model
├── payment.js          # Payment model
└── ... (other models)
```

**Purpose**: Sequelize models defining database schema and relationships.

**Model Example**:
```javascript
// restaurant.js
module.exports = (sequelize, DataTypes) => {
  const Restaurant = sequelize.define('Restaurant', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    description: DataTypes.TEXT,
    address: DataTypes.STRING,
    phoneNumber: DataTypes.STRING,
    isActive: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    }
  })

  Restaurant.associate = (models) => {
    Restaurant.hasMany(models.Dish, { foreignKey: 'restaurantId' })
    Restaurant.hasMany(models.Order, { foreignKey: 'restaurantId' })
  }

  return Restaurant
}
```

### 🛣️ Routes (`/src/routes`)
```
routes/
├── admin.routes.js       # Admin API routes
├── customer.routes.js    # Customer API routes
├── home.routes.js        # Public API routes
├── resto_admin.routes.js # Restaurant admin routes
└── test.routes.js        # Test routes
```

**Purpose**: Define API endpoints and route them to controllers.

**Route Example**:
```javascript
// customer.routes.js
const express = require('express')
const router = express.Router()
const authController = require('../controllers/customer/auth.controller')
const { authenticateToken } = require('../middlewares/auth')

// Public routes
router.post('/auth/login', authController.login)
router.post('/auth/register', authController.register)

// Protected routes
router.get('/profile', authenticateToken, authController.getProfile)
router.put('/profile', authenticateToken, authController.updateProfile)

module.exports = router
```

## 📚 Documentation (`/docs`)

```
docs/
├── API_DOCUMENTATION.md      # Complete API reference
├── DATABASE_MANAGEMENT.md    # Database setup and management
├── SEEDER_DOCUMENTATION.md   # Seeder system documentation
├── SEEDER_SYSTEM_GUIDE.md    # Advanced seeder guide
├── USER_GUIDE.md             # Comprehensive user guide
└── QUICK_START.md            # Quick setup guide
```

**Purpose**: Comprehensive project documentation for users and developers.

## 🧪 Test Cases (`/test-case`)

```
test-case/
├── List-Api.md            # Complete API endpoint list
├── template.md            # Test case template
├── template.xlsx          # Excel test template
├── 📁 Admin Resto/        # Restaurant admin test cases
└── 📁 Home/               # Public endpoint test cases
```

**Purpose**: Manual testing documentation and API testing examples.

## 📁 Public Files (`/public`)

```
public/
├── sketch1656314034272.png   # Project logo
└── 📁 uploads/               # Uploaded files
    ├── 📁 dishes/            # Dish images
    └── 📁 restaurants/       # Restaurant images
```

**Purpose**: Static files, uploads, and public assets.

## 🔧 Configuration Files

### 📄 `app.js`
Main application entry point that:
- Initializes Express server
- Sets up middleware
- Connects to database
- Defines route handlers
- Starts the server

### 📄 `package.json`
Project metadata and dependencies:
```json
{
  "scripts": {
    "dev": "nodemon app.js",
    "db:setup": "node db-cli.js setup",
    "db:migrate": "npx sequelize-cli db:migrate",
    "db:seed": "npx sequelize-cli db:seed:all",
    "lint": "eslint .",
    "format": "prettier --write ."
  }
}
```

### 📄 `.env.example`
Environment variables template:
```env
# Server Configuration
PORT=5000
NODE_ENV=development
TOKEN_SECRET=your-secret-key

# Database Configuration
USE_DB=sqlite
DB_STORAGE=./db/database.sqlite
```

### 📄 `nodemon.json`
Nodemon configuration for development:
```json
{
  "watch": ["src", "app.js"],
  "ext": "js,json",
  "ignore": ["node_modules", "public/uploads"],
  "env": {
    "NODE_ENV": "development"
  }
}
```

## 📊 Database Structure

### Models and Relationships

```
User (1:N) → Order
User (1:1) → Cart
Restaurant (1:N) → Dish
Restaurant (1:N) → Order
Order (1:N) → OrderDetail
Cart (1:N) → CartDetail
Dish (1:N) → CartDetail
Dish (1:N) → OrderDetail
```

### Key Tables

1. **Users**: Authentication and user profiles
2. **Restaurants**: Restaurant information and settings
3. **Dishes**: Food items with pricing and descriptions
4. **Orders**: Order tracking and management
5. **Cart**: Shopping cart functionality
6. **Addresses**: User delivery addresses
7. **Payments**: Payment method information

## 🔄 Data Flow

### Typical Request Flow

1. **Client Request** → Express Router
2. **Router** → Middleware (auth, validation)
3. **Middleware** → Controller
4. **Controller** → Model (database)
5. **Model** → Database Query
6. **Database** → Model Response
7. **Model** → Controller Processing
8. **Controller** → JSON Response
9. **JSON Response** → Client

### File Upload Flow

1. **Client** uploads file → Multer middleware
2. **Multer** saves file → `/public/uploads/`
3. **Controller** processes → Database update
4. **Database** stores file path
5. **API** returns file URL

## 🚀 Development Workflow

### Adding New Features

1. **Model**: Create/update Sequelize model
2. **Migration**: Create database migration
3. **Controller**: Implement business logic
4. **Routes**: Define API endpoints
5. **Middleware**: Add validation/auth if needed
6. **Test**: Create test cases
7. **Documentation**: Update API docs

### Database Changes

1. **Create Migration**: `npx sequelize-cli migration:generate --name your-change`
2. **Edit Migration**: Define up/down methods
3. **Run Migration**: `pnpm run db:migrate`
4. **Update Model**: Modify Sequelize model
5. **Test**: Verify changes work

## 🛠️ Build and Deployment

### Development Build
```bash
pnpm install       # Install dependencies
pnpm run db:setup  # Setup database
pnpm run dev       # Start development server
```

### Production Build
```bash
NODE_ENV=production
pnpm install --prod
pnpm run db:migrate
node app.js
```

## 📈 Monitoring and Logs

### Log Locations
- **Application Logs**: Console output
- **Database Logs**: Enabled via `DB_LOGGING=true`
- **Error Logs**: Captured in error handlers

### Performance Monitoring
- Database query performance
- API response times
- Memory usage
- Error rates

---

This structure provides a scalable, maintainable foundation for the FoodTrip API while following Node.js and Express.js best practices.
