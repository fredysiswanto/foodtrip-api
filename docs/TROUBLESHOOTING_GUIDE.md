# Troubleshooting Guide

This comprehensive troubleshooting guide helps developers and QA engineers quickly identify, diagnose, and resolve common issues with the FoodTrip API.

## 🚨 Quick Issue Resolution

### Emergency Checklist

When the API is not responding:

1. **Check server status**
   ```bash
   # Check if API is running
   curl http://localhost:5000/health
   
   # Check PM2 status (production)
   pm2 status
   
   # Check development server
   ps aux | grep node
   ```

2. **Check database connectivity**
   ```bash
   # Test database connection
   npm run db:status
   
   # Check SQLite file (development)
   ls -la db/database.sqlite
   
   # Check PostgreSQL (production)
   pg_isready -h localhost -p 5432
   ```

3. **Check logs**
   ```bash
   # Application logs
   tail -f logs/combined.log
   
   # PM2 logs
   pm2 logs
   
   # System logs
   sudo journalctl -u nginx -f
   ```

4. **Quick restart**
   ```bash
   # Development
   Ctrl+C and restart: npm run dev
   
   # Production
   pm2 restart foodtrip-api
   ```

## 🔧 Common Development Issues

### 1. Server Won't Start

#### Issue: "Port already in use"
```
Error: listen EADDRINUSE: address already in use :::5000
```

**Solutions:**
```bash
# Find process using port 5000
lsof -i :5000
# or on Windows
netstat -ano | findstr :5000

# Kill process by PID
kill -9 <PID>
# or on Windows
taskkill /PID <PID> /F

# Use different port
PORT=5001 npm run dev

# Or set in .env file
echo "PORT=5001" >> .env
```

#### Issue: "Module not found"
```
Error: Cannot find module 'express'
```

**Solutions:**
```bash
# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install

# Or with pnpm
rm -rf node_modules pnpm-lock.yaml
pnpm install

# Check if package.json exists
ls -la package.json

# Install specific missing module
npm install express
```

#### Issue: "Environment variables not loaded"
```
Error: JWT_SECRET is not defined
```

**Solutions:**
```bash
# Check if .env file exists
ls -la .env

# Create from example
cp .env.example .env

# Check environment loading in app.js
head -5 app.js | grep dotenv

# Manually load environment (for testing)
export JWT_SECRET="your-secret-here"
```

### 2. Database Connection Issues

#### Issue: "Database connection failed"
```
ConnectionError: ECONNREFUSED 127.0.0.1:5432
```

**Solutions:**
```bash
# Check database service
sudo systemctl status postgresql

# Start database service
sudo systemctl start postgresql

# Check database configuration
cat src/config/config.json

# Test connection manually
psql -h localhost -U foodtrip_user -d foodtrip_production

# For SQLite, check file permissions
ls -la db/database.sqlite
chmod 644 db/database.sqlite
```

#### Issue: "Database does not exist"
```
SequelizeDatabaseError: database "foodtrip_production" does not exist
```

**Solutions:**
```bash
# Create database
npm run db:create

# Or manually create
createdb foodtrip_production

# Reset database completely
npm run db:setup
```

#### Issue: "Migration failed"
```
Error: Migration failed with error: relation "users" already exists
```

**Solutions:**
```bash
# Check migration status
npm run db:status

# Undo last migration
npx sequelize-cli db:migrate:undo

# Reset all migrations
npx sequelize-cli db:migrate:undo:all

# Re-run migrations
npm run db:migrate

# Or reset database completely
npm run db:setup
```

### 3. Authentication Issues

#### Issue: "JWT token verification failed"
```
JsonWebTokenError: invalid signature
```

**Solutions:**
```bash
# Check JWT_SECRET in environment
echo $JWT_SECRET

# Verify .env file has JWT_SECRET
grep JWT_SECRET .env

# Generate new JWT secret
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"

# Clear any cached tokens
# In browser: localStorage.clear()
# In Postman: Remove Authorization header
```

#### Issue: "User not authenticated"
```
Error: Authorization header missing
```

