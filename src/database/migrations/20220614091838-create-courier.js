'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Couriers', {
      courier_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      courier_no: {
        type: Sequelize.STRING(17),
        allowNull: false
      },
      courier_name: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      courier_status: {
        type: Sequelize.STRING(255),
        allowNull: false,
        defaultValue: 'Available'
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
    await queryInterface.dropTable('Couriers');
  }
};