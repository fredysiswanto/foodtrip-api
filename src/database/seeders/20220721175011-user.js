'use strict';
const bcrypt = require('bcrypt');
const { v4: uuidv4 } = require('uuid');

module.exports = {
	async up(queryInterface, Sequelize) {
		// * User Customers
		await queryInterface.bulkInsert('Users', [
			// * Example
			{
				user_id: uuidv4(),
				user_no: '16862518406',
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)),
				first_name: 'James Paul',
				middle_name: 'Lim',
				last_name: 'Tulod',
				email_address: 'jptulod123@gmail.com',
				phone_number: '09451152076',
				gender: 'Male',
				user_type: 'Customer',
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
			{
				user_id: uuidv4(), // ! wag galawin
				user_no: '', // ! 11 digits only (random numbers)
				password: await bcrypt.hash('Customer@123', parseInt(process.env.SALT_ROUND)), // ! wag galawin
				first_name: '',
				middle_name: '', // ! optional lang to
				last_name: '',
				email_address: '',
				phone_number: '', // ! 11 digits only and only starts with 09...
				gender: '', // ! Male, Female or Others
				user_type: 'Customer', // ! wag galawin
				date_created: new Date(), // ! wag galawin
				date_updated: new Date(), // ! wag galawin
			},
		]);

		const users = await queryInterface.sequelize.query(`SELECT user_id from Users;`);
		const userRows = users[0];

		// * Customers Addresses
		return await queryInterface.bulkInsert('Addresses', [
			// * Example
			{
				address_id: uuidv4(),
				address_1: 'Block 8 Lot 34, Sunrise Street',
				address_2: 'Maligaya Subdivision',
				barangay: '177',
				city: 'Caloocan',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1424',
				full_name: 'James Paul L. Tulod',
				phone_number: '09451152076',
				is_default: '1',
				user_id: userRows[0].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: 'Block 10 Lot 55, Bautista Street',
				address_2: 'Maligaya Subdivision',
				barangay: 'pasong Putik',
				city: 'Quezon City',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1424',
				full_name: 'Jerald Guillermo',
				phone_number: '09482749382',
				is_default: '1',
				user_id: userRows[1].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '1188 Katinuan Street',
				address_2: 'Nitang Ave.',
				barangay: 'Gulod',
				city: 'Quezon City',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1117',
				full_name: 'Shaine R. Villanueva',
				phone_number: '09592749184',
				is_default: '1',
				user_id: userRows[2].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '3423 Mankor Street ',
				address_2: '',
				barangay: 'Tungkong Mangga',
				city: 'San Jose del Monte',
				province: 'Bulacan',
				region: 'Central Luzon',
				zip_code: '3023',
				full_name: 'Allison Locsin',
				phone_number: '09752048137',
				is_default: '1',
				user_id: userRows[3].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '2132 Zenia Street',
				address_2: '',
				barangay: '174',
				city: 'Caloocan',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1400',
				full_name: 'Princess Anna C. Santos',
				phone_number: '09293819382',
				is_default: '1',
				user_id: userRows[4].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '165 Ruby Street',
				address_2: '',
				barangay: '171',
				city: 'Caloocan',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1400',
				full_name: 'Javen Brylle Dela Cruz',
				phone_number: '09482048339',
				is_default: '1',
				user_id: userRows[5].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '324 H. Capiral Street',
				address_2: '',
				barangay: 'Duhat',
				city: 'Bocaue',
				province: 'Bulacan',
				region: 'Central Luzon',
				zip_code: '3018',
				full_name: 'Aphryll Joy Malazzab',
				phone_number: '09294482931',
				is_default: '1',
				user_id: userRows[6].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '7231 Bukal road',
				address_2: 'Promise land subdivision',
				barangay: 'Santol',
				city: 'Tanza',
				province: 'Cavite',
				region: 'Calabarzon',
				zip_code: '4108',
				full_name: 'Frankly Samson',
				phone_number: '09382746311',
				is_default: '1',
				user_id: userRows[7].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '143 Yakal Street',
				address_2: '',
				barangay: 'Almanza Uno',
				city: 'Las Piñas',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1750',
				full_name: 'Mellissa C. Taylor',
				phone_number: '09997492838',
				is_default: '1',
				user_id: userRows[8].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '432 Febo Street',
				address_2: '',
				barangay: '862',
				city: 'Manila',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1011',
				full_name: 'James Smith',
				phone_number: '09673849384',
				is_default: '1',
				user_id: userRows[9].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '655 Banahaw Street',
				address_2: '',
				barangay: '900',
				city: 'Manila',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1009',
				full_name: 'Charles J. Fowler',
				phone_number: '09243849261',
				is_default: '1',
				user_id: userRows[10].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			// ! IMPORTANT: mauulit ulit yung address pero user 1-5 lang
			{
				address_id: uuidv4(),
				address_1: '223 Nenita Street Ext',
				address_2: '',
				barangay: 'Gulod',
				city: 'Quezon City',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1117',
				full_name: 'Angela V. Reymundo',
				phone_number: '0956610746',
				is_default: '0',
				user_id: userRows[1].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '543 Gold Street',
				address_2: '',
				barangay: 'Novaliches Proper',
				city: 'Quezon City',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1123',
				full_name: 'Jason T. Nuesta',
				phone_number: '09511744508',
				is_default: '0',
				user_id: userRows[2].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '44 Salvador Street',
				address_2: '',
				barangay: '186',
				city: 'Caloocan',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1400',
				full_name: 'Brian Garcia',
				phone_number: '09288461967',
				is_default: '0',
				user_id: userRows[3].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '99 Midway Street',
				address_2: 'Forest Hill drive subdivision',
				barangay: 'Gulod',
				city: 'Quezon City',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1117',
				full_name: 'Kaiden Bascue',
				phone_number: '09299523227',
				is_default: '0',
				user_id: userRows[4].user_id,
				date_created: new Date(),
				date_updated: new Date(),
			},
			{
				address_id: uuidv4(),
				address_1: '980 Deleon Street',
				address_2: '',
				barangay: 'Holy Spirit',
				city: 'Quezon City',
				province: 'NCR',
				region: 'NCR',
				zip_code: '1127',
				full_name: 'Pinky Ramos',
				phone_number: '09578677438',
				is_default: '0',
				user_id: userRows[5].user_id,
				date_created: new Date(),
				date_updated: new Date(),
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
