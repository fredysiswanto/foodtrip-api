# Deployment Guide

This comprehensive guide covers production deployment strategies, configurations, and best practices for the FoodTrip API.

## 🎯 Overview

The FoodTrip API supports multiple deployment strategies:
- **Single Server Deployment**: Traditional server setup
- **Containerized Deployment**: Docker-based deployment
- **Cloud Platform Deployment**: PaaS solutions (Heroku, Railway, etc.)
- **Serverless Deployment**: Function-as-a-Service platforms

## 🏗️ Production Architecture

### Recommended Production Stack

```
┌─────────────────────────────────────────────────────┐
│                 Production Setup                    │
├─────────────────────────────────────────────────────┤
│ ┌─────────────┐  ┌──────────────┐  ┌─────────────┐ │
│ │   Nginx     │  │   Node.js    │  │ PostgreSQL  │ │
│ │(Reverse     │  │   + PM2      │  │  Database   │ │
│ │ Proxy)      │  │   App Server │  │             │ │
│ └─────────────┘  └──────────────┘  └─────────────┘ │
└─────────────────────────────────────────────────────┘
```

### Security Layers

```
┌─────────────────────────────────────────────────────┐
│                 Security Stack                      │
├─────────────────────────────────────────────────────┤
│ 1. SSL/TLS Certificate (Let's Encrypt)              │
│ 2. Firewall (UFW/iptables)                         │
│ 3. Rate Limiting (Nginx + Express)                 │
│ 4. Environment Variables Protection                 │
│ 5. Database Connection Security                     │
│ 6. CORS Configuration                               │
│ 7. Security Headers                                 │
└─────────────────────────────────────────────────────┘
```

## 🐧 Single Server Deployment

### Prerequisites

#### Server Requirements
- **OS**: Ubuntu 20.04 LTS or newer
- **RAM**: 2GB minimum, 4GB recommended
- **Storage**: 20GB minimum, 50GB recommended
- **CPU**: 2 cores minimum
- **Network**: Public IP address

