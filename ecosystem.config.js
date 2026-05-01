module.exports = {
  apps: [
    {
      // name: 'foodtrip-api',
      // script: 'npm',
      // args: 'start',
      // cwd: '/mnt/data_d/server/projects/foodtrip-api',
      // env: {
      //   NODE_ENV: 'production',
      //   PORT: 3000,
      //   DB_HOST: '127.0.0.1',
      //   DB_PORT: 3306,
      //   DB_USER: 'foodtrip',
      //   DB_PASS: 'foodtrip',
      //   DB_NAME: 'foodtrip'
      // }

      name: 'foodtrip-api',
      script: './app.js',
      exec_mode: 'fork',
      instances: '1',
      watch: false,
      ignore_watch: ['node_modules', 'public/uploads', 'logs', '.git'],
      max_memory_restart: '500M',
      kill_timeout: 5000,
      kill_signal: 'SIGTERM',
      wait_ready: true,
      listen_timeout: 8000, // ✅ Increased from 3000 to 8000
      merge_logs: true,
      autorestart: true,
      max_restarts: 30, // ✅ Increased from 10
      min_uptime: '30s', // ✅ Increased from 10s
      env: {
        NODE_ENV: 'production',
        PORT: 3000,
        DB_HOST: '127.0.0.1',
        DB_PORT: 3306,
        DB_USER: 'foodtrip',
        DB_PASS: 'foodtrip',
        DB_NAME: 'foodtrip'
      },
      error_file: './logs/err.log',
      out_file: './logs/out.log',
      log_file: './logs/combined.log',
      time_format: 'YYYY-MM-DD HH:mm:ss Z'
    }
  ]
}
