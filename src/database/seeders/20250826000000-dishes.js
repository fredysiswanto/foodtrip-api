'use strict'
const { v4: uuidv4 } = require('uuid')

module.exports = {
  async up(queryInterface, Sequelize) {
    try {
      // Check if dishes already exist
      const existingDishes = await queryInterface.sequelize.query(
        'SELECT COUNT(*) as count FROM "Dishes"',
        { type: Sequelize.QueryTypes.SELECT }
      )

      if (existingDishes[0].count > 0) {
        console.log('ℹ️  Dishes already exist, skipping seeder')
        return
      }

      console.log('🔄 Creating dishes...')

      // Get existing dish categories
      const dishCategories = await queryInterface.sequelize.query(
        'SELECT dishcatg_id FROM "DishCategories" ORDER BY dishcatg_name ASC',
        { type: Sequelize.QueryTypes.SELECT }
      )

      // Get existing restaurants
      const restaurants = await queryInterface.sequelize.query(
        'SELECT resto_id FROM "Restaurants" ORDER BY resto_name ASC',
        { type: Sequelize.QueryTypes.SELECT }
      )

      if (dishCategories.length === 0) {
        throw new Error(
          'No dish categories found. Please run dish categories seeder first.'
        )
      }

      if (restaurants.length === 0) {
        throw new Error(
          'No restaurants found. Please run restaurant seeder first.'
        )
      }

      const createdBy = '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8' // Admin user ID
      const now = new Date()

      // Generate dish number helper function
      const generateDishNo = index => {
        return `DISH-${String(index + 1).padStart(12, '0')}`
      }

      const dishes = [
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(0),
          dish_name: 'Margherita Pizza',
          dish_desc:
            'Classic Italian pizza with fresh tomatoes, mozzarella cheese, and basil leaves on a thin crust.',
          dish_price: 15.99,
          dish_img: 'margherita_pizza.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(1),
          dish_name: 'Grilled Chicken Breast',
          dish_desc:
            'Tender grilled chicken breast seasoned with herbs and spices, served with steamed vegetables.',
          dish_price: 18.5,
          dish_img: 'grilled_chicken_breast.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(2),
          dish_name: 'Caesar Salad',
          dish_desc:
            'Fresh romaine lettuce tossed with Caesar dressing, croutons, and parmesan cheese.',
          dish_price: 12.75,
          dish_img: 'caesar_salad.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(3),
          dish_name: 'Beef Burger Deluxe',
          dish_desc:
            'Juicy beef patty with lettuce, tomato, onion, cheese, and special sauce on a sesame bun.',
          dish_price: 16.25,
          dish_img: 'beef_burger_deluxe.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(4),
          dish_name: 'Spaghetti Carbonara',
          dish_desc:
            'Creamy pasta with bacon, eggs, parmesan cheese, and black pepper.',
          dish_price: 14.99,
          dish_img: 'spaghetti_carbonara.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(5),
          dish_name: 'Fish and Chips',
          dish_desc:
            'Beer-battered fish fillet served with crispy fries and tartar sauce.',
          dish_price: 17.5,
          dish_img: 'fish_and_chips.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(6),
          dish_name: 'Chocolate Lava Cake',
          dish_desc:
            'Warm chocolate cake with a molten chocolate center, served with vanilla ice cream.',
          dish_price: 8.99,
          dish_img: 'chocolate_lava_cake.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(7),
          dish_name: 'Thai Green Curry',
          dish_desc:
            'Spicy green curry with coconut milk, vegetables, and your choice of meat.',
          dish_price: 19.25,
          dish_img: 'thai_green_curry.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(8),
          dish_name: 'Mushroom Risotto',
          dish_desc:
            'Creamy Italian rice dish with mixed mushrooms and parmesan cheese.',
          dish_price: 16.75,
          dish_img: 'mushroom_risotto.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(9),
          dish_name: 'BBQ Ribs',
          dish_desc:
            'Tender pork ribs glazed with barbecue sauce, served with coleslaw and fries.',
          dish_price: 22.99,
          dish_img: 'bbq_ribs.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(10),
          dish_name: 'Tuna Sashimi',
          dish_desc:
            'Fresh raw tuna slices served with wasabi, pickled ginger, and soy sauce.',
          dish_price: 24.5,
          dish_img: 'tuna_sashimi.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(11),
          dish_name: 'Vegetable Stir Fry',
          dish_desc:
            'Fresh mixed vegetables stir-fried with garlic, ginger, and soy sauce.',
          dish_price: 13.25,
          dish_img: 'vegetable_stir_fry.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(12),
          dish_name: 'Chicken Tacos',
          dish_desc:
            'Three soft tacos filled with seasoned chicken, lettuce, tomato, and cheese.',
          dish_price: 11.99,
          dish_img: 'chicken_tacos.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(13),
          dish_name: 'Lamb Chops',
          dish_desc:
            'Grilled lamb chops with rosemary and garlic, served with roasted potatoes.',
          dish_price: 28.75,
          dish_img: 'lamb_chops.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(14),
          dish_name: 'Pancakes with Syrup',
          dish_desc:
            'Stack of fluffy pancakes served with butter and maple syrup.',
          dish_price: 9.5,
          dish_img: 'pancakes_syrup.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(15),
          dish_name: 'Iced Coffee',
          dish_desc:
            'Refreshing cold brew coffee served over ice with cream and sugar.',
          dish_price: 4.75,
          dish_img: 'iced_coffee.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(16),
          dish_name: 'Seafood Paella',
          dish_desc:
            'Traditional Spanish rice dish with mixed seafood, saffron, and vegetables.',
          dish_price: 26.99,
          dish_img: 'seafood_paella.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(17),
          dish_name: 'Buffalo Wings',
          dish_desc:
            'Spicy chicken wings served with blue cheese dip and celery sticks.',
          dish_price: 13.99,
          dish_img: 'buffalo_wings.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(18),
          dish_name: 'Tiramisu',
          dish_desc:
            'Classic Italian dessert with coffee-soaked ladyfingers and mascarpone cream.',
          dish_price: 7.5,
          dish_img: 'tiramisu.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        },
        {
          dish_id: uuidv4(),
          dish_no: generateDishNo(19),
          dish_name: 'Pork Adobo',
          dish_desc:
            'Traditional Filipino dish with pork braised in vinegar, soy sauce, and spices.',
          dish_price: 15.25,
          dish_img: 'pork_adobo.jpg',
          status: 'Available',
          dishcatg_id:
            dishCategories[Math.floor(Math.random() * dishCategories.length)]
              .dishcatg_id,
          resto_id:
            restaurants[Math.floor(Math.random() * restaurants.length)]
              .resto_id,
          created_by: createdBy,
          date_created: now,
          date_updated: now
        }
      ]

      await queryInterface.bulkInsert('Dishes', dishes)
      console.log(`✅ Successfully created ${dishes.length} dishes`)
    } catch (error) {
      console.error('❌ Error creating dishes:', error.message)
      throw error
    }
  },

  async down(queryInterface, Sequelize) {
    try {
      console.log('🔄 Removing all dishes...')
      await queryInterface.bulkDelete('Dishes', null, {})
      console.log('✅ Successfully removed all dishes')
    } catch (error) {
      console.error('❌ Error removing dishes:', error.message)
      throw error
    }
  }
}