**Solutions:**
```bash
# Check request headers
# In curl:
curl -H "Authorization: Bearer <token>" http://localhost:5000/api/customer/profile

# In Postman:
# Add Authorization header: Bearer <your-token>

# Test login to get new token
curl -X POST http://localhost:5000/api/home/login \
  -H "Content-Type: application/json" \
  -d '{"email":"customer@foodtrip.com","password":"password123"}'
```

#### Issue: "Password hash comparison failed"
```
Error: Invalid credentials
```

**Solutions:**
```bash
# Check if user exists in database
npm run db:cli
# Then: SELECT * FROM users WHERE email = 'customer@foodtrip.com';

# Reset user password
npm run db:seed

# Check bcrypt version compatibility
npm list bcrypt

# Manually hash password for testing
node -e "
const bcrypt = require('bcrypt');
bcrypt.hash('password123', 12, (err, hash) => {
  console.log('Hash:', hash);
});
"
```

### 4. File Upload Issues

#### Issue: "File upload failed"
```
Error: ENOENT: no such file or directory, open 'public/uploads/...'
```

**Solutions:**
```bash
# Create upload directories
mkdir -p public/uploads/dishes
mkdir -p public/uploads/restaurants

# Check directory permissions
ls -la public/uploads
chmod 755 public/uploads
chmod 755 public/uploads/dishes
chmod 755 public/uploads/restaurants

# Check multer configuration
grep -n "multer" src/middlewares/uploadImage.js

# Test file upload with curl
curl -X POST http://localhost:5000/api/resto_admin/dish \
  -H "Authorization: Bearer <token>" \
  -F "name=Test Dish" \
  -F "description=Test Description" \
  -F "price=25000" \
  -F "dishcategory_id=1" \
  -F "image=@/path/to/test-image.jpg"
```

#### Issue: "File size too large"
```
Error: File too large
```

**Solutions:**
```bash
# Check file size limits in uploadImage.js
grep -n "limits" src/middlewares/uploadImage.js

# Increase limit if needed (in bytes)
# 5MB = 5 * 1024 * 1024 = 5242880

# Check Nginx upload limit (production)
grep client_max_body_size /etc/nginx/sites-available/foodtrip-api

# Compress image before upload
# Use online tools or image compression libraries
```

### 5. CORS Issues

#### Issue: "CORS policy blocked"
```
Access to fetch at 'http://localhost:5000/api/...' from origin 'http://localhost:3000' has been blocked by CORS policy
```

**Solutions:**
```bash
# Check CORS configuration in app.js
grep -A5 -B5 "cors" app.js

# Update CORS origin in .env
CORS_ORIGIN=http://localhost:3000,http://localhost:3001

# Or allow all origins (development only)
# In app.js:
# app.use(cors({ origin: true }));

# Restart server after changes
npm run dev
```

## 🗄️ Database-Specific Issues

### 1. SQLite Issues (Development)

#### Issue: "Database locked"
```
Error: SQLITE_BUSY: database is locked
```

**Solutions:**
```bash
# Close all database connections
pkill -f "node.*app.js"

# Remove lock file if exists
rm -f db/database.sqlite-wal
rm -f db/database.sqlite-shm

# Restart development server
npm run dev

# If persistent, recreate database
rm db/database.sqlite
npm run db:setup
```

#### Issue: "Disk space full"
```
Error: SQLITE_FULL: database or disk is full
```

**Solutions:**
```bash
# Check disk space
df -h

# Check database size
ls -lh db/database.sqlite

# Clean up logs
rm -f logs/*.log

# Clean up node_modules and reinstall
rm -rf node_modules
npm install
```

### 2. PostgreSQL Issues (Production)

#### Issue: "Connection pool exhausted"
```
Error: Timed out after 30000ms while trying to acquire a connection from the pool
```

**Solutions:**
```bash
# Check active connections
sudo -u postgres psql -c "SELECT count(*) FROM pg_stat_activity WHERE datname='foodtrip_production';"

# Kill long-running queries
sudo -u postgres psql -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='foodtrip_production' AND state='idle in transaction';"

# Increase connection pool (in Sequelize config)
# "pool": { "max": 20, "min": 0, "acquire": 30000, "idle": 10000 }

# Restart application
pm2 restart foodtrip-api
```

