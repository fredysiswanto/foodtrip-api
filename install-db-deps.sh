#!/bin/bash

# Script untuk install database dependencies
# Usage: ./install-db-deps.sh [database_type]

echo "🔧 Database Dependencies Installer"
echo "=================================="

DATABASE_TYPE=${1:-""}

if [ -z "$DATABASE_TYPE" ]; then
    echo "Available database types:"
    echo "1. postgresql"
    echo "2. mariadb"
    echo "3. all (install all optional dependencies)"
    echo ""
    read -p "Select database type (1-3): " choice
    
    case $choice in
        1) DATABASE_TYPE="postgresql" ;;
        2) DATABASE_TYPE="mariadb" ;;
        3) DATABASE_TYPE="all" ;;
        *) echo "Invalid choice"; exit 1 ;;
    esac
fi

echo "Installing dependencies for: $DATABASE_TYPE"

case $DATABASE_TYPE in
    "postgresql")
        echo "Installing PostgreSQL dependencies..."
        npm install pg pg-hstore
        ;;
    "mariadb")
        echo "Installing MariaDB dependencies..."
        npm install mariadb
        ;;
    "all")
        echo "Installing all database dependencies..."
        npm install pg pg-hstore mariadb
        ;;
    *)
        echo "Unsupported database type: $DATABASE_TYPE"
        echo "Supported types: postgresql, mariadb, all"
        exit 1
        ;;
esac

echo "✅ Dependencies installed successfully!"
echo "You can now configure the database using: npm run db:config"
