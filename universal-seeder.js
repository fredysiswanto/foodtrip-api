/* eslint-disable no-console */
'use strict'

const db = require('./src/models')
const fs = require('fs')
const path = require('path')
const bcrypt = require('bcrypt')
const { v4: uuidv4 } = require('uuid')

class UniversalSeeder {
  constructor() {
    this.seedersPath = path.join(__dirname, 'src', 'database', 'seeders')
    this.dataPath = path.join(__dirname, 'seeder-data')
    this.systemAdminId = '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8'
  }

  async seedUsers() {
    console.log('👥 Seeding users...')

    // Ensure system admin exists first
    const systemAdmin = await db.User.findOne({
      where: { user_id: this.systemAdminId }
    })

    if (!systemAdmin) {
      await db.User.create({
        user_id: this.systemAdminId,
        user_no: 'USR-9999999999999',
        password: await bcrypt.hash('SysAdmin@123', 10),
        first_name: 'System',
        last_name: 'Admin',
        email_address: 'sysadmin@gmail.com',
        user_type: 'Admin',
        created_by: this.systemAdminId
      })
      console.log('✅ System admin created')
    }

    // Sample users data
    const users = [
      {
        user_type: 'Admin',
        first_name: 'Admin',
        last_name: 'User',
        email_address: 'admin@foodtrip.com',
        password: 'Admin@123',
        phone_number: '09123456789'
      },
      {
        user_type: 'Customer',
        first_name: 'John',
        last_name: 'Doe',
        email_address: 'john.doe@gmail.com',
        password: 'Customer@123',
        phone_number: '09123456790'
      },
      {
        user_type: 'Customer',
        first_name: 'Jane',
        last_name: 'Smith',
        email_address: 'jane.smith@gmail.com',
        password: 'Customer@123',
        phone_number: '09123456791'
      },
      {
        user_type: 'Resto_Admin',
        first_name: 'Restaurant',
        last_name: 'Owner',
        email_address: 'owner@restaurant.com',
        password: 'Resto@123',
        phone_number: '09123456792'
      }
    ]

    let created = 0

    for (const userData of users) {
      try {
        // Check if user already exists
        const existingUser = await db.User.findOne({
          where: { email_address: userData.email_address }
        })

        if (!existingUser) {
          await db.User.create({
            user_id: uuidv4(),
            user_no:
              `USR-${Date.now()}-${Math.floor(Math.random() * 1000)}`.padEnd(
                17,
                '0'
              ),
            password: await bcrypt.hash(userData.password, 10),
            first_name: userData.first_name,
            last_name: userData.last_name,
            email_address: userData.email_address,
            user_type: userData.user_type,
            phone_number: userData.phone_number,
            created_by: this.systemAdminId
          })
          created++
        }
      } catch (error) {
        console.error(
          `❌ Error creating user ${userData.email_address}:`,
          error.message
        )
      }
    }

    console.log(`✅ Created ${created} new users`)
    return created
  }

  async seedRestaurantCategories() {
    console.log('🏪 Seeding restaurant categories...')

    const categories = [
      'Fast Food',
      'Fine Dining',
      'Casual Dining',
      'Cafe',
      'Bakery',
      'Street Food',
      'Buffet',
      'Food Truck',
      'Bar & Grill',
      'Pizza',
      'Asian Cuisine',
      'Mexican',
      'Italian',
      'American',
      'Seafood'
    ]

    let created = 0

    for (const categoryName of categories) {
      try {
        const existingCategory = await db.RestoCategory.findOne({
          where: { restocatg_name: categoryName }
        })

        if (!existingCategory) {
          await db.RestoCategory.create({
            restocatg_id: uuidv4(),
            restocatg_name: categoryName,
            created_by: this.systemAdminId
          })
          created++
        }
      } catch (error) {
        console.error(
          `❌ Error creating category ${categoryName}:`,
          error.message
        )
      }
    }

    console.log(`✅ Created ${created} new restaurant categories`)
    return created
  }

