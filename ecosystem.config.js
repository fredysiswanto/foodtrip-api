module.exports = {
  apps: [
    {
      name: 'foodtrip-api',
      script: 'npm',
      args: 'start',
      cwd: '/mnt/data_d/server/projects/foodtrip-api',
      env: {
        NODE_ENV: 'production',
        PORT: 3000,
        DB_HOST: '127.0.0.1',
        DB_PORT: 3306,
        DB_USER: 'foodtrip',
        DB_PASS: 'foodtrip',
        DB_NAME: 'foodtrip'
      }
    }
  ]
}
