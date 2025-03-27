'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('DeliveryDetails', {
      delivery_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      tracking_no: {
        type: Sequelize.STRING(17),
        allowNull: false
      },
      order_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      courier_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      driver_name: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      driver_phone: {
        type: Sequelize.STRING(13),
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
      date_received: {
        type: Sequelize.DATE,
        allowNull: true,
        comment: 'Date and Time in which the order has been received by the customer.'
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
    await queryInterface.dropTable('DeliveryDetails');
  }
};