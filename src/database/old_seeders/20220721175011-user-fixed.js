/* eslint-disable no-console */
'use strict'
const bcrypt = require('bcrypt')
const { v4: uuidv4 } = require('uuid')

module.exports = {
  async up(queryInterface, Sequelize) {
    try {
      // Check if users already exist
      const existingUsers = await queryInterface.sequelize.query(
        'SELECT COUNT(*) as count FROM "Users"',
        { type: Sequelize.QueryTypes.SELECT }
      )

      if (existingUsers[0].count > 0) {
        console.log('ℹ️  Users already exist, skipping user seeder')
        return
      }

      console.log('🔄 Creating users...')

      // Generate unique user numbers
      const baseTimestamp = Date.now()
      const generateUserNo = index => {
        const timestamp = baseTimestamp + index
        return `USR-${timestamp.toString().padStart(13, '0')}`
      }

      // * User Data
      const users = [
        {
          user_id: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
          user_no: 'USR-9999999999999',
          password: await bcrypt.hash(
            'SysAdmin@123',
            parseInt(process.env.SALT_ROUND) || 10
          ),
          first_name: 'System',
          middle_name: null,
          last_name: 'Admin',
          email_address: 'sysadmin@gmail.com',
          phone_number: null,
          gender: null,
          user_type: 'Admin',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          user_id: uuidv4(),
          user_no: generateUserNo(1),
          password: await bcrypt.hash(
            'Customer@123',
            parseInt(process.env.SALT_ROUND) || 10
          ),
          first_name: 'James Paul',
          middle_name: 'Lim',
          last_name: 'Tulod',
          email_address: 'jptulod123@gmail.com',
          phone_number: '09451152076',
          gender: 'Male',
          user_type: 'Customer',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          user_id: uuidv4(),
          user_no: generateUserNo(2),
          password: await bcrypt.hash(
            'Customer@123',
            parseInt(process.env.SALT_ROUND) || 10
          ),
          first_name: 'Jerald',
          middle_name: null,
          last_name: 'Guillermo',
          email_address: 'jerald05@gmail.com',
          phone_number: '09482749382',
          gender: 'Male',
          user_type: 'Customer',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          user_id: uuidv4(),
          user_no: generateUserNo(3),
          password: await bcrypt.hash(
            'Customer@123',
            parseInt(process.env.SALT_ROUND) || 10
          ),
          first_name: 'Shaine',
          middle_name: 'Rieta',
          last_name: 'Villanueva',
          email_address: 'shainevil30@gmail.com',
          phone_number: '09592749184',
          gender: 'Female',
          user_type: 'Customer',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          user_id: uuidv4(),
          user_no: generateUserNo(4),
          password: await bcrypt.hash(
            'Customer@123',
            parseInt(process.env.SALT_ROUND) || 10
          ),
          first_name: 'Allison',
          middle_name: null,
          last_name: 'Locsin',
          email_address: 'allilocsin@gmail.com',
          phone_number: '09752048137',
          gender: 'Female',
          user_type: 'Customer',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        }
      ]

      // Insert users in batches to avoid timeout
      const batchSize = 10
      for (let i = 0; i < users.length; i += batchSize) {
        const batch = users.slice(i, i + batchSize)
        await queryInterface.bulkInsert('Users', batch, {
          ignoreDuplicates: true
        })
        console.log(
          `✅ Inserted batch ${Math.floor(i / batchSize) + 1} of users`
        )
      }

      console.log('✅ User seeder completed successfully')
    } catch (error) {
      console.error('❌ User seeder failed:', error.message)
      throw error
    }
  },

  async down(queryInterface, Sequelize) {
    try {
      await queryInterface.bulkDelete('Users', null, {})
      console.log('✅ User seeder rolled back successfully')
    } catch (error) {
      console.error('❌ User seeder rollback failed:', error.message)
      throw error
    }
  }
}
