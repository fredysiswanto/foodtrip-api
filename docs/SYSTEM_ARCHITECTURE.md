# System Architecture Guide

This document provides a comprehensive overview of the FoodTrip API system architecture, including components, data flow, design patterns, and technical decisions.

## 🏗️ Architecture Overview

FoodTrip API follows a **3-tier architecture** pattern with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                   │
│  (Frontend Applications, Mobile Apps, Third-party APIs) │
└─────────────────────┬───────────────────────────────────┘
                      │ HTTP/HTTPS Requests
┌─────────────────────▼───────────────────────────────────┐
│                   Application Layer                     │
│        (Express.js API Server, Business Logic)         │
└─────────────────────┬───────────────────────────────────┘
                      │ Database Queries
┌─────────────────────▼───────────────────────────────────┐
│                     Data Layer                         │
│     (SQLite/MySQL/PostgreSQL Database, File Storage)   │
└─────────────────────────────────────────────────────────┘
```

## 🧩 System Components

### 1. Core Components

#### Application Server (Express.js)
- **Purpose**: HTTP request handling and routing
- **Location**: `app.js`
- **Responsibilities**:
  - Request routing
  - Middleware orchestration
  - Error handling
  - Server configuration

#### Database Layer (Sequelize ORM)
- **Purpose**: Data persistence and management
- **Location**: `src/models/`, `src/database/`
- **Responsibilities**:
  - Data modeling
  - Database migrations
  - Query optimization
  - Relationship management

#### Business Logic Layer
- **Purpose**: Application logic and rules
- **Location**: `src/controllers/`, `src/helpers/`
- **Responsibilities**:
  - Request processing
  - Business rule enforcement
  - Data validation
  - Service integration

### 2. Supporting Components

#### Authentication & Authorization
- **JWT Token Management**: Stateless authentication
- **Role-Based Access Control**: Admin, Restaurant Admin, Customer
- **Session Management**: Token lifecycle and refresh

#### File Storage System
- **Image Upload**: Dish and restaurant images
- **Static File Serving**: Public asset delivery
- **File Validation**: Type and size constraints

#### API Documentation
- **Comprehensive Documentation**: Complete API reference
- **Request/Response Examples**: Implementation guidelines
- **Error Handling**: Standardized error responses

## 📊 Data Architecture

### Database Design Principles

1. **Normalization**: Reduced data redundancy
2. **Referential Integrity**: Foreign key constraints
3. **Scalability**: Optimized for growth
4. **Performance**: Indexed queries

### Entity Relationship Diagram

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│    User     │    │  Restaurant  │    │   Dish      │
│             │    │              │    │             │
│ id (PK)     │    │ id (PK)      │    │ id (PK)     │
│ name        │◄──┐│ name         │◄──┐│ name        │
│ email       │   ││ description  │   ││ description │
│ password    │   ││ address      │   ││ price       │
│ role        │   ││ phone        │   ││ image       │
│ created_at  │   │└──────────────┘   │└─────────────┘
└─────────────┘   │                   │
       │          │                   │
       │          │                   │
┌─────────────┐   │ ┌──────────────┐  │ ┌─────────────┐
│   Address   │   │ │ OpeningHour  │  │ │DishCategory │
│             │   │ │              │  │ │             │
│ id (PK)     │   │ │ id (PK)      │  │ │ id (PK)     │
│ user_id(FK) │───┘ │ restaurant_id│──┘ │ name        │
│ title       │     │ day          │    │ description │
│ address     │     │ opening_time │    └─────────────┘
│ latitude    │     │ closing_time │           │
│ longitude   │     │ is_open      │           │
└─────────────┘     └──────────────┘           │
       │                                       │
       │                                       │
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│    Order    │    │   OrderDetails│   │    Cart     │
│             │    │              │    │             │
│ id (PK)     │    │ id (PK)      │    │ id (PK)     │
│ user_id(FK) │────┤ order_id(FK) │    │ user_id(FK) │
│ address_id  │    │ dish_id(FK)  │    │ dish_id(FK) │
│ total_price │    │ quantity     │    │ quantity    │
│ status      │    │ price        │    │ notes       │
│ created_at  │    │ notes        │    │ created_at  │
└─────────────┘    └──────────────┘    └─────────────┘
```