#### Issue: "PostgreSQL won't start"
```
Error: could not connect to server: Connection refused
```

**Solutions:**
```bash
# Check PostgreSQL status
sudo systemctl status postgresql

# Start PostgreSQL
sudo systemctl start postgresql

# Enable auto-start
sudo systemctl enable postgresql

# Check PostgreSQL logs
sudo tail -f /var/log/postgresql/postgresql-*.log

# Check disk space
df -h /var/lib/postgresql/

# Reset PostgreSQL if corrupted
sudo systemctl stop postgresql
sudo -u postgres /usr/lib/postgresql/13/bin/pg_resetwal /var/lib/postgresql/13/main
sudo systemctl start postgresql
```

## 🚀 Production Issues

### 1. PM2 Issues

#### Issue: "PM2 app not running"
```
App [foodtrip-api] exited with code [1]
```

**Solutions:**
```bash
# Check PM2 status
pm2 status

# View logs
pm2 logs foodtrip-api

# Restart application
pm2 restart foodtrip-api

# Delete and restart
pm2 delete foodtrip-api
pm2 start ecosystem.config.js --env production

# Check PM2 startup script
pm2 startup
pm2 save

# Flush logs if too large
pm2 flush
```

#### Issue: "High memory usage"
```
App [foodtrip-api] restarted due to memory limit
```

**Solutions:**
```bash
# Check memory usage
pm2 monit

# Increase memory limit in ecosystem.config.js
# max_memory_restart: '2G'

# Check for memory leaks
node --inspect app.js
# Then use Chrome DevTools Memory tab

# Optimize database queries
# Add LIMIT clauses, use pagination

# Enable garbage collection logging
# node --expose-gc --trace-gc app.js
```

### 2. Nginx Issues

#### Issue: "502 Bad Gateway"
```
nginx: 502 Bad Gateway
```

**Solutions:**
```bash
# Check if application is running
curl http://localhost:3000/health

# Check Nginx configuration
sudo nginx -t

# Check Nginx logs
sudo tail -f /var/log/nginx/error.log

# Restart services
pm2 restart foodtrip-api
sudo systemctl restart nginx

# Check proxy configuration
grep -A10 "location /" /etc/nginx/sites-available/foodtrip-api
```

#### Issue: "SSL certificate issues"
```
Error: SSL_ERROR_BAD_CERT_DOMAIN
```

**Solutions:**
```bash
# Check certificate status
sudo certbot certificates

# Renew certificate
sudo certbot renew

# Test SSL configuration
curl -I https://yourdomain.com

# Check certificate expiry
openssl x509 -in /etc/letsencrypt/live/yourdomain.com/fullchain.pem -text -noout | grep "Not After"

# Update Nginx SSL configuration
sudo nano /etc/nginx/sites-available/foodtrip-api
sudo nginx -t
sudo systemctl reload nginx
```

### 3. Performance Issues

#### Issue: "Slow response times"
```
API responses taking > 5 seconds
```

**Solutions:**
```bash
# Check database performance
npm run db:cli
# Run: EXPLAIN ANALYZE SELECT * FROM dishes WHERE restaurant_id = 1;

# Add database indexes
# See SYSTEM_ARCHITECTURE.md for recommended indexes

# Enable query logging
# In config.json: "logging": console.log

# Check system resources
top
htop
iotop

# Optimize images
# Compress uploaded images
# Use CDN for static assets

# Enable Nginx caching
# See DEPLOYMENT_GUIDE.md for caching configuration
```

#### Issue: "High CPU usage"
```
CPU usage consistently > 80%
```

**Solutions:**
```bash
# Check which process is using CPU
top -p $(pgrep -f "node.*app.js")

# Scale with PM2 cluster mode
pm2 delete foodtrip-api
pm2 start ecosystem.config.js --env production

# Optimize code
# Remove console.log statements
# Use async/await properly
# Implement caching

# Check for infinite loops
# Use profiling tools
node --prof app.js
```

## 🔍 Debugging Techniques

### 1. Application Debugging

