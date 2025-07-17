/* eslint-disable no-console */
'use strict'

const db = require('./src/models')
const fs = require('fs')
const path = require('path')

class SeederManager {
  constructor() {
    this.seedersPath = path.join(__dirname, 'src', 'database', 'seeders')
  }

  async runSeeder(seederFile) {
    try {
      console.log(`🔄 Running seeder: ${seederFile}`)

      const seederPath = path.join(this.seedersPath, seederFile)
      const seeder = require(seederPath)

      if (seeder.up) {
        await seeder.up(db.sequelize.getQueryInterface(), db.Sequelize)
        console.log(`✅ Seeder ${seederFile} completed successfully`)
        return true
      } else {
        console.log(`⚠️  Seeder ${seederFile} has no up method`)
        return false
      }
    } catch (error) {
      console.error(`❌ Seeder ${seederFile} failed:`, error.message)
      if (error.errors && error.errors.length > 0) {
        error.errors.forEach(err => {
          console.error(`   - ${err.message} (field: ${err.path})`)
        })
      }
      return false
    }
  }

  async runAllSeeders() {
    try {
      console.log('🚀 Running all seeders...')

      const fixedSeeders = [
        '20220721175011-user-fixed.js',
        '20220721190234-resto-categories-fixed.js',
        '20220721190251-dish-categories-fixed.js'
      ]

      let successCount = 0
      let failCount = 0

      for (const seederFile of fixedSeeders) {
        const seederPath = path.join(this.seedersPath, seederFile)

        if (fs.existsSync(seederPath)) {
          const success = await this.runSeeder(seederFile)
          if (success) {
            successCount++
          } else {
            failCount++
          }
        } else {
          console.log(`⚠️  Seeder file not found: ${seederFile}`)
          failCount++
        }
      }

      console.log('\n📊 Seeder Summary:')
      console.log(`✅ Success: ${successCount}`)
      console.log(`❌ Failed: ${failCount}`)
      console.log(`📋 Total: ${successCount + failCount}`)

      return failCount === 0
    } catch (error) {
      console.error('❌ Failed to run seeders:', error.message)
      return false
    }
  }

  async checkSeederStatus() {
    try {
      console.log('📊 Checking seeder status...')

      const checks = [
        { table: 'Users', name: 'Users' },
        { table: 'RestoCategories', name: 'Restaurant Categories' },
        { table: 'DishCategories', name: 'Dish Categories' }
      ]

      for (const check of checks) {
        try {
          const [result] = await db.sequelize.query(
            `SELECT COUNT(*) as count FROM "${check.table}"`,
            { type: db.Sequelize.QueryTypes.SELECT }
          )

          const count = result.count
          console.log(
            `├── ${check.name}: ${count} records ${count > 0 ? '✅' : '❌'}`
          )
        } catch (error) {
          console.log(`├── ${check.name}: Table not found ❌`)
        }
      }
    } catch (error) {
      console.error('❌ Failed to check seeder status:', error.message)
    }
  }
}

async function main() {
  const args = process.argv.slice(2)
  const command = args[0]

  const seederManager = new SeederManager()

  switch (command) {
  case 'run': {
    const success = await seederManager.runAllSeeders()
    process.exit(success ? 0 : 1)
  }
  // eslint-disable-next-line no-fallthrough
  case 'status': {
    await seederManager.checkSeederStatus()
    process.exit(0)
  }
  // eslint-disable-next-line no-fallthrough
  default: {
    console.log(`
🌱 Seeder Manager

Usage: node seeder-manager.js <command>

Commands:
  run     Run all fixed seeders
  status  Check seeder status

Examples:
  node seeder-manager.js run
  node seeder-manager.js status
      `)
    process.exit(0)
  }
  }
}

if (require.main === module) {
  main().catch(error => {
    console.error('❌ Seeder manager failed:', error.message)
    process.exit(1)
  })
}

module.exports = SeederManager
