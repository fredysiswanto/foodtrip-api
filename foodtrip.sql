-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2025 at 04:38 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `foodtrip`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `address_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `address_1` varchar(500) NOT NULL COMMENT 'Room, Floor, Suite or House Number, Street Name',
  `address_2` varchar(500) DEFAULT NULL COMMENT 'Building, Dormitory, School or Company Name, Subdivision, Village',
  `barangay` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `province` varchar(50) NOT NULL,
  `region` varchar(50) NOT NULL,
  `zip_code` int(4) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(13) DEFAULT NULL COMMENT 'Phone number must start with "09" or "+639" and only up 13 characters',
  `is_default` tinyint(1) NOT NULL DEFAULT 1,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `resto_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`address_id`, `address_1`, `address_2`, `barangay`, `city`, `province`, `region`, `zip_code`, `full_name`, `phone_number`, `is_default`, `user_id`, `resto_id`, `created_by`, `updated_by`, `deleted_by`, `date_created`, `date_updated`, `date_deleted`) VALUES
('02cd07c8-2d00-4259-87e4-1e9445258aa5', '99 Midway Street', 'Forest Hill drive subdivision', 'Gulod', 'Quezon City', 'NCR', 'NCR', 1117, 'Kaiden Bascue', '09299523227', 0, 'fbffe4ad-7978-462e-bd3b-ee109d9010b3', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('033d1dc5-014f-4d3e-b280-c35ec40f92d0', '3423 Mankor Street ', NULL, 'Tungkong Mangga', 'San Jose del Monte', 'Bulacan', 'Central Luzon', 3023, 'Allison Locsin', '09752048137', 1, '1a90b095-3121-4cae-a766-ed18f907a398', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('069f552c-7964-4d54-84c9-d19e1e358a71', '1118 Commonwealth Ave', 'Novaliches', 'Pasong Putik', 'Quezon City', 'NCR', 'NCR', 1118, NULL, NULL, 1, NULL, '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('106412e5-0950-4fc5-85ef-445692d4ff90', 'Commercial Center', 'Regalado Hive', '2/F', ' Quezon City', 'NCR', 'NCR', 1118, NULL, NULL, 1, NULL, '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('15d1d834-8ef2-4b85-bc91-bbbc32ced7c7', 'Block 41, Lot, 22 Ascension Ave', 'Novaliches', 'North Fairview', 'Quezon City', 'NCR', 'NCR', 1121, NULL, NULL, 1, NULL, '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('15f836ba-e9e6-4d1a-bddd-56c5ad3840b7', 'Block 10 Lot 55, Bautista Street', 'Maligaya Subdivision', 'pasong Putik', 'Quezon City', 'NCR', 'NCR', 1424, 'Jerald Guillermo', '09482749382', 1, '02b9b6db-b044-4e83-bc16-85e1d6d02509', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('21aa2a7d-eab4-4744-8200-eaa89510ac0c', 'Plaza Nova Bldg.', 'Santiago Blvd.', 'Barangay Dadiangas South', 'General Santos City', 'South Cotabato', 'SOCCSKSARGEN', 9500, NULL, NULL, 1, NULL, '732164d4-e7c4-4d0b-9969-9a1b1b3cde03', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('23ab55e2-1d01-4e60-ba97-a67d75b6f0a6', '2132 Zenia Street', NULL, '174', 'Caloocan', 'NCR', 'NCR', 1400, 'Princess Anna C. Santos', '09293819382', 1, 'fbffe4ad-7978-462e-bd3b-ee109d9010b3', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('24571cc5-bff4-4afb-80b4-703f5a0c3019', '655 Banahaw Street', NULL, '900', 'Manila', 'NCR', 'NCR', 1009, 'Charles J. Fowler', '09243849261', 1, '75e58ffc-f2a1-420b-b162-0dd5a926b25b', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('324db4db-c9b6-44b8-a95e-18ea05b738c7', 'A. Bonifacio Street', 'Ilaya', 'Lumangbayan', ' Calapan City', 'Oriental Mindoro', '	Mimaropa', 5208, NULL, NULL, 1, NULL, '3c698b91-a6b8-4b13-9e82-b77043d41089', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('36149c25-edd6-4b12-baa2-c3fda3ea5f95', '1188 Katinuan Street', 'Nitang Ave.', 'Gulod', 'Quezon City', 'NCR', 'NCR', 1117, 'Shaine R. Villanueva', '09592749184', 1, '585f0dca-ff76-42ac-99c2-30729ad5fbd7', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('36ad6f15-93ee-468a-ae97-3c03bdaf037f', 'Block 8 Lot 34, Sunrise Street', 'Maligaya Subdivision', '177', 'Caloocan', 'NCR', 'NCR', 1424, 'James Paul L. Tulod', '09451152076', 1, '9dfc8a70-ff3b-41ef-900a-95109f3aff8d', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('3712303d-60c9-402a-a5f5-c8d7d946d591', 'Domingo Street', 'Cubao', 'San Martin de Porres', 'Quezon City', 'Metro Manila', 'NCR', 1713, NULL, NULL, 1, NULL, 'db92e05e-509e-43ae-9385-4d4aaf2cf2a7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('3f3fb623-f9ab-4f63-a3c5-1253d9a168f3', '980 Deleon Street', NULL, 'Holy Spirit', 'Quezon City', 'NCR', 'NCR', 1127, 'Pinky Ramos', '09578677438', 0, '96c2d011-87f2-48da-b934-23b293779aaa', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('4d42a646-1cc1-4236-b599-2ed45bd083b4', '1119-D J P Rizal 1200', NULL, 'Barangka Ilaya', 'Makati City', 'Metro Manila', 'NCR', 1550, NULL, NULL, 1, NULL, '033579a5-6dca-4e93-915d-fcf4de53722c', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('53b20429-acbf-4d68-82bf-ac1126b42016', '34 East Drive Hts. ', 'Concepcion 1811', 'Marikina Heights', 'Marikina City', 'NCR', 'NCR', 1810, NULL, NULL, 1, NULL, '95592b80-21dd-42dd-9ee6-dcf97c765d04', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('57661cae-3de4-4dec-8fc1-09fc6347cacf', '143 Yakal Street', NULL, 'Almanza Uno', 'Las Piñas', 'NCR', 'NCR', 1750, 'Mellissa C. Taylor', '09997492838', 1, '95b10df6-8aca-4185-a87e-5f6f2e250007', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('657166d6-c88a-4bba-8df3-794a66933a3a', ' Edsa Central Pavillion', 'Unite Street corner Edsa', '46 Commonwealth Ave', 'Mandaluyong City', 'Metro Manila', 'NCR', 1550, NULL, NULL, 1, NULL, '9715b035-2cec-4933-b39d-d0bd82bb858d', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('68c95762-7eaf-4211-bfee-ba4186dbdda2', '7231 Bukal road', 'Promise land subdivision', 'Santol', 'Tanza', 'Cavite', 'Calabarzon', 4108, 'Frankly Samson', '09382746311', 1, '00ae9d57-c569-443e-bf05-f916aa215c6d', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('6d86ac04-fc72-49dd-b3ba-fc85d8e9c38b', '92 Fairview Terraces', NULL, 'Pasong Putik', 'Quezon City', 'NCR', 'NCR', 1424, NULL, NULL, 1, NULL, '6b9d42cd-affa-44e5-8874-5b810c5b47ee', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('71c1de74-ff6c-43e3-bc50-28f75d93ae55', '44 Salvador Street', NULL, '186', 'Caloocan', 'NCR', 'NCR', 1400, 'Brian Garcia', '09288461967', 0, '1a90b095-3121-4cae-a766-ed18f907a398', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('7dc12fe9-227a-45ee-809e-a9ab5d083e12', '28 Sgt. Esguerra Ave', NULL, ' Diliman', 'Quezon City', 'NCR', 'NCR', 1101, NULL, NULL, 1, NULL, 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('8199d8ec-cc2e-4730-ad46-8734e37c094a', '894 Quezon Boulevard 1000', 'Ermita', 'Brgy. 395', ' Sampaloc', 'Manila', 'NCR', 1008, NULL, NULL, 1, NULL, '30bcd7a5-415b-49b6-8933-720fe958065e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('8d0c2319-d9e2-4832-918f-b490a37d6c00', '324 H. Capiral Street', NULL, 'Duhat', 'Bocaue', 'Bulacan', 'Central Luzon', 3018, 'Aphryll Joy Malazzab', '09294482931', 1, 'cbab6c73-fac4-4a8d-851c-be3cc9bcdb04', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('976f6370-e6f3-44dd-8b7b-bf353967a1ed', 'Fairview Centermall,Don Mariano', 'Marcos Ave. cor. Regalado', 'Novaliches', 'Quezon City', 'NCR', 'NCR', 1118, NULL, NULL, 1, NULL, '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('991c5b02-7db1-48b8-8b91-eeef868e2543', '11 Seattle Street ', 'Immaculate Comcepion 1109', 'San Martin de Porres', 'Quezon City', 'Metro Manila', 'NCR', 1713, NULL, NULL, 1, NULL, '76eef8e8-9103-429c-af7f-b7731ebe2616', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9be4f935-3d37-4e27-b261-65adae23a275', '165 Ruby Street', NULL, '171', 'Caloocan', 'NCR', 'NCR', 1400, 'Javen Brylle Dela Cruz', '09482048339', 1, '96c2d011-87f2-48da-b934-23b293779aaa', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('a583df91-329b-48de-8173-1af4548db4a5', '103-G', 'Commonwealth Ave.', 'Fairview', 'Quezon City', 'NCR', 'NCR', 1121, NULL, NULL, 1, NULL, 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('a899ec27-e0b3-40f9-92bd-ecfc6d6d40d5', '432 Febo Street', NULL, '862', 'Manila', 'NCR', 'NCR', 1011, 'James Smith', '09673849384', 1, '02f6fa67-3522-4e41-a1f8-962065aa080d', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('ae07d320-8ce2-4a24-b313-0036f71b0c02', 'M32G+H2J', NULL, 'Diliman', 'Quezon City', 'NCR', 'NCR', 1101, NULL, NULL, 1, NULL, '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('ae4746f8-b6c9-4c1c-9518-0672668a3000', ' Diliman Commercial Center', NULL, '46 Commonwealth Ave', 'Quezon City', 'NCR', 'NCR', 1121, NULL, NULL, 1, NULL, '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('bee68688-c65d-4261-9fb4-a63f64ea1427', 'Commonwealth Avenue ', 'Calle Bistro', 'Ever Commonwealth', 'Quezon City', 'NCR', 'NCR', 1121, NULL, NULL, 1, NULL, '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('c2bab477-e395-419e-863c-409d8b3a2d0f', '543 Gold Street', NULL, 'Novaliches Proper', 'Quezon City', 'NCR', 'NCR', 1123, 'Jason T. Nuesta', '09511744508', 0, '585f0dca-ff76-42ac-99c2-30729ad5fbd7', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('d066d5f9-f8a2-4e73-a55b-35ba3e04a166', '223 Nenita Street Ext', NULL, 'Gulod', 'Quezon City', 'NCR', 'NCR', 1117, 'Angela V. Reymundo', '0956610746', 0, '02b9b6db-b044-4e83-bc16-85e1d6d02509', NULL, '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('df2cc266-75db-4815-bb54-c81c3796e968', 'H3J8+6WC, St. Paul College', 'St. Paul St.', 'Caniogan', 'Pasig City', 'Metro Manila', 'NCR', 1606, NULL, NULL, 1, NULL, 'afa5ea13-ffdc-46c3-85ad-100b5e642092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('f5cdf66c-601a-426a-9aac-bec5059513c6', '9696 Kamagong Street', 'San Antonio Village', 'Palanan', 'Makati City', 'Metro Manila', 'NCR', 1235, NULL, NULL, 1, NULL, '040eecac-240e-43c0-a9f3-402f51e8ec73', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('fbde2b8c-5b40-4c7b-9d83-f2e85ea12769', '303 Tomas', 'Morato Ave', 'Diliman', 'Quezon City', 'NCR', 'NCR', 1101, NULL, NULL, 1, NULL, 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cartdetails`
--

CREATE TABLE `cartdetails` (
  `cartdetail_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `quantity` int(10) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL COMMENT 'Dish(dish_price) * OrderDetails(quantity)',
  `cart_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `dish_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `cart_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `resto_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `cart_total` decimal(10,2) DEFAULT 0.00 COMMENT 'Sum of the CartDetails(subtotal) of all rows with the same order_id',
  `date_created` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `couriers`
--

CREATE TABLE `couriers` (
  `courier_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `courier_no` varchar(17) NOT NULL,
  `courier_name` varchar(255) NOT NULL,
  `courier_status` varchar(255) NOT NULL DEFAULT 'Available',
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `couriers`
--

INSERT INTO `couriers` (`courier_id`, `courier_no`, `courier_name`, `courier_status`, `created_by`, `updated_by`, `deleted_by`, `date_created`, `date_updated`, `date_deleted`) VALUES
('03240b5a-9e62-4b5f-94eb-ae4e11d1ac91', 'COR-8695999360357', 'Transportify', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL),
('1646a6fa-7675-4066-8673-750d19e08823', 'COR-8695999360359', 'Lalamove', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL),
('343566c6-8d4e-4252-acb6-1913b5c09049', 'COR-8695999360361', 'J&T Express', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL),
('38a8b2d2-da0b-4221-84a3-03699d2b51d4', 'COR-8695999360363', 'Entrego', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL),
('44002178-0298-4cd9-abf4-bf3bed33d3bf', 'COR-8695999360364', '2GO', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL),
('5dd01f97-0254-4eee-9e62-8f08a6c8fa03', 'COR-8695999360362', 'LBC Express', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL),
('5fe3cae1-cf1e-4c88-88f2-bd976d26f1c6', 'COR-8695999360356', 'Black Arrow Express', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL),
('c57bd20d-31dd-40a0-8af1-84a4119c559b', 'COR-8695999360358', 'Gogo Xpress', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL),
('dde05a37-406b-4c82-969e-91e2eb52b325', 'COR-8695999360355', 'Grab Express', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL),
('fbc2c212-433c-4467-8ed9-5c61cfd6c550', 'COR-8695999360360', 'Toktok', 'Available', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:32', '2025-02-10 15:04:32', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deliverydetails`
--

CREATE TABLE `deliverydetails` (
  `delivery_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tracking_no` varchar(17) NOT NULL,
  `order_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `courier_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `driver_name` varchar(255) NOT NULL,
  `driver_phone` varchar(13) NOT NULL,
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_received` datetime DEFAULT NULL COMMENT 'Date and Time in which the order has been received by the customer.',
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dishcategories`
--

CREATE TABLE `dishcategories` (
  `dishcatg_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `dishcatg_name` varchar(255) NOT NULL,
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dishcategories`
--

INSERT INTO `dishcategories` (`dishcatg_id`, `dishcatg_name`, `created_by`, `updated_by`, `deleted_by`, `date_created`, `date_updated`, `date_deleted`) VALUES
('153a356c-9919-4c85-bb0d-599c14df40ef', 'Seafood', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('28d6d16e-9031-499b-95af-78496dc90ad9', 'Rice Dishes', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('2d79ccfc-8ca7-4f25-8853-5f0ce1eeda80', 'Spread', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('344837b9-f391-450e-ad5a-5a5eda063aeb', 'Chicken and Sandwiches', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('39b395a4-3c0c-4673-a92c-301f64480f2a', 'Sandwiches', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('3b7a3f5f-0b9f-472f-937e-4d5b373e8007', 'Breads', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('5393fc15-02a3-4fc1-aff2-48ce8daa6b86', 'Premium Cakes', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('5b2a162d-ef68-4408-806f-aa73377de5c4', 'Pasta', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('5e585357-fdac-4ddb-8130-696698d6fbe1', 'Pork', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('63a5313c-86d1-4d15-86fa-f78f93e2a6c4', 'Ready to Eat', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('65b93ccb-f0f5-4376-af35-4e0ced7f584e', 'Beef', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('69cf7537-0534-4715-88cd-c47b45300753', 'Dessert', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('7940da74-b334-46a6-a70c-259c2375855e', 'Fried Dishes', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('806a8aa3-ab7b-42ad-acd4-48706d6526e1', 'Appetizer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('928d7915-ddc2-41b3-a25b-d81228c60457', 'Chicken', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('9ac755ee-8855-45cc-9615-173eedabcc5e', 'Greeting Cakes', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('9b2c1e51-238d-40b4-9469-3bf51bc04cc5', 'Beverages', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('9e83c664-ce96-4144-b929-3f040ffd2aaa', 'Coffee', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('ad76a800-9cfe-450b-b4ae-bee2c43e2943', 'Cake Rolls', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('b44991d6-71f8-4786-bd54-c378bcfd3184', 'Pizza', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('bb943b5f-2c56-4d53-ac10-2d1fa439b702', 'Breakfast', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('cbc3fcc2-9ad9-4811-ac23-0ea8a68f3d37', 'Noodles', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('ceacd50f-fcbe-434e-96c4-a95431190815', 'Soups', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('f45a269d-9639-4e46-880c-d8e88c7027c7', 'Cold Drinks', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('fc039146-3ef9-42b0-95f8-ff09c61c13aa', 'Vegetables', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dishes`
--

CREATE TABLE `dishes` (
  `dish_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `dish_no` varchar(17) NOT NULL,
  `dish_name` varchar(255) NOT NULL,
  `dish_desc` text NOT NULL,
  `dish_price` decimal(10,2) NOT NULL,
  `dish_img` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Available',
  `dishcatg_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `resto_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dishes`
--

INSERT INTO `dishes` (`dish_id`, `dish_no`, `dish_name`, `dish_desc`, `dish_price`, `dish_img`, `status`, `dishcatg_id`, `resto_id`, `created_by`, `updated_by`, `deleted_by`, `date_created`, `date_updated`, `date_deleted`) VALUES
('03217699-5d11-46a9-af2b-0d48b3ccab75', 'DSH-4347999675195', 'Whole Wheat Loaf', 'Soft, sliced-bread oven-baked to perfection. All the goodness of wheat and fiber, a healthy alternative.', 78.00, 'dish_img-0000000000045.png', 'Available', '3b7a3f5f-0b9f-472f-937e-4d5b373e8007', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('0a34c90a-73d9-49c6-b9e3-e45e5c832545', 'DSH-4347999675152', 'Sizzling Gambas', 'Shrimp dish that is considered to be both an appetizer and a main dish.', 365.00, 'dish_img-000000000005.png', 'Available', '153a356c-9919-4c85-bb0d-599c14df40ef', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('0aed71fd-4ea8-4cbf-8345-0ea577845f37', 'DSH-4347999675181', 'Tangerine Chicken', 'Sweet and Sour Citrus Chicken with Eggplant and Plantain', 380.00, 'dish_img-0000000000031.png', 'Available', '7940da74-b334-46a6-a70c-259c2375855e', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('0b951484-7254-475f-b938-e68905670f5d', 'DSH-4347999675201', 'Baklava', 'Authentic Turkish Baklava is a delicious, flaky dessert made with thin sheets of dough soaked in syrup and layered with nuts', 170.00, 'dish_img-0000000000051.png', 'Available', '69cf7537-0534-4715-88cd-c47b45300753', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('0c85813c-c483-41bd-8a64-0abc2ab419c5', 'DSH-4347999675194', 'Milk Tea (500Ml)', 'The classic taste of milktea in a bottle.', 80.00, 'dish_img-0000000000044.png', 'Available', '9b2c1e51-238d-40b4-9469-3bf51bc04cc5', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('0e35e121-4380-4610-8607-ca52f88d69f7', 'DSH-4347999675222', 'Hawaiian', 'A local favorite with sweet pineapples, and savory ham and crumbled bacon.', 350.00, 'dish_img-0000000000072.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('11fc3d2f-e811-410f-b409-34dadb24bb8b', 'DSH-4347999675243', 'Chocolate Mousse Cake', 'Rich chocolate mousse on moist chocolate butter cake and iced with freshly whipped cream. The top is laced with layers of cream border. The whole cake is drizzled with chocolate ganache and chocolate vermicelli. Top of the cake is sprinkled with chocolate chips.', 682.00, 'dish_img-0000000000093.png', 'Available', '5393fc15-02a3-4fc1-aff2-48ce8daa6b86', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('1594d535-a3cc-450f-bc62-58b9751f0a0d', 'DSH-4347999675190', 'Ramyeon', 'Korean Ramen', 220.00, 'dish_img-0000000000040.png', 'Available', 'cbc3fcc2-9ad9-4811-ac23-0ea8a68f3d37', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('15ad3d66-1f38-426a-8ebd-bb24af5728af', 'DSH-4347999675197', 'Tsokolate Spread (220g)', 'Smooth and creamy, luscious tsokolate spread.', 120.00, 'dish_img-0000000000047.png', 'Available', '2d79ccfc-8ca7-4f25-8853-5f0ce1eeda80', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('19f17d7e-d5bb-42ea-b359-cd875899f2dc', 'DSH-4347999675159', 'Strawberry Lemonade Cheesecake', 'Lemon creamy cheesecake swirled with strawberry puree then topped with light creamy strawberries and cream topping.', 250.00, 'dish_img-000000000012.png', 'Available', '69cf7537-0534-4715-88cd-c47b45300753', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('1b3dabe9-b1e9-4b70-8afb-dced07e119fe', 'DSH-4347999675233', 'Ojingeo Dolsot', 'Stir-fried squid Bibimbap', 320.00, 'dish_img-0000000000083.png', 'Available', '153a356c-9919-4c85-bb0d-599c14df40ef', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('1e43de3c-dd0f-4981-9dca-cdfdb3812941', 'DSH-4347999675230', 'Chicken Alfredo', 'Chicken Pasta with chicken strips, olives, and basil chiffonade.', 235.00, 'dish_img-0000000000080.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('21cf9ecf-bfa2-4b70-8b56-10c265a330c8', 'DSH-4347999675229', 'Charlie Chan', 'Chicken strips, chitake mushroom and roasted peanuts in a spicy oriental sauce.', 235.00, 'dish_img-0000000000079.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('221e1e92-25c4-47df-b155-8d7ad3a24c35', 'DSH-4347999675172', 'Asian Chicken pasta', 'Spaghetti pasta cook in soy sauce with chicken and mushroom', 115.00, 'dish_img-0000000000025.png', 'Available', '5b2a162d-ef68-4408-806f-aa73377de5c4', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('226c2e11-531e-44c7-8c1f-c6f5e1019f15', 'DSH-4347999675221', 'Pepperoni', 'Our take on a true New york favorite featuring edge-to-edge pepperoni', 350.00, 'dish_img-0000000000071.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('2446b3ef-1bc8-41db-9c86-92a24f76181b', 'DSH-4347999675149', 'Chicken Kebab', 'Is simply delicious, beautiful and chargegrilled on skewers make the perfect treat for any BBQ or picnic', 285.00, 'dish_img-000000000002.png', 'Available', '928d7915-ddc2-41b3-a25b-d81228c60457', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('24a70ab9-563c-4202-b486-05d2f026300c', 'DSH-4347999675246', 'Dulce de Leche Roll', 'Vanilla sponge cake with decadent dulce de leche filling, iced with vanilla buttercreme and caramel', 352.00, 'dish_img-0000000000096.png', 'Available', 'ad76a800-9cfe-450b-b4ae-bee2c43e2943', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('25451a58-2dc7-4a3b-bcd8-bfe3ce610c7f', 'DSH-4347999675196', 'Pesto Cheese Sticks (4 Sticks)', 'Herb-flavored soft bread sticks with cheese melted on top.', 100.00, 'dish_img-0000000000046.png', 'Available', '3b7a3f5f-0b9f-472f-937e-4d5b373e8007', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('267633ef-de9b-4b40-b533-371e77b99e95', 'DSH-4347999675236', 'Gool', 'Fresh oysters on ice with lemon', 400.00, 'dish_img-0000000000086.png', 'Available', '153a356c-9919-4c85-bb0d-599c14df40ef', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('291c8176-2ca3-4bd5-aec6-481194a6d2c8', 'DSH-4347999675174', 'Garlic Shrimp', 'culinary cream, shrimp, garlic, cheddar cheese, mozzarella cheese', 355.00, 'dish_img-0000000000027.png', 'Available', 'b44991d6-71f8-4786-bd54-c378bcfd3184', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('2ad865a6-f0ca-4098-b794-fec594499b02', 'DSH-4347999675151', 'Sizzling Kangkong Ala Pobre', 'Kangkong in Oyster Sauce', 195.00, 'dish_img-000000000004.png', 'Available', 'fc039146-3ef9-42b0-95f8-ff09c61c13aa', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('2e2b4907-29e4-4932-baf3-c6ae1c9a3591', 'DSH-4347999675180', 'Creamy Spinach Dip', 'spinach, onion, mayonnaise, cream cheese, parmesan cheese, pizza cheese & mozzarella cheese', 370.00, 'dish_img-0000000000030.png', 'Available', 'b44991d6-71f8-4786-bd54-c378bcfd3184', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('312f9e8c-2edc-4742-9756-09ec515001ee', 'DSH-4347999675203', 'Shawarma Pulutan', 'A deconstructed Shawarma wrap that is best eaten with garlic, chili and parsley sauce.', 175.00, 'dish_img-0000000000053.png', 'Available', '65b93ccb-f0f5-4376-af35-4e0ced7f584e', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('3b2e8544-fb21-49db-aee7-0c1a35785aa6', 'DSH-4347999675191', 'Pesto Cheese Pandesal (Pack of 5)', 'Cheddar cheese overload, melted on top and infused in the dough.', 155.00, 'dish_img-0000000000041.png', 'Available', '3b7a3f5f-0b9f-472f-937e-4d5b373e8007', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('3f2641c9-7048-4de9-a2d1-265548d96d36', 'DSH-4347999675147', 'Spicy Crispy Chicken Sandwich ', 'With our Spicy Pepper Sauce topping the southern style fried chicken fillet on a toasted potato roll, this sandwich was made for those who like it crispy, juicy, tender and hot.', 150.00, 'dish_img-000000000000.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', '6b9d42cd-affa-44e5-8874-5b810c5b47ee', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('4165c43e-9009-4ae2-92a0-7611ffa86186', 'DSH-4347999675186', 'Kimchi Bokkeumbap', 'Spicy and tangy kimchi fried rice', 300.00, 'dish_img-0000000000036.png', 'Available', '28d6d16e-9031-499b-95af-78496dc90ad9', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('417f6a3d-16b9-410e-a6ef-fbd3049890e5', 'DSH-4347999675168', 'Creamy garlic and 5 Cheese', 'Culinary cream, garlic, pizza cheese, mozzarella, parmesan, cheddar, feta cheese 1', 355.00, 'dish_img-0000000000021.png', 'Available', 'b44991d6-71f8-4786-bd54-c378bcfd3184', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('41ab5823-b3f6-487f-98b1-1070dc45f586', 'DSH-4347999675205', 'Beef Biryani', 'Beef Biryani is a rice-based dish made with spices, rice and beef, mutton, fish, eggs, or vegetables.', 315.00, 'dish_img-0000000000055.png', 'Available', '65b93ccb-f0f5-4376-af35-4e0ced7f584e', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('48c2eb1d-29e7-44f7-ba16-444686474883', 'DSH-4347999675227', 'Roasted Garlic And Shrimp', 'Juicy Shrimps, onions, and garlic on a bed of white wine sauce.', 470.00, 'dish_img-0000000000077.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('4a284e22-635e-4380-abba-bb97b32a8314', 'DSH-4347999675245', 'Chocolate Overload  Roll', 'Chocolate sponge cake in rich chocolate frosting, topped with buttercreme rosettes.', 352.00, 'dish_img-0000000000095.png', 'Available', 'ad76a800-9cfe-450b-b4ae-bee2c43e2943', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('4c6e59ad-6c30-4033-8dcd-ec669184b751', 'DSH-4347999675247', 'Classic Mocha Roll', 'Moist mocha sponge cake iced in mocha buttercreme, sprinkled with twin chocolate chips.', 352.00, 'dish_img-0000000000097.png', 'Available', 'ad76a800-9cfe-450b-b4ae-bee2c43e2943', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('4cf51d96-d8fa-4667-94ae-6a727f379c45', 'DSH-4347999675213', 'Cafe Mocha', 'The secret to a good cafe mocha lies in its ingredients. Chocolatey and slightly sweet, this mocha is for the chocoholics out there looking for a pick-me-up. ', 240.00, 'dish_img-0000000000063.png', 'Available', '9e83c664-ce96-4144-b929-3f040ffd2aaa', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('53540ad8-cf85-462d-96d2-84f1566fc2cb', 'DSH-4347999675250', 'Celebrate Marble 8x12 with filling', 'A combination of vanilla and choco chiffon cake iced with vanilla buttercream icing. The surface and side of the cake is attractively decorated with streaks of chocolate frosting topped with celebrate toppers.', 682.00, 'dish_img-00000000000100.png', 'Available', '9ac755ee-8855-45cc-9615-173eedabcc5e', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('540274e2-1975-462b-afe6-f90c41db78e0', 'DSH-4347999675167', 'Caramel Waffle', 'The iconic Starbucks chewy caramel waffle. Enjoy with coffee for the ultimate sweet delight.', 85.00, 'dish_img-0000000000020.png', 'Available', '63a5313c-86d1-4d15-86fa-f78f93e2a6c4', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('54b9d487-a830-477a-adfc-f03206fd4acb', 'DSH-4347999675211', 'Matcha Latte', 'Rich taste of matcha with fresh Holly\'s milk makes for a delicious and mildy sweet drink.', 220.00, 'dish_img-0000000000061.png', 'Available', '9e83c664-ce96-4144-b929-3f040ffd2aaa', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('55976da7-def4-433f-b2b4-1e8b96bc8f9f', 'DSH-4347999675220', 'K Pasta', 'kimchi, spaghettini, fried egg, cheese, nori shreds, spring onions.', 310.00, 'dish_img-0000000000070.png', 'Available', '5b2a162d-ef68-4408-806f-aa73377de5c4', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('575ccd04-167c-4193-8dbc-fec3c6938e2b', 'DSH-4347999675217', 'Kimchi fried Rice with Maple Bacon Slab', 'topped with spring onion, nori shreds & sunny-side up egg.', 340.00, 'dish_img-0000000000067.png', 'Available', '28d6d16e-9031-499b-95af-78496dc90ad9', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('5801804a-4cea-4882-ade1-93b4fba51af9', 'DSH-4347999675163', 'Sausage Roll', 'Buttery, flaky crust filed with juicy sausage.', 130.00, 'dish_img-000000000016.png', 'Available', '3b7a3f5f-0b9f-472f-937e-4d5b373e8007', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('583a2749-9158-459c-92ea-540ae3a15bc2', 'DSH-4347999675169', 'Halleluia Mozzarella', 'Overload mozzarella cheese', 370.00, 'dish_img-0000000000022.png', 'Available', 'b44991d6-71f8-4786-bd54-c378bcfd3184', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('5c4d5b25-4e16-4ed3-bc35-829350cc2f06', 'DSH-4347999675157', 'Beef Kare Kare', 'Is made from peanut sauce with a variety of vegetables, stewed oxtail,beef, and occasionally offal or tripe.', 550.00, 'dish_img-0000000000010.png', 'Available', '65b93ccb-f0f5-4376-af35-4e0ced7f584e', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('5da2503d-ac8b-4f16-b50e-388238eeb9f4', 'DSH-4347999675148', 'Tokwa\'t Lechon Kawali', 'Classic dishprepared with a mix of lechon kawali and fried tofu served over a sweet and savoury sauce.', 435.00, 'dish_img-000000000001.png', 'Available', '5e585357-fdac-4ddb-8130-696698d6fbe1', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('5f993088-7cd5-41f9-914a-d0020ae2083e', 'DSH-4347999675228', 'Patty Melt', 'Flavorful burger patties with a bit of heat smothered with gooey melted cheese and topped with juicy tomatoes and sweetened onions', 470.00, 'dish_img-0000000000078.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('62eb7eda-dae4-4f1f-bd86-50e19b2aa401', 'DSH-4347999675153', 'Inihaw na tuna belly', 'Tuna belly marinated then grilled until done', 395.00, 'dish_img-000000000006.png', 'Available', '153a356c-9919-4c85-bb0d-599c14df40ef', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('684643c6-f7e7-4c63-b375-05f72c361ae1', 'DSH-4347999675160', 'Meatless and Eggless Breakfast Sandwich (Vegan-friendly!)', 'This savory breakfast sandwich is vegan made with soft, eggless and dairy-free brioche bread filled with minced plant-based meat, mushrooms, and creamy scrambled tofu.', 150.00, 'dish_img-000000000013.png', 'Available', '39b395a4-3c0c-4673-a92c-301f64480f2a', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('6c4e981a-a8cd-428d-b3c4-928c9bb3072a', 'DSH-4347999675209', 'Chicken Biryani', 'A rich and flavorful layered dish served with cooked rice, spiced chickenand mixed vegetables', 265.00, 'dish_img-0000000000059.png', 'Available', '928d7915-ddc2-41b3-a25b-d81228c60457', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('70a5afd2-4167-40b5-b37c-75217b6258bf', 'DSH-4347999675248', 'Celebrate Choco with filling', 'Chocolate flavored chiffon cake with chocolate frosting topped with celebrate toppers.', 682.00, 'dish_img-0000000000098.png', 'Available', '9ac755ee-8855-45cc-9615-173eedabcc5e', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('71fa96cc-3b75-49c8-8786-e045d2eb4bfd', 'DSH-4347999675188', 'Galbitang', 'Beef Short Rib Soup with Glass Noodles', 480.00, 'dish_img-0000000000038.png', 'Available', 'ceacd50f-fcbe-434e-96c4-a95431190815', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('7229d4da-27e8-40c7-878f-ce47696df19a', 'DSH-4347999675223', 'New York\'s Finest', 'Our best selling edge-to-edge pizza packed with 15 kinds of meat and vegetables', 820.00, 'dish_img-0000000000073.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('7241a19d-8337-47b8-9f5b-9be7b9441625', 'DSH-4347999675183', 'Ebi Tempura', '5 pcs Prawn Tempura', 480.00, 'dish_img-0000000000033.png', 'Available', '7940da74-b334-46a6-a70c-259c2375855e', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('79432493-1d1d-4d8c-abe8-3ce224db652c', 'DSH-4347999675165', 'Honey Glazed Doughnut', 'A classic doughnut glazed with delicious sweet icing.', 80.00, 'dish_img-000000000018.png', 'Available', '3b7a3f5f-0b9f-472f-937e-4d5b373e8007', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('7b17c7a9-4d26-48a5-9be7-853085f97d1f', 'DSH-4347999675193', 'Malunggay Pandesal (Pack of 12)', 'Pan de Manila\'s classic favorite pandesal blended with real malunggay bits. A healthy alternative.', 75.00, 'dish_img-0000000000043.png', 'Available', '3b7a3f5f-0b9f-472f-937e-4d5b373e8007', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('81dcf0a9-d637-45fa-8b1c-769522f3ce17', 'DSH-4347999675214', 'Almond Milk Latte', 'Adverse to dairy? A bit of a health nut? We’ve got you covered. Our almond milk bottled lattes use Bonsoy Almond Milk, so it doesn’t just taste good. It is good.', 250.00, 'dish_img-0000000000064.png', 'Available', '9e83c664-ce96-4144-b929-3f040ffd2aaa', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('8cadc39f-526d-4025-945a-6801c2319eea', 'DSH-4347999675192', 'Pandesal Regular (Pack of 12)', 'Pan de Manila\'s classic favorite, baked to perfection with its distinct flavor, brown crust and soft inside.', 65.00, 'dish_img-0000000000042.png', 'Available', '3b7a3f5f-0b9f-472f-937e-4d5b373e8007', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('8e336fe9-1399-4536-9054-22869c08109a', 'DSH-4347999675170', 'Mac and Cheese', 'A macaroni with overload cheese and ham', 115.00, 'dish_img-0000000000023.png', 'Available', '5b2a162d-ef68-4408-806f-aa73377de5c4', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('8e429fba-0195-44e4-b8a0-d84d139b9e94', 'DSH-4347999675202', 'Arayes', 'Beef stuffed pita bread, marinated with many spices and then grilled to crispy perfection', 245.00, 'dish_img-0000000000052.png', 'Available', '3b7a3f5f-0b9f-472f-937e-4d5b373e8007', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9381112a-6c14-44e2-8a98-c8a950b025af', 'DSH-4347999675155', 'Crispy Pata (Regular)', 'Whole pork leg boiled until tender and then deep-fried until golden and crisp', 655.00, 'dish_img-000000000008.png', 'Available', '5e585357-fdac-4ddb-8130-696698d6fbe1', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('93ddb050-9265-493d-85f5-a134c294f60a', 'DSH-4347999675179', 'Toppings so bongga', 'mozzarella cheese, pepperoni, ham, chorizo, bacon, beef, Italian sausage, mushrooms, green pepper, onion, pineapple, tomato, black olive', 370.00, 'dish_img-0000000000029.png', 'Available', 'b44991d6-71f8-4786-bd54-c378bcfd3184', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9402efa8-df9b-435c-bab9-1921f4f36ca6', 'DSH-4347999675171', 'Cheesy lasagna', 'Meaty and Creamy overload cheese', 165.00, 'dish_img-0000000000024.png', 'Available', '5b2a162d-ef68-4408-806f-aa73377de5c4', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('95140c9c-28c6-4551-aec7-315ae9a903f6', 'DSH-4347999675231', 'Galbijjim', 'A variety of gui or grilled dishes in Korean cuisine that is made with marinated beef short ribs in a ganjang-based sauce (Korean soy sauce).', 350.00, 'dish_img-0000000000081.png', 'Available', '65b93ccb-f0f5-4376-af35-4e0ced7f584e', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('96fce579-b2f7-4e7d-b923-5570b4a2fe00', 'DSH-4347999675218', 'Affogato', 'We all scream for iceream err well technically it\'s an Affogato (ice cream + espresso) which honestly makes it even better.', 165.00, 'dish_img-0000000000068.png', 'Available', 'f45a269d-9639-4e46-880c-d8e88c7027c7', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9730cd8f-fce7-416f-b798-f2430dd11cb3', 'DSH-4347999675200', 'Dragon Fruit Jam (220g)', 'All-natural Dragonfruit Jam made from 100% real Dragonfruit. Naturally sweet and tangy.', 170.00, 'dish_img-0000000000050.png', 'Available', '2d79ccfc-8ca7-4f25-8853-5f0ce1eeda80', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9801bd42-6d27-4985-b0e5-775abab78179', 'DSH-4347999675187', 'Doenjang Jjigae', 'Tofu with Beef Stew in Bean Soup *comes with Rice', 350.00, 'dish_img-0000000000037.png', 'Available', 'ceacd50f-fcbe-434e-96c4-a95431190815', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('99a911b8-f5fc-4218-8fac-53343f72627b', 'DSH-4347999675198', 'Peanut Butter Creamy Big (330g)', 'All-natural, smooth and creamy, made with choice peanuts roasted to perfection.', 140.00, 'dish_img-0000000000048.png', 'Available', '2d79ccfc-8ca7-4f25-8853-5f0ce1eeda80', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9a28ceb8-810b-4bd2-a632-5c846b994899', 'DSH-4347999675234', 'Kimchi Jjigae', 'Stew-Like Dish, made with kimchi, tofu, meat and vegetable', 280.00, 'dish_img-0000000000084.png', 'Available', 'ceacd50f-fcbe-434e-96c4-a95431190815', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9a446328-16f3-4a71-b39d-3ba38fc58856', 'DSH-4347999675237', 'Dduk mandoo gook', 'Rice cake soup with beef broth, dumplings and topped with shredded beef and egg', 290.00, 'dish_img-0000000000087.png', 'Available', 'ceacd50f-fcbe-434e-96c4-a95431190815', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9ac867d9-953c-4c4f-bb1e-15879cd04f1e', 'DSH-4347999675208', 'Chicken Mansat', 'A rice dish with dried yogurt made into a creamy and tangy sauce then topped with nuts.', 245.00, 'dish_img-0000000000058.png', 'Available', '928d7915-ddc2-41b3-a25b-d81228c60457', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9c80ad2c-a670-446d-9baf-e278c2f62ec7', 'DSH-4347999675239', 'Soondae', 'A sausage made of Beef and Beancurb stuffed in Pig intestine', 650.00, 'dish_img-0000000000089.png', 'Available', '65b93ccb-f0f5-4376-af35-4e0ced7f584e', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9d793f80-a36b-4304-a85f-07fa45b64775', 'DSH-4347999675162', 'Roasted Chicken Pesto', 'Crusty and soft flat bread filled with juicy roasted sliced chicken breast fillet, sauted shiitake mushroom, Emmental cheese and pesto mayo sauce.', 195.00, 'dish_img-000000000015.png', 'Available', '39b395a4-3c0c-4673-a92c-301f64480f2a', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('a17c6703-4091-41ed-a727-07c3a15270e9', 'DSH-4347999675150', 'Gerry\'s Stuffed Laing (Tinomok)', 'Our fresh bounty from the sea wrapped in taro leaves', 285.00, 'dish_img-000000000003.png', 'Available', '5e585357-fdac-4ddb-8130-696698d6fbe1', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('a511e935-ca9c-49a0-b773-965b67c34130', 'DSH-4347999675158', 'Chocolate Cherrific Cake', 'Combination of soft and moist chocolate cake layers, rich and creamy dark chocolate ganache, and sweet spiked cherry compote, and then finished with light whipped cream and chocolate shavings.', 250.00, 'dish_img-000000000011.png', 'Available', '69cf7537-0534-4715-88cd-c47b45300753', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('aa974098-81cb-454f-9bc3-fd203cd185c5', 'DSH-4347999675212', 'Cold Brew', 'This coffee packs a punch, in terms of caffeine that is! Roughly equal to four cups of coffee, this cold brew tastes of hazelnuts and chocolate. Enjoy the buzz that could last for days. ', 190.00, 'dish_img-0000000000062.png', 'Available', 'f45a269d-9639-4e46-880c-d8e88c7027c7', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('ac75765e-5a89-40f7-9e9d-883dbc8133c1', 'DSH-4347999675164', 'Ham & Cheese French Butter Croissant', 'French butter croissant filled with ham and cheese', 150.00, 'dish_img-000000000017.png', 'Available', '3b7a3f5f-0b9f-472f-937e-4d5b373e8007', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('b54a6d91-41d6-4720-a1f4-1a3ac03a3b5e', 'DSH-4347999675185', 'Tempura Jyu', 'Ebi tempura topped with our special tempura sauce', 350.00, 'dish_img-0000000000035.png', 'Available', '28d6d16e-9031-499b-95af-78496dc90ad9', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('b5f423a9-75ac-4efd-a08c-1396393edf8b', 'DSH-4347999675225', 'Lemon Mallow Tart', 'Meet the latest addition to our dessert menu - the new Lemon Mallow Tarts! Light, zingy, and refreshing lemon curd filling sit on a slightly sweet cookie crust and topped with torched mallows - a perfect way to end a heavy and savory Yellow Cab meal!', 150.00, 'dish_img-0000000000075.png', 'Available', '69cf7537-0534-4715-88cd-c47b45300753', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('bd4c2d0d-413c-4661-b687-28f20b20d8b2', 'DSH-4347999675216', 'Buttermilk Fried Chicken & Ube Waffles', 'ube waffles with buttermilk fried chicken bacon infused maple syrup, salted egg sauce & pickled onions.', 380.00, 'dish_img-0000000000066.png', 'Available', 'bb943b5f-2c56-4d53-ac10-2d1fa439b702', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('bd950cae-7bee-496e-a8fc-d1ddb838996a', 'DSH-4347999675204', 'Roast Beef', 'Beef cooked into a savory sauce with mushroom and other spices. ', 250.00, 'dish_img-0000000000054.png', 'Available', '65b93ccb-f0f5-4376-af35-4e0ced7f584e', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('be4924cd-fdd5-4170-850f-84db4d35b19d', 'DSH-4347999675173', 'Halo-Halo', 'Perfect halo-halo dessert with ice cream and leche flan on the top', 105.00, 'dish_img-0000000000026.png', 'Available', '69cf7537-0534-4715-88cd-c47b45300753', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('c31be692-9acf-43ab-a32a-736596cf537b', 'DSH-4347999675210', 'Cordon Bleu', 'Chicken breast wrapped in mid-flavored cheese, covered in bread crumbs then fried into a firm and crispy perfection', 325.00, 'dish_img-0000000000060.png', 'Available', '928d7915-ddc2-41b3-a25b-d81228c60457', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('c381c949-6a11-46f3-a9ae-400836357901', 'DSH-4347999675189', 'Gamjatang', 'Hearty pork bone soup with potatoes *Not Spicy', 400.00, 'dish_img-0000000000039.png', 'Available', 'ceacd50f-fcbe-434e-96c4-a95431190815', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('c825ddac-9a4a-4353-a5b7-f8b2b0b897bf', 'DSH-4347999675161', 'Salmon Dill w/ Egg', 'Salmon flakes, cream cheese and mozzarella cheese on a multigrain bread.', 195.00, 'dish_img-000000000014.png', 'Available', '39b395a4-3c0c-4673-a92c-301f64480f2a', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('ca256cb9-1f0c-4ad8-8b15-73b8dd7f7c75', 'DSH-4347999675206', 'Beef Mansat', 'A version of rice dish with dried yogurt made into a creamy and tangy sauce then topped with nuts, also considered as Jordan\'s national dish', 275.00, 'dish_img-0000000000056.png', 'Available', '65b93ccb-f0f5-4376-af35-4e0ced7f584e', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('cbadadc4-4621-4dbd-bbee-6ee361d80747', 'DSH-4347999675184', 'Dolsot Bibimbap', ' Assorted topping with rice cooked in stone pot', 350.00, 'dish_img-0000000000034.png', 'Available', '28d6d16e-9031-499b-95af-78496dc90ad9', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('d17aaf0c-ef2d-4d2a-9338-10a7d958dfbc', 'DSH-4347999675199', 'Ube Halaya (230g)', 'All-natural and heavenly made from pure 100% UBE, Milk, Sugar and Butter. No preservatives added.', 135.00, 'dish_img-0000000000049.png', 'Available', '2d79ccfc-8ca7-4f25-8853-5f0ce1eeda80', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('d5170f26-b4f7-48af-80a6-cf5b17f50170', 'DSH-4347999675154', 'Crunchy Squid Heads', 'Fried and Crunchy squid heads', 185.00, 'dish_img-000000000007.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('d6c7ef1c-1630-4c13-923d-d15ab02efc2b', 'DSH-4347999675156', 'Crispy Pata (Family)', 'Whole pork leg boiled until tender and then deep-fried until golden and crisp', 835.00, 'dish_img-000000000009.png', 'Available', '5e585357-fdac-4ddb-8130-696698d6fbe1', '97d5820e-9e94-4c1a-99fb-e9767e491092', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('d8102211-0851-41bd-b55e-f531999c75d5', 'DSH-4347999675244', 'Royal Fudge Cake with Toblerone', 'Deliciously moist chocolate caramel cake with buttercream and choco mousse filling, topped with chocolate ganache, Toblerone chunks, and chocolate shavings.', 682.00, 'dish_img-0000000000094.png', 'Available', '5393fc15-02a3-4fc1-aff2-48ce8daa6b86', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('d989f1bc-b321-486a-89ba-5e79b457dd11', 'DSH-4347999675207', 'Chicken Kebab', 'Ground lean chicken marinated with lots of spices that hails from Jordan and Palestine, pan-grilled to juicy perfection.', 235.00, 'dish_img-0000000000057.png', 'Available', '928d7915-ddc2-41b3-a25b-d81228c60457', '4a125a03-1482-43a3-9faf-9a862518bd7f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('de3ec2ee-5097-4e2d-86e8-ce38566a617c', 'DSH-4347999675242', 'All About Chocolate Cake', 'A moist and fudgy chocolate cake filled with chocolate mousse filling and whipped cream. Iced with chocolate whipped cream and covered with chocolate ganache. It is topped with chocolate flower and chocolate sticks. The sides were decorated by marble chocolate triangle bordered with round chocolate whipped cream.', 792.00, 'dish_img-0000000000092.png', 'Available', '5393fc15-02a3-4fc1-aff2-48ce8daa6b86', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('e323de20-56de-458e-a843-9ed8420ca864', 'DSH-4347999675182', 'Chicken Karaage', 'Japanese Fried Chicken', 320.00, 'dish_img-0000000000032.png', 'Available', '7940da74-b334-46a6-a70c-259c2375855e', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('e45aa560-4a3f-4627-8820-5304170a2b27', 'DSH-4347999675219', 'Latte', 'Heaven in a cuppa.', 170.00, 'dish_img-0000000000069.png', 'Available', '9e83c664-ce96-4144-b929-3f040ffd2aaa', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('e703ec73-31ba-4207-9699-92ee65b4f639', 'DSH-4347999675232', 'Donkas', 'Boneless pork cutlet chops on a bed of silky mashed potatoes', 350.00, 'dish_img-0000000000082.png', 'Available', '5e585357-fdac-4ddb-8130-696698d6fbe1', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('e7652056-8fbc-4e81-9f98-28027c4d78d7', 'DSH-4347999675224', 'Wings', 'A deep-fried unbreaded chicken wings or drumsticks coated with a vinegar-and-cayenne-pepper hot sauce mixed with butter.', 450.00, 'dish_img-0000000000074.png', 'Available', '928d7915-ddc2-41b3-a25b-d81228c60457', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('ea6204f8-cdcb-49b4-a31f-f41f3cc647a9', 'DSH-4347999675238', 'Bulgogi', 'A thin slices of marinated beef. on a grill. The marinade highlights the savory flavors of soy sauce, sasame oil, garlic and the sweet flavors of brown sugar.', 150.00, 'dish_img-0000000000088.png', 'Available', '65b93ccb-f0f5-4376-af35-4e0ced7f584e', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('f1095edc-040b-4d55-a998-dcee991148ed', 'DSH-4347999675175', 'Cheesy Burger Pizza', 'beef, bacon, mozzarella cheese', 355.00, 'dish_img-0000000000028.png', 'Available', 'b44991d6-71f8-4786-bd54-c378bcfd3184', 'ec48a206-da00-4875-ab21-0016794cf330', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('f2d7069e-fdf7-4eb1-a063-84a850bd561a', 'DSH-4347999675166', 'Blueberry-licious Cheesecake', 'A silken smooth, yet light cheesecake swirled with blueberries bursting with flavors. Finished with sweet-tangy blueberry compote. A refreshing dessert!', 170.00, 'dish_img-000000000019.png', 'Available', '69cf7537-0534-4715-88cd-c47b45300753', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('f313954b-3039-44dd-810e-c7961ce2a4da', 'DSH-4347999675240', 'Tteokbokki', 'A chewy rice cakes simmered in an addictive mix of sweet, savory and spicy sauce.', 280.00, 'dish_img-0000000000090.png', 'Available', '806a8aa3-ab7b-42ad-acd4-48706d6526e1', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('f4fa1cf9-f117-48f3-b15f-c13f5486db69', 'DSH-4347999675226', 'Chicken Strips', 'Boneless chicken thigh cut into strips and coated with our special spice mix then fried to crispy perfection', 505.00, 'dish_img-0000000000076.png', 'Available', '928d7915-ddc2-41b3-a25b-d81228c60457', '5ca135f2-c0e7-4849-b332-af0802289f65', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('f89211b9-be84-41e6-8b8b-35af3fe0eec1', 'DSH-4347999675215', 'Spanish Latte', ' Coffee with Dulce de Leche or means tempered condensed milk, if you want to be specific.It’s deliciously sweet and creamy, without being overbearing and blends perfectly with our espresso.', 220.00, 'dish_img-0000000000065.png', 'Available', '9e83c664-ce96-4144-b929-3f040ffd2aaa', '42500097-26a1-4456-83de-4709e51a2751', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('fb41d9c1-4151-41b4-9392-acc1e60a986b', 'DSH-4347999675241', 'Black Forest Cake', 'Layers of rich chocolate cake and creamy cherry filling, frosted in whipped cream and topped with chocolates and cherries.', 682.00, 'dish_img-0000000000091.png', 'Available', '5393fc15-02a3-4fc1-aff2-48ce8daa6b86', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('fc2800e7-76f8-4241-aa81-9397d97019d9', 'DSH-4347999675235', 'Nakji bokkeum', 'Prepared with a small-sized octopus that is sliced and then fried in a flavorful combination of garlic, ginger, and gochujang chili paste, while other additions include sliced vegetables such as onions, scallions, cucumbers, chili peppers, or zucchinis.', 650.00, 'dish_img-0000000000085.png', 'Available', '153a356c-9919-4c85-bb0d-599c14df40ef', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('fe6f825e-60a3-447c-ba59-e20f3c83d138', 'DSH-4347999675249', 'Celebrate Mocha 8x12 with filling', 'Light - brown colored mocha chiffon cake iced with mocha butter créme icing. The sides of the cake are bordered with vanilla butter créme icing topped with balloons toppers', 682.00, 'dish_img-0000000000099.png', 'Available', '9ac755ee-8855-45cc-9615-173eedabcc5e', '8e263315-6950-4369-b4e2-039e3b5d3bc5', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `openinghours`
--

CREATE TABLE `openinghours` (
  `openhrs_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `resto_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `day` varchar(255) NOT NULL,
  `open_time` time NOT NULL,
  `close_time` time NOT NULL,
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `openinghours`
--

INSERT INTO `openinghours` (`openhrs_id`, `resto_id`, `day`, `open_time`, `close_time`, `created_by`, `updated_by`, `deleted_by`, `date_created`, `date_updated`, `date_deleted`) VALUES
('0046e7cf-856b-4d18-99c8-7865b537d2f6', '040eecac-240e-43c0-a9f3-402f51e8ec73', 'Monday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('00c1e086-8a48-4f88-8fba-f147bf2bdcbe', '8e263315-6950-4369-b4e2-039e3b5d3bc5', 'Tuesday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('023f5f7b-f2b5-43f1-85eb-f19144466020', '95592b80-21dd-42dd-9ee6-dcf97c765d04', 'Monday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('06498dee-f1d3-4b4e-a48b-476a0b06def9', '76eef8e8-9103-429c-af7f-b7731ebe2616', 'Friday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('06ba46da-978d-4fd1-b96b-3994690fdeeb', '95592b80-21dd-42dd-9ee6-dcf97c765d04', 'Thursday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('07e65cec-96b3-4a90-be00-0843619a0c0b', 'db92e05e-509e-43ae-9385-4d4aaf2cf2a7', 'Wednesday', '10:00:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('0a53513e-b9b0-4c30-badc-0bac8f3b6c4b', '033579a5-6dca-4e93-915d-fcf4de53722c', 'Thursday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('0bbc3d98-b913-4ea4-bbe4-b5167caf0e48', '42500097-26a1-4456-83de-4709e51a2751', 'Saturday', '09:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('0f7b09ff-6944-499d-879e-dd550bf91129', '4a125a03-1482-43a3-9faf-9a862518bd7f', 'Friday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('111faea3-0c54-4d5d-b4e7-c1db648997ed', '040eecac-240e-43c0-a9f3-402f51e8ec73', 'Wednesday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('14392829-c075-4292-8484-e28ef1791fb1', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', 'Monday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('16119e22-5d0b-4aeb-9f98-2bab39ff1f58', '9715b035-2cec-4933-b39d-d0bd82bb858d', 'Saturday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('1f03de10-1d90-4302-a23c-7c157865452d', '8e263315-6950-4369-b4e2-039e3b5d3bc5', 'Saturday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('1fd5791a-6012-42a2-8f2c-46381cfcf6c7', '3c698b91-a6b8-4b13-9e82-b77043d41089', 'Friday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('2093a09c-8880-4fcf-af40-9d0526d1651b', '040eecac-240e-43c0-a9f3-402f51e8ec73', 'Saturday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('223531f7-c7d8-4ab2-862e-62d655cadcd4', '4a125a03-1482-43a3-9faf-9a862518bd7f', 'Thursday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('259dd630-b161-4512-93a1-b249ad9a8943', '4a125a03-1482-43a3-9faf-9a862518bd7f', 'Wednesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('25c60e39-1240-4f48-8feb-e4817971a7fa', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', 'Saturday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('25f1f950-e0fc-4a11-8744-74738c70ed56', '6b9d42cd-affa-44e5-8874-5b810c5b47ee', 'Friday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('26942103-1132-4a1c-a8b5-6f03cfa3f82e', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', 'Monday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('2730e355-9d75-4d7b-a225-e3302e237bbc', '95592b80-21dd-42dd-9ee6-dcf97c765d04', 'Tuesday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('284d6973-7351-4407-b916-bcbaaa013300', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', 'Tuesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('2c86575d-fa74-43d8-9a40-81479583f675', '5ca135f2-c0e7-4849-b332-af0802289f65', 'Saturday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('2de08b40-08cc-4a8f-8372-08c1c6929aae', '8e263315-6950-4369-b4e2-039e3b5d3bc5', 'Monday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('2e28c356-51b5-4b22-81c5-55e70bc0a0fb', '5ca135f2-c0e7-4849-b332-af0802289f65', 'Wednesday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('31f81f64-2c68-416e-beb8-934651757b2e', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', 'Thursday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('36ba4aa6-79a7-4f55-ba2c-1ad5e88735bf', 'db92e05e-509e-43ae-9385-4d4aaf2cf2a7', 'Friday', '10:00:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('38656612-27e7-422e-8117-b50a911c1ad3', '5ca135f2-c0e7-4849-b332-af0802289f65', 'Friday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('386636d0-e500-4625-93a1-c82ac9eda00e', 'ec48a206-da00-4875-ab21-0016794cf330', 'Wednesday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('38a69e22-7fca-43c1-be7c-39f1d4dfda4d', 'ec48a206-da00-4875-ab21-0016794cf330', 'Monday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('3b51fd8c-b174-4d15-b52a-51c2eadf9985', '8e263315-6950-4369-b4e2-039e3b5d3bc5', 'Friday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('3b6375e8-708b-4df4-b5d0-d3a437cf8acd', '76eef8e8-9103-429c-af7f-b7731ebe2616', 'Monday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('3d40fbb8-62ea-4c28-9c26-a8916b48004b', '040eecac-240e-43c0-a9f3-402f51e8ec73', 'Tuesday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('3fa87227-8a72-4760-a2cd-7a2810f32d4d', 'db92e05e-509e-43ae-9385-4d4aaf2cf2a7', 'Monday', '10:00:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('40c938ad-dcd4-48da-bfcb-ce3e8c148685', '6b9d42cd-affa-44e5-8874-5b810c5b47ee', 'Saturday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('46858f9b-39d5-4926-9a67-cb467f4cec5d', '9715b035-2cec-4933-b39d-d0bd82bb858d', 'Friday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('4916c5a4-1d09-4a9d-9c2a-7190c1adf174', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', 'Thursday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('496733a2-25c9-4340-8a1f-673254c8a125', '42500097-26a1-4456-83de-4709e51a2751', 'Thursday', '09:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('49f2c19e-8cf1-44d1-9d20-6783b8c90e93', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', 'Thursday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('4aab4a21-4a58-48b6-b1b8-95b24e21e201', 'afa5ea13-ffdc-46c3-85ad-100b5e642092', 'Friday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('4d1921f5-c1b9-4dc6-9d08-31c41cf70f6a', '3c698b91-a6b8-4b13-9e82-b77043d41089', 'Thursday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('4def6b76-8cb1-40b1-80f2-580e0d0c2215', '42500097-26a1-4456-83de-4709e51a2751', 'Wednesday', '09:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('4ee4f57e-7e86-46a3-b609-70a1b381c5fe', '6b9d42cd-affa-44e5-8874-5b810c5b47ee', 'Monday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('52cf9d6c-39c3-40a6-9fce-5756d2443d0a', '040eecac-240e-43c0-a9f3-402f51e8ec73', 'Thursday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('52e2168f-0a03-437e-bf8c-d0ed112976cd', '3c698b91-a6b8-4b13-9e82-b77043d41089', 'Monday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('52e247b1-a5f8-428d-abda-b6e339b57731', '42500097-26a1-4456-83de-4709e51a2751', 'Monday', '09:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('583f182c-ce19-42e2-9ac7-e1f247097b86', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', 'Friday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('588b4583-011f-4bc7-a26b-668349262f33', '97d5820e-9e94-4c1a-99fb-e9767e491092', 'Friday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('5e0c71a6-9e89-473d-a799-f4fea8beca11', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', 'Wednesday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('5e2153f2-654d-4640-a87d-3b8e4da2ce13', 'afa5ea13-ffdc-46c3-85ad-100b5e642092', 'Thursday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('5ec61070-dc7c-47e6-97b1-a976ccb2fe37', '732164d4-e7c4-4d0b-9969-9a1b1b3cde03', 'Saturday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('61908e93-5ba8-4245-979b-1a16091b88fe', '30bcd7a5-415b-49b6-8933-720fe958065e', 'Wednesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('637de359-2a5c-490e-9753-8a1e25c073cb', '97d5820e-9e94-4c1a-99fb-e9767e491092', 'Monday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('638b402c-399e-4cee-aecf-c7c8198ccbbd', '42500097-26a1-4456-83de-4709e51a2751', 'Tuesday', '09:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('64d2995a-4ee8-437a-b865-aa06d113b0bc', 'afa5ea13-ffdc-46c3-85ad-100b5e642092', 'Saturday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('682f911c-dd58-4335-ae90-a1f9890b9b25', 'ec48a206-da00-4875-ab21-0016794cf330', 'Saturday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('686bc1c5-1ace-4c6e-a3cc-e5e424ff8b4d', '9715b035-2cec-4933-b39d-d0bd82bb858d', 'Wednesday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('69eeea30-7384-425f-ac98-f14e29757ac9', '76eef8e8-9103-429c-af7f-b7731ebe2616', 'Wednesday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('6e36a209-b796-4888-b2eb-6fa889bc98bb', '30bcd7a5-415b-49b6-8933-720fe958065e', 'Saturday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('6f0bad85-b4e9-4f89-94e5-b8fb861fdc2f', '033579a5-6dca-4e93-915d-fcf4de53722c', 'Monday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('702b1922-e298-471e-b4fc-8526234c4a17', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', 'Tuesday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('70b8deba-93bd-43cb-9eef-0f8e8e83f38f', '95592b80-21dd-42dd-9ee6-dcf97c765d04', 'Wednesday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('70ed846e-be1c-4350-87d1-299412167566', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', 'Monday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('7109c46d-4dc1-42fc-b2df-056e5fff07ed', '6b9d42cd-affa-44e5-8874-5b810c5b47ee', 'Tuesday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('7390f0bc-d922-4c32-8062-b8ad6c171978', '9715b035-2cec-4933-b39d-d0bd82bb858d', 'Monday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('7669bf85-fc12-46ca-9451-4a585ca31e52', '3c698b91-a6b8-4b13-9e82-b77043d41089', 'Tuesday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('787f5cf9-94c2-439f-ad94-838264bb53c4', '040eecac-240e-43c0-a9f3-402f51e8ec73', 'Friday', '10:30:00', '221:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('7c0ac354-b5bb-44f7-b661-946267bbba15', '732164d4-e7c4-4d0b-9969-9a1b1b3cde03', 'Friday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('7d4e3880-c0d0-42d8-b243-f4685fc149e1', 'afa5ea13-ffdc-46c3-85ad-100b5e642092', 'Monday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('82dacfd4-4799-422b-9f31-da39b9988da1', '033579a5-6dca-4e93-915d-fcf4de53722c', 'Tuesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8374f2bf-3782-474b-8087-652209b5178f', '30bcd7a5-415b-49b6-8933-720fe958065e', 'Monday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8908fcf8-0d57-48c7-86bf-7c6cf8cc389c', '3c698b91-a6b8-4b13-9e82-b77043d41089', 'Wednesday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('89dffef0-fd64-4dfd-b7c4-474fff437b5f', 'ec48a206-da00-4875-ab21-0016794cf330', 'Thursday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8b413f45-87fb-49e2-a4ab-a595f551574d', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', 'Wednesday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8b5359dd-7048-4ead-b3a7-637609f4a1ad', 'db92e05e-509e-43ae-9385-4d4aaf2cf2a7', 'Saturday', '10:00:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8d5c43d8-4ddb-44e9-bb5b-4cbbbf1ecbb6', '3c698b91-a6b8-4b13-9e82-b77043d41089', 'Saturday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8d8459d9-1b2c-4339-b191-8d33fb941720', '30bcd7a5-415b-49b6-8933-720fe958065e', 'Friday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('8e9c016f-be7b-4de2-975f-c41acf8f66c8', '5ca135f2-c0e7-4849-b332-af0802289f65', 'Monday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('96f37a78-194c-4c86-8b8e-83a87ebfbdae', '76eef8e8-9103-429c-af7f-b7731ebe2616', 'Saturday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('9b25c5be-ef63-46d2-a90a-b6729f637986', '6b9d42cd-affa-44e5-8874-5b810c5b47ee', 'Thursday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('9e845dce-7a98-4165-b76f-0dd9806d2639', '30bcd7a5-415b-49b6-8933-720fe958065e', 'Thursday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('9e9f9082-6013-4483-9c22-56c9d8b29ea8', 'ec48a206-da00-4875-ab21-0016794cf330', 'Tuesday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('9fb77b2e-0c7c-44d3-914e-f9538daa7062', '95592b80-21dd-42dd-9ee6-dcf97c765d04', 'Friday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('a1e34fde-d937-4b73-84a7-247f99e2be53', '76eef8e8-9103-429c-af7f-b7731ebe2616', 'Thursday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('a24faa33-8afe-4e97-bc75-866688f7c0de', '732164d4-e7c4-4d0b-9969-9a1b1b3cde03', 'Thursday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('a301da6b-4e57-4d58-98e0-7d84ac1abc89', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', 'Saturday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('a382b0c7-cce8-42c2-a315-d3c0383ca9b1', '95592b80-21dd-42dd-9ee6-dcf97c765d04', 'Saturday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('a7027112-a034-4b31-a5d0-bab36adb66da', '732164d4-e7c4-4d0b-9969-9a1b1b3cde03', 'Monday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('b191379f-023e-40d5-92d2-16fe1e2925b0', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', 'Wednesday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('b77fd401-425e-42ab-a642-46963e109575', 'db92e05e-509e-43ae-9385-4d4aaf2cf2a7', 'Thursday', '10:00:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('ba2797dc-be40-4a7b-9296-155097917744', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', 'Tuesday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('bbd3db20-d6d0-4ce3-91e4-be1fcea1074f', '8e263315-6950-4369-b4e2-039e3b5d3bc5', 'Wednesday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('c454511a-51f7-42ff-8e4f-9b72272ac0ab', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', 'Thursday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('c7d481de-8644-46fb-be88-32250dde796b', '4a125a03-1482-43a3-9faf-9a862518bd7f', 'Saturday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('ca625b6e-0505-4a98-abdd-7faddf9f7e56', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', 'Friday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('cba70eca-33da-423e-9b52-c4f14341d840', '033579a5-6dca-4e93-915d-fcf4de53722c', 'Saturday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('ce47e526-b3f2-46a8-84bf-d9c8692d6614', '4a125a03-1482-43a3-9faf-9a862518bd7f', 'Monday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d172977c-9e01-4e2b-940b-43489c994643', '97d5820e-9e94-4c1a-99fb-e9767e491092', 'Saturday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d4380560-3789-4e2d-880c-17cab7eb4714', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', 'Saturday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d53c04e1-f472-4973-a2b2-860b3babf383', 'afa5ea13-ffdc-46c3-85ad-100b5e642092', 'Wednesday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d5ac25d1-a882-4b60-a86e-a5e26c958a4b', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', 'Wednesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d5eeed02-4359-42b8-a55b-1a729ca7705b', '42500097-26a1-4456-83de-4709e51a2751', 'Friday', '09:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d6134e08-63c2-46c2-a44a-803f291604cf', '97d5820e-9e94-4c1a-99fb-e9767e491092', 'Thursday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d7b5f870-49a2-45bd-8108-a75508155bc8', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', 'Monday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d85e2d86-7917-4d98-8bb5-c9c5c3c6da33', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', 'Friday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('d9bf997c-51d7-4009-b91b-dfeac919ee73', 'ec48a206-da00-4875-ab21-0016794cf330', 'Friday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('dc00ef40-c145-420d-8a8c-3a99a5197abc', '732164d4-e7c4-4d0b-9969-9a1b1b3cde03', 'Wednesday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('dd9207b3-3be4-49ed-ad50-a1595f05b7af', '6b9d42cd-affa-44e5-8874-5b810c5b47ee', 'Wednesday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e13783ac-d954-4e2c-8860-679ea32697e1', '9715b035-2cec-4933-b39d-d0bd82bb858d', 'Tuesday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e2bda856-2b5a-4280-8e8c-feae306b4da0', '76eef8e8-9103-429c-af7f-b7731ebe2616', 'Tuesday', '09:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e2fc69a4-a7c1-4147-8deb-f62d1d72e855', '033579a5-6dca-4e93-915d-fcf4de53722c', 'Wednesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e483b9ed-1b96-4965-b22f-e6b4a0b491d3', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', 'Saturday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e4d70587-5c6c-4333-9b22-8776b3d75ab0', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', 'Tuesday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e53ff580-21db-435a-8f76-efb26bcc5dcf', '732164d4-e7c4-4d0b-9969-9a1b1b3cde03', 'Tuesday', '10:30:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e6bfe308-b3c6-4b0c-a106-1560ef8ca9cd', 'afa5ea13-ffdc-46c3-85ad-100b5e642092', 'Tuesday', '10:30:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('e8f9cb69-64f4-4240-86af-ac8f4a9b3145', '5ca135f2-c0e7-4849-b332-af0802289f65', 'Thursday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('eb18d17a-c7b2-4f37-870c-ac9df267d019', 'db92e05e-509e-43ae-9385-4d4aaf2cf2a7', 'Tuesday', '10:00:00', '21:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('ebffdf44-c5e0-4411-9ce9-6bd2c016223a', '033579a5-6dca-4e93-915d-fcf4de53722c', 'Friday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('ec225198-cb6f-4624-9c32-d948ddf208f5', '30bcd7a5-415b-49b6-8933-720fe958065e', 'Tuesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('efea20f4-aaae-4bfa-b5b0-cd97151bbd06', '4a125a03-1482-43a3-9faf-9a862518bd7f', 'Tuesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('f5e5ed31-3aa0-408c-a96f-50a1850a684f', '5ca135f2-c0e7-4849-b332-af0802289f65', 'Tuesday', '10:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('f6a691df-254b-4b0e-a0a0-b4a3c45b01e9', '8e263315-6950-4369-b4e2-039e3b5d3bc5', 'Thursday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('f7bdfb5d-d00e-4d90-88a0-737d0fa510cd', '97d5820e-9e94-4c1a-99fb-e9767e491092', 'Wednesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('fd8df896-38d6-4646-b20d-d402dc61d830', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', 'Friday', '09:00:00', '21:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('fdb58bb4-b114-468d-afcb-31043ff0f9f4', '9715b035-2cec-4933-b39d-d0bd82bb858d', 'Thursday', '08:30:00', '20:30:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
('ff7828fe-e37a-4dd9-91ad-6f157e01a0ed', '97d5820e-9e94-4c1a-99fb-e9767e491092', 'Tuesday', '08:00:00', '20:00:00', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `orddetail_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `quantity` int(10) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL COMMENT 'Dish(dish_price) * OrderDetails(quantity)',
  `dish_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `order_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `order_no` varchar(17) NOT NULL,
  `resto_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `order_status` varchar(255) NOT NULL DEFAULT 'Pending',
  `order_total` decimal(10,2) NOT NULL COMMENT 'Sum of the OrderDetails(subtotal) of all rows with the same order_id',
  `order_comment` text DEFAULT NULL COMMENT 'Remarks/ Additional Request from customer',
  `address_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL COMMENT 'Date and time in which the order/food has been processed by the restaurant and is sent to the kitchen for preparation and cooking.',
  `date_cancelled` datetime DEFAULT NULL COMMENT 'Date and time in which the order/food is cancelled by the customer.',
  `date_released` datetime DEFAULT NULL COMMENT 'Date and time in which the order/food is released from the restaurant and dispatched to the courier',
  `date_rejected` datetime DEFAULT NULL COMMENT 'Date and time in which the order has been rejected',
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `payment_no` varchar(17) NOT NULL,
  `order_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `payment_status` varchar(255) NOT NULL DEFAULT 'Pending',
  `payment_total` decimal(10,2) NOT NULL COMMENT 'Total payment made by the customer.',
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `restaurants`
--

CREATE TABLE `restaurants` (
  `resto_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `resto_no` varchar(17) NOT NULL,
  `resto_name` varchar(255) NOT NULL,
  `resto_email` varchar(255) NOT NULL,
  `resto_phone` varchar(13) DEFAULT NULL COMMENT 'Phone number must start with "09" or "+639" and only up 13 characters',
  `resto_landline` varchar(8) NOT NULL COMMENT 'Landline number should have 8 digits.',
  `resto_website` varchar(255) NOT NULL,
  `resto_img` varchar(255) NOT NULL,
  `restocatg_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Open',
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `restaurants`
--

INSERT INTO `restaurants` (`resto_id`, `resto_no`, `resto_name`, `resto_email`, `resto_phone`, `resto_landline`, `resto_website`, `resto_img`, `restocatg_id`, `status`, `created_by`, `updated_by`, `deleted_by`, `date_created`, `date_updated`, `date_deleted`) VALUES
('033579a5-6dca-4e93-915d-fcf4de53722c', 'RTO-3478399741592', 'Seattle\'s Best Coffee', 'guestservice@sbc.com.ph', '+63 (2) 8 421', '+63 (2) ', 'seattlesbest.com.ph', 'resto_img-000000000014.png', 'fd60177c-bc1f-4913-b7fc-a15dc620dac3', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('040eecac-240e-43c0-a9f3-402f51e8ec73', 'RTO-3478399741595', 'GOGI Korean BBQ', 'gogi,philippines@gmail.com', '+63 (916) 595', '6598-986', 'www.facebook.com/gogi.ph', 'resto_img-000000000017.png', '39232f1f-5d58-4b6f-ab8d-3585aeaca194', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('08dca6c6-331c-4ebb-a303-8097d17ce1c7', 'RTO-3478399737451', 'Pan De Manila', 'pandemanila@gmail.com', '09325478165', '8433-555', 'www.pandemanila.com.ph', 'resto_img-000000000005.png', '05baa8f5-0884-4206-a65a-6d1925756d39', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('30bcd7a5-415b-49b6-8933-720fe958065e', 'RTO-3478399741596', 'Hwarang Korean Restaurant', 'hwarang.kr@gmail.com', '09563278559', '+63 (2) ', 'www.hwarangkreso.com', 'resto_img-000000000018.png', '39232f1f-5d58-4b6f-ab8d-3585aeaca194', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('3c698b91-a6b8-4b13-9e82-b77043d41089', 'RTO-3478399741597', 'Papa Johns Pizza', 'info@papajohns.com.ph', '09154548668', '+63 (2) ', 'papajohns.com.ph', 'resto_img-000000000019.png', '5dabdaac-3751-42d5-baa5-4e0d03d4923c', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('42500097-26a1-4456-83de-4709e51a2751', 'RTO-3478399737453', 'The Fat Seed Cafe', 'thefatseedph@gmail.com', '09452781134', '8936-211', 'www.thefatseedph.com', 'resto_img-000000000007.png', 'fd60177c-bc1f-4913-b7fc-a15dc620dac3', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('4a125a03-1482-43a3-9faf-9a862518bd7f', 'RTO-3478399737452', 'The Melting Potluck', 'meltingpotluck@gmail.com', '09152533335', '8533-333', 'www.meltingpotluck.com.ph', 'resto_img-000000000006.png', '200080d5-29df-4157-8e9e-7c613356f9ce', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('5ca135f2-c0e7-4849-b332-af0802289f65', 'RTO-3478399737454', 'Yellow Cab Pizza Co.', 'onlinesupport@yellowcabpizza.com', '09188035571', '8789-999', 'www.delivery.yellowcabpizza.com', 'resto_img-000000000008.png', '5dabdaac-3751-42d5-baa5-4e0d03d4923c', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('6b9d42cd-affa-44e5-8874-5b810c5b47ee', 'RTO-3478399737446', 'Jollibot', 'jollibee@gmail.com', '09451152076', '12345678', 'www.jollibee.com', 'resto_img-000000000000.png', '3cd1db04-f8a5-4560-82cc-2b467aaac0eb', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('732164d4-e7c4-4d0b-9969-9a1b1b3cde03', 'RTO-3478399741589', 'Conti’s Bakeshop & Restaurant', 'ctf.contis@yahoo.com', '09514548948', '8921 347', 'www.contis.ph', 'resto_img-000000000011.png', '05baa8f5-0884-4206-a65a-6d1925756d39', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('76eef8e8-9103-429c-af7f-b7731ebe2616', 'RTO-3478399741591', 'Cafe France', 'cf_unave@cafefrance.net', '+63 (2) 8 254', '+63 (2) ', 'www.cafefrance.net', 'resto_img-000000000013.png', 'fd60177c-bc1f-4913-b7fc-a15dc620dac3', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('8e263315-6950-4369-b4e2-039e3b5d3bc5', 'RTO-3478399737456', 'Goldilocks', 'customercare@goldilocks.com.ph', '09862544713', '2532-271', 'www.goldilocks.com.ph', 'resto_img-000000000010.png', '05baa8f5-0884-4206-a65a-6d1925756d39', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('95592b80-21dd-42dd-9ee6-dcf97c765d04', 'RTO-3478399741594', 'Ilustrado Restaurant', 'catering@ilustradorestaurant.com', '+63 (998) 850', '+63 (2) ', 'ilustradorestaurant.com.ph', 'resto_img-000000000016.png', '200080d5-29df-4157-8e9e-7c613356f9ce', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9715b035-2cec-4933-b39d-d0bd82bb858d', 'RTO-3478399741590', 'The French Baker', 'info@thefrenchbaker.com', '09298564842', '+63 (2) ', 'thefrenchbaker.com', 'resto_img-000000000012.png', '05baa8f5-0884-4206-a65a-6d1925756d39', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('97d5820e-9e94-4c1a-99fb-e9767e491092', 'RTO-3478399737447', 'Gerrys Grill', 'gerrysgrill@gmail.com', '09175011273', '8332-111', 'www.gerrysgrill.com.ph', 'resto_img-000000000001.png', '200080d5-29df-4157-8e9e-7c613356f9ce', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', 'RTO-3478399737448', 'Starbucks', 'customer@rustancoffee.ph', '09457157924', '8462-626', 'www.starbucks.ph', 'resto_img-000000000002.png', 'fd60177c-bc1f-4913-b7fc-a15dc620dac3', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('afa5ea13-ffdc-46c3-85ad-100b5e642092', 'RTO-3478399741598', 'Pizza Hut', 'phutcsc@pizzahut.com.ph', '09884546235', '828-7007', 'https://www.pizzahut.com.ph/', 'resto_img-000000000020.png', '5dabdaac-3751-42d5-baa5-4e0d03d4923c', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('d23fef9f-6faf-4abf-a987-a27dcef3977f', 'RTO-3478399737450', 'Seoul Train Korean BBQ', 'eat@seoultrain.ph', '09177722203', '8733-111', 'http://bit.ly/minimall-st', 'resto_img-000000000004.png', '39232f1f-5d58-4b6f-ab8d-3585aeaca194', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('db92e05e-509e-43ae-9385-4d4aaf2cf2a7', 'RTO-3478399741593', 'Lemuria Gourmet Restaurant', 'lemuria@brumms.com.ph', '+63 (927) 428', '93693311', 'www.lemuria.com.ph', 'resto_img-000000000015.png', '200080d5-29df-4157-8e9e-7c613356f9ce', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('ec48a206-da00-4875-ab21-0016794cf330', 'RTO-3478399737449', 'Angels Pizza', 'angelspizza@gmail.com', '09287635411', '8922-222', 'www.angelspizza.com.ph', 'resto_img-000000000003.png', '5dabdaac-3751-42d5-baa5-4e0d03d4923c', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', 'RTO-3478399737455', 'OGANE Restaurant', 'paradise30399@yahoo.com.ph', '09557428535', '7794-278', 'oganerestaurant.com.ph', 'resto_img-000000000009.png', '39232f1f-5d58-4b6f-ab8d-3585aeaca194', 'Open', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `restocategories`
--

CREATE TABLE `restocategories` (
  `restocatg_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `restocatg_name` varchar(255) NOT NULL,
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `restocategories`
--

INSERT INTO `restocategories` (`restocatg_id`, `restocatg_name`, `created_by`, `updated_by`, `deleted_by`, `date_created`, `date_updated`, `date_deleted`) VALUES
('05baa8f5-0884-4206-a65a-6d1925756d39', 'Bakery', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('200080d5-29df-4157-8e9e-7c613356f9ce', 'Fine Dining', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('39232f1f-5d58-4b6f-ab8d-3585aeaca194', 'Korean', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('3cd1db04-f8a5-4560-82cc-2b467aaac0eb', 'Fast Food', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('5dabdaac-3751-42d5-baa5-4e0d03d4923c', 'Pizzerias', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('fd60177c-bc1f-4913-b7fc-a15dc620dac3', 'Cafe', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `resto_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user_no` varchar(17) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `email_address` varchar(255) NOT NULL,
  `phone_number` varchar(13) DEFAULT NULL COMMENT 'Phone number must start with "09" or "+639" and only up 13 characters',
  `gender` varchar(255) DEFAULT NULL,
  `user_type` varchar(255) NOT NULL DEFAULT 'Customer',
  `created_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deleted_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `resto_id`, `user_no`, `password`, `first_name`, `middle_name`, `last_name`, `email_address`, `phone_number`, `gender`, `user_type`, `created_by`, `updated_by`, `deleted_by`, `date_created`, `date_updated`, `date_deleted`) VALUES
('00ae9d57-c569-443e-bf05-f916aa215c6d', NULL, 'USR-2608799801099', '$2b$10$kTyIGcTkmNLpyKumxEc1.uXU.CX6Qsrg793C9RwwQ9PZH.duDZC5K', 'Frankly', NULL, 'Samson', 'samsonfrankly21@gmail.com', '09382746311', 'Male', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:27', '2025-02-10 15:04:27', NULL),
('02b9b6db-b044-4e83-bc16-85e1d6d02509', NULL, 'USR-2608799800366', '$2b$10$V7Xe23jB0YTCnN9hyMGWZePTnQLRxLoAVsCyDZZwLHpRrgSPjUnuW', 'Jerald', NULL, 'Guillermo', 'jerald05@gmail.com', '09482749382', 'Male', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:26', '2025-02-10 15:04:26', NULL),
('02f6fa67-3522-4e41-a1f8-962065aa080d', NULL, 'USR-2608799801341', '$2b$10$bEoNhAleZrarK3EwnrUk9uHPO5RhZ2BKFSL604P4r5aYEO3ZTg3Wm', 'James', NULL, 'Smith', 'smithjames11@gmail.com', '09673849384', 'Male', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:27', '2025-02-10 15:04:27', NULL),
('0f98dea5-37b7-4c51-a081-d7086af09d4a', '9715b035-2cec-4933-b39d-d0bd82bb858d', 'USR-2608799806637', '$2b$10$HMHZ11O365nwR9mmPx02jOCfxb5hKm.JfuPfMxzeT6nmbGesSsL7q', 'Marian Mae', NULL, 'Simon', 'mariasimon28@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('1a90b095-3121-4cae-a766-ed18f907a398', NULL, 'USR-2608799800608', '$2b$10$q49VzNHT5/x.BvMphCLWLupcQf/ppjRM3zx6PkA7jS/MzAchGxz7C', 'Allison', NULL, 'Locsin', 'allilocsin@gmail.com', '09752048137', 'Female', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:27', '2025-02-10 15:04:27', NULL),
('1ea006a5-1a64-4ac3-a601-3c76a43eaa60', 'ec48a206-da00-4875-ab21-0016794cf330', 'USR-2608799803663', '$2b$10$d17HCOBbTjbq7s3/mvIjm.5XRvtF/RYCC6MgSqI3wqJvqY4RQtEuC', 'Sydney', 'Blayne', 'Bonilla', 'Sydney@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('29810573-358a-4a3b-8e20-d88c346befd8', '95592b80-21dd-42dd-9ee6-dcf97c765d04', 'USR-2608799807124', '$2b$10$WbWDkmJxgODEwRqujyv6h.ewAeGwx9SLwDMw/YC6hWGVjZu4tKWdm', 'Lyndsey Ann', 'Minezes', 'Bartolome', 'annlynbartolome@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('2aa66525-0df5-46cc-a741-76dc983d994c', '9bd5ce9a-b830-4f31-a8aa-e8d42fd4393b', 'USR-2608799803542', '$2b$10$5yP9wOwXpTbKIX2bffVlTuVKZjiM5Y42.0eIspQ.gX2UiJmjuv3JG', 'Lee', 'Caprice', 'Maynard', 'Lee@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('33a11cdd-29df-4881-b76a-8b8615a1e052', NULL, 'USR-2608799805540', '$2b$10$ex99j8HQv.3QiSoc5H0JLeeYRPaG.DJIARW4yZcRNZLZfxGIZGoQi', 'Josiah', NULL, 'Fallesgon', 'JosiahFallesgon@gmail.com', NULL, NULL, 'Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('585f0dca-ff76-42ac-99c2-30729ad5fbd7', NULL, 'USR-2608799800487', '$2b$10$HPDghuWHKf0pUCPICcMjiuZZtl4IVVK2HUO87FJHNWY8vHuzZqh4W', 'Shaine', 'Rieta', 'Villanueva', 'shainevil30@gmail.com', '09592749184', 'Female', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:27', '2025-02-10 15:04:27', NULL),
('5ee77a6d-d4d1-4a4c-bf7a-a346ed839ad7', NULL, 'USR-2608799805905', '$2b$10$FQkjJbSlDBAsYG9zemDHoebREAlQdscv0nwKR5eFsxfLiW/mRZo1G', 'Emman', NULL, 'Peralta', 'EmmanPeralta@gmail.com', NULL, NULL, 'Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, 'USR-9999999999999', '$2b$10$gyW9J7MbXzLGc/t7I0l5CeilAEY9dAtnmoQwnvxxDcme1T0.pjNim', 'System', NULL, 'Admin', 'sysadmin@gmail.com', NULL, NULL, 'Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:26', '2025-02-10 15:04:26', NULL),
('75e58ffc-f2a1-420b-b162-0dd5a926b25b', NULL, 'USR-2608799801462', '$2b$10$ZWQPPESwAPIVVdTlwHY60eqbJbU/xx62uboWo9MEWpoPRYZ/Xtkq6', 'Charles', 'Julian', 'Fowler', 'charlesfowler@gmail.com', '09243849261', 'Male', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:27', '2025-02-10 15:04:27', NULL),
('862cf964-bc9e-44b2-80bc-20c3eaeddf92', NULL, 'USR-2608799805415', '$2b$10$B4WWAsr7sYZGiUhPsefWCezTgF3y8OHEGOZxpDpd9nXUMC9/16PW6', 'Micah', NULL, 'Villaruz', 'micahmvillaruz@gmail.com', NULL, NULL, 'Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('87ea24dc-79ca-492a-a93c-0f93b022c761', NULL, 'USR-2608799805782', '$2b$10$PlQKMrZZV9A2ZSea0ibOHOOOvSkOC3Xxq5L.e6bptYDUPn8EaIjFW', 'Ashlee Jude', NULL, 'Delmundo', 'AJDelmundo@gmail.com', NULL, NULL, 'Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('92849e50-b4c1-4b61-a5d5-d64bfa4b2024', '76eef8e8-9103-429c-af7f-b7731ebe2616', 'USR-2608799806758', '$2b$10$iF3Z4kxWKXr6SsfKxM9lPe.jrcPLTh4Uc1H5W2N.1pj6sRvmwbkEm', 'Gregg', 'Mendez', 'Lopez', 'mendezgregg@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('93058754-c5f5-4d4e-bd99-8a3303d2eba7', '732164d4-e7c4-4d0b-9969-9a1b1b3cde03', 'USR-2608799806508', '$2b$10$qfLvZ5Lwj3yQdaWP3JkBaOEhTRf/qiowi82WfCGhEVL3b4K.p9aJq', 'Vicky', NULL, 'Sanchez', 'vickysanchez@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('95b10df6-8aca-4185-a87e-5f6f2e250007', NULL, 'USR-2608799801220', '$2b$10$a3N9VuUNYSghZRr/RBykK.39keWm3oK4w5kmnr4NA1UWtzhvgafKW', 'Mellissa', 'Cruz', 'Taylor', 'melcruztaylor@gmail.com', '09997492838', 'Female', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:27', '2025-02-10 15:04:27', NULL),
('96c2d011-87f2-48da-b934-23b293779aaa', NULL, 'USR-2608799800850', '$2b$10$FKP6dcaI7vH8GbGSi76yR.gWSUph7X1vmVL51mefrHvGiCx99VU9y', 'Javen Brylle', NULL, 'Dela Cruz', 'bryllejaven@gmail.com', '09482048339', 'Male', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:27', '2025-02-10 15:04:27', NULL),
('9ccf8913-4710-48ba-814b-f13b175d61f5', NULL, 'USR-2608799805661', '$2b$10$H.Y6sot6F5p06B7f0Y1It.E8./NV/kbwa1HDydwCqY/nIgcwCb65a', 'Filwayne', NULL, 'De Lara', 'Dfilwayne@gmail.com', NULL, NULL, 'Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('9dfc8a70-ff3b-41ef-900a-95109f3aff8d', NULL, 'USR-2608799800245', '$2b$10$iGiOqOqp4.wkrSzfsUG1WOjTTMP9IIQIHdgZ23FvQMkdvMUHVSkyK', 'James Paul', 'Lim', 'Tulod', 'jptulod123@gmail.com', '09451152076', 'Male', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:26', '2025-02-10 15:04:26', NULL),
('a20a3365-487c-4d00-ae61-a69de46658a9', '4a125a03-1482-43a3-9faf-9a862518bd7f', 'USR-2608799804028', '$2b$10$PaleQ4BapCFFG/rPzEXZTeqzlF6BixdIh3XylQHeJzTvllhG9zCCS', 'Killian', 'Miranda', 'Alvarez', 'Killian@gmail.copm', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('a40866c0-382a-470e-b2d2-c9af611fcacd', '033579a5-6dca-4e93-915d-fcf4de53722c', 'USR-2608799806880', '$2b$10$i7ywdoT5wa2IlAgY7EBwquSY2KJjmAjbBFM0kQEQEYG/Zk8R/ymdi', 'Yvonne', 'Morgan', 'Haynez', 'yvonnehaynes13@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('b29e460a-40db-453d-9ef1-3e86baf14fbe', '5ca135f2-c0e7-4849-b332-af0802289f65', 'USR-2608799804271', '$2b$10$TvSRSzv4KcMA4yRU601k9ebf/129FXHWdxPK7EnLDWWiAMVf8W1Ou', 'Shawn', 'Murphy', 'White', 'Shawn@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('b6813704-f332-417c-85c8-5d90b9de3d48', '8e263315-6950-4369-b4e2-039e3b5d3bc5', 'USR-2608799804518', '$2b$10$TFeGxFyN8lZjjXonHNlnV.GcoSt.rOwG1nAchgNqJ1.IX3gNSpVXy', 'Dominique', 'Jacklyn', 'Rollins', 'Dominique@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('b9d49c56-07e5-4293-802d-e305e7874091', NULL, 'USR-2608800021235', '$2b$10$jXhF6OMe3SSegHd9B/qbp.Kjs4uowVt4wWKewOGPdpZgkovw78HNO', 'thirteen customer', '', 'last name', 'thirteen@gmail.com', '09123456789', 'Others', 'Customer', NULL, NULL, NULL, '2025-02-10 15:06:54', '2025-02-10 15:06:54', NULL),
('c56b7cef-cb2a-4644-bda2-d93f1b483508', 'f3ccd82d-933a-440d-a0b9-a5a3dcd8e10e', 'USR-2608799804394', '$2b$10$QP8QHZ.jeJOVEbACZ9x.YuJludt0kZ4f9YENDt35PDKZM5U/IVNJu', 'Uriel', 'Michael', 'Harvey', 'Uriel@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('c7fbb547-491f-4275-8324-5029e3e01f8a', '3c698b91-a6b8-4b13-9e82-b77043d41089', 'USR-2608799807488', '$2b$10$m0Szk2I0r5K/7eh7cPR3PO443CTfgXPdhsxpbUv7896o/tmbUt5M.', 'Ronald', NULL, 'Cooper', 'ronaldcooper@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('cbab6c73-fac4-4a8d-851c-be3cc9bcdb04', NULL, 'USR-2608799800977', '$2b$10$tWNn59i/p6CydO.qKENe9uStZnfB3e8BzFO9TqydPp7tkl1N5tcYW', 'Aphryll Joy', NULL, 'Malazzab', 'ajmallazzab@gmail.com', '09294482931', 'Female', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:27', '2025-02-10 15:04:27', NULL),
('cf11ead0-f451-4f20-a769-fd2861c95125', NULL, 'USR-2608799805280', '$2b$10$VY/uGQaYEXxrgcC/s6AoFuWEp8VcAI7ad72estAycH8v7ZGZO.OXy', 'Paul', NULL, 'Tulod', 'paultulod@pm.me', NULL, NULL, 'Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL),
('d5fafaeb-090f-4b23-b551-c8e85fd45819', '42500097-26a1-4456-83de-4709e51a2751', 'USR-2608799804150', '$2b$10$eYOMvKk8htauO8Rk2g4P2OS3MG0yvZL/7tyvy4/Dx.UrlWqOSW6jS', 'Kamryn', 'Tyson', 'Dominguez', 'kamryn@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('d728b513-2fa3-4d63-b3f7-889afcc7b26c', '30bcd7a5-415b-49b6-8933-720fe958065e', 'USR-2608799807366', '$2b$10$NodKDljnKWpO1LnR6xMEgu/Upwq6Rrysuc/bz/raLtF768onuGCki', 'Angeline', NULL, 'Cacacho', 'angelinecacacho@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('db4d79b7-63fa-4681-829c-92f4a97165eb', '6b9d42cd-affa-44e5-8874-5b810c5b47ee', 'USR-2608799803300', '$2b$10$fo3ta90Alyl7Vj69PNe5YuPxSddYFRszX2IVjHk3TpFMrId8GDKZy', 'Yoorim', NULL, 'Heo', 'yoorimie@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:28', '2025-02-10 15:04:28', NULL),
('ddb75745-2676-4c57-aa44-35444466ebb1', '97d5820e-9e94-4c1a-99fb-e9767e491092', 'USR-2608799803421', '$2b$10$kTJfzLORxY.zclnje4Nhy.1LbO8uNFal3.OWpzuaBTP6OObANmwAS', 'Shyann', 'Viola', 'Horne', 'Shyann@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('e280b024-108f-4a61-93fc-11296c625df5', '08dca6c6-331c-4ebb-a303-8097d17ce1c7', 'USR-2608799803907', '$2b$10$1VnF5EMV8W5kDK8UwaQoyOdpsGAiTNysZIxp6OU3.oBsHntNQTnpK', 'Leila', 'Arden', 'Gilbert', 'Leila@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('e4b66879-77b0-4b9a-a820-7be34bf83447', '040eecac-240e-43c0-a9f3-402f51e8ec73', 'USR-2608799807245', '$2b$10$ngMAnOt8pMRH9O033cnyIuiNMsygHH/civ/2IeIDxtT85BMEI610G', 'Jake Angelo ', 'Felix', 'Tan', 'tanfelixjake@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('f1ec0076-52e9-4d63-89d7-ea9f94f6dfe7', 'db92e05e-509e-43ae-9385-4d4aaf2cf2a7', 'USR-2608799807000', '$2b$10$ywcEdz.f5RfF0ksFDxrUdeBiUFnVIIbp4KbWVgzU8LgJkttuBdKK.', 'Alfred', NULL, 'Herrera', 'herreraalfred08@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('f6d036ba-e46c-489c-a936-cd516a85602b', 'afa5ea13-ffdc-46c3-85ad-100b5e642092', 'USR-2608799807609', '$2b$10$1v3OoW.pRFY0NcrCkLo1V.8YOOEWIC9ObHm5/FEg7QFunyAxTS706', 'Mark Andrey', 'Mejano', 'Ramirez', 'markramirez@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:31', '2025-02-10 15:04:31', NULL),
('fbffe4ad-7978-462e-bd3b-ee109d9010b3', NULL, 'USR-2608799800729', '$2b$10$4hi/qYXYTGbrfuBugujHAu4rIy8EjDOzJLx2pX/sgqF/9twLHI0UO', 'Princess Anna', 'Calban', 'Santos', 'princess28@gmail.com', '09293819382', 'Female', 'Customer', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:27', '2025-02-10 15:04:27', NULL),
('fd8f8065-54a0-4bd8-8de9-c6325f22976e', 'd23fef9f-6faf-4abf-a987-a27dcef3977f', 'USR-2608799803786', '$2b$10$c.hmUCw3ufvLyCK2tMG8oeBbJflFhCxjtOFOkgA9/pT4dJ4WEFCFe', 'Roderick', 'Varian', 'Keller', 'Roderick@gmail.com', NULL, NULL, 'Resto_Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:29', '2025-02-10 15:04:29', NULL),
('feb6a115-da44-4f5b-ad65-3cb9590dd364', NULL, 'USR-2608799806027', '$2b$10$oyfbwFTZ9GI5ziaQVqdQA.lroQvhvENB6ACmnw2I2W43uFSmIOzGK', 'Racquel', NULL, 'Ulibas', 'RacquelUlibas@gmail.com', NULL, NULL, 'Admin', '70ea56c6-407b-4bdf-8cf0-b4e09df50fe8', NULL, NULL, '2025-02-10 15:04:30', '2025-02-10 15:04:30', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `resto_id` (`resto_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `cartdetails`
--
ALTER TABLE `cartdetails`
  ADD PRIMARY KEY (`cartdetail_id`),
  ADD UNIQUE KEY `CartDetails_dish_id_cart_id_unique` (`cart_id`,`dish_id`),
  ADD KEY `dish_id` (`dish_id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `resto_id` (`resto_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `couriers`
--
ALTER TABLE `couriers`
  ADD PRIMARY KEY (`courier_id`),
  ADD UNIQUE KEY `Couriers_courier_no_unique` (`courier_no`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `deliverydetails`
--
ALTER TABLE `deliverydetails`
  ADD PRIMARY KEY (`delivery_id`),
  ADD UNIQUE KEY `DeliveryDetails_tracking_no_unique` (`tracking_no`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `courier_id` (`courier_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `dishcategories`
--
ALTER TABLE `dishcategories`
  ADD PRIMARY KEY (`dishcatg_id`),
  ADD UNIQUE KEY `DishCategories_dishcatg_name_unique` (`dishcatg_name`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`dish_id`),
  ADD UNIQUE KEY `Dishes_dish_no_unique` (`dish_no`),
  ADD KEY `dishcatg_id` (`dishcatg_id`),
  ADD KEY `resto_id` (`resto_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `openinghours`
--
ALTER TABLE `openinghours`
  ADD PRIMARY KEY (`openhrs_id`),
  ADD KEY `resto_id` (`resto_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`orddetail_id`),
  ADD UNIQUE KEY `OrderDetails_order_id_dish_id_unique` (`dish_id`,`order_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `Orders_order_no_unique` (`order_no`),
  ADD KEY `resto_id` (`resto_id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `Payments_payment_no_unique` (`payment_no`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `restaurants`
--
ALTER TABLE `restaurants`
  ADD PRIMARY KEY (`resto_id`),
  ADD UNIQUE KEY `Restaurants_resto_no_unique` (`resto_no`),
  ADD UNIQUE KEY `Restaurants_resto_email_unique` (`resto_email`),
  ADD KEY `restocatg_id` (`restocatg_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `restocategories`
--
ALTER TABLE `restocategories`
  ADD PRIMARY KEY (`restocatg_id`),
  ADD UNIQUE KEY `RestoCategories_restocatg_name_unique` (`restocatg_name`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `Users_user_no_unique` (`user_no`),
  ADD UNIQUE KEY `Users_email_address_unique` (`email_address`),
  ADD KEY `resto_id` (`resto_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_10` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_11` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_12` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_13` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_14` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_15` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_16` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_17` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_18` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_19` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_20` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_21` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_22` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_23` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_24` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_25` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_26` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_27` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_28` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_29` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_30` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_31` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_32` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_33` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_34` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_35` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_36` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_37` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_38` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_39` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_40` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_5` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_6` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_7` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_8` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_9` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `cartdetails`
--
ALTER TABLE `cartdetails`
  ADD CONSTRAINT `cartdetails_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_10` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_11` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_12` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_13` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_14` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_15` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_16` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_3` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_4` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_5` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_6` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_7` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_8` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cartdetails_ibfk_9` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_10` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_11` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_12` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_13` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_14` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_15` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_16` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_3` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_5` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_6` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_7` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_8` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_9` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `couriers`
--
ALTER TABLE `couriers`
  ADD CONSTRAINT `couriers_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_10` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_11` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_12` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_13` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_14` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_15` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_16` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_17` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_18` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_19` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_20` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_21` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_22` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_4` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_5` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_6` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_7` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_8` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `couriers_ibfk_9` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `deliverydetails`
--
ALTER TABLE `deliverydetails`
  ADD CONSTRAINT `deliverydetails_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_10` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_11` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_12` FOREIGN KEY (`courier_id`) REFERENCES `couriers` (`courier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_13` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_14` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_15` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_16` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_17` FOREIGN KEY (`courier_id`) REFERENCES `couriers` (`courier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_18` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_19` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_2` FOREIGN KEY (`courier_id`) REFERENCES `couriers` (`courier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_20` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_21` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_22` FOREIGN KEY (`courier_id`) REFERENCES `couriers` (`courier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_23` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_24` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_25` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_26` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_27` FOREIGN KEY (`courier_id`) REFERENCES `couriers` (`courier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_28` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_29` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_30` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_31` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_32` FOREIGN KEY (`courier_id`) REFERENCES `couriers` (`courier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_33` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_34` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_35` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_5` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_7` FOREIGN KEY (`courier_id`) REFERENCES `couriers` (`courier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_8` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverydetails_ibfk_9` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `dishcategories`
--
ALTER TABLE `dishcategories`
  ADD CONSTRAINT `dishcategories_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_10` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_11` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_12` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_13` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_14` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_15` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_16` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_17` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_18` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_19` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_20` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_21` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_5` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_6` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_7` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_8` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishcategories_ibfk_9` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `dishes`
--
ALTER TABLE `dishes`
  ADD CONSTRAINT `dishes_ibfk_1` FOREIGN KEY (`dishcatg_id`) REFERENCES `dishcategories` (`dishcatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_10` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_11` FOREIGN KEY (`dishcatg_id`) REFERENCES `dishcategories` (`dishcatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_12` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_13` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_14` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_15` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_16` FOREIGN KEY (`dishcatg_id`) REFERENCES `dishcategories` (`dishcatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_17` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_18` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_19` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_2` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_20` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_21` FOREIGN KEY (`dishcatg_id`) REFERENCES `dishcategories` (`dishcatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_22` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_23` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_24` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_25` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_26` FOREIGN KEY (`dishcatg_id`) REFERENCES `dishcategories` (`dishcatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_27` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_28` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_29` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_30` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_31` FOREIGN KEY (`dishcatg_id`) REFERENCES `dishcategories` (`dishcatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_32` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_33` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_34` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_35` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_5` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_6` FOREIGN KEY (`dishcatg_id`) REFERENCES `dishcategories` (`dishcatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_7` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_8` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `dishes_ibfk_9` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `openinghours`
--
ALTER TABLE `openinghours`
  ADD CONSTRAINT `openinghours_ibfk_1` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_10` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_11` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_12` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_13` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_14` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_15` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_16` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_17` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_18` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_19` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_20` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_21` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_22` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_23` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_24` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_25` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_26` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_27` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_28` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_4` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_5` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_6` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_7` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_8` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `openinghours_ibfk_9` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_10` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_11` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_12` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_13` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_14` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_3` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_4` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_5` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_7` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_8` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_9` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_10` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_11` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_12` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_13` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_14` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_15` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_16` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_17` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_18` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_19` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_20` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_21` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_22` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_23` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_24` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_25` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_26` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_27` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_28` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_29` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_30` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_31` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_32` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_33` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_34` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_35` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_5` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_6` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_7` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_8` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_9` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_10` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_11` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_12` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_13` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_14` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_15` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_16` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_17` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_18` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_19` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_20` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_21` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_22` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_23` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_24` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_25` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_26` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_27` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_28` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_4` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_5` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_6` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_7` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_8` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_9` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `restaurants`
--
ALTER TABLE `restaurants`
  ADD CONSTRAINT `restaurants_ibfk_1` FOREIGN KEY (`restocatg_id`) REFERENCES `restocategories` (`restocatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_10` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_11` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_12` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_13` FOREIGN KEY (`restocatg_id`) REFERENCES `restocategories` (`restocatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_14` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_15` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_16` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_17` FOREIGN KEY (`restocatg_id`) REFERENCES `restocategories` (`restocatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_18` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_19` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_20` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_21` FOREIGN KEY (`restocatg_id`) REFERENCES `restocategories` (`restocatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_22` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_23` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_24` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_25` FOREIGN KEY (`restocatg_id`) REFERENCES `restocategories` (`restocatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_26` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_27` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_28` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_4` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_5` FOREIGN KEY (`restocatg_id`) REFERENCES `restocategories` (`restocatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_6` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_7` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_8` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restaurants_ibfk_9` FOREIGN KEY (`restocatg_id`) REFERENCES `restocategories` (`restocatg_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `restocategories`
--
ALTER TABLE `restocategories`
  ADD CONSTRAINT `restocategories_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_10` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_11` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_12` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_13` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_14` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_15` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_16` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_17` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_18` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_19` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_20` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_5` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_6` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_7` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_8` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `restocategories_ibfk_9` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_10` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_11` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_12` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_13` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_14` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_15` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_16` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_17` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_18` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_19` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_20` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_21` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_22` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_23` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_24` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_4` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_5` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_6` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_7` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_8` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_9` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`resto_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
