const db = require('../../models');
const { dataResponse, errResponse, emptyDataResponse } = require('../../helpers/controller.helper');

// * Retrieve all Dish
exports.getAllDishes = async (req, res) => {
	try {
		const data = await db.Dish.findAll({ include: ['dish_category', 'restaurant'] });
		dataResponse(res, data, 'All Dishes has been retrieved', 'No Dishes has been retrieved');
	} catch (err) {
		errResponse(res, err);
	}
};

// * Retrieve all Dish Category
exports.getAllDishCat = async (req, res) => {
	try {
		const data = await db.DishCategory.findAll({ include: 'dishes' });
		dataResponse(res, data, 'All Dish Category has been retrieved', 'No Dish Category has been retrieved');
	} catch (err) {
		errResponse(res, err);
	}
};

// * Retrieve single Dish Category
exports.getDishCat = async (req, res) => {
	const id = req.params.dishCatID;

	try {
		const data = await db.DishCategory.findByPk(id, { include: 'dishes' });
		dataResponse(res, data, 'Dish Category has been retrieved', 'No Dish Category has been retrieved');
	} catch (err) {
		errResponse(res, err);
	}
};
