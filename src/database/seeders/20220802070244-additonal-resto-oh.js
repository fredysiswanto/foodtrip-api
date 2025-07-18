const { v4: uuidv4 } = require('uuid')
;('use strict')

module.exports = {
  async up(queryInterface, Sequelize) {
    const restaurants = await queryInterface.sequelize.query(
      'SELECT resto_id FROM restaurants ORDER BY restaurants.resto_no ASC; '
    )
    const restaurantRows = restaurants[0]

    // * Restaurant Opening Hours
    return await queryInterface.bulkInsert('OpeningHours', [
      // * Restaurant 11
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[11].resto_id,
        day: 'Monday',
        open_time: '10:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[11].resto_id,
        day: 'Tuesday',
        open_time: '10:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[11].resto_id,
        day: 'Wednesday',
        open_time: '10:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[11].resto_id,
        day: 'Thursday',
        open_time: '10:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[11].resto_id,
        day: 'Friday',
        open_time: '10:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[11].resto_id,
        day: 'Saturday',
        open_time: '10:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      // * Restaurant 12
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[12].resto_id,
        day: 'Monday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[12].resto_id,
        day: 'Tuesday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[12].resto_id,
        day: 'Wednesday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[12].resto_id,
        day: 'Thursday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[12].resto_id,
        day: 'Friday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[12].resto_id,
        day: 'Saturday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      // * Restaurant 13
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[13].resto_id,
        day: 'Monday',
        open_time: '09:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[13].resto_id,
        day: 'Tuesday',
        open_time: '09:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[13].resto_id,
        day: 'Wednesday',
        open_time: '09:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[13].resto_id,
        day: 'Thursday',
        open_time: '09:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[13].resto_id,
        day: 'Friday',
        open_time: '09:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[13].resto_id,
        day: 'Saturday',
        open_time: '09:30:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8',
        date_created: new Date(),
        date_updated: new Date()
      }
    ])
  },

  async down(queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
}
