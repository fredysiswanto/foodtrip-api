'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Dishes', {
      dish_id: {
        type: Sequelize.CHAR(36),
        allowNull: false,
        primaryKey: true
      },
      dish_no: {
        type: Sequelize.STRING(17),
        allowNull: false
      },
      dish_name: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      dish_desc: {
        type: Sequelize.TEXT,
        allowNull: false
      },
      dish_price: {
        type: Sequelize.DECIMAL(10,2),
        allowNull: false
      },
      dish_img: {
        type: Sequelize.STRING(255),
        allowNull: false
      },
      status: {
        type: Sequelize.STRING(255),
        allowNull: false,
        defaultValue: 'Available'
      },
      dishcatg_id: {
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
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Dishes');
  }
};