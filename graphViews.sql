CREATE VIEW `daySalesGraph` AS select 
count(`groupedSalesView`.`date`) AS `salesQuantity`,
round(sum(`groupedSalesView`.`obtained`),2) AS `obtained`,
round(sum(`groupedSalesView`.`profit`),2) AS `profit`,
`groupedSalesView`.`date` AS `date`,
`groupedSalesView`.`userID` AS `userID` 
from `groupedSalesView` 
group by `groupedSalesView`.`date`,`groupedSalesView`.`userID` 
order by `groupedSalesView`.`date` desc;

CREATE VIEW `clientsGraph` AS select 
`clientsView`.`id` AS `id`,
`clientsView`.`name` AS `name`,
`clientsView`.`bought` AS `bought`,
`clientsView`.`profit` AS `profit`,
`clientsView`.`purchases` AS `purchases`,
`clientsView`.`userID` AS `userID` 
from `clientsView` 
order by `clientsView`.`bought` desc;

CREATE VIEW `ordersGraph` AS select 
concat(`id`,' (',`supplier`,')') AS `supplierName`,
`ordersView`.`expectedObtained` - `ordersView`.`obtained` AS `toGoal`,
`ordersView`.`obtained` AS `obtained`,
`ordersView`.`profit` AS `profit`,
`ordersView`.`userID` AS `userID` 
from `ordersView`;
