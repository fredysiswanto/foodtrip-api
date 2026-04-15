/* eslint-disable no-unused-vars */
/* eslint-disable no-console */
const { exec } = require('child_process')
const { promisify } = require('util')
const db = require('../models')
const path = require('path')
const fs = require('fs')

const execAsync = promisify(exec)

class DatabaseHelper {
  /**
   * Check if database tables exist
   * @returns {Promise<boolean>}
   */
  static async checkTablesExist() {
    try {
      const queryInterface = db.sequelize.getQueryInterface()
      const tables = await queryInterface.showAllTables()

      // Check if there are any tables (excluding system tables)
      const userTables = tables.filter(table => {
        // Filter out system tables
        return ![
          'sqlite_sequence',
          'information_schema',
          'performance_schema',
          'mysql',
          'sys'
        ].includes(table)
      })

      console.log(`📊 Found ${userTables.length} tables in database`)
      return userTables.length > 0
    } catch (error) {
      console.error('Error checking tables:', error.message)
      return false
    }
  }

  /**
   * Check if migration table exists and has records
   * @returns {Promise<boolean>}
   */
  static async checkMigrationsExist() {
    try {
      const queryInterface = db.sequelize.getQueryInterface()
      const tables = await queryInterface.showAllTables()

      // Check if SequelizeMeta table exists
      const migrationTableExists = tables.includes('SequelizeMeta')

      if (!migrationTableExists) {
        console.log('📝 No migration table found')
        return false
      }

      // Check if there are any migration records
      const [results] = await db.sequelize.query(
        'SELECT COUNT(*) as count FROM `SequelizeMeta`'
      )
      const migrationCount = results[0].count

      console.log(`📝 Found ${migrationCount} migration records`)
      return migrationCount > 0
    } catch (error) {
      console.error('Error checking migrations:', error.message)
      return false
    }
  }

  /**
   * Check if seeder data exists in key tables
   * @returns {Promise<boolean>}
   */
  static async checkSeedersExist() {
    try {
      // Check some key tables that typically have seed data
      const tablesToCheck = ['Users', 'DishCategories', 'RestaurantCategories']
      let hasSeederData = false

      for (const tableName of tablesToCheck) {
        try {
          const [results] = await db.sequelize.query(
            `SELECT COUNT(*) as count FROM \`${tableName}\``
          )
          const count = results[0].count

          if (count > 0) {
            console.log(`🌱 Found ${count} records in ${tableName}`)
            hasSeederData = true
          }
        } catch (error) {
          // Table might not exist yet, continue checking
          console.log(`⚠️  Table ${tableName} not found or empty`)
        }
      }

      return hasSeederData
    } catch (error) {
      console.error('Error checking seeders:', error.message)
      return false
    }
  }

  /**
   * Run database migrations
   * @returns {Promise<boolean>}
   */
  static async runMigrations() {
    try {
      console.log('🔄 Running database migrations...')

      const { stdout, stderr } = await execAsync(
        'npx sequelize-cli db:migrate',
        {
          cwd: process.cwd()
        }
      )

      if (stderr && !stderr.includes('Sequelize CLI')) {
        console.error('Migration stderr:', stderr)
      }

      console.log('✅ Migrations completed successfully')
      console.log(stdout)
      return true
    } catch (error) {
      console.error('❌ Migration failed:', error.message)
      return false
    }
  }

  /**
   * Run database seeders
   * @returns {Promise<boolean>}
   */
  static async runSeeders() {
    try {
      console.log('🌱 Running database seeders...')

      const { stdout, stderr } = await execAsync(
        'npx sequelize-cli db:seed:all',
        {
          cwd: process.cwd()
        }
      )

      if (stderr && !stderr.includes('Sequelize CLI')) {
        console.error('Seeder stderr:', stderr)
      }

      console.log('✅ Seeders completed successfully')
      console.log(stdout)
      return true
    } catch (error) {
      console.error('❌ Seeder failed:', error.message)
      return false
    }
  }

  /**
   * Create database if it doesn't exist (for non-SQLite databases)
   * @returns {Promise<boolean>}
   */
  static async createDatabase() {
    try {
      console.log('🔄 Creating database if not exists...')

      const { stdout, stderr } = await execAsync(
        'npx sequelize-cli db:create',
        {
          cwd: process.cwd()
        }
      )

      if (stderr && !stderr.includes('Sequelize CLI')) {
        console.error('Database creation stderr:', stderr)
      }

      console.log('✅ Database creation completed')
      console.log(stdout)
      return true
    } catch (error) {
      console.error('❌ Database creation failed:', error.message)
      return false
    }
  }

