'use strict'
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Users', {
      user_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      resto_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      user_no: {
        type: Sequelize.STRING(17),
        allowNull: false
      },
      password: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      first_name: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      middle_name: {
        type: Sequelize.STRING(255),
        allowNull: true
      },
      last_name: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      email_address: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      phone_number: {
        type: Sequelize.STRING(13),
        allowNull: true,
        comment:
          'Phone number must start with "09" or "+639" and only up 13 characters'
      },
      gender: {
        type: Sequelize.STRING(255),
        allowNull: true
      },
      user_type: {
        type: Sequelize.STRING(255),
        allowNull: false,
        defaultValue: 'Customer'
      },
      created_by: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      updated_by: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      deleted_by: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      date_created: {
        type: Sequelize.DATE,
        allowNull: false
      },
      date_updated: {
        type: Sequelize.DATE,
        allowNull: false
      },
      date_deleted: {
        type: Sequelize.DATE,
        allowNull: true
      }
    })
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Users')
  }
}
