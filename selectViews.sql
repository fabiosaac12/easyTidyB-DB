CREATE VIEW `ordersSuppliersSelectView` AS select 
`suppliers`.`id` AS `value`,
`suppliers`.`name` AS `label`,
`suppliers`.`contact` AS `contact`,
`suppliers`.`userID` AS `userID` 
from `suppliers`;

CREATE VIEW `productsOrdersSelectView` AS select 
`ordersView`.`id` AS `value`,
concat(`id`,' (',`supplier`,')') AS `label`,
`ordersView`.`date` AS `date`,
`ordersView`.`userID` AS `userID` 
from `ordersView`;

CREATE VIEW `salesProductsSelectView` AS select 
`productsView`.`id` AS `value`,
`productsView`.`orderID` AS `orderID`,
concat(`name`,' ',ifnull(`char1`,''),' ',ifnull(`char2`,'')) AS `label`,
`productsView`.`retailPrice` AS `retailPrice`,
`productsView`.`wholesalePrice` AS `wholesalePrice`,
`productsView`.`purchasePrice` AS `purchasePrice`,
`productsView`.`available` AS `available`,
`productsView`.`userID` AS `userID` 
from `productsView` 
order by `productsView`.`name`,`productsView`.`id`;

CREATE VIEW `salesClientsSelectView` AS select 
`clientsView`.`id` AS `value`,
`clientsView`.`name` AS `label`,
`clientsView`.`contact` AS `contact`,
`clientsView`.`place` AS `place`,
`clientsView`.`userID` AS `userID` 
from `clientsView` 
order by `clientsView`.`id` desc;
