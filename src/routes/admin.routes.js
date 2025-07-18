const router = require('express').Router()

const restaurantCtl = require('../controllers/admin/restaurants.controller')
router.get('/restaurants', restaurantCtl.getAllRestaurants)
router.get('/restaurant/:restoID', restaurantCtl.getRestaurant)
router.get('/resto-cat', restaurantCtl.getAllRestoCat)
router.get('/resto-cat/:restoCatID', restaurantCtl.getRestoCat)

const dishCtl = require('../controllers/admin/dishes.controller')
router.get('/dishes', dishCtl.getAllDishes)
router.get('/dish-cat', dishCtl.getAllDishCat)
router.get('/dish/:dishID', dishCtl.getDish)
router.get('/dish-cat/:dishCatID', dishCtl.getDishCat)

const addressCtl = require('../controllers/admin/addresses.controller')
router.get('/address', addressCtl.getAllAddress)
router.get('/address/:addressID', addressCtl.getAddress)

const userCtl = require('../controllers/admin/user.controller')
router.get('/user/resto-admin', userCtl.getAllRestoAdmin)
router.get('/user/resto-admin/:restoAdminID', userCtl.getRestoAdmin)
router.get('/user/customer', userCtl.getAllCustomer)
router.get('/user/customer/:customerID', userCtl.getCustomer)
router.get('/user/admin', userCtl.getAllAdmin)
router.get('/user/admin/:adminID', userCtl.getAdmin)

const acctInfoCtl = require('../controllers/admin/acc_info.controller')
router.get('/account/info', acctInfoCtl.getAccountInfo)
router.put('/account/info', acctInfoCtl.updateAcctInfo)
router.post('/account/verify-password', acctInfoCtl.verifyPassword)
router.put('/account/password', acctInfoCtl.updatePassword)

const orderCtl = require('../controllers/admin/orders.controller')
router.get('/orders', orderCtl.getAllOrders)
router.get('/order/:orderID', orderCtl.getOrder)

const courierCtl = require('../controllers/admin/couriers.controller')
router.get('/couriers', courierCtl.getAllCouriers)

const deliveryCtl = require('../controllers/admin/deliveries.controller')
router.get('/deliveries', deliveryCtl.getAllDeliveries)

module.exports = router
