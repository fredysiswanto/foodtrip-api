'use strict';

module.exports = {
	async up(queryInterface, Sequelize) {
		const restaurants = await queryInterface.sequelize.query(
			`SELECT resto_id FROM restaurants ORDER BY restaurants.resto_no ASC; `
		);
		const restaurantRows = restaurants[0];

		// * Restaurant Opening Hours
		return await queryInterface.bulkInsert('OpeningHours', [
			// * Restaurant 11
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[11].resto_id,
				day: 'Monday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[11].resto_id,
				day: 'Tuesday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[11].resto_id,
				day: 'Wednesday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[11].resto_id,
				day: 'Thursday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[11].resto_id,
				day: 'Friday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[11].resto_id,
				day: 'Saturday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			// * Restaurant 12
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[12].resto_id,
				day: 'Monday',
				open_time: '08:30:00',
				close_time: '20:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[12].resto_id,
				day: 'Tuesday',
				open_time: '08:30:00',
				close_time: '20:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[12].resto_id,
				day: 'Wednesday',
				open_time: '08:30:00',
				close_time: '20:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[12].resto_id,
				day: 'Thursday',
				open_time: '08:30:00',
				close_time: '20:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[12].resto_id,
				day: 'Friday',
				open_time: '08:30:00',
				close_time: '20:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[12].resto_id,
				day: 'Saturday',
				open_time: '08:30:00',
				close_time: '20:30:00',
			},
			// * Restaurant 13
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[13].resto_id,
				day: 'Monday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[13].resto_id,
				day: 'Tuesday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[13].resto_id,
				day: 'Wednesday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[13].resto_id,
				day: 'Thursday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[13].resto_id,
				day: 'Friday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[13].resto_id,
				day: 'Saturday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			// * Restaurant 14
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[14].resto_id,
				day: 'Monday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[14].resto_id,
				day: 'Tuesday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[14].resto_id,
				day: 'Wednesday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[14].resto_id,
				day: 'Thursday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[14].resto_id,
				day: 'Friday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[14].resto_id,
				day: 'Saturday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			// * Restaurant 15
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[15].resto_id,
				day: 'Monday',
				open_time: '10:00:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[15].resto_id,
				day: 'Tuesday',
				open_time: '10:00:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[15].resto_id,
				day: 'Wednesday',
				open_time: '10:00:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[15].resto_id,
				day: 'Thursday',
				open_time: '10:00:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[15].resto_id,
				day: 'Friday',
				open_time: '10:00:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[15].resto_id,
				day: 'Saturday',
				open_time: '10:00:00',
				close_time: '21:30:00',
			},
			// * Restaurant 16
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[16].resto_id,
				day: 'Monday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[16].resto_id,
				day: 'Tuesday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[16].resto_id,
				day: 'Wednesday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[16].resto_id,
				day: 'Thursday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[16].resto_id,
				day: 'Friday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[16].resto_id,
				day: 'Saturday',
				open_time: '09:30:00',
				close_time: '21:00:00',
			},
			// * Restaurant 17
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[17].resto_id,
				day: 'Monday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[17].resto_id,
				day: 'Tuesday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[17].resto_id,
				day: 'Wednesday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[17].resto_id,
				day: 'Thursday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[17].resto_id,
				day: 'Friday',
				open_time: '10:30:00',
				close_time: '221:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[17].resto_id,
				day: 'Saturday',
				open_time: '10:30:00',
				close_time: '21:00:00',
			},
			// * Restaurant 18
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[18].resto_id,
				day: 'Monday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[18].resto_id,
				day: 'Tuesday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[18].resto_id,
				day: 'Wednesday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[18].resto_id,
				day: 'Thursday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[18].resto_id,
				day: 'Friday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[18].resto_id,
				day: 'Saturday',
				open_time: '08:00:00',
				close_time: '20:00:00',
			},
			// * Restaurant 19
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[19].resto_id,
				day: 'Monday',
				open_time: '09:00:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[19].resto_id,
				day: 'Tuesday',
				open_time: '09:00:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[19].resto_id,
				day: 'Wednesday',
				open_time: '09:00:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[19].resto_id,
				day: 'Thursday',
				open_time: '09:00:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[19].resto_id,
				day: 'Friday',
				open_time: '09:00:00',
				close_time: '21:00:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[19].resto_id,
				day: 'Saturday',
				open_time: '09:00:00',
				close_time: '21:00:00',
			},
			// * Restaurant 20
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[20].resto_id,
				day: 'Monday',
				open_time: '10:30:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[20].resto_id,
				day: 'Tuesday',
				open_time: '10:30:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[20].resto_id,
				day: 'Wednesday',
				open_time: '10:30:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[20].resto_id,
				day: 'Thursday',
				open_time: '10:30:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[20].resto_id,
				day: 'Friday',
				open_time: '10:30:00',
				close_time: '21:30:00',
			},
			{
				openhrs_id: uuidv4(),
				resto_id: restaurantRows[20].resto_id,
				day: 'Saturday',
				open_time: '10:30:00',
				close_time: '21:30:00',
			},
		]);
	},

	async down(queryInterface, Sequelize) {
		/**
		 * Add commands to revert seed here.
		 *
		 * Example:
		 * await queryInterface.bulkDelete('People', null, {});
		 */
	},
};
