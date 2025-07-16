require('dotenv').config() // Load env variables dari .env

module.exports = {
  development: {
    dialect: process.env.USE_DB || 'mysql',
    host: process.env.DB_HOST || 'localhost',
    username: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: process.env.DB_NAME || 'foodtrip',
    storage: process.env.DB_STORAGE || './db/database.sqlite',
    logging: false
  },
  test: {
    dialect: 'sqlite',
    storage: ':memory:',
    logging: false
  },
  production: {
    dialect: process.env.USE_DB || 'mysql',
    host: process.env.DB_HOST || 'localhost',
    username: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: process.env.DB_NAME || 'my_database',
    storage: process.env.DB_STORAGE || './database.sqlite',
    logging: false
  }
}