### Key Entities

#### User Management
```sql
-- User entity with role-based access
User {
  id: Primary Key
  name: String (required)
  email: String (unique, required)
  password: String (hashed, required)
  phone: String
  role: Enum ['admin', 'restaurant_admin', 'customer']
  is_active: Boolean (default: true)
  created_at: Timestamp
  updated_at: Timestamp
}
```

#### Restaurant Management
```sql
-- Restaurant entity
Restaurant {
  id: Primary Key
  user_id: Foreign Key (User)
  name: String (required)
  description: Text
  address: String (required)
  phone: String
  image: String (file path)
  restocategory_id: Foreign Key (RestaurantCategory)
  is_active: Boolean (default: true)
  created_at: Timestamp
  updated_at: Timestamp
}

-- Opening hours for restaurants
OpeningHour {
  id: Primary Key
  restaurant_id: Foreign Key (Restaurant)
  day: Enum ['monday', 'tuesday', ..., 'sunday']
  opening_time: Time
  closing_time: Time
  is_open: Boolean (default: true)
}
```

#### Menu Management
```sql
-- Dish entity
Dish {
  id: Primary Key
  restaurant_id: Foreign Key (Restaurant)
  dishcategory_id: Foreign Key (DishCategory)
  name: String (required)
  description: Text
  price: Decimal (required)
  image: String (file path)
  is_available: Boolean (default: true)
  created_at: Timestamp
  updated_at: Timestamp
}

-- Dish categories
DishCategory {
  id: Primary Key
  name: String (required)
  description: Text
  created_at: Timestamp
}
```

#### Order Management
```sql
-- Order entity
Order {
  id: Primary Key
  user_id: Foreign Key (User)
  address_id: Foreign Key (Address)
  total_price: Decimal
  status: Enum ['pending', 'confirmed', 'preparing', 'ready', 'delivered', 'cancelled']
  payment_method: Enum ['cash', 'card', 'digital_wallet']
  payment_status: Enum ['pending', 'paid', 'failed', 'refunded']
  notes: Text
  created_at: Timestamp
  updated_at: Timestamp
}

-- Order details (items in order)
OrderDetails {
  id: Primary Key
  order_id: Foreign Key (Order)
  dish_id: Foreign Key (Dish)
  quantity: Integer (required)
  price: Decimal (price at time of order)
  notes: Text
}

-- Shopping cart
Cart {
  id: Primary Key
  user_id: Foreign Key (User)
  dish_id: Foreign Key (Dish)
  quantity: Integer (required)
  notes: Text
  created_at: Timestamp
  updated_at: Timestamp
}
```

## 🔄 Request Flow Architecture

### 1. API Request Lifecycle

```
Client Request
      │
      ▼
┌─────────────┐
│ Express.js  │ ◄── app.js (main entry point)
│ Router      │
└─────┬───────┘
      │
      ▼
┌─────────────┐
│ Middleware  │ ◄── Authentication, Validation, Logging
│ Stack       │
└─────┬───────┘
      │
      ▼
┌─────────────┐
│ Route       │ ◄── src/routes/*.routes.js
│ Handler     │
└─────┬───────┘
      │
      ▼
┌─────────────┐
│ Controller  │ ◄── src/controllers/*/*.controller.js
│ Method      │
└─────┬───────┘
      │
      ▼
┌─────────────┐
│ Business    │ ◄── src/helpers/*.js
│ Logic       │
└─────┬───────┘
      │
      ▼
┌─────────────┐
│ Database    │ ◄── src/models/*.js (Sequelize ORM)
│ Operation   │
└─────┬───────┘
      │
      ▼
┌─────────────┐
│ Response    │ ◄── JSON response with status codes
│ Formatting  │
└─────────────┘
```

