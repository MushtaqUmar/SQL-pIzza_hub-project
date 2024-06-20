 /* Importing csv files 'pizzas' and pizza_types' directly as they have not very large no. of records like 10k, 20k etc 
 USING OPTION: 'Table Data Import Wizard' - right click on tables under database 'pizza_outlet'   */
 
 
 
 
 
 /* Now importing remaining 2 csv files 'orders' & 'ordere_details' inside custom created 2 tables (having equal cols with datatype) and importing there 
 by right click on those created tables (ON NAVIGATOR SIDE-left)  like in below created table ------  for very large files containing large no. of records*/
 
 /* 3 table . Create table 'orders' (of same cols as going to import) and import csv file named 'orders' containing very large no of records 
 by right click on 'orders table on navigator side- left' and click 'table data import wizard' to import that csv file */
 CREATE TABLE orders (
 order_id INT NOT NULL,
 date DATE NOT NULL,
 time time NOT NULL,
 PRIMARY KEY(order_id)
 );
 
 /* 4. Create table 'order_details' and import csv file named 'order_details' containing very large no of records 
 by right click on 'order_details' table on navigator side- left' and click 'table data import wizard' to import that csv file */
 
 CREATE TABLE order_details(
 order_details_id INT NOT NULL,
 order_id INT NOT NULL,
 pizza_id text NOT NULL,
 quantity INT NOT NULL,
 PRIMARY KEY(order_details_id)
 );