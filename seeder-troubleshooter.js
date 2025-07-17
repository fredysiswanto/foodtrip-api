/* eslint-disable no-console */
'use strict'

const db = require('./src/models')
const fs = require('fs')
const path = require('path')

class SeederTroubleshooter {
  constructor() {
    this.seedersPath = path.join(__dirname, 'src', 'database', 'seeders')
  }

  async validateData() {
    console.log('🔍 Validating seeder data...')

    const issues = []

    // Check Users table
    try {
      const users = await db.User.findAll()
      console.log(`📊 Found ${users.length} users`)

      // Check for duplicate emails
      const emails = users.map(u => u.email_address)
      const duplicateEmails = emails.filter(
        (email, index) => emails.indexOf(email) !== index
      )
      if (duplicateEmails.length > 0) {
        issues.push(`Duplicate emails found: ${duplicateEmails.join(', ')}`)
      }

      // Check for duplicate user_no
      const userNos = users.map(u => u.user_no)
      const duplicateUserNos = userNos.filter(
        (userNo, index) => userNos.indexOf(userNo) !== index
      )
      if (duplicateUserNos.length > 0) {
        issues.push(
          `Duplicate user numbers found: ${duplicateUserNos.join(', ')}`
        )
      }

      // Check user_no length
      const invalidUserNos = users.filter(u => u.user_no.length > 17)
      if (invalidUserNos.length > 0) {
        issues.push(
          `Invalid user numbers (too long): ${invalidUserNos.map(u => u.user_no).join(', ')}`
        )
      }

      // Check phone number format
      const phoneRegex = /^(09|\+639)\d{9}$/
      const invalidPhones = users.filter(
        u => u.phone_number && !phoneRegex.test(u.phone_number)
      )
      if (invalidPhones.length > 0) {
        issues.push(
          `Invalid phone numbers: ${invalidPhones.map(u => u.phone_number).join(', ')}`
        )
      }

      // Check user types
      const validUserTypes = ['Customer', 'Resto_Admin', 'Admin']
      const invalidUserTypes = users.filter(
        u => !validUserTypes.includes(u.user_type)
      )
      if (invalidUserTypes.length > 0) {
        issues.push(
          `Invalid user types: ${invalidUserTypes.map(u => u.user_type).join(', ')}`
        )
      }
    } catch (error) {
      issues.push(`Error checking users: ${error.message}`)
    }

    // Check RestoCategories table
    try {
      const restoCategories = await db.RestoCategory.findAll()
      console.log(`📊 Found ${restoCategories.length} restaurant categories`)

      // Check for duplicate names
      const names = restoCategories.map(c => c.restocatg_name)
      const duplicateNames = names.filter(
        (name, index) => names.indexOf(name) !== index
      )
      if (duplicateNames.length > 0) {
        issues.push(
          `Duplicate restaurant category names: ${duplicateNames.join(', ')}`
        )
      }
    } catch (error) {
      issues.push(`Error checking restaurant categories: ${error.message}`)
    }

    // Check DishCategories table
    try {
      const dishCategories = await db.DishCategory.findAll()
      console.log(`📊 Found ${dishCategories.length} dish categories`)

      // Check for duplicate names
      const names = dishCategories.map(c => c.dishcatg_name)
      const duplicateNames = names.filter(
        (name, index) => names.indexOf(name) !== index
      )
      if (duplicateNames.length > 0) {
        issues.push(
          `Duplicate dish category names: ${duplicateNames.join(', ')}`
        )
      }
    } catch (error) {
      issues.push(`Error checking dish categories: ${error.message}`)
    }

    // Report issues
    if (issues.length > 0) {
      console.log('\n❌ Issues found:')
      issues.forEach(issue => console.log(`  - ${issue}`))
    } else {
      console.log('\n✅ No data validation issues found')
    }

    return issues
  }

