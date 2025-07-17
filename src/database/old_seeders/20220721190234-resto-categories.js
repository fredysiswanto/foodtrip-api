'use strict'
const bcrypt = require('bcrypt')
const { v4: uuidv4 } = require('uuid')

module.exports = {
  async up(queryInterface, Sequelize) {
    // * Restaurant Categories
    await queryInterface.bulkInsert('RestoCategories', [
      // * Example
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
        restocatg_name: 'Korean',
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        restocatg_id: uuidv4(),
        restocatg_name: 'Pizzerias',
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      }
    ])

    const restoCat = await queryInterface.sequelize.query(
      'SELECT restocatg_id FROM restocategories ORDER BY restocategories.restocatg_name ASC;'
    )
    const restoCatRows = restoCat[0]

    // * Restaurants
    await queryInterface.bulkInsert('Restaurants', [
      // * Example
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2}`,
        resto_name: 'Jollibot',
        resto_email: 'jollibee@gmail.com',
        resto_phone: '09451152076',
        resto_landline: '12345678',
        resto_website: 'www.jollibee.com',
        resto_img: 'resto_img-000000000000.png',
        restocatg_id: restoCatRows[2].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 1}`,
        resto_name: 'Gerrys Grill',
        resto_email: 'gerrysgrill@gmail.com',
        resto_phone: '09175011273',
        resto_landline: '8332-1111',
        resto_website: 'www.gerrysgrill.com.ph',
        resto_img: 'resto_img-000000000001.png',
        restocatg_id: restoCatRows[3].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 2}`,
        resto_name: 'Starbucks',
        resto_email: 'customer@rustancoffee.ph',
        resto_phone: '09457157924',
        resto_landline: '8462-6262 ',
        resto_website: 'www.starbucks.ph',
        resto_img: 'resto_img-000000000002.png',
        restocatg_id: restoCatRows[1].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 3}`,
        resto_name: 'Angels Pizza',
        resto_email: 'angelspizza@gmail.com',
        resto_phone: '09287635411',
        resto_landline: '8922-2222',
        resto_website: 'www.angelspizza.com.ph',
        resto_img: 'resto_img-000000000003.png',
        restocatg_id: restoCatRows[5].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 4}`,
        resto_name: 'Seoul Train Korean BBQ',
        resto_email: 'eat@seoultrain.ph',
        resto_phone: '09177722203',
        resto_landline: '8733-1111',
        resto_website: 'http://bit.ly/minimall-st',
        resto_img: 'resto_img-000000000004.png',
        restocatg_id: restoCatRows[4].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 5}`,
        resto_name: 'Pan De Manila',
        resto_email: 'pandemanila@gmail.com',
        resto_phone: '09325478165',
        resto_landline: '8433-5555',
        resto_website: 'www.pandemanila.com.ph',
        resto_img: 'resto_img-000000000005.png',
        restocatg_id: restoCatRows[0].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 6}`,
        resto_name: 'The Melting Potluck',
        resto_email: 'meltingpotluck@gmail.com',
        resto_phone: '09152533335',
        resto_landline: '8533-3335',
        resto_website: 'www.meltingpotluck.com.ph',
        resto_img: 'resto_img-000000000006.png',
        restocatg_id: restoCatRows[3].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 7}`,
        resto_name: 'The Fat Seed Cafe',
        resto_email: 'thefatseedph@gmail.com',
        resto_phone: '09452781134',
        resto_landline: '8936-2113',
        resto_website: 'www.thefatseedph.com',
        resto_img: 'resto_img-000000000007.png',
        restocatg_id: restoCatRows[1].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 8}`,
        resto_name: 'Yellow Cab Pizza Co.',
        resto_email: 'onlinesupport@yellowcabpizza.com',
        resto_phone: '09188035571',
        resto_landline: '8789-9999',
        resto_website: 'www.delivery.yellowcabpizza.com',
        resto_img: 'resto_img-000000000008.png',
        restocatg_id: restoCatRows[5].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 9}`,
        resto_name: 'OGANE Restaurant',
        resto_email: 'paradise30399@yahoo.com.ph',
        resto_phone: '09557428535',
        resto_landline: '7794-2785',
        resto_website: 'oganerestaurant.com.ph',
        resto_img: 'resto_img-000000000009.png',
        restocatg_id: restoCatRows[4].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        resto_id: uuidv4(),
        resto_no: `RTO-${Date.now() * 2 + 10}`,
        resto_name: 'Goldilocks',
        resto_email: 'customercare@goldilocks.com.ph',
        resto_phone: '09862544713',
        resto_landline: '2532-2718',
        resto_website: 'www.goldilocks.com.ph',
        resto_img: 'resto_img-000000000010.png',
        restocatg_id: restoCatRows[0].restocatg_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      }
    ])

    const restaurants = await queryInterface.sequelize.query(
      'SELECT resto_id FROM restaurants ORDER BY restaurants.resto_no ASC; '
    )
    const restaurantRows = restaurants[0]

    // * Restaurant Address
    await queryInterface.bulkInsert('Addresses', [
      // * Example
      {
        address_id: uuidv4(),
        address_1: '92 Fairview Terraces',
        address_2: null,
        barangay: 'Pasong Putik',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1424',
        is_default: '1',
        resto_id: restaurantRows[0].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: 'Commonwealth Avenue ',
        address_2: 'Calle Bistro',
        barangay: 'Ever Commonwealth',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1121',
        is_default: '1',
        resto_id: restaurantRows[1].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: ' Diliman Commercial Center',
        address_2: null,
        barangay: '46 Commonwealth Ave',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1121',
        is_default: '1',
        resto_id: restaurantRows[2].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: '103-G',
        address_2: 'Commonwealth Ave.',
        barangay: 'Fairview',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1121',
        is_default: '1',
        resto_id: restaurantRows[3].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: '28 Sgt. Esguerra Ave',
        address_2: null,
        barangay: ' Diliman',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '	1101',
        is_default: '1',
        resto_id: restaurantRows[4].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: '1118 Commonwealth Ave',
        address_2: 'Novaliches',
        barangay: 'Pasong Putik',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1118',
        is_default: '1',
        resto_id: restaurantRows[5].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: 'Block 41, Lot, 22 Ascension Ave',
        address_2: 'Novaliches',
        barangay: 'North Fairview',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1121',
        is_default: '1',
        resto_id: restaurantRows[6].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: 'M32G+H2J',
        address_2: null,
        barangay: 'Diliman',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1101',
        is_default: '1',
        resto_id: restaurantRows[7].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: 'Commercial Center',
        address_2: 'Regalado Hive',
        barangay: '2/F',
        city: ' Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1118',
        is_default: '1',
        resto_id: restaurantRows[8].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: '303 Tomas',
        address_2: 'Morato Ave',
        barangay: 'Diliman',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1101',
        is_default: '1',
        resto_id: restaurantRows[9].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        address_id: uuidv4(),
        address_1: 'Fairview Centermall,Don Mariano',
        address_2: 'Marcos Ave. cor. Regalado',
        barangay: 'Novaliches',
        city: 'Quezon City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1118',
        is_default: '1',
        resto_id: restaurantRows[10].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      }
    ])

    // * Resto-Admin User
    await queryInterface.bulkInsert('Users', [
      {
        user_id: uuidv4(),
        user_no: `USR-${Math.floor(Date.now() * 1.5)}`,
        password: await bcrypt.hash(
          'RestoAdmin@123',
          parseInt(process.env.SALT_ROUND)
        ),
        first_name: 'Yoorim',
        middle_name: null,
        last_name: 'Heo',
        email_address: 'yoorimie@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[0].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        user_id: uuidv4(),
        user_no: `USR-${Math.floor(Date.now() * 1.5) + 1}`,
        password: await bcrypt.hash(
          'RestoAdmin@123',
          parseInt(process.env.SALT_ROUND)
        ),
        first_name: 'Shyann',
        middle_name: 'Viola',
        last_name: 'Horne',
        email_address: 'Shyann@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[1].resto_id,
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
        first_name: 'Lee',
        middle_name: 'Caprice',
        last_name: 'Maynard',
        email_address: 'Lee@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[2].resto_id,
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
        first_name: 'Sydney',
        middle_name: 'Blayne',
        last_name: 'Bonilla',
        email_address: 'Sydney@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[3].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        user_id: uuidv4(),
        user_no: `USR-${Math.floor(Date.now() * 1.5) + 4}`,
        password: await bcrypt.hash(
          'RestoAdmin@123',
          parseInt(process.env.SALT_ROUND)
        ),
        first_name: 'Roderick',
        middle_name: 'Varian',
        last_name: 'Keller',
        email_address: 'Roderick@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[4].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        user_id: uuidv4(),
        user_no: `USR-${Math.floor(Date.now() * 1.5) + 5}`,
        password: await bcrypt.hash(
          'RestoAdmin@123',
          parseInt(process.env.SALT_ROUND)
        ),
        first_name: 'Leila',
        middle_name: 'Arden',
        last_name: 'Gilbert',
        email_address: 'Leila@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[5].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        user_id: uuidv4(),
        user_no: `USR-${Math.floor(Date.now() * 1.5) + 6}`,
        password: await bcrypt.hash(
          'RestoAdmin@123',
          parseInt(process.env.SALT_ROUND)
        ),
        first_name: 'Killian',
        middle_name: 'Miranda',
        last_name: 'Alvarez',
        email_address: 'Killian@gmail.copm',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[6].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        user_id: uuidv4(),
        user_no: `USR-${Math.floor(Date.now() * 1.5) + 7}`,
        password: await bcrypt.hash(
          'RestoAdmin@123',
          parseInt(process.env.SALT_ROUND)
        ),
        first_name: 'Kamryn',
        middle_name: 'Tyson',
        last_name: 'Dominguez',
        email_address: 'kamryn@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[7].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        user_id: uuidv4(),
        user_no: `USR-${Math.floor(Date.now() * 1.5) + 8}`,
        password: await bcrypt.hash(
          'RestoAdmin@123',
          parseInt(process.env.SALT_ROUND)
        ),
        first_name: 'Shawn',
        middle_name: 'Murphy',
        last_name: 'White',
        email_address: 'Shawn@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[8].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        user_id: uuidv4(),
        user_no: `USR-${Math.floor(Date.now() * 1.5) + 9}`,
        password: await bcrypt.hash(
          'RestoAdmin@123',
          parseInt(process.env.SALT_ROUND)
        ),
        first_name: 'Uriel',
        middle_name: 'Michael',
        last_name: 'Harvey',
        email_address: 'Uriel@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[9].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        user_id: uuidv4(),
        user_no: `USR-${Math.floor(Date.now() * 1.5) + 10}`,
        password: await bcrypt.hash(
          'RestoAdmin@123',
          parseInt(process.env.SALT_ROUND)
        ),
        first_name: 'Dominique',
        middle_name: 'Jacklyn',
        last_name: 'Rollins',
        email_address: 'Dominique@gmail.com',
        user_type: 'Resto_Admin',
        resto_id: restaurantRows[10].resto_id,
        date_created: new Date(),
        date_updated: new Date(),
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      }
    ])

    // * Restaurant Opening Hours
    return await queryInterface.bulkInsert('OpeningHours', [
      // * Example
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[0].resto_id,
        day: 'Monday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[0].resto_id,
        day: 'Tuesday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[0].resto_id,
        day: 'Wednesday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[0].resto_id,
        day: 'Thursday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[0].resto_id,
        day: 'Friday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[0].resto_id,
        day: 'Saturday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 1
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[1].resto_id,
        day: 'Monday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[1].resto_id,
        day: 'Tuesday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[1].resto_id,
        day: 'Wednesday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[1].resto_id,
        day: 'Thursday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[1].resto_id,
        day: 'Friday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[1].resto_id,
        day: 'Saturday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 2
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[2].resto_id,
        day: 'Monday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[2].resto_id,
        day: 'Tuesday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[2].resto_id,
        day: 'Wednesday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[2].resto_id,
        day: 'Thursday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[2].resto_id,
        day: 'Friday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[2].resto_id,
        day: 'Saturday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 3
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[3].resto_id,
        day: 'Monday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[3].resto_id,
        day: 'Tuesday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[3].resto_id,
        day: 'Wednesday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[3].resto_id,
        day: 'Thursday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[3].resto_id,
        day: 'Friday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[3].resto_id,
        day: 'Saturday',
        open_time: '08:30:00',
        close_time: '20:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 4
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[4].resto_id,
        day: 'Monday',
        open_time: '10:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[4].resto_id,
        day: 'Tuesday',
        open_time: '10:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[4].resto_id,
        day: 'Wednesday',
        open_time: '10:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[4].resto_id,
        day: 'Thursday',
        open_time: '10:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[4].resto_id,
        day: 'Friday',
        open_time: '10:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[4].resto_id,
        day: 'Saturday',
        open_time: '10:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 5
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[5].resto_id,
        day: 'Monday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[5].resto_id,
        day: 'Tuesday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[5].resto_id,
        day: 'Wednesday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[5].resto_id,
        day: 'Thursday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[5].resto_id,
        day: 'Friday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[5].resto_id,
        day: 'Saturday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 6
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[6].resto_id,
        day: 'Monday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[6].resto_id,
        day: 'Tuesday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[6].resto_id,
        day: 'Wednesday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[6].resto_id,
        day: 'Thursday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[6].resto_id,
        day: 'Friday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[6].resto_id,
        day: 'Saturday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 7
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[7].resto_id,
        day: 'Monday',
        open_time: '09:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[7].resto_id,
        day: 'Tuesday',
        open_time: '09:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[7].resto_id,
        day: 'Wednesday',
        open_time: '09:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[7].resto_id,
        day: 'Thursday',
        open_time: '09:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[7].resto_id,
        day: 'Friday',
        open_time: '09:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[7].resto_id,
        day: 'Saturday',
        open_time: '09:30:00',
        close_time: '21:30:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 8
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[8].resto_id,
        day: 'Monday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[8].resto_id,
        day: 'Tuesday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[8].resto_id,
        day: 'Wednesday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[8].resto_id,
        day: 'Thursday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[8].resto_id,
        day: 'Friday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[8].resto_id,
        day: 'Saturday',
        open_time: '10:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 9
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[9].resto_id,
        day: 'Monday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[9].resto_id,
        day: 'Tuesday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[9].resto_id,
        day: 'Wednesday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[9].resto_id,
        day: 'Thursday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[9].resto_id,
        day: 'Friday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[9].resto_id,
        day: 'Saturday',
        open_time: '08:00:00',
        close_time: '20:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      // * Restaurant 10
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[10].resto_id,
        day: 'Monday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[10].resto_id,
        day: 'Tuesday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[10].resto_id,
        day: 'Wednesday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[10].resto_id,
        day: 'Thursday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[10].resto_id,
        day: 'Friday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      },
      {
        openhrs_id: uuidv4(),
        resto_id: restaurantRows[10].resto_id,
        day: 'Saturday',
        open_time: '09:00:00',
        close_time: '21:00:00',
        created_by: '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
      }
    ])
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete('OpeningHours', null, {})
    await queryInterface.bulkDelete('Addresses', null, {})
    await queryInterface.bulkDelete('Restaurants', null, {})
    return await queryInterface.bulkDelete('RestoCategories', null, {})
  }
}
