'use strict'
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Orders', {
      order_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      order_no: {
        type: Sequelize.STRING(17),
        allowNull: false
      },
      resto_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      order_status: {
        type: Sequelize.STRING(255),
        allowNull: false,
        defaultValue: 'Pending'
      },
      order_total: {
        type: Sequelize.DECIMAL(10, 2),
        allowNull: false
      },
      order_comment: {
        type: Sequelize.TEXT,
        allowNull: true
      },
      address_id: {
        type: Sequelize.CHAR(36),
        allowNull: true
      },
      date_processed: {
        type: Sequelize.DATE,
        allowNull: true
      },
      date_cancelled: {
        type: Sequelize.DATE,
        allowNull: true
      },
      date_released: {
        type: Sequelize.DATE,
        allowNull: true
      },
      date_rejected: {
        type: Sequelize.DATE,
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
    })
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Orders')
  }
}