  async checkConstraints() {
    console.log('🔍 Checking database constraints...')

    const constraints = []

    try {
      // Check foreign key constraints
      const usersWithInvalidCreatedBy = await db.sequelize.query(
        `
        SELECT u1.user_id, u1.email_address, u1.created_by 
        FROM "Users" u1 
        LEFT JOIN "Users" u2 ON u1.created_by = u2.user_id 
        WHERE u1.created_by IS NOT NULL AND u2.user_id IS NULL
      `,
        { type: db.Sequelize.QueryTypes.SELECT }
      )

      if (usersWithInvalidCreatedBy.length > 0) {
        constraints.push(
          `Users with invalid created_by: ${usersWithInvalidCreatedBy.length}`
        )
      }

      // Check if system admin user exists
      const systemAdmin = await db.User.findOne({
        where: { user_id: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8' }
      })

      if (!systemAdmin) {
        constraints.push(
          'System admin user not found (required for foreign key constraints)'
        )
      }
    } catch (error) {
      constraints.push(`Error checking constraints: ${error.message}`)
    }

    if (constraints.length > 0) {
      console.log('\n❌ Constraint issues found:')
      constraints.forEach(constraint => console.log(`  - ${constraint}`))
    } else {
      console.log('\n✅ No constraint issues found')
    }

    return constraints
  }

  async checkMissingData() {
    console.log('🔍 Checking for missing essential data...')

    const missing = []

    try {
      // Check for system admin
      const systemAdmin = await db.User.findOne({
        where: { user_type: 'Admin' }
      })

      if (!systemAdmin) {
        missing.push('No admin user found')
      }

      // Check for basic categories
      const restoCategories = await db.RestoCategory.findAll()
      if (restoCategories.length === 0) {
        missing.push('No restaurant categories found')
      }

      const dishCategories = await db.DishCategory.findAll()
      if (dishCategories.length === 0) {
        missing.push('No dish categories found')
      }

      // Check for sample customers
      const customers = await db.User.findAll({
        where: { user_type: 'Customer' }
      })

      if (customers.length === 0) {
        missing.push('No customer users found')
      }
    } catch (error) {
      missing.push(`Error checking missing data: ${error.message}`)
    }

    if (missing.length > 0) {
      console.log('\n❌ Missing essential data:')
      missing.forEach(item => console.log(`  - ${item}`))
    } else {
      console.log('\n✅ All essential data is present')
    }

    return missing
  }

  async generateReport() {
    console.log('📋 Generating seeder troubleshooting report...')

    const report = {
      timestamp: new Date().toISOString(),
      validation: await this.validateData(),
      constraints: await this.checkConstraints(),
      missing: await this.checkMissingData()
    }

    const reportPath = path.join(__dirname, 'seeder-report.json')
    fs.writeFileSync(reportPath, JSON.stringify(report, null, 2))

    console.log(`\n📄 Report saved to: ${reportPath}`)

    const totalIssues =
      report.validation.length +
      report.constraints.length +
      report.missing.length

    if (totalIssues === 0) {
      console.log('🎉 All seeder checks passed!')
    } else {
      console.log(`⚠️  Found ${totalIssues} issues that need attention`)
    }

    return report
  }

  async fixCommonIssues() {
    console.log('🔧 Attempting to fix common seeder issues...')

    const fixes = []

    try {
      // Fix: Ensure system admin exists
      const systemAdmin = await db.User.findOne({
        where: { user_id: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8' }
      })

      if (!systemAdmin) {
        const bcrypt = require('bcrypt')
        await db.User.create({
          user_id: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
          user_no: 'USR-9999999999999',
          password: await bcrypt.hash('SysAdmin@123', 10),
          first_name: 'System',
          last_name: 'Admin',
          email_address: 'sysadmin@gmail.com',
          user_type: 'Admin',
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        })
        fixes.push('Created system admin user')
      }

      // Fix: Remove duplicate emails (keep first occurrence)
      const users = await db.User.findAll()
      const seenEmails = new Set()

      for (const user of users) {
        if (seenEmails.has(user.email_address)) {
          await user.destroy()
          fixes.push(`Removed duplicate user: ${user.email_address}`)
        } else {
          seenEmails.add(user.email_address)
        }
      }
    } catch (error) {
      console.error('❌ Error fixing issues:', error.message)
    }

    if (fixes.length > 0) {
      console.log('\n✅ Fixed issues:')
      fixes.forEach(fix => console.log(`  - ${fix}`))
    } else {
      console.log('\n✅ No fixes needed')
    }

    return fixes
  }
}

async function main() {
  const args = process.argv.slice(2)
  const command = args[0]

  const troubleshooter = new SeederTroubleshooter()

  switch (command) {
    case 'validate': {
      await troubleshooter.validateData()
      process.exit(0)
    }
    // eslint-disable-next-line no-fallthrough
    case 'constraints': {
      await troubleshooter.checkConstraints()
      process.exit(0)
    }
    // eslint-disable-next-line no-fallthrough
    case 'missing': {
      await troubleshooter.checkMissingData()
      process.exit(0)
    }
    // eslint-disable-next-line no-fallthrough
    case 'report': {
      await troubleshooter.generateReport()
      process.exit(0)
    }
    // eslint-disable-next-line no-fallthrough
    case 'fix': {
      await troubleshooter.fixCommonIssues()
      process.exit(0)
    }
    // eslint-disable-next-line no-fallthrough
    default: {
      console.log(`
🔧 Seeder Troubleshooter

Usage: node seeder-troubleshooter.js <command>

Commands:
  validate     Validate seeder data
  constraints  Check database constraints
  missing      Check for missing essential data
  report       Generate comprehensive report
  fix          Fix common issues automatically

Examples:
  node seeder-troubleshooter.js validate
  node seeder-troubleshooter.js report
  node seeder-troubleshooter.js fix
      `)
      process.exit(0)
    }
  }
}

if (require.main === module) {
  main().catch(error => {
    console.error('❌ Troubleshooter failed:', error.message)
    process.exit(1)
  })
}

module.exports = SeederTroubleshooter
