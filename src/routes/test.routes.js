const router = require('express').Router()

const testCtlr = require('../controllers/test.controller')
router.get('/', testCtlr.testing)

module.exports = router
