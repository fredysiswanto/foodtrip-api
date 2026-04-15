# 🚀 Deployment Guide - FoodTrip API

This guide covers deployment options for the FoodTrip API to various platforms.

## Table of Contents

- [Quick Start](#quick-start)
- [System Requirements](#system-requirements)
- [Docker Deployment](#docker-deployment)
- [Manual Deployment](#manual-deployment)
- [Environment Configuration](#environment-configuration)
- [Database Setup](#database-setup)
- [Production Considerations](#production-considerations)
- [Troubleshooting](#troubleshooting)

---

## Quick Start

### Using Docker Compose (Recommended)

```bash
# Clone the repository
git clone https://github.com/fredysiswanto/foodtrip-api
cd foodtrip-api

# Copy environment file
cp .env.production .env

# Update environment variables (especially TOKEN_SECRET and database credentials)
nano .env

# Start the application with MySQL
docker-compose up -d

# Check logs
docker-compose logs -f api

# Stop the application
docker-compose down
```

---

## System Requirements

### Minimum Requirements

- **Node.js**: v20+ (v22 recommended)
- **npm/pnpm**: v8+
- **MySQL**: v8.0+
- **RAM**: 1 GB minimum (2 GB+ recommended)
- **Disk Space**: 2 GB minimum

### For Docker Deployment

- **Docker**: v20.10+
- **Docker Compose**: v1.29+

---

## Docker Deployment

### Build and Run with Docker

#### Option 1: Using Docker Compose (Complete Stack)

```bash
# Build images
docker-compose build

# Start services (MySQL + API)
docker-compose up -d

# View logs
docker-compose logs -f api

# Scale the API service (for load balancing)
docker-compose up -d --scale api=3
```

#### Option 2: Using Docker CLI

```bash
# Build the image
docker build -t foodtrip-api:latest .

# Run with external MySQL
docker run -d \
  --name foodtrip-api \
  -p 3000:3000 \
  -e DB_HOST=your-mysql-host \
  -e DB_USER=foodtrip \
  -e DB_PASS=your-password \
  -e TOKEN_SECRET=your-secret-key \
  -v $(pwd)/public/uploads:/app/public/uploads \
  foodtrip-api:latest
```

### Environment Variables for Docker

```yaml
Environment:
  NODE_ENV: production
  PORT: 3000
  DB_HOST: mysql
  DB_PORT: 3306
  DB_USER: foodtrip
  DB_PASS: yourpassword
  DB_NAME: foodtrip
  TOKEN_SECRET: your-super-secret-key
  AUTO_SETUP_DB: "true"
  ALLOW_SYNC: "false"
```

### Health Check

The Docker image includes a built-in health check:

```bash
# Check service health
docker-compose ps

# Manually test endpoint
curl http://localhost:3000/api/v1/home/restaurants
```

---

## Manual Deployment

### Prerequisites Installation

#### Linux/macOS

```bash
# Update package manager
sudo apt-get update  # Ubuntu/Debian
brew update          # macOS

# Install Node.js (using NVM recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 22
nvm use 22

# Install MySQL
sudo apt-get install mysql-server  # Ubuntu/Debian
brew install mysql                 # macOS

# Install pnpm
npm install -g pnpm
```

#### Windows PowerShell

```powershell
# Install Node.js via Chocolatey
choco install nodejs

# Install MySQL
choco install mysql

# Install pnpm
npm install -g pnpm
```

### Application Setup

```bash
# 1. Clone repository
git clone https://github.com/polekstulod/foodtrip-api.git
cd foodtrip-api

# 2. Install dependencies
pnpm install

# 3. Setup environment
cp .env.production .env

# 4. Update environment variables
nano .env  # Edit with your values

# 5. Create required directories
mkdir -p public/uploads/{dishes,restaurants}

# 6. Setup database
pnpm run db:setup

# 7. Start the application
npm start
```

### Verify Installation

```bash
# Test API health
curl http://localhost:3000/api/v1/home/restaurants

# Expected response:
# {"error": false, "data": [...], "message": "..."}
```

---

## Environment Configuration

### Production Environment Variables

Create a `.env` file in the root directory:

```env
# Server Configuration
PORT=3000
API_VERSION=/api/v1
TOKEN_SECRET=your-strong-secret-key-minimum-32-chars
NODE_ENV=production
ALLOW_SYNC=false
AUTO_SETUP_DB=true
SALT_ROUND=10

# Database Configuration
USE_DB=mysql
DB_HOST=localhost
DB_PORT=3306
DB_USER=foodtrip
DB_PASS=your-database-password
DB_NAME=foodtrip

# Database Pool (Production optimized)
DB_POOL_MAX=20
DB_POOL_MIN=5
DB_POOL_ACQUIRE=30000
DB_POOL_IDLE=10000

# Logging
DB_LOGGING=false
```

### Security Notes

1. **TOKEN_SECRET**: Generate a strong random string
   ```bash
   # Generate using OpenSSL
   openssl rand -hex 32
   ```

2. **Database Password**: Use a strong password
   ```bash
   # Generate strong password
   openssl rand -base64 32
   ```

3. **Never commit .env files to version control**
   - Use `.env` for local, `.env.production` for reference
   - Add `.env*local` to `.gitignore`

---

## Database Setup

### Option 1: Automatic Setup

The application can auto-setup the database:

```bash
# Set in .env
AUTO_SETUP_DB=true

# Start the application
npm start
# Database migrations and seeds run automatically
```

### Option 2: Manual Setup

```bash
# Create database
pnpm run db:create

# Run migrations
pnpm run db:migrate

# Seed data
pnpm run db:seed

# Check status
pnpm run db:status
```

### Troubleshooting Database

```bash
# Reset migrations (development only!)
pnpm run db:migrate:undo:all

# Undo specific migration
pnpm run db:migrate:undo

# View database CLI options
pnpm run db:cli

# Check database status
pnpm run db:status
```

---

## Production Considerations

### 1. Security

- [ ] Change default database password
- [ ] Generate strong TOKEN_SECRET
- [ ] Use HTTPS only (nginx/Apache reverse proxy)
- [ ] Enable CORS with specific domains
- [ ] Set secure HTTP headers
- [ ] Use environment variables for secrets
- [ ] Regular security audits

### 2. Performance

- [ ] Enable database connection pooling
- [ ] Use reverse proxy (nginx/Apache)
- [ ] Implement caching (Redis)
- [ ] Enable gzip compression
- [ ] Optimize database queries
- [ ] Monitor resource usage

### 3. Logging & Monitoring

- [ ] Setup centralized logging (ELK, Datadog)
- [ ] Monitor API response times
- [ ] Track error rates
- [ ] Monitor database performance
- [ ] Setup alerts for critical issues

### 4. Backup & Recovery

- [ ] Daily database backups
- [ ] Test restoration procedures
- [ ] Document recovery procedures
- [ ] Version control infrastructure code

### 5. Scaling

```bash
# Docker Compose: Scale API services
docker-compose up -d --scale api=3

# Configure load balancer (nginx)
# See deployment platform-specific docs
```

---

## Platform-Specific Deployments

### AWS EC2

1. Launch EC2 instance (Ubuntu 22.04 LTS)
2. Install Docker and Docker Compose
3. Clone repository
4. Configure security groups
5. Start with docker-compose

### Heroku

```bash
# Create Heroku app
heroku create foodtrip-api

# Set environment variables
heroku config:set TOKEN_SECRET=your-secret-key
heroku config:set DB_HOST=your-db-host

# Deploy
git push heroku main
```

### DigitalOcean App Platform

1. Connect GitHub repository
2. Create database cluster
3. Set environment variables
4. Deploy from `Dockerfile`

### Google Cloud Run

```bash
# Build and push image
docker build -t gcr.io/YOUR-PROJECT/foodtrip-api .
docker push gcr.io/YOUR-PROJECT/foodtrip-api

# Deploy
gcloud run deploy foodtrip-api \
  --image gcr.io/YOUR-PROJECT/foodtrip-api \
  --platform managed
```

---

## Troubleshooting

### Common Issues

#### 1. Port Already in Use

```bash
# Find process using port 3000
lsof -i :3000

# Kill the process
kill -9 <PID>
```

#### 2. Database Connection Error

```bash
# Check MySQL is running
systemctl status mysql  # Linux
brew services list      # macOS

# Test connection
mysql -h localhost -u foodtrip -p foodtrip
```

#### 3. Files/Permissions Error

```bash
# Create upload directories
mkdir -p public/uploads/{dishes,restaurants}

# Set permissions (Docker)
chmod -R 755 public/uploads
```

#### 4. Out of Memory

```bash
# Increase available memory (Docker)
docker-compose down
docker-compose up -d

# Check Docker memory allocation
docker stats
```

### Debug Mode

```bash
# Enable debug logging
export DEBUG=*
npm start

# Or with NODE_ENV
NODE_ENV=development npm start
```

### Health Check

```bash
# Manual health check
curl -v http://localhost:3000/api/v1/home/restaurants

# Docker health check
docker-compose ps api

# Check logs
docker-compose logs api
```

---

## Performance Optimization

### Database Query Optimization

```javascript
// Use database indexes
// Already configured in migrations
// Monitor slow queries
pnpm run db:status
```

### Caching Strategy

- Implement Redis cache for frequently accessed data
- Cache dish categories and restaurant listings
- Set appropriate TTL values

### Load Testing

```bash
# Install locust (Python-based)
pip install locust

# Create loadtest_user.py
# Run: locust -f loadtest_user.py
```

---

## Monitoring & Alerts

### Key Metrics to Monitor

- API response time (p50, p95, p99)
- Error rate
- Database connection pool usage
- Server resource usage (CPU, RAM, Disk)
- Disk space for uploads

### Common Monitoring Tools

- **Application**: DataDog, New Relic, Sentry
- **Infrastructure**: Prometheus, Grafana
- **Logs**: ELK Stack, Splunk, CloudWatch

---

## Support & Documentation

For more information:
- [Express.js Documentation](https://expressjs.com/)
- [Sequelize ORM](https://sequelize.org/)
- [Docker Documentation](https://docs.docker.com/)
- [MySQL Documentation](https://dev.mysql.com/doc/)

For issues and questions:
- GitHub Issues: [FoodTrip API Issues](https://github.com/fredysiswanto/foodtrip-api/issues)
- Email: tester.fredy@gmail.com

---

Last Updated: April 2026
