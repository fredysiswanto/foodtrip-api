'use strict'
const { v4: uuidv4 } = require('uuid')

module.exports = {
  async up(queryInterface, Sequelize) {
    const restaurants = await queryInterface.sequelize.query(
      'SELECT resto_id FROM restaurants ORDER BY restaurants.resto_no ASC;',
      { type: Sequelize.QueryTypes.SELECT }
    )

    if (restaurants.length < 21) {
      throw new Error(
        'Not enough restaurants to assign addresses. Require at least 21.'
      )
    }

    const rawAddresses = [
      {
        address_1: 'Plaza Nova Bldg.',
        address_2: 'Santiago Blvd.',
        barangay: 'Barangay Dadiangas South',
        city: 'General Santos City',
        province: 'South Cotabato',
        region: 'SOCCSKSARGEN',
        zip_code: '9500',
        resto_index: 11
      },
      {
        address_1: 'Edsa Central Pavillion',
        address_2: 'Unite Street corner Edsa',
        barangay: '46 Commonwealth Ave',
        city: 'Mandaluyong City',
        province: 'Metro Manila',
        region: 'NCR',
        zip_code: '1550',
        resto_index: 12
      },
      {
        address_1: '11 Seattle Street',
        address_2: 'Immaculate Conception 1109',
        barangay: 'San Martin de Porres',
        city: 'Quezon City',
        province: 'Metro Manila',
        region: 'NCR',
        zip_code: '1713',
        resto_index: 13
      },
      {
        address_1: '1119-D J P Rizal 1200',
        address_2: null,
        barangay: 'Barangka Ilaya',
        city: 'Makati City',
        province: 'Metro Manila',
        region: 'NCR',
        zip_code: '1550',
        resto_index: 14
      },
      {
        address_1: 'Domingo Street',
        address_2: 'Cubao',
        barangay: 'San Martin de Porres',
        city: 'Quezon City',
        province: 'Metro Manila',
        region: 'NCR',
        zip_code: '1713',
        resto_index: 15
      },
      {
        address_1: '34 East Drive Hts.',
        address_2: 'Concepcion 1811',
        barangay: 'Marikina Heights',
        city: 'Marikina City',
        province: 'NCR',
        region: 'NCR',
        zip_code: '1810',
        resto_index: 16
      },
      {
        address_1: '9696 Kamagong Street',
        address_2: 'San Antonio Village',
        barangay: 'Palanan',
        city: 'Makati City',
        province: 'Metro Manila',
        region: 'NCR',
        zip_code: '1235',
        resto_index: 17
      },
      {
        address_1: '894 Quezon Boulevard 1000',
        address_2: 'Ermita',
        barangay: 'Brgy. 395',
        city: 'Sampaloc',
        province: 'Manila',
        region: 'NCR',
        zip_code: '1008',
        resto_index: 18
      },
      {
        address_1: 'A. Bonifacio Street',
        address_2: 'Ilaya',
        barangay: 'Lumangbayan',
        city: 'Calapan City',
        province: 'Oriental Mindoro',
        region: 'Mimaropa',
        zip_code: '5208',
        resto_index: 19
      },
      {
        address_1: 'H3J8+6WC, St. Paul College',
        address_2: 'St. Paul St.',
        barangay: 'Caniogan',
        city: 'Pasig City',
        province: 'Metro Manila',
        region: 'NCR',
        zip_code: '1606',
        resto_index: 20
      }
    ]

    const createdBy = '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
    const now = new Date()

    const addressToInsert = []

    for (const raw of rawAddresses) {
      const resto_id = restaurants[raw.resto_index]?.resto_id
      if (!resto_id) continue

      // Cek apakah address_1 & resto_id sudah ada
      const exists = await queryInterface.sequelize.query(
        'SELECT 1 FROM "Addresses" WHERE address_1 = :address_1 AND resto_id = :resto_id LIMIT 1',
        {
          replacements: {
            address_1: raw.address_1,
            resto_id: resto_id
          },
          type: Sequelize.QueryTypes.SELECT
        }
      )

      if (exists.length === 0) {
        addressToInsert.push({
          address_id: uuidv4(),
          address_1: raw.address_1,
          address_2: raw.address_2,
          barangay: raw.barangay,
          city: raw.city,
          province: raw.province,
          region: raw.region,
          zip_code: raw.zip_code,
          is_default: '1',
          resto_id: resto_id,
          date_created: now,
          date_updated: now,
          created_by: createdBy
        })
      }
    }

    if (addressToInsert.length > 0) {
      await queryInterface.bulkInsert('Addresses', addressToInsert)
      console.log(`✅ Inserted ${addressToInsert.length} new address records.`)
    } else {
      console.log('⚠️ No new addresses inserted (all exist).')
    }
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete('Addresses', {
      address_1: [
        'Plaza Nova Bldg.',
        'Edsa Central Pavillion',
        '11 Seattle Street',
        '1119-D J P Rizal 1200',
        'Domingo Street',
        '34 East Drive Hts.',
        '9696 Kamagong Street',
        '894 Quezon Boulevard 1000',
        'A. Bonifacio Street',
        'H3J8+6WC, St. Paul College'
      ]
    })
  }
}
