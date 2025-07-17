require('dotenv').config() // Load env variables dari .env

// Helper function untuk membuat konfigurasi database
const createDatabaseConfig = environment => {
  const dialect = process.env.USE_DB || 'mysql'
  const baseConfig = {
    dialect,
    logging: process.env.DB_LOGGING === 'true' || false,
    pool: {
      max: parseInt(process.env.DB_POOL_MAX) || 5,
      min: parseInt(process.env.DB_POOL_MIN) || 0,
      acquire: parseInt(process.env.DB_POOL_ACQUIRE) || 30000,
      idle: parseInt(process.env.DB_POOL_IDLE) || 10000
    }
  }

  // Konfigurasi untuk SQLite
  if (dialect === 'sqlite') {
    return {
      ...baseConfig,
      storage: process.env.DB_STORAGE || './db/database.sqlite'
    }
  }

  // Konfigurasi untuk database lainnya (MySQL, PostgreSQL, MariaDB, MSSQL)
  const databaseName =
    environment === 'production'
      ? process.env.DB_NAME || 'my_database'
      : process.env.DB_NAME || 'foodtrip'

  return {
    ...baseConfig,
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT) || getDefaultPort(dialect),
    username: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: databaseName
  }
}

// Helper function untuk mendapatkan port default berdasarkan database
const getDefaultPort = dialect => {
  const ports = {
    mysql: 3306,
    postgresql: 5432,
    mariadb: 3306,
    mssql: 1433
  }
  return ports[dialect] || 3306
}

module.exports = {
  development: createDatabaseConfig('development'),
  test: {
    dialect: 'sqlite',
    storage: ':memory:',
    logging: false
  },
  production: createDatabaseConfig('production')
}
