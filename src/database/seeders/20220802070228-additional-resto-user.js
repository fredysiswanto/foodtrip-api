const bcrypt = require('bcrypt')
const { v4: uuidv4 } = require('uuid')
;('use strict')

module.exports = {
  async up(queryInterface, Sequelize) {
    try {
      const restaurants = await queryInterface.sequelize.query(
        'SELECT resto_id FROM `Restaurants` ORDER BY `Restaurants`.resto_no ASC; ',
        { type: Sequelize.QueryTypes.SELECT }
      )
      const restaurantRows = restaurants || []

      console.log(`Found ${restaurantRows.length} restaurants`)

      // Check if resto admin users already exist
      const existingUsers = await queryInterface.sequelize.query(
        'SELECT email_address FROM `Users` WHERE email_address IN (?, ?, ?)',
        {
          replacements: [
            'vickysanchez@gmail.com',
            'mariasimon28@gmail.com',
            'mendezgregg@gmail.com'
          ],
          type: Sequelize.QueryTypes.SELECT
        }
      )

      if (existingUsers.length > 0) {
        console.log('ℹ️  Resto admin users already exist, skipping')
        return
      }

      // * Resto-Admin User
      await queryInterface.bulkInsert('Users', [
        {
          user_id: uuidv4(),
          user_no: `USR-${Math.floor(Date.now() * 1.5) + 1}`,
          password: await bcrypt.hash(
            'RestoAdmin@123',
            parseInt(process.env.SALT_ROUND)
          ),
          first_name: 'Vicky',
          middle_name: null,
          last_name: 'Sanchez',
          email_address: 'vickysanchez@gmail.com',
          user_type: 'Resto_Admin',
          resto_id: restaurantRows[11].resto_id,
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          user_id: uuidv4(),
          user_no: `USR-${Math.floor(Date.now() * 1.5) + 2}`,
          password: await bcrypt.hash(
            'RestoAdmin@123',
            parseInt(process.env.SALT_ROUND)
          ),
          first_name: 'Marian Mae',
          middle_name: null,
          last_name: 'Simon',
          email_address: 'mariasimon28@gmail.com',
          user_type: 'Resto_Admin',
          resto_id: restaurantRows[12].resto_id,
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        },
        {
          user_id: uuidv4(),
          user_no: `USR-${Math.floor(Date.now() * 1.5) + 3}`,
          password: await bcrypt.hash(
            'RestoAdmin@123',
            parseInt(process.env.SALT_ROUND)
          ),
          first_name: 'Gregg',
          middle_name: 'Mendez',
          last_name: 'Lopez',
          email_address: 'mendezgregg@gmail.com',
          user_type: 'Resto_Admin',
          resto_id: restaurantRows[13].resto_id,
          date_created: new Date(),
          date_updated: new Date(),
          created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        }
        // {
        //   user_id: uuidv4(),
        //   user_no: `USR-${Math.floor(Date.now() * 1.5) + 4}`,
        //   password: await bcrypt.hash(
        //     'RestoAdmin@123',
        //     parseInt(process.env.SALT_ROUND)
        //   ),
        //   first_name: 'Yvonne',
        //   middle_name: 'Morgan',
        //   last_name: 'Haynez',
        //   email_address: 'yvonnehaynes13@gmail.com',
        //   user_type: 'Resto_Admin',
        //   resto_id: restaurantRows[14].resto_id,
        //   date_created: new Date(),
        //   date_updated: new Date(),
        //   created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        // },
        // {
        //   user_id: uuidv4(),
        //   user_no: `USR-${Math.floor(Date.now() * 1.5) + 5}`,
        //   password: await bcrypt.hash(
        //     'RestoAdmin@123',
        //     parseInt(process.env.SALT_ROUND)
        //   ),
        //   first_name: 'Alfred',
        //   middle_name: null,
        //   last_name: 'Herrera',
        //   email_address: 'herreraalfred08@gmail.com',
        //   user_type: 'Resto_Admin',
        //   resto_id: restaurantRows[15].resto_id,
        //   date_created: new Date(),
        //   date_updated: new Date(),
        //   created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        // },
        // {
        //   user_id: uuidv4(),
        //   user_no: `USR-${Math.floor(Date.now() * 1.5) + 6}`,
        //   password: await bcrypt.hash(
        //     'RestoAdmin@123',
        //     parseInt(process.env.SALT_ROUND)
        //   ),
        //   first_name: 'Lyndsey Ann',
        //   middle_name: 'Minezes',
        //   last_name: 'Bartolome',
        //   email_address: 'annlynbartolome@gmail.com',
        //   user_type: 'Resto_Admin',
        //   resto_id: restaurantRows[16].resto_id,
        //   date_created: new Date(),
        //   date_updated: new Date(),
        //   created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        // },
        // {
        //   user_id: uuidv4(),
        //   user_no: `USR-${Math.floor(Date.now() * 1.5) + 7}`,
        //   password: await bcrypt.hash(
        //     'RestoAdmin@123',
        //     parseInt(process.env.SALT_ROUND)
        //   ),
        //   first_name: 'Jake Angelo ',
        //   middle_name: 'Felix',
        //   last_name: 'Tan',
        //   email_address: 'tanfelixjake@gmail.com',
        //   user_type: 'Resto_Admin',
        //   resto_id: restaurantRows[17].resto_id,
        //   date_created: new Date(),
        //   date_updated: new Date(),
        //   created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        // },
        // {
        //   user_id: uuidv4(),
        //   user_no: `USR-${Math.floor(Date.now() * 1.5) + 8}`,
        //   password: await bcrypt.hash(
        //     'RestoAdmin@123',
        //     parseInt(process.env.SALT_ROUND)
        //   ),
        //   first_name: 'Angeline',
        //   middle_name: null,
        //   last_name: 'Cacacho',
        //   email_address: 'angelinecacacho@gmail.com',
        //   user_type: 'Resto_Admin',
        //   resto_id: restaurantRows[18].resto_id,
        //   date_created: new Date(),
        //   date_updated: new Date(),
        //   created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        // },
        // {
        //   user_id: uuidv4(),
        //   user_no: `USR-${Math.floor(Date.now() * 1.5) + 9}`,
        //   password: await bcrypt.hash(
        //     'RestoAdmin@123',
        //     parseInt(process.env.SALT_ROUND)
        //   ),
        //   first_name: 'Ronald',
        //   middle_name: null,
        //   last_name: 'Cooper',
        //   email_address: 'ronaldcooper@gmail.com',
        //   user_type: 'Resto_Admin',
        //   resto_id: restaurantRows[19].resto_id,
        //   date_created: new Date(),
        //   date_updated: new Date(),
        //   created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        // },
        // {
        //   user_id: uuidv4(),
        //   user_no: `USR-${Math.floor(Date.now() * 1.5) + 10}`,
        //   password: await bcrypt.hash(
        //     'RestoAdmin@123',
        //     parseInt(process.env.SALT_ROUND)
        //   ),
        //   first_name: 'Mark Andrey',
        //   middle_name: 'Mejano',
        //   last_name: 'Ramirez',
        //   email_address: 'markramirez@gmail.com',
        //   user_type: 'Resto_Admin',
        //   resto_id: restaurantRows[20].resto_id,
        //   date_created: new Date(),
        //   date_updated: new Date(),
        //   created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
        // }
      ])
    } catch (error) {
      console.error('Error in additional-resto-user seeder:', error)
      throw error
    }
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
