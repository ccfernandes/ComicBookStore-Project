--INSERT INTO StoreItem(itemid, price, title, publishedDate, numcopies) VALUES (1, 5,'Percy Jackson', '01-AUG-2013', 3);
--INSERT INTO StoreItem(itemid, price, title, publishedDate, numcopies) VALUES (2, 12,'Winnie the Pooh', '12-FEB-1946', 20);
--INSERT INTO StoreItem(itemid, price, t_size) VALUES (3, 10, 'S');
INSERT INTO StoreItem(itemid, price, title, publishedDate, numcopies) VALUES (4, 200, 'Chemistry', '21-MAR-2009', 15); 
--INSERT INTO StoreItem(itemid, price, t_size) VALUES (5, 12, 'M');
INSERT INTO StoreItem(itemid, price, t_size) VALUES (8, 106, 'XXL');
--INSERT INTO StoreItem(itemid, price, t_size) VALUES (7, 35, 'S');

--INSERT INTO StoreCustomer(custid, name, phone_email, street, city, state, zip, isGold, dateJoined) VALUES (12345, 'Chelsea Fernandes', 5101234567, 'Roselle Cmn', 'Fremont', 'CA', 94536, 1, '06-AUG-2018');

--INSERT INTO StoreCustomer(custid, name, phone_email, street, city, state, zip, isGold, dateJoined) VALUES (67890, 'Laurynn Diby', 4081236547, '500 El Camino Real', 'Santa Clara', 'CA', 95051, 1, '22-JUN-2019');

--INSERT INTO StoreCustomer(custid, name, phone_email, street, city, state, zip, isGold, dateJoined) VALUES (34567, 'Shreya Venkatesh', 'svenkatesh@scu.edu', '123 Main St.', 'Stockton', 'CA', 94237, 0, '11-NOV-2019'); 

UPDATE StoreItem
SET numCopies = 3
WHERE t_size is not null;
