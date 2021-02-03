CREATE TABLE `users` (
  `id` int(7) NOT NULL AUTO_INCREMENT,
  `username` varchar(15) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
);

CREATE TABLE `suppliers` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `place` varchar(20) DEFAULT NULL,
  `userID` int(7) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `supplier` (`name`,`userID`),
  KEY `userID` (`userID`),
  CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
);

CREATE TABLE `orders` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `supplierID` int(6) NOT NULL,
  `expectedObtained` float NOT NULL,
  `date` date DEFAULT NULL,
  `userID` int(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `supplierID` (`supplierID`),
  KEY `userID` (`userID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`supplierID`) REFERENCES `suppliers` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
);

CREATE TABLE `products` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `orderID` int(6) NOT NULL,
  `name` varchar(30) NOT NULL,
  `char1` varchar(15) DEFAULT NULL,
  `char2` varchar(15) DEFAULT NULL,
  `initialStock` int(6) NOT NULL,
  `retailPrice` float NOT NULL,
  `wholesalePrice` float NOT NULL,
  `purchasePrice` float NOT NULL,
  `userID` int(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orderID` (`orderID`),
  KEY `userID` (`userID`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `orders` (`id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
);

CREATE TABLE `clients` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `place` varchar(25) DEFAULT NULL,
  `userID` int(7) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client` (`name`,`userID`),
  KEY `userID` (`userID`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
);

CREATE TABLE `sales` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `clientID` int(6) NOT NULL,
  `productID` int(6) NOT NULL,
  `quantity` int(5) NOT NULL,
  `obtained` float NOT NULL,
  `profit` float NOT NULL,
  `discount` float NOT NULL,
  `type` varchar(10) NOT NULL,
  `date` date DEFAULT NULL,
  `userID` int(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `clientID` (`clientID`),
  KEY `productID` (`productID`),
  KEY `userID` (`userID`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`clientID`) REFERENCES `clients` (`id`),
  CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `products` (`id`),
  CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
);

