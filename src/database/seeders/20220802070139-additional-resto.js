'use strict'
const { faker } = require('@faker-js/faker')
const { v4: uuidv4 } = require('uuid')

module.exports = {
  async up(queryInterface, Sequelize) {
    const restoCat = await queryInterface.sequelize.query(
      'SELECT restocatg_id FROM restocategories ORDER BY restocategories.restocatg_name ASC;',
      { type: Sequelize.QueryTypes.SELECT }
    )
    const restoCatRows = restoCat

    if (restoCatRows.length === 0) {
      throw new Error(
        'No restaurant categories found in table restocategories.'
      )
    }

    // Ambil existing email untuk menghindari duplikasi
    const existingEmails = await queryInterface.sequelize.query(
      'SELECT resto_email FROM "Restaurants";',
      { type: Sequelize.QueryTypes.SELECT }
    )
    const existingEmailSet = new Set(existingEmails.map(e => e.resto_email))

    const baseTimestamp = Date.now() * 2
    const createdBy = '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
    const now = new Date()

    const restaurantsToInsert = []

    // 5 restoran tetap (static)
    const staticRestaurants = [
      {
        name: 'Conti’s Bakeshop & Restaurant',
        email: 'ctf.contis@yahoo.com',
        phone: '09514548948',
        landline: '8921 3475',
        website: 'www.contis.ph',
        img: 'resto_img-000000000011.png',
        catIndex: 0
      },
      {
        name: 'The French Baker',
        email: 'info@thefrenchbaker.com',
        phone: '09298564842',
        landline: '+63 (2) 84706210',
        website: 'thefrenchbaker.com',
        img: 'resto_img-000000000012.png',
        catIndex: 0
      },
      {
        name: 'Cafe France',
        email: 'cf_unave@cafefrance.net',
        phone: '+63 (2) 8 254 9788',
        landline: '+63 (2) 8 523 5555',
        website: 'www.cafefrance.net',
        img: 'resto_img-000000000013.png',
        catIndex: 1
      },
      {
        name: "Seattle's Best Coffee",
        email: 'guestservice@sbc.com.ph',
        phone: '+63 (2) 8 421 2043',
        landline: '+63 (2) 8 421 2043',
        website: 'seattlesbest.com.ph',
        img: 'resto_img-000000000014.png',
        catIndex: 1
      },
      {
        name: 'Lemuria Gourmet Restaurant',
        email: 'lemuria@brumms.com.ph',
        phone: '+63 (927) 428 4202',
        landline: '93693311',
        website: 'www.lemuria.com.ph',
        img: 'resto_img-000000000015.png',
        catIndex: 3
      }
    ]

    let index = 0
    for (const resto of staticRestaurants) {
      if (!existingEmailSet.has(resto.email)) {
        restaurantsToInsert.push({
          resto_id: uuidv4(),
          resto_no: `RTO-${baseTimestamp + index}`,
          resto_name: resto.name,
          resto_email: resto.email,
          resto_phone: resto.phone,
          resto_landline: resto.landline,
          resto_website: resto.website,
          resto_img: resto.img,
          restocatg_id:
            restoCatRows[resto.catIndex % restoCatRows.length].restocatg_id,
          date_created: now,
          date_updated: now,
          created_by: createdBy
        })
        index++
      }
    }

    // Generate 20 dummy resto (untuk total jadi 25)
    while (restaurantsToInsert.length < 25) {
      const fakeEmail = faker.internet.email()
      if (existingEmailSet.has(fakeEmail)) continue // skip if email already exists

      const cat = restoCatRows[Math.floor(Math.random() * restoCatRows.length)]

      restaurantsToInsert.push({
        resto_id: uuidv4(),
        resto_no: `RTO-${baseTimestamp + index}`,
        resto_name: faker.company.name() + ' Restaurant',
        resto_email: fakeEmail,
        resto_phone: faker.phone.number('09#########'),
        resto_landline: faker.phone.number('####-####'),
        resto_website: faker.internet.url(),
        resto_img: `resto_img-${faker.number.int({ min: 100000000000, max: 999999999999 })}.png`,
        restocatg_id: cat.restocatg_id,
        date_created: now,
        date_updated: now,
        created_by: createdBy
      })
      existingEmailSet.add(fakeEmail)
      index++
    }

    if (restaurantsToInsert.length > 0) {
      await queryInterface.bulkInsert('Restaurants', restaurantsToInsert)
      console.log(`✅ Inserted ${restaurantsToInsert.length} restaurants.`)
    } else {
      console.log('⚠️ No new restaurants inserted.')
    }
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete('Restaurants', {
      resto_email: {
        [Sequelize.Op.or]: [
          'ctf.contis@yahoo.com',
          'info@thefrenchbaker.com',
          'cf_unave@cafefrance.net',
          'guestservice@sbc.com.ph',
          'lemuria@brumms.com.ph'
          // Dummy resto_email faker-generated tidak bisa dihapus via down()
        ]
      }
    })
  }
}