#### Enable Debug Mode
```bash
# Development debugging
DEBUG=* npm run dev

# Specific module debugging
DEBUG=express:* npm run dev

# Database query debugging
# In config.json: "logging": console.log

# Request debugging
# Add middleware:
app.use((req, res, next) => {
  console.log(`${req.method} ${req.path}`, req.body);
  next();
});
```

#### Using Node.js Inspector
```bash
# Start with inspector
node --inspect app.js

# Start with inspector and break on first line
node --inspect-brk app.js

# In Chrome: go to chrome://inspect
# Click "Open dedicated DevTools for Node"
```

#### Application Logging
```javascript
// Enhanced logging middleware
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

// Usage in controllers
logger.info('User login attempt', { email: req.body.email });
logger.error('Database connection failed', { error: err.message });
```

### 2. Database Debugging

#### SQL Query Analysis
```sql
-- Enable query logging in PostgreSQL
ALTER SYSTEM SET log_statement = 'all';
SELECT pg_reload_conf();

-- Check slow queries
SELECT query, mean_time, calls 
FROM pg_stat_statements 
WHERE mean_time > 1000 
ORDER BY mean_time DESC;

-- Analyze table statistics
ANALYZE;

-- Check index usage
SELECT 
  schemaname,
  tablename,
  attname,
  n_distinct,
  correlation
FROM pg_stats
WHERE tablename = 'dishes';
```

#### Sequelize Debugging
```javascript
// Enable Sequelize logging
const sequelize = new Sequelize(config.database, config.username, config.password, {
  ...config,
  logging: (sql, timing) => {
    console.log(`[${timing}ms] ${sql}`);
  },
  benchmark: true
});

// Log all queries
sequelize.addHook('beforeQuery', (options, query) => {
  console.log('Query:', query.sql);
  console.log('Bind:', query.bind);
});
```

### 3. API Testing and Debugging

#### Using curl for Testing
```bash
# Test authentication
curl -X POST http://localhost:5000/api/home/login \
  -H "Content-Type: application/json" \
  -d '{"email":"customer@foodtrip.com","password":"password123"}' \
  -v

# Test with authentication
TOKEN="your-jwt-token-here"
curl -X GET http://localhost:5000/api/customer/profile \
  -H "Authorization: Bearer $TOKEN" \
  -v

# Test file upload
curl -X POST http://localhost:5000/api/resto_admin/dish \
  -H "Authorization: Bearer $TOKEN" \
  -F "name=Test Dish" \
  -F "price=25000" \
  -F "dishcategory_id=1" \
  -F "image=@test-image.jpg" \
  -v
```

#### HTTP Status Code Reference

| Code | Meaning | Common Causes | Solutions |
|------|---------|---------------|-----------|
| 400 | Bad Request | Invalid JSON, missing fields | Check request body, validate inputs |
| 401 | Unauthorized | Missing/invalid token | Login again, check token format |
| 403 | Forbidden | Wrong user role | Check user permissions |
| 404 | Not Found | Wrong endpoint, resource doesn't exist | Check URL, verify resource exists |
| 409 | Conflict | Duplicate data | Check for existing records |
| 422 | Unprocessable Entity | Validation errors | Fix validation errors |
| 500 | Internal Server Error | Application/database error | Check logs, fix bugs |

## 📱 Frontend Integration Issues

### 1. API Client Issues

#### Issue: "Network request failed"
```javascript
// Check network connectivity
fetch('http://localhost:5000/health')
  .then(response => console.log('API Status:', response.status))
  .catch(error => console.log('Network Error:', error));

// Check CORS headers
fetch('http://localhost:5000/api/home/restaurants', {
  method: 'GET',
  headers: {
    'Content-Type': 'application/json',
  }
})
.then(response => {
  console.log('CORS headers:', response.headers);
  return response.json();
})
.then(data => console.log(data))
.catch(error => console.log('Error:', error));
```

#### Issue: "Token expires too quickly"
```javascript
// Implement token refresh
const refreshToken = async () => {
  try {
    const response = await fetch('/api/auth/refresh', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('refresh_token')}`
      }
    });
    
    if (response.ok) {
      const { token } = await response.json();
      localStorage.setItem('auth_token', token);
      return token;
    }
  } catch (error) {
    // Redirect to login
    window.location.href = '/login';
  }
};

