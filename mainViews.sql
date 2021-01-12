CREATE VIEW `productsView` AS select 
`products`.`id` AS `id`,
`products`.`orderID` AS `orderID`,
concat(`products`.`orderID`,' (',`suppliers`.`name`,')') AS `order`,
`products`.`name` AS `name`,
`products`.`char1` AS `char1`,
`products`.`char2` AS `char2`,
`products`.`initialStock` AS `initialStock`,
`products`.`initialStock` - ifnull(sum(`sales`.`quantity`),0) AS `available`,
ifnull(sum(`sales`.`quantity`),0) AS `sold`,
round(`products`.`retailPrice`,2) AS `retailPrice`,
round(`products`.`wholesalePrice`,2) AS `wholesalePrice`,
round(`products`.`purchasePrice`,2) AS `purchasePrice`,
ifnull(round(sum(`sales`.`obtained`),2),0) AS `obtained`,
ifnull(round(sum(`sales`.`obtained`),2),0) - round(`products`.`initialStock` * `products`.`purchasePrice`,2) AS `profit`,
round(`products`.`initialStock` * `products`.`purchasePrice`,2) AS `invested`,
`products`.`userID` AS `userID` 
from (((`products` left join `sales` on(`products`.`id` = `sales`.`productID`)) join `orders` on(`products`.`orderID` = `orders`.`id`)) join `suppliers` on(`orders`.`supplierID` = `suppliers`.`id`)) 
group by `products`.`id`;

CREATE VIEW `ordersView` AS select 
`orders`.`id` AS `id`,
`suppliers`.`id` AS `supplierID`,
`suppliers`.`name` AS `supplier`,
`orders`.`expectedObtained` AS `expectedObtained`,
ifnull(sum(`productsView`.`obtained`),0) AS `obtained`,
ifnull(sum(`productsView`.`obtained`),0) - ifnull(sum(`productsView`.`invested`),0) AS `profit`,
ifnull(sum(`productsView`.`invested`),0) AS `invested`,
sum(`productsView`.`initialStock`) AS `initialStock`,
`orders`.`date` AS `date`,
`orders`.`userID` AS `userID` 
from ((`orders` join `suppliers` on(`orders`.`supplierID` = `suppliers`.`id`)) left join `productsView` on(`orders`.`id` = `productsView`.`orderID`)) 
group by `orders`.`id` 
order by `orders`.`date` desc;

CREATE VIEW `suppliersView` AS select 
`suppliers`.`id` AS `id`,
`suppliers`.`name` AS `name`,
`suppliers`.`contact` AS `contact`,
`suppliers`.`place` AS `place`,
ifnull(count(`ordersView`.`id`),0) AS `purchases`,
ifnull(sum(`ordersView`.`obtained`),0) AS `obtained`,
ifnull(sum(`ordersView`.`profit`),0) AS `profit`,
ifnull(sum(`ordersView`.`invested`),0) AS `invested`,
max(`ordersView`.`date`) AS `lastPurchase`,
min(`ordersView`.`date`) AS `firstPurchase`,
`suppliers`.`userID` AS `userID`
from (`suppliers` left join `ordersView` on(`suppliers`.`id` = `ordersView`.`supplierID`)) 
group by `suppliers`.`id`;

CREATE VIEW `salesView` AS select 
`sales`.`id` AS `id`,
`clients`.`id` AS `clientID`,
`clients`.`name` AS `client`,
`products`.`id` AS `productID`,
`products`.`orderID` AS `orderID`,
concat(`products`.`name`,' ',ifnull(`products`.`char1`,''),' ',ifnull(`products`.`char2`,'')) AS `product`,
`sales`.`quantity` AS `quantity`,
`sales`.`obtained` AS `obtained`,
`sales`.`profit` AS `profit`,
`sales`.`discount` AS `discount`,
`sales`.`type` AS `type`,
`sales`.`date` AS `date`,
`sales`.`userID` AS `userID` 
from ((`sales` join `clients` on(`sales`.`clientID` = `clients`.`id`)) join `products` on(`sales`.`productID` = `products`.`id`));

CREATE VIEW `groupedSalesView` AS select 
`salesView`.`client` AS `client`,
`salesView`.`clientID` AS `clientID`,
round(sum(`salesView`.`obtained`),2) AS `obtained`,
round(sum(`salesView`.`profit`),2) AS `profit`,
round(avg(`salesView`.`discount`),2) AS `discount`,
`salesView`.`type` AS `type`,
`salesView`.`date` AS `date`,
`salesView`.`userID` AS `userID` 
from `salesView` 
where `salesView`.`client` = `salesView`.`client` and `salesView`.`date` = `salesView`.`date` 
group by `salesView`.`client`,`salesView`.`date` 
order by `salesView`.`date` desc,`salesView`.`client`,`salesView`.`userID`;

CREATE VIEW `groupedProductsView` AS select `productsView`.`name` AS `name`, `productsView`.`char1` AS `char1`,
`productsView`.`char2` AS `char2`,
sum(`productsView`.`available`) AS `available`,
`productsView`.`retailPrice` AS `retailPrice`,
`productsView`.`wholesalePrice` AS `wholesalePrice`,
`productsView`.`purchasePrice` AS `purchasePrice`,
`productsView`.`userID` AS `userID` 
from `productsView` 
group by `productsView`.`name`,`productsView`.`char1`,`productsView`.`char2`,`productsView`.`userID`;

CREATE VIEW `clientsView` AS select 
`clients`.`id` AS `id`,
`clients`.`name` AS `name`,
`clients`.`contact` AS `contact`,
`clients`.`place` AS `place`,
ifnull(round(sum(`groupedSalesView`.`obtained`),2),0) AS `bought`,
ifnull(round(sum(`groupedSalesView`.`profit`),2),0) AS `profit`,
count(`groupedSalesView`.`client`) AS `purchases`,
max(`groupedSalesView`.`date`) AS `lastPurchase`,
min(`groupedSalesView`.`date`) AS `firstPurchase`,
`clients`.`userID` AS `userID` 
from (`clients` left join `groupedSalesView` on(`clients`.`id` = `groupedSalesView`.`clientID`)) 
group by `clients`.`id` 
order by `clients`.`id` desc;