  async seedDishCategories() {
    console.log('🍽️ Seeding dish categories...')

    const categories = [
      'Appetizers',
      'Soups',
      'Salads',
      'Main Course',
      'Desserts',
      'Beverages',
      'Pasta',
      'Rice Dishes',
      'Noodles',
      'Grilled',
      'Fried',
      'Steamed',
      'Baked',
      'Vegetarian',
      'Vegan',
      'Gluten-Free',
      'Spicy',
      'Seafood',
      'Meat',
      'Chicken'
    ]

    let created = 0

    for (const categoryName of categories) {
      try {
        const existingCategory = await db.DishCategory.findOne({
          where: { dishcatg_name: categoryName }
        })

        if (!existingCategory) {
          await db.DishCategory.create({
            dishcatg_id: uuidv4(),
            dishcatg_name: categoryName,
            created_by: this.systemAdminId
          })
          created++
        }
      } catch (error) {
        console.error(
          `❌ Error creating category ${categoryName}:`,
          error.message
        )
      }
    }

    console.log(`✅ Created ${created} new dish categories`)
    return created
  }

  async seedRestaurants() {
    console.log('🏪 Seeding restaurants...')

    // Get restaurant categories
    const categories = await db.RestoCategory.findAll()
    if (categories.length === 0) {
      console.log(
        '❌ No restaurant categories found. Run category seeder first.'
      )
      return 0
    }

    // Get a restaurant admin
    const restoAdmin = await db.User.findOne({
      where: { user_type: 'Resto_Admin' }
    })

    if (!restoAdmin) {
      console.log('❌ No restaurant admin found. Run user seeder first.')
      return 0
    }

    const restaurants = [
      {
        resto_name: 'The Golden Spoon',
        resto_address: '123 Main Street, City Center',
        resto_phone: '09123456793',
        resto_email: 'info@goldenspoon.com',
        resto_description: 'Fine dining experience with international cuisine'
      },
      {
        resto_name: 'Pizza Palace',
        resto_address: '456 Food Avenue, Downtown',
        resto_phone: '09123456794',
        resto_email: 'orders@pizzapalace.com',
        resto_description: 'Authentic Italian pizzas and pasta'
      },
      {
        resto_name: 'Burger Barn',
        resto_address: '789 Fast Lane, Mall Area',
        resto_phone: '09123456795',
        resto_email: 'contact@burgerbarn.com',
        resto_description: 'Gourmet burgers and fast food favorites'
      }
    ]

    let created = 0

    for (const restoData of restaurants) {
      try {
        const existingResto = await db.Restaurant.findOne({
          where: { resto_name: restoData.resto_name }
        })

        if (!existingResto) {
          await db.Restaurant.create({
            resto_id: uuidv4(),
            resto_name: restoData.resto_name,
            resto_address: restoData.resto_address,
            resto_phone: restoData.resto_phone,
            resto_email: restoData.resto_email,
            resto_description: restoData.resto_description,
            restocatg_id:
              categories[Math.floor(Math.random() * categories.length)]
                .restocatg_id,
            user_id: restoAdmin.user_id,
            created_by: this.systemAdminId
          })
          created++
        }
      } catch (error) {
        console.error(
          `❌ Error creating restaurant ${restoData.resto_name}:`,
          error.message
        )
      }
    }

    console.log(`✅ Created ${created} new restaurants`)
    return created
  }