// Axios interceptor for automatic retry
axios.interceptors.response.use(
  response => response,
  async error => {
    if (error.response?.status === 401) {
      const newToken = await refreshToken();
      if (newToken) {
        error.config.headers.Authorization = `Bearer ${newToken}`;
        return axios.request(error.config);
      }
    }
    return Promise.reject(error);
  }
);
```

## 🛠️ System Administration

### 1. Log Management

#### Log Rotation Setup
```bash
# Create logrotate configuration
sudo nano /etc/logrotate.d/foodtrip-api

# Content:
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

# Test logrotate
sudo logrotate -d /etc/logrotate.d/foodtrip-api
```

#### Clean Up Logs
```bash
# Clear large log files
truncate -s 0 logs/combined.log
truncate -s 0 logs/error.log

# PM2 logs
pm2 flush

# System logs
sudo journalctl --vacuum-time=7d
```

### 2. Monitoring Scripts

#### Health Check Script
```bash
#!/bin/bash
# health-monitor.sh

API_URL="http://localhost:3000/health"
LOG_FILE="/home/foodtrip/logs/health-check.log"

# Check API health
response=$(curl -s -o /dev/null -w "%{http_code}" $API_URL)

if [ $response != "200" ]; then
    echo "$(date): API health check failed - Status: $response" >> $LOG_FILE
    
    # Restart PM2 application
    pm2 restart foodtrip-api
    
    # Send notification (configure webhook/email)
    curl -X POST "YOUR_SLACK_WEBHOOK_URL" \
      -H 'Content-type: application/json' \
      --data '{"text":"🚨 FoodTrip API health check failed and restarted"}'
else
    echo "$(date): API health check passed" >> $LOG_FILE
fi
```

#### Resource Monitor
```bash
#!/bin/bash
# resource-monitor.sh

# Check disk space
DISK_USAGE=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)
if [ $DISK_USAGE -gt 80 ]; then
    echo "Warning: Disk usage is ${DISK_USAGE}%"
fi

# Check memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{printf("%.2f", $3/$2 * 100.0)}')
if (( $(echo "$MEMORY_USAGE > 80" | bc -l) )); then
    echo "Warning: Memory usage is ${MEMORY_USAGE}%"
fi

# Check database connections
DB_CONNECTIONS=$(sudo -u postgres psql -t -c "SELECT count(*) FROM pg_stat_activity WHERE datname='foodtrip_production';")
if [ $DB_CONNECTIONS -gt 15 ]; then
    echo "Warning: High database connections: $DB_CONNECTIONS"
fi
```

## 📞 Getting Help

### 1. Support Channels

#### Development Team
- **Technical Issues**: Create GitHub issue
- **Documentation**: Update relevant docs
- **Critical Issues**: Contact senior developers immediately

#### External Resources
- **Node.js Issues**: [Node.js Documentation](https://nodejs.org/docs/)
- **Express.js Issues**: [Express.js Guide](https://expressjs.com/guide/)
- **Sequelize Issues**: [Sequelize Documentation](https://sequelize.org/docs/)
- **PostgreSQL Issues**: [PostgreSQL Documentation](https://www.postgresql.org/docs/)

### 2. Issue Reporting Template

When reporting issues:

```markdown
## Issue Description
Brief description of the problem

## Environment
- OS: [Windows/Linux/macOS]
- Node.js version: 
- npm/pnpm version:
- Database: [SQLite/PostgreSQL]

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Error Messages
```
Copy error messages here
```

## Additional Context
- Screenshots (if applicable)
- Log files
- Configuration files (remove sensitive data)
```

### 3. Emergency Contacts

#### Production Issues
1. **Immediate Response**: Restart services
2. **Escalation**: Contact DevOps team
3. **Communication**: Notify stakeholders
4. **Documentation**: Log incident details

This troubleshooting guide should help resolve most common issues. For persistent problems, don't hesitate to reach out to the development team or create detailed issue reports.
