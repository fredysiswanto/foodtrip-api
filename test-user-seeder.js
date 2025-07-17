/* eslint-disable no-console */
const db = require('./src/models')
const bcrypt = require('bcrypt')

async function testUserSeeder() {
  try {
    console.log('🔄 Testing user seeder data...')

    // Test single user data
    const testUser = {
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
    }

    console.log('Test user data:', testUser)

    // Validate user_no length
    console.log('user_no length:', testUser.user_no.length)

    // Test phone number regex if exists
    if (testUser.phone_number) {
      const phoneRegex = /^(09|\+639)\d{9}$/
      console.log('Phone validation:', phoneRegex.test(testUser.phone_number))
    }

    // Test user_type validation
    const validUserTypes = ['Customer', 'Resto_Admin', 'Admin']
    console.log('User type valid:', validUserTypes.includes(testUser.user_type))

    // Test gender validation
    if (testUser.gender) {
      const validGenders = ['Male', 'Female', 'Others']
      console.log('Gender valid:', validGenders.includes(testUser.gender))
    }

    // Try to create user
    const user = await db.User.create(testUser)
    console.log('✅ User created successfully:', user.user_id)

    // Clean up
    await db.User.destroy({ where: { user_id: user.user_id }, force: true })
    console.log('✅ Test user cleaned up')
  } catch (error) {
    console.error('❌ Error:', error.message)
    if (error.errors) {
      error.errors.forEach(err => {
        console.error(
          '   - Validation error:',
          err.message,
          'for field:',
          err.path
        )
      })
    }
  }
}

// Run test
testUserSeeder()
  .then(() => {
    console.log('Test completed')
    process.exit(0)
  })
  .catch(error => {
    console.error('Test failed:', error)
    process.exit(1)
  })
