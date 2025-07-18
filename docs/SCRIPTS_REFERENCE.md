# Package.json Scripts Reference

## Development Scripts

```bash
# Start development server with auto-reload
npm run dev

# Lint code
npm run lint
npm run lint:fix
npm run lint:check

# Format code
npm run format
npm run format:check
```

## Database Scripts

### Configuration

```bash
# Interactive database configuration
npm run db:config
```

### CLI Commands

```bash
# Database status
npm run db:status

# Auto setup database (create, migrate, seed)
npm run db:setup

# Create database
npm run db:create

# Full CLI access
npm run db:cli
```

### Migration Scripts

```bash
# Run migrations
npm run db:migrate

# Undo last migration
npm run db:migrate:undo

# Using CLI for more options
npm run db:cli migrate:create add-user-table
npm run db:cli migrate:undo
```

### Seeder Scripts

```bash
# Run seeders
npm run db:seed

# Using CLI for more options
npm run db:cli seed:create demo-users
npm run db:cli seed:undo
npm run db:cli seed:undo:all
```

### Dependencies

```bash
# Show database dependencies installation info
npm run db:install-deps
```

## All Available Scripts

```json
{
  "scripts": {
    "dev": "nodemon app.js",
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "lint:check": "eslint . --quiet",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "db:config": "node db-config.js",
    "db:cli": "node db-cli.js",
    "db:status": "node db-cli.js status",
    "db:setup": "node db-cli.js setup",
    "db:create": "node db-cli.js create",
    "db:migrate": "npx sequelize-cli db:migrate",
    "db:migrate:undo": "npx sequelize-cli db:migrate:undo",
    "db:seed": "npx sequelize-cli db:seed:all",
    "db:install-deps": "node -e \"console.log('For database dependencies installation, run:\\n- Linux/Mac: ./install-db-deps.sh\\n- Windows: ./install-db-deps.ps1')\""
  }
}
```

## Quick Setup Workflow

### First Time Setup

```bash
# 1. Configure database
npm run db:config

# 2. Setup database
npm run db:setup

# 3. Start development
npm run dev
```

### Daily Development

```bash
# Start server (auto-setup enabled)
npm run dev

# Check database status
npm run db:status

# Run migrations if needed
npm run db:migrate

# Run seeders if needed
npm run db:seed
```

### Creating New Features

```bash
# Create new migration
npm run db:cli migrate:create add-new-feature

# Create new seeder
npm run db:cli seed:create demo-data

# Create new model
npm run db:cli model:create NewModel
```
