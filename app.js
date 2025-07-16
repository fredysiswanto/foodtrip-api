/* eslint-disable no-console */
const express = require('express')
const dotenv = require('dotenv')
const db = require('./src/models')
const jwt = require('jsonwebtoken')
const path = require('path')
const cors = require('cors')
const { processMessage } = require('./src/helpers/ollamaHelper')
// * Get config variables
dotenv.config()

// * Authenticate Database connection
db.sequelize
  .authenticate()
  .then(() => {
    console.log('Connection has been established successfully.')
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err)
  })

// * Sync Database tables
if (process.env.ALLOW_SYNC === 'true') {
  db.sequelize
    .sync({ alter: true })
    .then(() =>
      console.log('Done adding/updating the database based on the Models.')
    )
}

// * Initialize express
const app = express()
const PORT = process.env.PORT || 5000

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(cors())

// * Middleware untuk autentikasi JWT
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers.authorization
  const token = authHeader && authHeader.split(' ')[1]

  if (token == null) return res.sendStatus(401)

  jwt.verify(token, process.env.TOKEN_SECRET, (err, user) => {
    if (err) return res.sendStatus(403)
    req.user = user
    next()
  })
}

// * Static files
// eslint-disable-next-line n/no-path-concat
app.use('/public', express.static(path.join(`${__dirname}/public/uploads/`)))

// * Routes
app.use(`${process.env.API_VERSION}/home`, require('./src/routes/home.routes'))
app.use(`${process.env.API_VERSION}/test`, require('./src/routes/test.routes'))
app.use(
  `${process.env.API_VERSION}/resto-admin`,
  authenticateToken,
  require('./src/routes/resto_admin.routes')
)
app.use(
  `${process.env.API_VERSION}/admin`,
  authenticateToken,
  require('./src/routes/admin.routes')
)
app.use(
  `${process.env.API_VERSION}/customer`,
  authenticateToken,
  require('./src/routes/customer.routes')
)

app.post('/chat', async (req, res) => {
  try {
    const messageData = req.body
    if (!messageData.message) {
      return res.status(400).json({ error: 'Message is required' })
    }

    const response = await processMessage(messageData)
    // console.log(response);

    res.json({ responseData: response })
  } catch (error) {
    console.error('Error processing chat:', error)
    res.status(500).json({ error: 'Failed to process chat request' })
  }
})

// * Start Server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`)
})
