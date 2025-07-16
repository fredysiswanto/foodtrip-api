const router = require('express').Router()
const { uploadRestoImage } = require('../middlewares/uploadImage')

const loginCtlr = require('../controllers/home/login.controller')
router.post('/login', loginCtlr.login)

const registerCtlr = require('../controllers/home/register.controller')
router.post('/register/customer', registerCtlr.customer)
router.post('/register/resto-admin', registerCtlr.restoAdmin)
router.post('/register/restaurant', uploadRestoImage, registerCtlr.restaurant)
router.post('/register/admin', registerCtlr.admin)

const dishCat = require('../controllers/all/dish_cat.controller')
router.get('/dishes', dishCat.getAllDishes)
router.get('/dish-cat', dishCat.getAllDishCat)
router.get('/dish-cat/:dishCatID', dishCat.getDishCat)

const restaurant = require('../controllers/all/restaurants.controller')
router.get('/restaurants', restaurant.getAllRestaurants)
router.get('/restaurant/:restoID', restaurant.getRestaurant)

const restoCat = require('../controllers/all/resto_cat.controller.js')
router.get('/resto-categories', restoCat.getAllRestoCat)
router.get('/resto-category/:restoCatID', restoCat.getRestoCat)

module.exports = router