### 2. Authentication Flow

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│   Client    │    │   API Server │    │  Database   │
└─────┬───────┘    └──────┬───────┘    └─────┬───────┘
      │                   │                  │
      │ POST /login       │                  │
      ├──────────────────►│                  │
      │ {email, password} │                  │
      │                   │ Validate user    │
      │                   ├─────────────────►│
      │                   │                  │
      │                   │ User data        │
      │                   │◄─────────────────┤
      │                   │                  │
      │                   │ Generate JWT     │
      │                   │ token            │
      │ Response          │                  │
      │◄──────────────────┤                  │
      │ {token, user}     │                  │
      │                   │                  │
      │ API Request       │                  │
      ├──────────────────►│                  │
      │ Bearer <token>    │                  │
      │                   │ Verify token     │
      │                   │                  │
      │ Protected data    │                  │
      │◄──────────────────┤                  │
```

### 3. File Upload Flow

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│   Client    │    │   API Server │    │File Storage │
└─────┬───────┘    └──────┬───────┘    └─────┬───────┘
      │                   │                  │
      │ POST with file    │                  │
      ├──────────────────►│                  │
      │ multipart/form    │                  │
      │                   │ Validate file    │
      │                   │ (size, type)     │
      │                   │                  │
      │                   │ Generate unique  │
      │                   │ filename         │
      │                   │                  │
      │                   │ Save file        │
      │                   ├─────────────────►│
      │                   │                  │
      │                   │ File path        │
      │                   │◄─────────────────┤
      │                   │                  │
      │                   │ Update database  │
      │                   │ with file path   │
      │ Success response  │                  │
      │◄──────────────────┤                  │
```

## 🔧 Design Patterns

### 1. MVC (Model-View-Controller) Pattern

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│    Model    │    │ Controller   │    │    View     │
│             │    │              │    │             │
│ ◦ User      │◄──►│ ◦ AuthCtrl   │◄──►│ ◦ JSON API  │
│ ◦ Restaurant│    │ ◦ RestaurantCtrl  │ ◦ Response  │
│ ◦ Dish      │    │ ◦ DishCtrl   │    │ ◦ Error     │
│ ◦ Order     │    │ ◦ OrderCtrl  │    │   Messages  │
│             │    │              │    │             │
│ Data Layer  │    │ Business     │    │ Presentation│
│ Database    │    │ Logic Layer  │    │ Layer       │
└─────────────┘    └──────────────┘    └─────────────┘
```

### 2. Repository Pattern (via Sequelize ORM)

```javascript
// Model as Repository
class User extends Model {
  static async findByEmail(email) {
    return this.findOne({ where: { email } });
  }
  
  static async createUser(userData) {
    return this.create(userData);
  }
  
  static async updateUser(id, updateData) {
    return this.update(updateData, { where: { id } });
  }
}

// Controller uses Model/Repository
class AuthController {
  async login(req, res) {
    const user = await User.findByEmail(req.body.email);
    // Business logic here
  }
}
```

### 3. Middleware Pattern

```javascript
// Express middleware chain
app.use(cors());                    // CORS handling
app.use(express.json());            // JSON parsing
app.use(morgan('combined'));        // Logging
app.use('/api/admin', 
  authenticateToken,                // Authentication
  authorizeRole(['admin']),         // Authorization
  adminRoutes                       // Route handling
);
```

### 4. Factory Pattern (Database Configuration)

```javascript
// Database configuration factory
const configFactory = {
  development: {
    dialect: 'sqlite',
    storage: './db/database.sqlite'
  },
  
  production: {
    dialect: 'postgresql',
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    username: process.env.DB_USER,
    password: process.env.DB_PASS
  }
};

