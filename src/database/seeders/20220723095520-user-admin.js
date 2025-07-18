'use strict'
const bcrypt = require('bcrypt')
const { v4: uuidv4 } = require('uuid')

module.exports = {
  async up(queryInterface, Sequelize) {
    const existingUsers = await queryInterface.sequelize.query(
      `SELECT email_address FROM "Users"`, // atau pakai backtick `Users` jika MySQL
      { type: Sequelize.QueryTypes.SELECT }
    )

    const existingEmails = new Set(existingUsers.map(u => u.email_address))

    const users = [
      {
        first_name: 'Paul',
        last_name: 'Tulod',
        email_address: 'paultulod@pm.me'
      },
      {
        first_name: 'Micah',
        last_name: 'Villaruz',
        email_address: 'micahmvillaruz@gmail.com'
      },
      {
        first_name: 'Josiah',
        last_name: 'Fallesgon',
        email_address: 'JosiahFallesgon@gmail.com'
      },
      {
        first_name: 'Filwayne',
        last_name: 'De Lara',
        email_address: 'Dfilwayne@gmail.com'
      },
      {
        first_name: 'Ashlee Jude',
        last_name: 'Delmundo',
        email_address: 'AJDelmundo@gmail.com'
      },
      {
        first_name: 'Emman',
        last_name: 'Peralta',
        email_address: 'EmmanPeralta@gmail.com'
      },
      {
        first_name: 'Racquel',
        last_name: 'Ulibas',
        email_address: 'RacquelUlibas@gmail.com'
      }
    ]

    const saltRounds = parseInt(process.env.SALT_ROUND)
    const createdBy = '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
    const now = new Date()

    const usersToInsert = []

    for (const u of users) {
      if (!existingEmails.has(u.email_address)) {
        usersToInsert.push({
          user_id: uuidv4(),
          user_no: `USR-${Math.floor(Date.now() * 1.5) + Math.floor(Math.random() * 100)}`,
          password: await bcrypt.hash('Admin@123', saltRounds),
          first_name: u.first_name,
          middle_name: null,
          last_name: u.last_name,
          email_address: u.email_address,
          user_type: 'Admin',
          date_created: now,
          date_updated: now,
          created_by: createdBy
        })
      }
    }

    if (usersToInsert.length > 0) {
      await queryInterface.bulkInsert('Users', usersToInsert)
      console.log(`Inserted ${usersToInsert.length} new users.`)
    } else {
      console.log('No new users to insert.')
    }
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete('Users', {
      email_address: [
        'paultulod@pm.me',
        'micahmvillaruz@gmail.com',
        'JosiahFallesgon@gmail.com',
        'Dfilwayne@gmail.com',
        'AJDelmundo@gmail.com',
        'EmmanPeralta@gmail.com',
        'RacquelUlibas@gmail.com'
      ]
    })
  }
}
