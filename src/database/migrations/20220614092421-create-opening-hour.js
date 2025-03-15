'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('OpeningHours', {
      openhrs_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      resto_id: {
        type: Sequelize.CHAR(36),
        allowNull: false
      },
      day: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      open_time: {
        type: Sequelize.TIME,
        allowNull: false
      },
      close_time: {
        type: Sequelize.TIME,
        allowNull: false
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
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('OpeningHours');
  }
};