const config = configFactory[process.env.NODE_ENV || 'development'];
```

## 🛡️ Security Architecture

### 1. Authentication & Authorization

```
┌─────────────────────────────────────────────────────┐
│                Security Layers                      │
├─────────────────────────────────────────────────────┤
│ 1. HTTPS/TLS Encryption                            │
├─────────────────────────────────────────────────────┤
│ 2. CORS (Cross-Origin Resource Sharing)            │
├─────────────────────────────────────────────────────┤
│ 3. Rate Limiting                                    │
├─────────────────────────────────────────────────────┤
│ 4. JWT Authentication                               │
├─────────────────────────────────────────────────────┤
│ 5. Role-Based Access Control (RBAC)                │
├─────────────────────────────────────────────────────┤
│ 6. Input Validation & Sanitization                 │
├─────────────────────────────────────────────────────┤
│ 7. SQL Injection Prevention (Sequelize ORM)        │
├─────────────────────────────────────────────────────┤
│ 8. Password Hashing (bcrypt)                       │
└─────────────────────────────────────────────────────┘
```

### 2. Role-Based Access Control

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│    Admin    │    │Restaurant    │    │  Customer   │
│             │    │    Admin     │    │             │
│ ◦ All users │    │ ◦ Own resto  │    │ ◦ Own profile│
│ ◦ All restos│    │ ◦ Own dishes │    │ ◦ Own orders │
│ ◦ All orders│    │ ◦ Own orders │    │ ◦ Public data│
│ ◦ System    │    │ ◦ Opening hrs│    │ ◦ Cart mgmt  │
│   config    │    │              │    │             │
└─────────────┘    └──────────────┘    └─────────────┘
```

### 3. Data Protection

```javascript
// Password hashing
const bcrypt = require('bcrypt');
const saltRounds = 12;

const hashPassword = async (password) => {
  return await bcrypt.hash(password, saltRounds);
};

// JWT token generation
const jwt = require('jsonwebtoken');

const generateToken = (payload) => {
  return jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: '24h',
    issuer: 'foodtrip-api',
    audience: 'foodtrip-client'
  });
};

// Input validation
const { body, validationResult } = require('express-validator');

const validateUserInput = [
  body('email').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }).trim(),
  body('name').trim().escape()
];
```

## 📁 Directory Structure Architecture

```
foodtrip-api/
├── 📁 src/                         # Source code
│   ├── 📁 config/                  # Configuration files
│   │   ├── config.js               # Database config logic
│   │   └── config.json             # Sequelize config
│   ├── 📁 controllers/             # Request handlers
│   │   ├── 📁 admin/               # Admin controllers
│   │   ├── 📁 customer/            # Customer controllers
│   │   ├── 📁 resto_admin/         # Restaurant admin controllers
│   │   ├── 📁 home/                # Public controllers
│   │   └── test.controller.js      # Test endpoints
│   ├── 📁 database/                # Database files
│   │   ├── 📁 migrations/          # Schema migrations
│   │   └── 📁 seeders/             # Sample data
│   ├── 📁 helpers/                 # Utility functions
│   │   ├── controller.helper.js    # Controller utilities
│   │   ├── databaseHelper.js       # Database utilities
│   │   ├── imageHelper.js          # Image processing
│   │   └── ollamaHelper.js         # AI integration
│   ├── 📁 middlewares/             # Express middlewares
│   │   ├── uploadImage.js          # File upload handling
│   │   └── validateCart.js         # Cart validation
│   ├── 📁 models/                  # Database models
│   │   ├── index.js                # Models registration
│   │   ├── user.js                 # User model
│   │   ├── restaurant.js           # Restaurant model
│   │   └── [other models]          # Additional models
│   └── 📁 routes/                  # Route definitions
│       ├── admin.routes.js         # Admin routes
│       ├── customer.routes.js      # Customer routes
│       ├── resto_admin.routes.js   # Restaurant admin routes
│       ├── home.routes.js          # Public routes
│       └── test.routes.js          # Test routes
├── 📁 docs/                        # Documentation
├── 📁 test-case/                   # Test cases and examples
├── 📁 public/                      # Static files and uploads
├── 📁 db/                          # SQLite database files
├── 📄 app.js                       # Main application entry
├── 📄 package.json                 # Dependencies and scripts
└── 📄 .env.example                 # Environment template
```