  async seedDishes() {
    console.log('🍽️ Seeding dishes...')

    // Get dish categories
    const dishCategories = await db.DishCategory.findAll()
    if (dishCategories.length === 0) {
      console.log('❌ No dish categories found. Run category seeder first.')
      return 0
    }

    // Get restaurants
    const restaurants = await db.Restaurant.findAll()
    if (restaurants.length === 0) {
      console.log('❌ No restaurants found. Run restaurant seeder first.')
      return 0
    }

    const dishes = [
      {
        dish_name: 'Grilled Chicken Breast',
        dish_desc: 'Tender grilled chicken with herbs and spices',
        dish_price: 250.0,
        dish_img: 'grilled-chicken.png',
        status: 'Available'
      },
      {
        dish_name: 'Margherita Pizza',
        dish_desc: 'Classic pizza with tomato sauce, mozzarella, and basil',
        dish_price: 380.0,
        dish_img: 'margherita-pizza.png',
        status: 'Available'
      },
      {
        dish_name: 'Caesar Salad',
        dish_desc: 'Fresh romaine lettuce with Caesar dressing and croutons',
        dish_price: 180.0,
        dish_img: 'caesar-salad.png',
        status: 'Available'
      },
      {
        dish_name: 'Chocolate Cake',
        dish_desc: 'Rich chocolate cake with chocolate frosting',
        dish_price: 150.0,
        dish_img: 'chocolate-cake.png',
        status: 'Available'
      },
      {
        dish_name: 'Beef Burger',
        dish_desc: 'Juicy beef patty with lettuce, tomato, and cheese',
        dish_price: 200.0,
        dish_img: 'beef-burger.png',
        status: 'Available'
      },
      {
        dish_name: 'Spaghetti Carbonara',
        dish_desc: 'Creamy pasta with bacon, eggs, and parmesan cheese',
        dish_price: 220.0,
        dish_img: 'spaghetti-carbonara.png',
        status: 'Available'
      },
      {
        dish_name: 'Fish and Chips',
        dish_desc: 'Beer-battered fish with crispy fries and tartar sauce',
        dish_price: 280.0,
        dish_img: 'fish-and-chips.png',
        status: 'Available'
      },
      {
        dish_name: 'Chicken Curry',
        dish_desc: 'Spicy chicken curry with aromatic spices and coconut milk',
        dish_price: 240.0,
        dish_img: 'chicken-curry.png',
        status: 'Available'
      },
      {
        dish_name: 'Vegetable Stir Fry',
        dish_desc: 'Mixed vegetables stir-fried with soy sauce and garlic',
        dish_price: 160.0,
        dish_img: 'vegetable-stir-fry.png',
        status: 'Available'
      },
      {
        dish_name: 'Ice Cream Sundae',
        dish_desc: 'Vanilla ice cream with chocolate sauce and whipped cream',
        dish_price: 120.0,
        dish_img: 'ice-cream-sundae.png',
        status: 'Available'
      }
    ]

    let created = 0

    for (const dishData of dishes) {
      try {
        const existingDish = await db.Dish.findOne({
          where: { dish_name: dishData.dish_name }
        })

        if (!existingDish) {
          await db.Dish.create({
            dish_id: uuidv4(),
            dish_no:
              `DSH-${Date.now()}-${Math.floor(Math.random() * 1000)}`.padEnd(
                17,
                '0'
              ),
            dish_name: dishData.dish_name,
            dish_desc: dishData.dish_desc,
            dish_price: dishData.dish_price,
            dish_img: dishData.dish_img,
            status: dishData.status,
            dishcatg_id:
              dishCategories[Math.floor(Math.random() * dishCategories.length)]
                .dishcatg_id,
            resto_id:
              restaurants[Math.floor(Math.random() * restaurants.length)]
                .resto_id,
            created_by: this.systemAdminId
          })
          created++
        }
      } catch (error) {
        console.error(
          `❌ Error creating dish ${dishData.dish_name}:`,
          error.message
        )
      }
    }

    console.log(`✅ Created ${created} new dishes`)
    return created
  }

