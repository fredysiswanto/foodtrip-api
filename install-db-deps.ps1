# Script untuk install database dependencies di Windows
# Usage: ./install-db-deps.ps1 [database_type]

param(
    [string]$DatabaseType = ""
)

Write-Host "🔧 Database Dependencies Installer" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

if (-not $DatabaseType) {
    Write-Host "Available database types:" -ForegroundColor Yellow
    Write-Host "1. postgresql" -ForegroundColor White
    Write-Host "2. mariadb" -ForegroundColor White
    Write-Host "3. all (install all optional dependencies)" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "Select database type (1-3)"
    
    switch ($choice) {
        "1" { $DatabaseType = "postgresql" }
        "2" { $DatabaseType = "mariadb" }
        "3" { $DatabaseType = "all" }
        default { 
            Write-Host "Invalid choice" -ForegroundColor Red
            exit 1 
        }
    }
}

Write-Host "Installing dependencies for: $DatabaseType" -ForegroundColor Green

switch ($DatabaseType) {
    "postgresql" {
        Write-Host "Installing PostgreSQL dependencies..." -ForegroundColor Yellow
        npm install pg pg-hstore
    }
    "mariadb" {
        Write-Host "Installing MariaDB dependencies..." -ForegroundColor Yellow
        npm install mariadb
    }
    "all" {
        Write-Host "Installing all database dependencies..." -ForegroundColor Yellow
        npm install pg pg-hstore mariadb
    }
    default {
        Write-Host "Unsupported database type: $DatabaseType" -ForegroundColor Red
        Write-Host "Supported types: postgresql, mariadb, all" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ Dependencies installed successfully!" -ForegroundColor Green
Write-Host "You can now configure the database using: npm run db:config" -ForegroundColor Cyan
