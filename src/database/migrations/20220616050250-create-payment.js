'use strict'
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Payments', {
      payment_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      payment_no: {
        type: Sequelize.STRING(17),
        allowNull: false
      },
      order_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      payment_status: {
        type: Sequelize.STRING(255),
        allowNull: false,
        defaultValue: 'Pending'
      },
      payment_total: {
        type: Sequelize.DECIMAL(10, 2),
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
    })
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Payments')
  }
}
