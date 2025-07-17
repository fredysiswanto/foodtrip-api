#!/usr/bin/env node

/* eslint-disable no-console */

const fs = require('fs')
const path = require('path')
const readline = require('readline')

const envPath = path.join(__dirname, '.env')
const envExamplePath = path.join(__dirname, '.env.example')

// Fungsi untuk membaca file .env
function readEnvFile (filePath) {
  if (!fs.existsSync(filePath)) {
    return {}
  }

  const content = fs.readFileSync(filePath, 'utf8')
  const env = {}

  content.split('\n').forEach(line => {
    const [key, ...valueParts] = line.split('=')
    if (key && valueParts.length > 0) {
      env[key.trim()] = valueParts.join('=').trim()
    }
  })

  return env
}

// Fungsi untuk menulis file .env
function writeEnvFile (filePath, env) {
  const content = Object.entries(env)
    .map(([key, value]) => `${key}=${value}`)
    .join('\n')

  fs.writeFileSync(filePath, `${content}\n`)
}

// Konfigurasi database yang tersedia
const databases = {
  sqlite: {
    USE_DB: 'sqlite',
    DB_STORAGE: './db/database.sqlite',
    description: 'SQLite (File-based database, cocok untuk development)'
  },
  mysql: {
    USE_DB: 'mysql',
    DB_HOST: 'localhost',
    DB_PORT: '3306',
    DB_USER: 'root',
    DB_PASS: '',
    DB_NAME: 'foodtrip',
    description: 'MySQL (Relational database, cocok untuk production)'
  },
  postgresql: {
    USE_DB: 'postgresql',
    DB_HOST: 'localhost',
    DB_PORT: '5432',
    DB_USER: 'postgres',
    DB_PASS: '',
    DB_NAME: 'foodtrip',
    description: 'PostgreSQL (Advanced relational database)'
  },
  mariadb: {
    USE_DB: 'mariadb',
    DB_HOST: 'localhost',
    DB_PORT: '3306',
    DB_USER: 'root',
    DB_PASS: '',
    DB_NAME: 'foodtrip',
    description: 'MariaDB (MySQL-compatible database)'
  }
}

// Interface untuk input user
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
})

function question (query) {
  return new Promise(resolve => rl.question(query, resolve))
}

async function main () {
  console.log('🔧 FoodTrip API Database Configuration Tool')
  console.log('===========================================\n')

  // Baca konfigurasi saat ini
  const currentEnv = readEnvFile(envPath)
  const currentDb = currentEnv.USE_DB || 'sqlite'

  console.log(`Current database: ${currentDb.toUpperCase()}`)
  console.log('\nAvailable databases:')

  Object.entries(databases).forEach(([key, config], index) => {
    const current = key === currentDb ? ' (current)' : ''
    console.log(
      `${index + 1}. ${key.toUpperCase()}${current} - ${config.description}`
    )
  })

  console.log('\n')
  const choice = await question(
    'Select database (1-4) or press Enter to keep current: '
  )

  if (!choice) {
    console.log('No changes made.')
    rl.close()
    return
  }

  const dbKeys = Object.keys(databases)
  const selectedIndex = parseInt(choice) - 1

  if (selectedIndex < 0 || selectedIndex >= dbKeys.length) {
    console.log('Invalid choice.')
    rl.close()
    return
  }

  const selectedDb = dbKeys[selectedIndex]
  const dbConfig = databases[selectedDb]

  console.log(`\nConfiguring ${selectedDb.toUpperCase()}...`)

  // Baca env saat ini atau gunakan example
  let env = readEnvFile(envPath)
  if (Object.keys(env).length === 0) {
    env = readEnvFile(envExamplePath)
  }

  // Update konfigurasi database
  Object.entries(dbConfig).forEach(([key, value]) => {
    if (key !== 'description') {
      env[key] = value
    }
  })

  // Jika bukan SQLite, tanyakan konfigurasi tambahan
  if (selectedDb !== 'sqlite') {
    console.log('\nDatabase connection details:')

    const host = await question(`Host [${env.DB_HOST}]: `)
    if (host) env.DB_HOST = host

    const port = await question(`Port [${env.DB_PORT}]: `)
    if (port) env.DB_PORT = port

    const user = await question(`Username [${env.DB_USER}]: `)
    if (user) env.DB_USER = user

    const pass = await question(`Password [${env.DB_PASS}]: `)
    if (pass) env.DB_PASS = pass

    const dbName = await question(`Database name [${env.DB_NAME}]: `)
    if (dbName) env.DB_NAME = dbName
  }

  // Simpan konfigurasi
  writeEnvFile(envPath, env)

  console.log(
    `\n✅ Database configuration updated to ${selectedDb.toUpperCase()}`
  )
  console.log('📁 Configuration saved to .env file')

  if (selectedDb === 'sqlite') {
    console.log(`📊 Database file: ${env.DB_STORAGE}`)
  } else {
    console.log(
      `📊 Database: ${env.DB_USER}@${env.DB_HOST}:${env.DB_PORT}/${env.DB_NAME}`
    )
  }

  console.log('\n🚀 You can now start the server with: npm run dev')

  rl.close()
}

main().catch(console.error)
