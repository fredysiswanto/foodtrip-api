/* eslint-disable no-console */
const express = require('express')
const dotenv = require('dotenv')
const db = require('./src/models')
const jwt = require('jsonwebtoken')
const path = require('path')
const cors = require('cors')
const { processMessage } = require('./src/helpers/ollamaHelper')
const DatabaseHelper = require('./src/helpers/databaseHelper')

// Load env
dotenv.config()

const app = express()
const PORT = process.env.PORT || 3000
const API_PREFIX = process.env.API_VERSION || '/api/v1'

// ===============================
// 🔗 DATABASE INITIALIZATION
// ===============================
async function initializeDatabase() {
  try {
    console.log('🔗 Connecting to database...')

    await db.sequelize.authenticate()
    console.log('✅ Database connected.')

    if (process.env.AUTO_SETUP_DB === 'true') {
      console.log('🔄 Auto setup database...')
      await DatabaseHelper.autoSetupDatabase()
    } else if (process.env.ALLOW_SYNC === 'true') {
      console.log('🔄 Syncing database...')
      await db.sequelize.sync({ alter: true })
      console.log('✅ Database synced.')
    }

    if (process.env.NODE_ENV === 'development') {
      const dbStatus = await DatabaseHelper.getDatabaseStatus()
      console.log('📊 Database Status:', dbStatus)
    }
  } catch (error) {
    console.error('❌ Database init failed:', error.message)
    console.error('⚠️ Server will still run (degraded mode)')
  }
}

// ===============================
// 🔧 MIDDLEWARE
// ===============================
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(cors())

// ===============================
// 🔐 AUTH MIDDLEWARE
// ===============================
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers.authorization
  const token = authHeader && authHeader.split(' ')[1]

  if (!token) return res.sendStatus(401)

  jwt.verify(token, process.env.TOKEN_SECRET, (err, user) => {
    if (err) return res.sendStatus(403)
    req.user = user
    next()
  })
}

// ===============================
// 📁 STATIC FILES
// ===============================
app.use('/public', express.static(path.join(__dirname, 'public/uploads')))

// ===============================
// 🧪 HEALTH CHECK (WAJIB)
// ===============================
app.get('/', (req, res) => {
  res.status(200).json({ message: 'API is running 🚀' })
})

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' })
})

// ===============================
// 🛣️ ROUTES
// ===============================
app.use(`${API_PREFIX}/home`, require('./src/routes/home.routes'))
app.use(`${API_PREFIX}/test`, require('./src/routes/test.routes'))

app.use(
  `${API_PREFIX}/resto-admin`,
  authenticateToken,
  require('./src/routes/resto_admin.routes')
)

app.use(
  `${API_PREFIX}/admin`,
  authenticateToken,
  require('./src/routes/admin.routes')
)

app.use(
  `${API_PREFIX}/customer`,
  authenticateToken,
  require('./src/routes/customer.routes')
)

// ===============================
// 🤖 AI CHAT
// ===============================
app.post('/chat', async (req, res) => {
  try {
    const { message } = req.body

    if (!message) {
      return res.status(400).json({ error: 'Message is required' })
    }

    const response = await processMessage(req.body)

    res.json({ responseData: response })
  } catch (error) {
    console.error('❌ Chat error:', error)
    res.status(500).json({ error: 'Failed to process chat' })
  }
})

// ===============================
// 🛠️ DATABASE MANAGEMENT (SECURED)
// ===============================
app.get('/api/database/status', authenticateToken, async (req, res) => {
  try {
    const status = await DatabaseHelper.getDatabaseStatus()
    res.json({ success: true, data: status })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false, error: 'Failed to get DB status' })
  }
})

app.post('/api/database/migrate', authenticateToken, async (req, res) => {
  try {
    const success = await DatabaseHelper.runMigrations()
    res.json({ success })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false })
  }
})

app.post('/api/database/seed', authenticateToken, async (req, res) => {
  try {
    const success = await DatabaseHelper.runSeeders()
    res.json({ success })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false })
  }
})

app.post('/api/database/setup', authenticateToken, async (req, res) => {
  try {
    const success = await DatabaseHelper.autoSetupDatabase()
    res.json({ success })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false })
  }
})

// ===============================
// ❌ 404 HANDLER
// ===============================
app.use((req, res) => {
  res.status(404).json({ error: 'Not Found' })
})

// ===============================
// 💥 GLOBAL ERROR HANDLER
// ===============================
app.use((err, req, res, next) => {
  console.error('🔥 Unhandled Error:', err)
  res.status(500).json({ error: 'Internal Server Error' })
})

// ===============================
// 🚀 START SERVER (IMPORTANT FIX)
// ===============================
async function startServer() {
  await initializeDatabase()

  app.listen(PORT, '0.0.0.0', () => {
    console.log(`🚀 Server running on port ${PORT}`)

    // PM2 cluster support
    if (process.send) {
      process.send('ready')
    }
  })
}

startServer()
