'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('OrderDetails', {
      orddetail_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      quantity: {
        type: Sequelize.INTEGER(10),
        allowNull: false
      },
      subtotal: {
        type: Sequelize.DECIMAL(10,2),
        allowNull: false
      },
      dish_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      order_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('OrderDetails');
  }
};