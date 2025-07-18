/* eslint-disable no-console */
'use strict'
const { v4: uuidv4 } = require('uuid')

module.exports = {
  async up(queryInterface, Sequelize) {
    try {
      // Check if dish categories already exist
      const existingCategories = await queryInterface.sequelize.query(
        'SELECT COUNT(*) as count FROM "DishCategories"',
        { type: Sequelize.QueryTypes.SELECT }
      )

      if (existingCategories[0].count > 0) {
        console.log('ℹ️  Dish categories already exist, skipping seeder')
        return
      }

      console.log('🔄 Creating dish categories...')

      const categories = [
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Appetizer',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Beef',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Beverages',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Chicken',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Dessert',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Fish',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Main Course',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Noodles',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Pasta',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Pizza',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Pork',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Rice',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Salad',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Seafood',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Soup',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          dishcatg_id: uuidv4(),
          dishcatg_name: 'Vegetarian',
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        }
      ]

      await queryInterface.bulkInsert('DishCategories', categories, {
        ignoreDuplicates: true
      })

      console.log('✅ Dish categories seeder completed successfully')
    } catch (error) {
      console.error('❌ Dish categories seeder failed:', error.message)
      throw error
    }
  },

  async down(queryInterface, Sequelize) {
    try {
      await queryInterface.bulkDelete('DishCategories', null, {})
      console.log('✅ Dish categories seeder rolled back successfully')
    } catch (error) {
      console.error('❌ Dish categories seeder rollback failed:', error.message)
      throw error
    }
  }
}