## 🚀 Deployment Architecture

### 1. Development Environment

```
┌─────────────────────────────────────────────────────┐
│              Development Stack                      │
├─────────────────────────────────────────────────────┤
│ ◦ Node.js + Express.js                             │
│ ◦ SQLite Database (file-based)                     │
│ ◦ Local file storage                               │
│ ◦ Nodemon (hot reload)                             │
│ ◦ ESLint + Prettier (code quality)                 │
└─────────────────────────────────────────────────────┘
```

### 2. Production Environment Options

#### Option A: Single Server Deployment
```
┌─────────────────────────────────────────────────────┐
│                 Production Server                   │
├─────────────────────────────────────────────────────┤
│ ◦ PM2 Process Manager                               │
│ ◦ Nginx Reverse Proxy                              │
│ ◦ PostgreSQL/MySQL Database                        │
│ ◦ SSL/HTTPS Encryption                             │
│ ◦ Log Management                                    │
└─────────────────────────────────────────────────────┘
```

#### Option B: Containerized Deployment
```
┌─────────────────────────────────────────────────────┐
│                 Docker Containers                   │
├─────────────────────────────────────────────────────┤
│ ┌─────────────┐  ┌──────────────┐  ┌─────────────┐ │
│ │   App       │  │   Database   │  │   Nginx     │ │
│ │ Container   │  │  Container   │  │ Container   │ │
│ └─────────────┘  └──────────────┘  └─────────────┘ │
└─────────────────────────────────────────────────────┘
```

#### Option C: Cloud Platform Deployment
```
┌─────────────────────────────────────────────────────┐
│                 Cloud Platform                      │
├─────────────────────────────────────────────────────┤
│ ◦ Heroku / Railway / DigitalOcean                   │
│ ◦ AWS / Google Cloud / Azure                       │
│ ◦ Managed Database Service                         │
│ ◦ CDN for static files                             │
│ ◦ Load balancing                                    │
└─────────────────────────────────────────────────────┘
```

### 3. Scalability Considerations

#### Horizontal Scaling
```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│Load Balancer│    │   App Server │    │  Database   │
│   (Nginx)   │    │   Instance 1 │    │   Cluster   │
│             │    ├──────────────┤    │             │
│             │───►│   App Server │◄──►│ Primary DB  │
│             │    │   Instance 2 │    │ Replica DB  │
│             │    ├──────────────┤    │             │
│             │    │   App Server │    │             │
│             │    │   Instance N │    │             │
└─────────────┘    └──────────────┘    └─────────────┘
```

#### Microservices Evolution (Future)
```
┌─────────────┐  ┌──────────────┐  ┌─────────────┐
│   Auth      │  │ Restaurant   │  │   Order     │
│  Service    │  │   Service    │  │  Service    │
└─────────────┘  └──────────────┘  └─────────────┘
       │                │                │
       └────────────────┼────────────────┘
                        │
              ┌──────────────┐
              │   API        │
              │  Gateway     │
              └──────────────┘
```

## 📊 Performance Architecture

### 1. Database Optimization

```sql
-- Index strategies for performance
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_dish_restaurant ON dishes(restaurant_id);
CREATE INDEX idx_order_user ON orders(user_id);
CREATE INDEX idx_order_status ON orders(status);
CREATE INDEX idx_dish_category ON dishes(dishcategory_id);
```

