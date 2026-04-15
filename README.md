![Logo](./public/sketch1656314034272.png)

# FoodTrip 😋🍕 API

A comprehensive REST API built with Express.js and Sequelize ORM for food ordering and restaurant management. This project supports multiple database systems and provides a complete backend solution for food delivery applications.

## [Origin Repo](https://github.com/polekstulod/foodtrip-api)

## About This Project

This repository serves as a learning resource for QA to improve api testing for simulate real project.

## Key Features

- 🏪 **Restaurant Management**: Complete CRUD operations for restaurants, dishes, and categories
- 👥 **User Management**: Authentication, authorization, and role-based access control
- 🛒 **Order System**: Cart management, order processing, and delivery tracking
- 📱 **Multi-database Support**: SQLite, MySQL, PostgreSQL, MariaDB, and MSSQL
- 🔧 **Database CLI Tools**: Built-in CLI for database management and seeding
- 📊 **Admin Dashboard**: Comprehensive admin controls for platform management
- 🖼️ **File Upload**: Image handling for restaurants and dishes
- 🧪 **Comprehensive Testing**: 127+ test cases covering all endpoints with automation guidance

## Developers

- [Tulod, James Paul Lim](https://github.com/polekstulod) (Project Leader)
- [De Lara, Filwayne Kean Murillo](https://github.com/drollive)
- [Del Mundo, Ashlee Jude Cruz](https://github.com/AshleeJude)
- [Fallesgon, Josiah Alether Galgo](https://github.com/Josayah32)
- [Peralta, Emmanuel Escarlan](https://github.com/emmanperalta4)
- [Ulibas, Racquel Feria](https://github.com/racquelulibas)
- [Villaruz, Micah Matorre](https://github.com/micahvllz)
- [Fredy Siswanto](https://github.com/fredysiswanto) (QA Engineer)

## Tech Stack

**Backend Framework:**
<a href="https://nodejs.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/nodejs/nodejs-plain.svg" alt="nodejs" width="40" height="40"/> </a>
<a href="https://expressjs.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/express/express-original.svg" alt="express" width="40" height="40"/> </a>

**Database & ORM:**
<a href="https://sequelize.org/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/sequelize/sequelize-plain.svg" alt="sequelize" width="40" height="40"/> </a>
<a href="https://www.mysql.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/mysql/mysql-plain.svg" alt="mysql" width="40" height="40"/> </a>

- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **Sequelize** - ORM for database operations
- **JWT** - Authentication and authorization
- **Multer** - File upload handling
- **Bcrypt** - Password hashing
- **CORS** - Cross-origin resource sharing

## 🚀 Quick Start

### Prerequisites

- Node.js (v16 or higher)
- pnpm (recommended) or npm
- Database system (MySQL, PostgreSQL, SQLite, MariaDB, or MSSQL)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/fredysiswanto/foodtrip-api
   cd foodtrip-api
   ```

2. **Install dependencies**
   ```bash
   pnpm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   ```
   Then edit `.env` file with your configuration.

4. **Set up the database**
   ```bash
   # Quick setup (recommended for development)
   pnpm run db:setup
   
   # Or manual setup
   pnpm run db:migrate
   pnpm run db:seed
   ```

5. **Start the development server**
   ```bash
   pnpm run dev
   ```

The API will be available at `http://localhost:5000` (or your configured PORT).

## 📋 Test Coverage

This project includes **127+ comprehensive test cases** covering all 85 API endpoints:

| User Role | Endpoints | Test Cases | Coverage |
|-----------|-----------|------------|----------|
| **Home/Public** | 11 | 35+ | Authentication, Registration, Public Data |
| **Customer** | 33 | 53+ | Cart, Orders, Address, Account Management |
| **Restaurant Admin** | 23 | 50+ | Dish Management, Hours, Restaurant Operations |
| **System Admin** | 18 | 34+ | User Management, System Operations |

### 🎯 Quick Test Access
- **[🔧 Setup Guide](./test-case/API_Testing_Best_Practices.md)** - Get started with API testing
- **[📊 All Endpoints](./test-case/API_Endpoints_Overview.md)** - Complete API reference
- **[🛒 Checkout Tests](./test-case/Customer/Checkout%20Order%20Creation.md)** - Critical user journey
- **[🏪 Restaurant Tests](./test-case/Admin%20Resto/Dish%20Management.md)** - Core business operations
- **[🔐 Authentication Tests](./test-case/Home/Customer%20Login.md)** - Security & access control

## 📖 Documentation

### Getting Started
- **[Quick Start Guide](./docs/QUICK_START.md)** - Get running in 5 minutes
- **[User Guide](./docs/USER_GUIDE.md)** - Comprehensive setup and usage guide
- **[Contributing Guide](./CONTRIBUTING.md)** - How to contribute to the project

### Technical Documentation
- **[API Documentation](./docs/API_DOCUMENTATION.md)** - Complete API reference
- **[Database Management](./docs/DATABASE_MANAGEMENT.md)** - Database setup and management
- **[Project Structure](./docs/PROJECT_STRUCTURE.md)** - Codebase organization guide
- **[Seeder System Guide](./docs/SEEDER_SYSTEM_GUIDE.md)** - Data seeding documentation

### Testing & Quality Assurance
- **[Test Cases Directory](./test-case/)** - Comprehensive API test documentation
- **[API Testing Best Practices](./test-case/API_Testing_Best_Practices.md)** - Testing guidelines and standards
- **[Test Data Generator](./test-case/Test_Data_Generator.md)** - Setup scripts for test data
- **[Postman Collection](./FoodTrip.postman_collection.json)** - Import for API testing

### Additional Resources
- **[Changelog](./CHANGELOG.md)** - Version history and changes

## 🛠️ Available Scripts

### Development
- `pnpm run dev` - Start development server with hot reload
- `pnpm run lint` - Run ESLint
- `pnpm run lint:fix` - Fix ESLint issues automatically
- `pnpm run format` - Format code with Prettier

### Database Management
- `pnpm run db:setup` - Complete database setup (migrate + seed)
- `pnpm run db:migrate` - Run database migrations
- `pnpm run db:seed` - Seed database with sample data
- `pnpm run db:status` - Check database status
- `pnpm run db:cli` - Interactive database CLI

### Testing
- `pnpm test` - Run tests (to be implemented)
- `pnpm run test:api` - Run API test suite (manual testing guide available)
- `pnpm run test:coverage` - Generate test coverage report (to be implemented)

## 🗃️ Database Support

This API supports multiple database systems:

- **SQLite** (default) - Perfect for development
- **MySQL** - Production ready
- **PostgreSQL** - Advanced features
- **MariaDB** - MySQL alternative
- **Microsoft SQL Server** - Enterprise solution

Configure your preferred database in the `.env` file using the `USE_DB` variable.

## ⚙️ Configuration

### Environment Variables

Create a `.env` file in the root directory with the following variables:

```env
# Server Configuration
PORT=5000
API_VERSION=/api/v1
TOKEN_SECRET=your-super-secret-jwt-token-here
ALLOW_SYNC=true
AUTO_SETUP_DB=true
NODE_ENV=development
SALT_ROUND=10

# Database Configuration
USE_DB=sqlite

# For SQLite (default)
DB_STORAGE=./db/database.sqlite

# For MySQL/PostgreSQL/MariaDB
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASS=your-password
DB_NAME=foodtrip

# Optional Database Settings
DB_POOL_MAX=5
DB_POOL_MIN=0
DB_POOL_ACQUIRE=30000
DB_POOL_IDLE=10000
DB_LOGGING=false
```

### Configuration Options

| Variable | Description | Default | Options |
|----------|-------------|---------|---------|
| `USE_DB` | Database type | `sqlite` | `sqlite`, `mysql`, `postgresql`, `mariadb`, `mssql` |
| `AUTO_SETUP_DB` | Auto setup database on start | `true` | `true`, `false` |
| `ALLOW_SYNC` | Allow Sequelize sync | `true` | `true`, `false` |
| `NODE_ENV` | Environment mode | `development` | `development`, `production`, `test` |

## 🔗 API Endpoints

### Authentication
- `POST /api/v1/auth/login` - User login
- `POST /api/v1/auth/register` - User registration

### Restaurants
- `GET /api/v1/restaurants` - Get all restaurants
- `GET /api/v1/restaurants/:id` - Get restaurant by ID
- `POST /api/v1/restaurants` - Create restaurant (Admin)
- `PUT /api/v1/restaurants/:id` - Update restaurant (Admin)
- `DELETE /api/v1/restaurants/:id` - Delete restaurant (Admin)

### Dishes
- `GET /api/v1/dishes` - Get all dishes
- `GET /api/v1/dishes/:id` - Get dish by ID
- `POST /api/v1/dishes` - Create dish (Restaurant Admin)
- `PUT /api/v1/dishes/:id` - Update dish (Restaurant Admin)
- `DELETE /api/v1/dishes/:id` - Delete dish (Restaurant Admin)

### Orders
- `GET /api/v1/orders` - Get user orders
- `POST /api/v1/orders` - Create new order
- `GET /api/v1/orders/:id` - Get order details
- `PUT /api/v1/orders/:id/status` - Update order status

For complete API documentation, see [API_DOCUMENTATION.md](./docs/API_DOCUMENTATION.md).

## 🧪 Testing

This project includes comprehensive test documentation covering all API endpoints with professional test cases, security testing, and automation guidance.

### Test Case Documentation

The `test-case/` directory contains detailed test documentation organized by user role:

#### **Home/Public API Tests** (11 endpoints)
- **[Customer Login](./test-case/Home/Customer%20Login.md)** - 15 test cases covering authentication scenarios
- **[Customer Registration](./test-case/Home/Customer%20Registration.md)** - 20 test cases for user registration
- **[Find All Dish Category](./test-case/Home/Find%20All%20Dish%20Category.md)** - Existing test case
- **[Find All Dish](./test-case/Home/Find%20All%20Dish.md)** - Existing test case

#### **Customer API Tests** (33 endpoints)
- **[Address Management](./test-case/Customer/Address%20Management.md)** - 28 test cases for CRUD operations
- **[Checkout Order Creation](./test-case/Customer/Checkout%20Order%20Creation.md)** - 25 test cases for order processing

#### **Restaurant Admin API Tests** (23 endpoints)
- **[Dish Management](./test-case/Admin%20Resto/Dish%20Management.md)** - 30 test cases for dish CRUD operations
- **[Create Opening Hour](./test-case/Admin%20Resto/Create%20Opening%20Hour.md)** - 20 test cases for hours management
- **[Update Opening Hour](./test-case/Admin%20Resto/Update%20Opening%20Hour.md)** - Existing test case
- **[Delete Opening Hour](./test-case/Admin%20Resto/Delete%20Opening%20Hour.md)** - Existing test case

#### **System Admin API Tests** (18 endpoints)
- **[User Management](./test-case/Admin/User%20Management.md)** - 34 test cases for admin operations

#### **Testing Resources**
- **[API Testing Best Practices](./test-case/API_Testing_Best_Practices.md)** - Comprehensive testing guidelines
- **[Test Data Generator](./test-case/Test_Data_Generator.md)** - Scripts for generating test data
- **[API Endpoints Overview](./test-case/API_Endpoints_Overview.md)** - Complete endpoint documentation
- **[Test Cases Summary](./test-case/Test_Cases_Summary.md)** - Overview of all test cases

### Using Postman

Import the provided Postman collection:
1. Open Postman
2. Click Import
3. Select `FoodTrip.postman_collection.json`
4. Configure environment variables (base_url, tokens)

### Manual Testing

Use the test files in the `test-case/` directory for manual API testing examples. Each test case includes:
- **Request/Response examples** with realistic data
- **Authentication setup** with Bearer tokens
- **Validation scenarios** covering edge cases
- **Security testing** for common vulnerabilities
- **Performance benchmarks** and expectations
- **Automation guidance** for CI/CD integration

### HTTP Files

Use the `request/test.http` file with VS Code REST Client extension for quick API testing.

## 🚀 Deployment

This project includes comprehensive deployment infrastructure and automated scripts for production deployment.

### 📦 Deployment Files Created

All deployment files are included and ready to use:

- **Dockerfile** - Optimized multi-stage Node.js container
- **docker-compose.yml** - Complete MySQL + API stack
- **.env.production** - Production environment configuration template
- **DEPLOYMENT.md** - Comprehensive deployment guide (450+ lines)
- **PRODUCTION_CHECKLIST.md** - Pre-deployment verification checklist
- **scripts/deploy.sh** - Automated deployment script
- **scripts/healthcheck.sh** - Health monitoring script
- **.github/workflows/ci-cd.yml** - GitHub Actions CI/CD pipeline

### Quick Start Deployment

```bash
# Option 1: Docker Compose (Recommended)
cp .env.production .env
nano .env  # Update with your settings
chmod +x scripts/deploy.sh
./scripts/deploy.sh deploy

# Option 2: Docker Only
docker build -t foodtrip-api:latest .
docker run -p 3000:3000 foodtrip-api:latest

# Option 3: Manual Deployment
pnpm install
pnpm run db:setup
npm start
```

### Automated Deployment Scripts

```bash
# Make scripts executable
chmod +x scripts/deploy.sh scripts/healthcheck.sh

# Deploy the application
./scripts/deploy.sh deploy

# Check application health
./scripts/healthcheck.sh check

# Monitor continuously
./scripts/healthcheck.sh monitor

# View logs
./scripts/deploy.sh logs

# Manage services
./scripts/deploy.sh stop
./scripts/deploy.sh restart
./scripts/deploy.sh status
```

### For Complete Deployment Information

👉 **Read [DEPLOYMENT.md](./docs/DEPLOYMENT.md)** for:
- Detailed step-by-step instructions
- Platform-specific deployment (AWS, Heroku, Google Cloud, DigitalOcean)
- Environment configuration guide
- Troubleshooting and optimization
- Monitoring and maintenance

👉 **Read [PRODUCTION_CHECKLIST.md](./docs/PRODUCTION_CHECKLIST.md)** for:
- Pre-deployment security review
- Performance optimization checklist
- Database backup strategy
- Infrastructure configuration verification
- Post-deployment testing procedures

👉 **Read [DEPLOYMENT_SUMMARY.md](./docs/DEPLOYMENT_SUMMARY.md)** for:
- Quick overview of all deployment files
- File structure and organization
- Quick reference guide

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines

- Follow the existing code style
- Run `pnpm run lint:fix` before committing
- Add tests for new features
- Update documentation as needed

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you have any questions or need help:

1. Check the [documentation](./docs/)
2. Look through existing [issues](https://github.com/fredysiswanto/foodtrip-api/issues)
3. Create a new issue if needed

## 🙏 Acknowledgments

- Original project by [James Paul L. Tulod](https://github.com/polekstulod)
- All contributors who helped build this project
- The open-source community for the amazing tools and libraries