  async seedAll() {
    console.log('🚀 Starting universal seeding process...')

    const results = {
      users: await this.seedUsers(),
      restoCategories: await this.seedRestaurantCategories(),
      dishCategories: await this.seedDishCategories(),
      restaurants: await this.seedRestaurants(),
      dishes: await this.seedDishes()
    }

    console.log('\n📊 Seeding Results:')
    console.log(`   Users: ${results.users}`)
    console.log(`   Restaurant Categories: ${results.restoCategories}`)
    console.log(`   Dish Categories: ${results.dishCategories}`)
    console.log(`   Restaurants: ${results.restaurants}`)
    console.log(`   Dishes: ${results.dishes}`)

    const total = Object.values(results).reduce((sum, count) => sum + count, 0)
    console.log(`\n✅ Total records created: ${total}`)

    return results
  }

  async clearAll() {
    console.log('🗑️ Clearing all seeded data...')

    try {
      // Clear in reverse order to avoid foreign key constraints
      await db.Dish.destroy({ where: {} })
      await db.Restaurant.destroy({ where: {} })
      await db.DishCategory.destroy({ where: {} })
      await db.RestoCategory.destroy({ where: {} })
      await db.User.destroy({
        where: {
          user_id: { [db.Sequelize.Op.ne]: this.systemAdminId }
        }
      })

      console.log('✅ All seeded data cleared')
      return true
    } catch (error) {
      console.error('❌ Error clearing data:', error.message)
      return false
    }
  }

  async status() {
    console.log('📊 Database Status:')

    const counts = {
      users: await db.User.count(),
      restoCategories: await db.RestoCategory.count(),
      dishCategories: await db.DishCategory.count(),
      restaurants: await db.Restaurant.count(),
      dishes: await db.Dish.count()
    }

    console.log(`   Users: ${counts.users}`)
    console.log(`   Restaurant Categories: ${counts.restoCategories}`)
    console.log(`   Dish Categories: ${counts.dishCategories}`)
    console.log(`   Restaurants: ${counts.restaurants}`)
    console.log(`   Dishes: ${counts.dishes}`)

    return counts
  }
}

async function main() {
  const args = process.argv.slice(2)
  const command = args[0]

  const seeder = new UniversalSeeder()

  switch (command) {
  case 'users': {
    await seeder.seedUsers()
    process.exit(0)
  }
  // eslint-disable-next-line no-fallthrough
  case 'resto-categories': {
    await seeder.seedRestaurantCategories()
    process.exit(0)
  }
  // eslint-disable-next-line no-fallthrough
  case 'dish-categories': {
    await seeder.seedDishCategories()
    process.exit(0)
  }
  // eslint-disable-next-line no-fallthrough
  case 'restaurants': {
    await seeder.seedRestaurants()
    process.exit(0)
  }
  // eslint-disable-next-line no-fallthrough
  case 'dishes': {
    await seeder.seedDishes()
    process.exit(0)
  }
  // eslint-disable-next-line no-fallthrough
  case 'all': {
    await seeder.seedAll()
    process.exit(0)
  }
  // eslint-disable-next-line no-fallthrough
  case 'clear': {
    await seeder.clearAll()
    process.exit(0)
  }
  // eslint-disable-next-line no-fallthrough
  case 'status': {
    await seeder.status()
    process.exit(0)
  }
  // eslint-disable-next-line no-fallthrough
  default: {
    console.log(`
🌱 Universal Seeder

Usage: node universal-seeder.js <command>

Commands:
  users              Seed user data
  resto-categories   Seed restaurant categories
  dish-categories    Seed dish categories
  restaurants        Seed restaurant data
  dishes             Seed dish data
  all                Seed all data
  clear              Clear all seeded data
  status             Show database status

Examples:
  node universal-seeder.js all
  node universal-seeder.js users
  node universal-seeder.js status
  node universal-seeder.js clear
      `)
    process.exit(0)
  }
  }
}

if (require.main === module) {
  main().catch(error => {
    console.error('❌ Universal seeder failed:', error.message)
    process.exit(1)
  })
}

module.exports = UniversalSeeder