### 2. Caching Strategy

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│   Client    │    │   API Server │    │  Database   │
└─────┬───────┘    └──────┬───────┘    └─────┬───────┘
      │                   │                  │
      │ Request data      │                  │
      ├──────────────────►│                  │
      │                   │ Check cache      │
      │                   │                  │
      │                   │ Cache miss       │
      │                   ├─────────────────►│
      │                   │                  │
      │                   │ Data response    │
      │                   │◄─────────────────┤
      │                   │                  │
      │                   │ Store in cache   │
      │ Cached response   │                  │
      │◄──────────────────┤                  │
```

### 3. File Storage Optimization

```
public/uploads/
├── dishes/
│   ├── thumbnails/       # Optimized thumbnails
│   └── original/         # Original images
└── restaurants/
    ├── thumbnails/
    └── original/
```

## 🔍 Monitoring and Logging

### 1. Application Monitoring

```javascript
// Logging configuration
const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'logs/error.log', level: 'error' }),
    new winston.transports.File({ filename: 'logs/combined.log' })
  ]
});

// Performance monitoring
const responseTime = require('response-time');
app.use(responseTime());

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});
```

### 2. Database Monitoring

```javascript
// Database connection monitoring
const { Sequelize } = require('sequelize');

sequelize.authenticate()
  .then(() => {
    logger.info('Database connection established successfully');
  })
  .catch(err => {
    logger.error('Unable to connect to database:', err);
  });

// Query logging
const sequelize = new Sequelize(config.database, config.username, config.password, {
  logging: (sql, timing) => {
    logger.info(`SQL Query: ${sql} [Execution time: ${timing}ms]`);
  }
});
```

## 🛠️ Configuration Management

### Environment-Based Configuration

```javascript
// config/config.js
const config = {
  development: {
    database: {
      dialect: 'sqlite',
      storage: './db/database.sqlite',
      logging: console.log
    },
    server: {
      port: 5000,
      host: 'localhost'
    },
    jwt: {
      secret: 'dev-secret-key',
      expiresIn: '24h'
    }
  },
  
  production: {
    database: {
      dialect: 'postgresql',
      host: process.env.DB_HOST,
      database: process.env.DB_NAME,
      username: process.env.DB_USER,
      password: process.env.DB_PASS,
      logging: false
    },
    server: {
      port: process.env.PORT || 3000,
      host: '0.0.0.0'
    },
    jwt: {
      secret: process.env.JWT_SECRET,
      expiresIn: '1h'
    }
  }
};

module.exports = config[process.env.NODE_ENV || 'development'];
```

## 🚦 API Versioning Strategy

### Current Implementation
- **Version**: v1 (implicit)
- **Strategy**: URL path versioning
- **Base URL**: `/api/`

### Future Versioning
```javascript
// Planned versioning structure
app.use('/api/v1', v1Routes);
app.use('/api/v2', v2Routes);

// Version-specific controllers
const v1Controller = require('./controllers/v1/auth.controller');
const v2Controller = require('./controllers/v2/auth.controller');
```

## 📈 Growth and Scaling Roadmap

### Phase 1: Current Architecture (MVP)
- ✅ Monolithic Express.js application
- ✅ SQLite database for development
- ✅ File-based storage
- ✅ JWT authentication

### Phase 2: Production Optimization
- 🔄 PostgreSQL/MySQL database
- 🔄 Cloud file storage (AWS S3, etc.)
- 🔄 Redis caching layer
- 🔄 PM2 process management

### Phase 3: Scale and Performance
- 🔄 Database read replicas
- 🔄 CDN integration
- 🔄 API rate limiting
- 🔄 Advanced monitoring

### Phase 4: Microservices (Future)
- 🔄 Service decomposition
- 🔄 API Gateway
- 🔄 Container orchestration
- 🔄 Event-driven architecture

This architecture guide provides a comprehensive understanding of the FoodTrip API system design, enabling better development decisions and future scaling strategies.
