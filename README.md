# Easy Tidy B - DB

This is the MySQL database of Easy Tidy Business App. This database contains certain tables and views which will be accessed by the easyTidyB-API app. 

### DB complementations:
This DB objective is to be accessed by an API whose code is on the [easyTidyB-API repository](https://github.com/fabiosaac12/easyTidyB-API):
And the API objective is to be accessed by a frontend whose code is on the [easyTidyB-Frontend repository](https://github.com/fabiosaac12/easyTidyB-Frontend):

### How to clone this repository and installl this database locally:
1. Open the terminal
2. `git clone https://github.com/fabiosaac12/easyTidyB-API` --> to clone the repository
3. `cd easyTidyB-API` --> to move to the generated folder
4. `mysql -u [user] --password=[password]`
5. `create database etb;` --> to create the database
6. `use etb;` --> to select the database previusly created
7. `source mainTables.sql` --> to create the tables: `users`, `suppliers`, `orders`, `products`, `clients`, `sales`
8. `source mainViews.sql` --> to create the views: `productsView`, `ordersView`, `suppliersView`, `salesView`, `groupedSalesView`, `groupedProductsView`, `clientsView`
9. `source selectViews.sql` --> to create the views: `ordersSuppliersSelectView`, `productsOrdersSelectView`, `salesProductsSelectView`, `salesClientsSelectView`
10. `source graphViews.sql` --> to create the views: `daySalesGraph`, `clientsGraph`, `ordersGraph`