#### Domain Setup
- Domain name pointed to server IP
- DNS A record configured
- SSL certificate (Let's Encrypt recommended)

### Step 1: Server Preparation

#### Update System
```bash
# Update package list and upgrade system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y curl wget git unzip software-properties-common
```

#### Create Application User
```bash
# Create dedicated user for application
sudo adduser foodtrip --disabled-password --gecos ""

# Add user to sudo group (if needed for maintenance)
sudo usermod -aG sudo foodtrip

# Switch to application user
sudo su - foodtrip
```

### Step 2: Install Dependencies

#### Install Node.js
```bash
# Install Node.js 18 LTS
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Verify installation
node --version  # Should show v18.x.x
npm --version   # Should show compatible npm version

# Install pnpm globally
sudo npm install -g pnpm pm2
```

#### Install PostgreSQL
```bash
# Install PostgreSQL
sudo apt install -y postgresql postgresql-contrib

# Start and enable PostgreSQL
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Create database and user
sudo -u postgres psql

-- In PostgreSQL prompt:
CREATE DATABASE foodtrip_production;
CREATE USER foodtrip_user WITH PASSWORD 'secure_password_here';
GRANT ALL PRIVILEGES ON DATABASE foodtrip_production TO foodtrip_user;
\q
```

#### Install Nginx
```bash
# Install Nginx
sudo apt install -y nginx

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Check status
sudo systemctl status nginx
```

### Step 3: Application Deployment

#### Clone and Setup Application
```bash
# Clone repository
cd /home/foodtrip
git clone https://github.com/fredysiswanto/foodtrip-api.git
cd foodtrip-api

# Install dependencies
pnpm install --production

# Create production environment file
cp .env.example .env.production
```

#### Configure Environment Variables
```bash
# Edit production environment
nano .env.production
```

**Production Environment Configuration:**
```env
# Server Configuration
NODE_ENV=production
PORT=3000
HOST=0.0.0.0

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=foodtrip_production
DB_USER=foodtrip_user
DB_PASS=secure_password_here
DB_DIALECT=postgres

# Security Configuration
JWT_SECRET=your_very_secure_jwt_secret_here_at_least_32_characters
BCRYPT_ROUNDS=12

# File Upload Configuration
UPLOAD_DIR=/home/foodtrip/foodtrip-api/public/uploads
MAX_FILE_SIZE=5242880

# CORS Configuration
CORS_ORIGIN=https://yourdomain.com,https://www.yourdomain.com

# Logging Configuration
LOG_LEVEL=info
LOG_FILE=/home/foodtrip/logs/app.log

# Rate Limiting
RATE_LIMIT_WINDOW=15
RATE_LIMIT_MAX=100
```

#### Setup Database
```bash
# Run database migrations
pnpm run db:migrate

# Seed production data (optional)
pnpm run db:seed
```

#### Configure PM2
```bash
# Create PM2 ecosystem file
nano ecosystem.config.js
```

**PM2 Configuration (`ecosystem.config.js`):**
```javascript
module.exports = {
  apps: [{
    name: 'foodtrip-api',
    script: 'app.js',
    instances: 'max',
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    // Logging
    log_file: '/home/foodtrip/logs/combined.log',
    out_file: '/home/foodtrip/logs/out.log',
    error_file: '/home/foodtrip/logs/error.log',
    log_date_format: 'YYYY-MM-DD HH:mm Z',
    
    // Process management
    max_memory_restart: '1G',
    restart_delay: 4000,
    max_restarts: 10,
    min_uptime: '10s',
    
    // Monitoring
    watch: false,
    ignore_watch: ['node_modules', 'logs', 'public/uploads'],
    
    // Environment
    env_file: '.env.production'
  }]
};
```

#### Create Log Directory
```bash
# Create logs directory
mkdir -p /home/foodtrip/logs

# Set permissions
chmod 755 /home/foodtrip/logs
```

#### Start Application with PM2
```bash
# Start application
pm2 start ecosystem.config.js --env production

# Save PM2 configuration
pm2 save

# Setup PM2 startup script
pm2 startup

# Follow the instructions provided by PM2 startup command
```

### Step 4: Nginx Configuration

#### Create Nginx Configuration
```bash
# Create site configuration
sudo nano /etc/nginx/sites-available/foodtrip-api
```

**Nginx Configuration:**
```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;
    
    # Redirect HTTP to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;
    
    # SSL Configuration
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    
    # Security Headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;
    
    # Rate Limiting
    limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
    limit_req zone=api burst=20 nodelay;
    
    # Gzip Compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types
        text/plain
        text/css
        text/xml
        text/javascript
        application/json
        application/javascript
        application/xml+rss
        application/atom+xml
        image/svg+xml;
    
    # Main application
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
        
        # Timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
    
    # Static file serving
    location /uploads/ {
        alias /home/foodtrip/foodtrip-api/public/uploads/;
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
    
    # API documentation (optional)
    location /docs {
        alias /home/foodtrip/foodtrip-api/docs/;
        index index.html;
    }
    
    # Health check endpoint (bypass rate limiting)
    location /health {
        proxy_pass http://localhost:3000/health;
        access_log off;
    }
}
```

#### Enable Site and Restart Nginx
```bash
# Enable site
sudo ln -s /etc/nginx/sites-available/foodtrip-api /etc/nginx/sites-enabled/

# Test configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx
```

### Step 5: SSL Certificate Setup

#### Install Certbot
```bash
# Install Certbot
sudo apt install -y certbot python3-certbot-nginx

# Obtain SSL certificate
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com

# Test auto-renewal
sudo certbot renew --dry-run
```

### Step 6: Firewall Configuration

#### Setup UFW Firewall
```bash
# Enable UFW
sudo ufw enable

# Allow SSH (important!)
sudo ufw allow ssh

# Allow HTTP and HTTPS
sudo ufw allow 'Nginx Full'

# Check status
sudo ufw status
```

### Step 7: Monitoring and Logging

#### Setup Log Rotation
```bash
# Create logrotate configuration
sudo nano /etc/logrotate.d/foodtrip-api
```

**Logrotate Configuration:**
```
/home/foodtrip/logs/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 644 foodtrip foodtrip
    postrotate
        pm2 reload foodtrip-api
    endscript
}
```

#### Setup Health Monitoring
```bash
# Create health check script
nano /home/foodtrip/health-check.sh
```

**Health Check Script:**
```bash
#!/bin/bash

# Check if API is responding
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/health)

if [ $response != "200" ]; then
    echo "API health check failed with status: $response"
    # Restart PM2 application
    pm2 restart foodtrip-api
    
    # Send notification (optional)
    # curl -X POST "your-slack-webhook-url" -d '{"text":"FoodTrip API health check failed"}'
fi
```

```bash
# Make script executable
chmod +x /home/foodtrip/health-check.sh

# Add to crontab
crontab -e

# Add this line to run every 5 minutes
*/5 * * * * /home/foodtrip/health-check.sh
```

## 🐳 Docker Deployment

### Docker Setup

#### Dockerfile
```dockerfile
# Multi-stage build for production
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./
COPY pnpm-lock.yaml ./

# Install pnpm and dependencies
RUN npm install -g pnpm
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Production stage
FROM node:18-alpine AS production

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm pm2

# Copy package files
COPY package*.json ./
COPY pnpm-lock.yaml ./

# Install production dependencies only
RUN pnpm install --frozen-lockfile --production

# Copy application code
COPY --from=builder /app .

# Create uploads directory
RUN mkdir -p public/uploads

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S foodtrip -u 1001

# Set ownership
RUN chown -R foodtrip:nodejs /app
USER foodtrip

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start application
CMD ["pm2-runtime", "start", "ecosystem.config.js", "--env", "production"]
```

#### Docker Compose
```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      target: production
    container_name: foodtrip-api
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DB_HOST=postgres
      - DB_PORT=5432
      - DB_NAME=foodtrip_production
      - DB_USER=foodtrip_user
      - DB_PASS=secure_password_here
      - JWT_SECRET=your_jwt_secret_here
    volumes:
      - uploads:/app/public/uploads
      - logs:/app/logs
    depends_on:
      postgres:
        condition: service_healthy
    networks:
      - foodtrip-network

  postgres:
    image: postgres:15-alpine
    container_name: foodtrip-postgres
    restart: unless-stopped
    environment:
      - POSTGRES_DB=foodtrip_production
      - POSTGRES_USER=foodtrip_user
      - POSTGRES_PASSWORD=secure_password_here
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U foodtrip_user -d foodtrip_production"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - foodtrip-network

  nginx:
    image: nginx:alpine
    container_name: foodtrip-nginx
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/ssl/certs:ro
      - uploads:/var/www/uploads:ro
    depends_on:
      - app
    networks:
      - foodtrip-network

volumes:
  postgres_data:
  uploads:
  logs:

networks:
  foodtrip-network:
    driver: bridge
```

#### Deploy with Docker
```bash
# Build and start services
docker-compose up -d

# View logs
docker-compose logs -f app

# Run database migrations
docker-compose exec app pnpm run db:migrate

# Check service status
docker-compose ps

# Scale application (if needed)
docker-compose up -d --scale app=3
```

## ☁️ Cloud Platform Deployment

### Heroku Deployment

#### Prerequisites
- Heroku CLI installed
- Git repository setup

#### Heroku Configuration
```bash
# Login to Heroku
heroku login

# Create Heroku app
heroku create foodtrip-api-production

# Add PostgreSQL addon
heroku addons:create heroku-postgresql:mini

# Set environment variables
heroku config:set NODE_ENV=production
heroku config:set JWT_SECRET=your_jwt_secret_here
heroku config:set BCRYPT_ROUNDS=12

# Configure buildpacks
heroku buildpacks:add heroku/nodejs
```

#### Procfile
```
web: npm start
worker: pm2-runtime start ecosystem.config.js --env production
release: npx sequelize-cli db:migrate
```

#### Deploy to Heroku
```bash
# Add Heroku remote
heroku git:remote -a foodtrip-api-production

# Deploy
git push heroku main

# Run database setup
heroku run npm run db:migrate
heroku run npm run db:seed

# Check logs
heroku logs --tail
```

### Railway Deployment

#### railway.json
```json
{
  "deploy": {
    "startCommand": "npm start",
    "healthcheckPath": "/health",
    "healthcheckTimeout": 300
  }
}
```

#### Environment Variables
```bash
# Set via Railway dashboard or CLI
railway variables set NODE_ENV=production
railway variables set JWT_SECRET=your_jwt_secret_here
railway variables set DATABASE_URL=postgresql://user:pass@host:port/db
```

### DigitalOcean App Platform

#### app.yaml
```yaml
name: foodtrip-api
services:
- name: api
  source_dir: /
  github:
    repo: fredysiswanto/foodtrip-api
    branch: main
  run_command: npm start
  environment_slug: node-js
  instance_count: 1
  instance_size_slug: basic-xxs
  health_check:
    http_path: /health
  envs:
  - key: NODE_ENV
    value: production
  - key: JWT_SECRET
    value: your_jwt_secret_here
    type: SECRET

databases:
- name: foodtrip-db
  engine: PG
  version: "13"
  size: db-s-dev-database
```

## 📊 Production Monitoring

### Application Monitoring

#### PM2 Monitoring
```bash
# Monitor applications
pm2 monit

# Check status
pm2 status

# View logs
pm2 logs

# Restart application
pm2 restart foodtrip-api

# Reload application (zero downtime)
pm2 reload foodtrip-api
```

#### Custom Monitoring Script
```javascript
// monitoring.js
const express = require('express');
const app = express();

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    memory: process.memoryUsage(),
    version: process.env.npm_package_version
  });
});

// Metrics endpoint
app.get('/metrics', (req, res) => {
  res.json({
    cpu: process.cpuUsage(),
    memory: process.memoryUsage(),
    uptime: process.uptime(),
    version: process.version,
    platform: process.platform
  });
});

module.exports = app;
```

### Database Monitoring

#### PostgreSQL Monitoring
```sql
-- Check database connections
SELECT * FROM pg_stat_activity WHERE datname = 'foodtrip_production';

-- Check database size
SELECT pg_size_pretty(pg_database_size('foodtrip_production'));

-- Check table sizes
SELECT 
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
FROM pg_tables 
WHERE schemaname = 'public' 
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Check slow queries (if logging enabled)
SELECT query, mean_time, calls, total_time 
FROM pg_stat_statements 
ORDER BY mean_time DESC 
LIMIT 10;
```

### Log Monitoring

#### Centralized Logging Setup
```bash
# Install log aggregation tools
sudo apt install -y rsyslog

# Configure application logs
sudo nano /etc/rsyslog.d/49-foodtrip.conf
```

**Rsyslog Configuration:**
```
# FoodTrip API logs
$InputFileName /home/foodtrip/logs/app.log
$InputFileTag foodtrip-api:
$InputFileStateFile stat-foodtrip-api
$InputFileSeverity info
$InputFileFacility local0
$InputRunFileMonitor

# Send to remote log server (optional)
local0.* @@log-server.yourdomain.com:514
```

## 🔒 Security Hardening

### Server Security

#### Security Updates
```bash
# Enable automatic security updates
sudo dpkg-reconfigure -plow unattended-upgrades

# Configure automatic updates
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

#### SSH Hardening
```bash
# Edit SSH configuration
sudo nano /etc/ssh/sshd_config

# Recommended settings:
# Port 2222 (change from default 22)
# PasswordAuthentication no
# PubkeyAuthentication yes
# PermitRootLogin no
# AllowUsers foodtrip

# Restart SSH
sudo systemctl restart ssh
```

#### Fail2Ban Setup
```bash
# Install Fail2Ban
sudo apt install -y fail2ban

# Create local configuration
sudo nano /etc/fail2ban/jail.local
```

**Fail2Ban Configuration:**
```ini
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5

[sshd]
enabled = true

[nginx-http-auth]
enabled = true

[nginx-limit-req]
enabled = true
filter = nginx-limit-req
action = iptables-multiport[name=ReqLimit, port="http,https", protocol=tcp]
logpath = /var/log/nginx/error.log
findtime = 600
bantime = 7200
maxretry = 10
```

### Application Security

#### Environment Variables Protection
```bash
# Set proper file permissions
chmod 600 .env.production

# Use external secret management (recommended for production)
# Examples: AWS Secrets Manager, HashiCorp Vault, etc.
```

#### Database Security
```sql
-- Create read-only user for monitoring
CREATE USER monitoring_user WITH PASSWORD 'monitoring_password';
GRANT CONNECT ON DATABASE foodtrip_production TO monitoring_user;
GRANT USAGE ON SCHEMA public TO monitoring_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO monitoring_user;

-- Revoke unnecessary permissions
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO foodtrip_user;
```

## 🚀 Performance Optimization

### Application Performance

#### PM2 Cluster Mode
```javascript
// ecosystem.config.js - optimized for production
module.exports = {
  apps: [{
    name: 'foodtrip-api',
    script: 'app.js',
    instances: 'max', // Use all CPU cores
    exec_mode: 'cluster',
    max_memory_restart: '1G',
    node_args: '--max_old_space_size=1024',
    env_production: {
      NODE_ENV: 'production',
      PORT: 3000,
      UV_THREADPOOL_SIZE: 16 // Increase thread pool
    }
  }]
};
```

#### Database Optimization
```sql
-- Create indexes for better performance
CREATE INDEX CONCURRENTLY idx_users_email ON users(email);
CREATE INDEX CONCURRENTLY idx_restaurants_user ON restaurants(user_id);
CREATE INDEX CONCURRENTLY idx_dishes_restaurant ON dishes(restaurant_id);
CREATE INDEX CONCURRENTLY idx_orders_user ON orders(user_id);
CREATE INDEX CONCURRENTLY idx_orders_status ON orders(status);

-- Analyze table statistics
ANALYZE;

-- Check query performance
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM dishes WHERE restaurant_id = 1;
```

### Nginx Optimization

#### Advanced Nginx Configuration
```nginx
# Add to main nginx.conf
worker_processes auto;
worker_connections 1024;

# Enable caching
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=api_cache:10m max_size=1g inactive=60m use_temp_path=off;

server {
    # ... existing configuration ...
    
    # Enable caching for API responses
    location /api/ {
        proxy_cache api_cache;
        proxy_cache_valid 200 5m;
        proxy_cache_valid 404 1m;
        proxy_cache_key "$scheme$request_method$host$request_uri";
        
        proxy_pass http://localhost:3000;
        # ... other proxy settings ...
    }
    
    # Cache static assets
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

## 🔄 Backup and Recovery

### Database Backup

#### Automated Backup Script
```bash
#!/bin/bash
# backup-database.sh

DB_NAME="foodtrip_production"
DB_USER="foodtrip_user"
BACKUP_DIR="/home/foodtrip/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p $BACKUP_DIR

# Create database backup
pg_dump -h localhost -U $DB_USER -d $DB_NAME > $BACKUP_DIR/foodtrip_$DATE.sql

# Compress backup
gzip $BACKUP_DIR/foodtrip_$DATE.sql

# Remove backups older than 30 days
find $BACKUP_DIR -name "*.sql.gz" -mtime +30 -delete

echo "Database backup completed: $BACKUP_DIR/foodtrip_$DATE.sql.gz"
```

```bash
# Make script executable
chmod +x backup-database.sh

# Add to crontab for daily backups
crontab -e
# Add: 0 2 * * * /home/foodtrip/backup-database.sh
```

### Application Backup

#### File System Backup
```bash
#!/bin/bash
# backup-files.sh

APP_DIR="/home/foodtrip/foodtrip-api"
BACKUP_DIR="/home/foodtrip/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p $BACKUP_DIR

# Backup uploads and configuration
tar -czf $BACKUP_DIR/foodtrip_files_$DATE.tar.gz \
  $APP_DIR/public/uploads \
  $APP_DIR/.env.production \
  $APP_DIR/ecosystem.config.js

echo "File backup completed: $BACKUP_DIR/foodtrip_files_$DATE.tar.gz"
```

### Recovery Procedures

#### Database Recovery
```bash
# Stop application
pm2 stop foodtrip-api

# Restore database
gunzip -c /home/foodtrip/backups/foodtrip_20231201_020000.sql.gz | \
  psql -h localhost -U foodtrip_user -d foodtrip_production

# Start application
pm2 start foodtrip-api
```

#### Application Recovery
```bash
# Extract file backup
tar -xzf /home/foodtrip/backups/foodtrip_files_20231201_020000.tar.gz -C /

# Restart application
pm2 restart foodtrip-api
```

This comprehensive deployment guide covers all aspects of production deployment, ensuring reliable, secure, and performant operation of the FoodTrip API in production environments.
