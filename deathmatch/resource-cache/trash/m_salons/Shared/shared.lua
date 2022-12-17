--[[
	
	AUTHOR - https://vk.com/ganzes77
	GROUP VK - https://vk.com/ganzes_shop

]]

CONFIG = {

	POS_SPAWN_AUTO = {
		['Тойота'] = {-1948.5045166016,265.05844116211,34.808839416504, 52.789058685303,  -2419.67725, -608.35468, 132.56250} -- xcar, ycar, zcar, xcamera, ycamera, zcamera
	},

	ALL_MARKETS = {
		['Тойота'] = {-2406.54541, -597.83887, 132.64844, 0, 0,}, -- маркер входа, интерьер, измерение
		['Хуйота'] = {-2420.54541, -597.83887, 132.64844, 0, 0}, -- x, y, z, int, dim

	},

	VEHICLES = {
		['Тойота'] = { -- id, name, price, speed, fuel, расход топлива, картинка, ширина/высота картинки (желательно иметь 159x84)

			{400, 'BMW M5 F90', 450000, 100, 75,75, 'files/images/vehicles/400.png', 159, 84},
			{401, 'Mercedes c63 S', 4500001, 150, 75, 46, 'files/images/vehicles/401.png', 159, 84},
			{402, 'McLaren', 4500002, 350, 75, 72, 'files/images/vehicles/402.png', 159, 84},
			{404, 'ВАЗ 2107', 4500003, 543, 75, 64, 'files/images/vehicles/404.png', 159, 84},
			{405, 'Mercedes G63', 4500001, 76, 75, 41, 'files/images/vehicles/405.png', 159, 84},
			{410, 'Nissan Silvia', 4500002, 3, 75, 54, 'files/images/vehicles/410.png', 159, 84},
			{411, 'Toyota Supra', 4500003, 76, 75, 55, 'files/images/vehicles/411.png', 159, 84},
			{415, 'Lamborghini Huracan', 4500001, 543, 75, 75, 'files/images/vehicles/415.png', 159, 84},
			{418, 'Mercedes Maybach', 4500002, 135, 75, 15, 'files/images/vehicles/418.png', 159, 84},
			{547, 'Приора', 4500003, 423, 75, 35, 'files/images/vehicles/547.png', 159, 84},
			{550, 'BMD M5', 4500001, 250, 75, 51, 'files/images/vehicles/550.png', 159, 84},
			{500, 'Caddilac11', 4500002, 250, 75, 52, 'files/images/vehicles/400.png', 159, 84},
			{500, 'Caddilac12', 4500003, 250, 75, 55, 'files/images/vehicles/400.png', 159, 84},

		},

		['Хуйота'] = {


		},


	},

	NUMBER_SYMBOLS = {

		'A',
		'B',
		'C',
		'Y',
		'O',
		'P',
		'T',
		'E',
		'X',
		'M',
		'H',
		'K',

	},


}
