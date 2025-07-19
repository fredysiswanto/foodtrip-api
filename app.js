/* eslint-disable no-console */
const express = require('express')
const dotenv = require('dotenv')
const db = require('./src/models')
const jwt = require('jsonwebtoken')
const path = require('path')
const cors = require('cors')
const { processMessage } = require('./src/helpers/ollamaHelper')
const DatabaseHelper = require('./src/helpers/databaseHelper')

// * Get config variables
dotenv.config()

// * Database setup and connection
async function initializeDatabase() {
  try {
    console.log('🔗 Connecting to database...')

    // * Authenticate Database connection
    await db.sequelize.authenticate()
    console.log('✅ Database connection established successfully.')

    // * Auto setup database if needed
    if (process.env.AUTO_SETUP_DB === 'true') {
      console.log('🔄 Auto setup database is enabled')
      await DatabaseHelper.autoSetupDatabase()
    } else {
      // * Manual sync if ALLOW_SYNC is enabled
      if (process.env.ALLOW_SYNC === 'true') {
        console.log('🔄 Syncing database tables...')
        await db.sequelize.sync({ alter: true })
        console.log('✅ Database sync completed.')
      }
    }
    if (process.env.NODE_ENV === 'development') {
      const dbStatus = await DatabaseHelper.getDatabaseStatus()
      console.log('📊 Database Status:')
      console.log(`   Connected: ${dbStatus.connected ? '✅' : '❌'}`)
      console.log(`   Tables: ${dbStatus.tablesExist ? '✅' : '❌'}`)
      console.log(`   Migrations: ${dbStatus.migrationsExist ? '✅' : '❌'}`)
      console.log(`   Seed Data: ${dbStatus.seedersExist ? '✅' : '❌'}`)
    }

    // * Display database status
  } catch (error) {
    console.error('❌ Database initialization failed:', error.message)
    console.error(
      '⚠️  Server will continue but database features may not work properly'
    )
  }
}

// * Initialize database on startup
initializeDatabase()

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

  if (token === null) return res.sendStatus(401)

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

// * Database management endpoints
app.get('/api/database/status', async (req, res) => {
  try {
    const status = await DatabaseHelper.getDatabaseStatus()
    res.json({
      success: true,
      data: status
    })
  } catch (error) {
    console.error('Error getting database status:', error)
    res.status(500).json({
      success: false,
      error: 'Failed to get database status'
    })
  }
})

app.post('/api/database/migrate', async (req, res) => {
  try {
    const success = await DatabaseHelper.runMigrations()
    res.json({
      success,
      message: success ? 'Migration completed successfully' : 'Migration failed'
    })
  } catch (error) {
    console.error('Error running migrations:', error)
    res.status(500).json({
      success: false,
      error: 'Failed to run migrations'
    })
  }
})

app.post('/api/database/seed', async (req, res) => {
  try {
    const success = await DatabaseHelper.runSeeders()
    res.json({
      success,
      message: success ? 'Seeding completed successfully' : 'Seeding failed'
    })
  } catch (error) {
    console.error('Error running seeders:', error)
    res.status(500).json({
      success: false,
      error: 'Failed to run seeders'
    })
  }
})

app.post('/api/database/setup', async (req, res) => {
  try {
    const success = await DatabaseHelper.autoSetupDatabase()
    res.json({
      success,
      message: success
        ? 'Database setup completed successfully'
        : 'Database setup failed'
    })
  } catch (error) {
    console.error('Error setting up database:', error)
    res.status(500).json({
      success: false,
      error: 'Failed to setup database'
    })
  }
})

// * Start Server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`)
})
