-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `street` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `quantity` bigint DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `fk_user` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'├ío nam'),(4,'electronics'),(3,'jewelery'),(2,'men\'s clothing'),(5,'women\'s clothing');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `order_items_ibfk_1` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (9,7,196,1),(10,8,196,1),(11,9,196,1),(12,10,196,1),(13,11,197,1),(14,11,196,1),(15,11,198,1),(16,12,200,1),(17,12,201,1),(18,12,206,1),(19,13,197,1),(20,13,198,1),(21,13,199,1),(22,14,199,1),(23,14,203,1),(24,14,207,1),(25,15,215,19),(26,15,214,4),(27,15,213,18),(28,15,196,12),(29,15,197,1),(30,15,198,20),(31,16,197,1),(32,16,196,1),(33,16,198,1),(34,16,199,1),(35,16,200,1),(36,16,201,6),(37,17,211,3),(38,17,197,1),(39,18,196,2),(40,19,196,1);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `total_amount` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Packing','Arriving','Shipping','Success') COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (7,9,'109.95','Arriving','LS79R6TVD4'),(8,9,'109.95','Success','2TPDL1WBSZ'),(9,9,'109.95','Success','B265DG8LJQ'),(10,9,'109.95','Success','4VZN0AKX3B'),(11,9,'1015.91','Success','3I8G0HPOLB'),(12,9,'6332.0','Packing','HE7M3Z4BKX'),(13,9,'94.28','Success','3NXKU9FDJ8'),(14,9,'140.98','Arriving','NXHS3U695V'),(15,9,'1627.3','Success','O8QDV2CMGF'),(16,9,'1907.23','Success','D9Q6VKO85H'),(17,16,'112.15','Success','CD76TGPMFH'),(18,16,'439.8','Success','AS8V5ZJ6LH'),(19,16,'109.95','Success','NTSL5ZOXWD');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `count` int DEFAULT NULL,
  `description` varchar(1155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(2255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` float DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` float NOT NULL,
  `category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (196,120,'thß╗¡ xem','https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',3.9,'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',109.95,1),(197,259,'Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.','https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',4.1,'Mens Casual Premium Slim Fit T-Shirts ',22.3,2),(198,500,'great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.','https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',4.7,'Mens Cotton Jacket',55.99,2),(199,430,'The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.','https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg',2.1,'Mens Casual Slim Fit',15.99,2),(200,400,'From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean\'s pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.','https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',4.6,'John Hardy Women\'s Legends Naga Gold & Silver Dragon Station Chain Bracelet',695,3),(201,70,'Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.','https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg',3.9,'Solid Gold Petite Micropave ',168,3),(202,400,'Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine\'s Day...','https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg',3,'White Gold Plated Princess',9.99,3),(203,100,'Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel','https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg',1.9,'Pierced Owl Rose Gold Plated Stainless Steel Double',10.99,3),(204,203,'USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on userΓÇÖs hardware configuration and operating system','https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',3.3,'WD 2TB Elements Portable External Hard Drive - USB 3.0 ',64,4),(205,470,'Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5ΓÇ¥ hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)','https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg',2.9,'SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s',109,4),(206,319,'3D NAND flash are applied to deliver high transfer speeds Remarkable transfer speeds that enable faster bootup and improved overall system performance. The advanced SLC Cache Technology allows performance boost and longer lifespan 7mm slim design suitable for Ultrabooks and Ultra-slim notebooks. Supports TRIM command, Garbage Collection technology, RAID, and ECC (Error Checking & Correction) to provide the optimized performance and enhanced reliability.','https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg',4.8,'Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5',109,4),(207,400,'Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity, 3-year manufacturer\'s limited warranty','https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_.jpg',4.8,'WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive',114,4),(208,250,'21. 5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate: 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16: 9. Color Supported - 16. 7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz','https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg',2.9,'Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin',599,4),(209,140,'49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag','https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg',2.2,'Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) ΓÇô Super Ultrawide Screen QLED ',999.99,4),(210,235,'Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates','https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',2.6,'BIYLACLESEN Women\'s 3-in-1 Snowboard Jacket Winter Coats',56.99,5),(211,340,'100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER), Faux leather material for style and comfort / 2 pockets of front, 2-For-One Hooded denim style faux leather jacket, Button detail on waist / Detail stitching at sides, HAND WASH ONLY / DO NOT BLEACH / LINE DRY / DO NOT IRON','https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg',2.9,'Lock and Love Women\'s Removable Hooded Faux Leather Moto Biker Jacket',29.95,5),(212,679,'Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good size to hold all kinds of things, it covers the hips, and the hood is generous but doesn\'t overdo it.Attached Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.','https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg',3.8,'Rain Jacket Women Windbreaker Striped Climbing Raincoats',39.99,5),(213,130,'95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem','https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg',4.7,'MBJ Women\'s Solid Short Sleeve Boat Neck V ',9.85,5),(214,146,'100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort','https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg',4.5,'Opna Women\'s Short Sleeve Moisture',7.95,5),(215,145,'95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.','https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg',3.6,'DANVOUY Womens T Shirt Casual Cotton Short',12.99,5),(216,0,'c','a',0,'b',1.4,1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (2,'ADMIN'),(1,'USER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(2155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maiden_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Luudung','Dungdung01','dungvl76@gmail.com',NULL,NULL,'Male',NULL,NULL,NULL),(8,'LuuVanDung','Dungdung','luudungvl76@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL),(9,'dungvl76','dungdung','dungvl76@gmail.com','https://scontent.fhan15-2.fna.fbcdn.net/v/t1.6435-9/158340785_2629172757375912_366554967716189900_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=1d70fc&_nc_eui2=AeHu0dzqHjGEGEH947ykVmL3Qq9uUczm681Cr25RzObrzdIAka0NF5zEpKnOjo39q6-f811wEZOPXUtNJfzi_6Zg&_nc_ohc=iNmGWviLv28Q7kNvgFQRys0&_nc_ht=scontent.fhan15-2.fna&oh=00_AYAC7-XXcPD_VmNCssseUxAxcr9KAswQIQxJhZR_p71tkA&oe=6707A04E','0343539561','Male','L╞░u','D┼⌐ng',23),(16,'an2906','an2906','an2906@gmail.com',NULL,'','Female','Trß║ºn','An',NULL),(17,'luudung01','dungdung',NULL,NULL,NULL,NULL,'',NULL,NULL),(18,'dung123','123',NULL,NULL,NULL,NULL,'',NULL,NULL),(19,'123456','123',NULL,NULL,NULL,NULL,'',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1),(8,1),(9,1),(16,1),(17,1),(9,2);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-29 11:00:22
