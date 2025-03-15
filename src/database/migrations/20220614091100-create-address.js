'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Addresses', {
      address_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      address_1: {
        type: Sequelize.STRING(500),
        allowNull: false,
        comment: 'Room, Floor, Suite or House Number, Street Name'
      },
      address_2: {
        type: Sequelize.STRING(500),
        allowNull: true,
        comment: 'Building, Dormitory, School or Company Name, Subdivision, Village'
      },
      barangay: {
        type: Sequelize.STRING(50),
        allowNull: false
      },
      city: {
        type: Sequelize.STRING(50),
        allowNull: false
      },
      province: {
        type: Sequelize.STRING(50),
        allowNull: false
      },
      region: {
        type: Sequelize.STRING(50),
        allowNull: false
      },
      zip_code: {
        type: Sequelize.INTEGER,
        allowNull: false
      },
      full_name: {
        type: Sequelize.STRING(255),
        allowNull: true
      },
      phone_number: {
        type: Sequelize.STRING(13),
        allowNull: true,
        comment: 'Phone number must start with "09" or "+639" and only up to 13 characters'
      },
      is_default: {
        type: Sequelize.TINYINT,
        allowNull: false,
        defaultValue: 1
      },
      user_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      resto_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
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
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('addresses');
  }
};