  /**
   * Check if migration files exist
   * @returns {Promise<boolean>}
   */
  static async checkMigrationFilesExist() {
    const migrationPath = path.join(
      process.cwd(),
      'src',
      'database',
      'migrations'
    )

    try {
      const files = fs.readdirSync(migrationPath)
      const migrationFiles = files.filter(file => file.endsWith('.js'))

      console.log(`📁 Found ${migrationFiles.length} migration files`)
      return migrationFiles.length > 0
    } catch (error) {
      console.log('📁 No migration directory found')
      return false
    }
  }

  /**
   * Check if seeder files exist
   * @returns {Promise<boolean>}
   */
  static async checkSeederFilesExist() {
    const seederPath = path.join(process.cwd(), 'src', 'database', 'seeders')

    try {
      const files = fs.readdirSync(seederPath)
      const seederFiles = files.filter(file => file.endsWith('.js'))

      console.log(`📁 Found ${seederFiles.length} seeder files`)
      return seederFiles.length > 0
    } catch (error) {
      console.log('📁 No seeder directory found')
      return false
    }
  }

  /**
   * Auto setup database: create, migrate, and seed if needed
   * @returns {Promise<boolean>}
   */
  static async autoSetupDatabase() {
    try {
      console.log('🚀 Starting automatic database setup...')

      // Step 1: Create database if needed (skip for SQLite)
      if (process.env.USE_DB !== 'sqlite') {
        await this.createDatabase()
      }

      // Step 2: Check if migrations are needed
      const tablesExist = await this.checkTablesExist()
      const migrationsExist = await this.checkMigrationsExist()
      const migrationFilesExist = await this.checkMigrationFilesExist()

      if (!tablesExist || !migrationsExist) {
        if (migrationFilesExist) {
          console.log(
            '🔄 Database is empty or migrations not complete, running migrations...'
          )
          const migrationSuccess = await this.runMigrations()

          if (!migrationSuccess) {
            console.error('❌ Migration failed, cannot continue')
            return false
          }
        } else {
          console.log('⚠️  No migration files found, skipping migrations')
        }
      } else {
        console.log(
          '✅ Database tables already exist and migrations are up to date'
        )
      }

      // Step 3: Check if seeders are needed
      const seedersExist = await this.checkSeedersExist()
      const seederFilesExist = await this.checkSeederFilesExist()

      if (!seedersExist) {
        if (seederFilesExist) {
          console.log('🌱 No seed data found, running seeders...')
          const seederSuccess = await this.runSeeders()

          if (!seederSuccess) {
            console.error('❌ Seeder failed, but continuing...')
          }
        } else {
          console.log('⚠️  No seeder files found, skipping seeders')
        }
      } else {
        console.log('✅ Seed data already exists')
      }

      console.log('🎉 Database setup completed successfully!')
      return true
    } catch (error) {
      console.error('❌ Auto setup failed:', error.message)
      return false
    }
  }

  /**
   * Get database status info
   * @returns {Promise<Object>}
   */
  static async getDatabaseStatus() {
    try {
      const status = {
        connected: false,
        tablesExist: false,
        migrationsExist: false,
        seedersExist: false,
        migrationFilesExist: false,
        seederFilesExist: false
      }

      // Check connection
      try {
        await db.sequelize.authenticate()
        status.connected = true
      } catch (error) {
        status.connected = false
      }

      if (status.connected) {
        status.tablesExist = await this.checkTablesExist()
        status.migrationsExist = await this.checkMigrationsExist()
        status.seedersExist = await this.checkSeedersExist()
      }

      status.migrationFilesExist = await this.checkMigrationFilesExist()
      status.seederFilesExist = await this.checkSeederFilesExist()

      return status
    } catch (error) {
      console.error('Error getting database status:', error.message)
      return {
        connected: false,
        tablesExist: false,
        migrationsExist: false,
        seedersExist: false,
        migrationFilesExist: false,
        seederFilesExist: false,
        error: error.message
      }
    }
  }
}

module.exports = DatabaseHelper
