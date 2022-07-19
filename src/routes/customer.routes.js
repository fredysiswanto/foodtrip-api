var router = require('express').Router();

var restaurantCtl = require('../controllers/customer/restaurants.controller');
router.get('/restaurants', restaurantCtl.getAllRestaurants);
router.get('/restaurant/:restoID', restaurantCtl.getRestaurant);
router.get('/resto-cat', restaurantCtl.getAllRestoCat);
router.get('/resto-cat/:restoCatID', restaurantCtl.getRestoCat);

var dishCtl = require('../controllers/customer/dishes.controller');
router.get('/dishes', dishCtl.getAllDishes);
router.get('/dish-cat', dishCtl.getAllDishCat);
router.get('/dish/:dishID', dishCtl.getDish);
router.get('/dish-cat/:dishCatID', dishCtl.getDishCat);

var addressCtl = require('../controllers/customer/addresses.controller');
router.post('/address', addressCtl.createAddress);
router.get('/address', addressCtl.getAllAddress);
router.get('/address/:addressID', addressCtl.getAddress);
router.put('/address/:addressID', addressCtl.updateAddress);
router.put('/address/default/:addressID', addressCtl.updateDefaultAddress);
router.delete('/address/:addressID', addressCtl.deleteAddress);

var acctInfoCtl = require('../controllers/customer/acc_info.controller');
router.get('/account/info', acctInfoCtl.getAccountInfo);
router.put('/account/info', acctInfoCtl.updateAcctInfo);
router.post('/account/verify-password', acctInfoCtl.verifyPassword);
router.put('/account/password', acctInfoCtl.updatePassword);

module.exports = router;
