'use strict'
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Carts', {
      cart_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      resto_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      cart_total: {
        type: Sequelize.DECIMAL(10, 2),
        allowNull: false,
        defaultValue: 0.0,
        comment:
          'Sum of the CartDetails(subtotal) of all rows with the same order_id'
      },
      date_created: {
        type: Sequelize.DATE,
        allowNull: false
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: false
      },
      created_by: {
        type: Sequelize.CHAR(36),
        allowNull: true
      }
    })
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Carts')
  }
}
