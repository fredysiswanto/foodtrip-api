#!/usr/bin/env node
 

/* eslint-disable no-console */

const DatabaseHelper = require('./src/helpers/databaseHelper')
const { exec } = require('child_process')
const { promisify } = require('util')

const execAsync = promisify(exec)

// Get command line arguments
const args = process.argv.slice(2)
const command = args[0]
const subcommand = args[1]

// Helper function to show usage
function showUsage() {
  console.log(`
🔧 Database CLI Tool for FoodTrip API

Usage: node db-cli.js <command> [options]

Commands:
  status                    Show database status
  migrate                   Run database migrations
  migrate:create <name>     Create a new migration file
  migrate:undo              Undo last migration
  seed                      Run database seeders
  seed:create <name>        Create a new seeder file
  seed:undo                 Undo last seeder
  seed:undo:all             Undo all seeders
  setup                     Auto setup database (create, migrate, seed)
  create                    Create database
  model:create <name>       Create a new model and migration

Examples:
  node db-cli.js status
  node db-cli.js migrate
  node db-cli.js migrate:create add-user-table
  node db-cli.js seed:create demo-users
  node db-cli.js setup
  `)
}

// Main CLI logic
async function main() {
  if (
    !command ||
    command === 'help' ||
    command === '--help' ||
    command === '-h'
  ) {
    showUsage()
    return
  }

  try {
    switch (command) {
      case 'status':
        await handleStatus()
        break
      case 'migrate':
        await handleMigrate()
        break
      case 'migrate:create':
        await handleMigrateCreate(subcommand)
        break
      case 'migrate:undo':
        await handleMigrateUndo()
        break
      case 'seed':
        await handleSeed()
        break
      case 'seed:create':
        await handleSeedCreate(subcommand)
        break
      case 'seed:undo':
        await handleSeedUndo()
        break
      case 'seed:undo:all':
        await handleSeedUndoAll()
        break
      case 'setup':
        await handleSetup()
        break
      case 'create':
        await handleCreate()
        break
      case 'model:create':
        await handleModelCreate(subcommand)
        break
      default:
        console.log(`❌ Unknown command: ${command}`)
        showUsage()
        process.exit(1)
    }
  } catch (error) {
    console.error('❌ Command failed:', error.message)
    process.exit(1)
  }
}

// Command handlers
async function handleStatus() {
  console.log('📊 Checking database status...\n')

  const status = await DatabaseHelper.getDatabaseStatus()

  console.log('Database Status:')
  console.log(`├── Connected: ${status.connected ? '✅' : '❌'}`)
  console.log(`├── Tables exist: ${status.tablesExist ? '✅' : '❌'}`)
  console.log(`├── Migrations exist: ${status.migrationsExist ? '✅' : '❌'}`)
  console.log(`├── Seed data exists: ${status.seedersExist ? '✅' : '❌'}`)
  console.log(
    `├── Migration files: ${status.migrationFilesExist ? '✅' : '❌'}`
  )
  console.log(`└── Seeder files: ${status.seederFilesExist ? '✅' : '❌'}`)

  if (status.error) {
    console.log(`\n❌ Error: ${status.error}`)
  }
}

async function handleMigrate() {
  const success = await DatabaseHelper.runMigrations()
  if (!success) {
    process.exit(1)
  }
}

async function handleMigrateCreate(migrationName) {
  if (!migrationName) {
    console.log('❌ Migration name is required')
    console.log('Usage: node db-cli.js migrate:create <name>')
    process.exit(1)
  }

  console.log(`🔄 Creating migration: ${migrationName}`)
  const { stdout } = await execAsync(
    `npx sequelize-cli migration:generate --name ${migrationName}`
  )
  console.log(stdout)
  console.log('✅ Migration file created successfully')
}

async function handleMigrateUndo() {
  console.log('🔄 Undoing last migration...')
  const { stdout } = await execAsync('npx sequelize-cli db:migrate:undo')
  console.log(stdout)
  console.log('✅ Migration undone successfully')
}

async function handleSeed() {
  const success = await DatabaseHelper.runSeeders()
  if (!success) {
    process.exit(1)
  }
}

async function handleSeedCreate(seederName) {
  if (!seederName) {
    console.log('❌ Seeder name is required')
    console.log('Usage: node db-cli.js seed:create <name>')
    process.exit(1)
  }

  console.log(`🔄 Creating seeder: ${seederName}`)
  const { stdout } = await execAsync(
    `npx sequelize-cli seed:generate --name ${seederName}`
  )
  console.log(stdout)
  console.log('✅ Seeder file created successfully')
}

async function handleSeedUndo() {
  console.log('🔄 Undoing last seeder...')
  const { stdout } = await execAsync('npx sequelize-cli db:seed:undo')
  console.log(stdout)
  console.log('✅ Seeder undone successfully')
}

async function handleSeedUndoAll() {
  console.log('🔄 Undoing all seeders...')
  const { stdout } = await execAsync('npx sequelize-cli db:seed:undo:all')
  console.log(stdout)
  console.log('✅ All seeders undone successfully')
}

async function handleSetup() {
  const success = await DatabaseHelper.autoSetupDatabase()
  if (!success) {
    process.exit(1)
  }
}

async function handleCreate() {
  const success = await DatabaseHelper.createDatabase()
  if (!success) {
    process.exit(1)
  }
}

async function handleModelCreate(modelName) {
  if (!modelName) {
    console.log('❌ Model name is required')
    console.log('Usage: node db-cli.js model:create <name>')
    process.exit(1)
  }

  console.log(`🔄 Creating model: ${modelName}`)
  const { stdout } = await execAsync(
    `npx sequelize-cli model:generate --name ${modelName}`
  )
  console.log(stdout)
  console.log('✅ Model and migration created successfully')
}

// Run the CLI
main().catch(console.error)
