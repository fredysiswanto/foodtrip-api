/* eslint-disable no-console */
'use strict'
const { v4: uuidv4 } = require('uuid')

module.exports = {
  async up(queryInterface, Sequelize) {
    try {
      // Check if resto categories already exist
      const existingCategories = await queryInterface.sequelize.query(
        'SELECT COUNT(*) as count FROM "RestoCategories"',
        { type: Sequelize.QueryTypes.SELECT }
      )

      if (existingCategories[0].count > 0) {
        console.log('ℹ️  Resto categories already exist, skipping seeder')
        return
      }

      console.log('🔄 Creating restaurant categories...')

      const categories = [
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Bakery',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Cafe',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Fast Food',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Fine Dining',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Casual Dining',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Food Truck',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Buffet',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Bar & Grill',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Pizza',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          restocatg_id: uuidv4(),
          restocatg_name: 'Asian Cuisine',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        }
      ]

      await queryInterface.bulkInsert('RestoCategories', categories, {
        ignoreDuplicates: true
      })

      console.log('✅ Restaurant categories seeder completed successfully')
    } catch (error) {
      console.error('❌ Restaurant categories seeder failed:', error.message)
      throw error
    }
  },

  async down(queryInterface, Sequelize) {
    try {
      await queryInterface.bulkDelete('RestoCategories', null, {})
      console.log('✅ Restaurant categories seeder rolled back successfully')
    } catch (error) {
      console.error(
        '❌ Restaurant categories seeder rollback failed:',
        error.message
      )
      throw error
    }
  }
}
