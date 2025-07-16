'use strict'
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Restaurants', {
      resto_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      resto_no: {
        type: Sequelize.STRING(17),
        allowNull: false
      },
      resto_name: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      resto_email: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      resto_phone: {
        type: Sequelize.STRING(13),
        allowNull: true,
        comment:
          'Phone number must start with "09" or "+639" and only up 13 characters'
      },
      resto_landline: {
        type: Sequelize.STRING(8),
        allowNull: false,
        comment: 'Landline number should have 8 digits.'
      },
      resto_website: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      resto_img: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      restocatg_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      status: {
        type: Sequelize.STRING(255),
        allowNull: false,
        defaultValue: 'Open'
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
    await queryInterface.dropTable('Restaurants')
  }
}
