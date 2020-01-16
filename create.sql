CREATE TABLE StoreCustomer(
custid NUMBER(5,0) PRIMARY KEY, 
name VARCHAR(50), 
phone_email VARCHAR(50) UNIQUE, 
street VARCHAR(20), 
city VARCHAR(20), 
state VARCHAR(2), 
zip NUMBER(5,0), 
isGold NUMBER(1) NOT NULL, 
dateJoined DATE);

CREATE TABLE StoreItem(
itemid NUMBER(5,0) PRIMARY KEY, 
price NUMBER(4,2), 
ISBN NUMBER(10,0) UNIQUE, 
title VARCHAR(50), 
publishedDate DATE, 
numCopies NUMBER(3,0), 
t_size VARCHAR(3));

CREATE TABLE ItemOrdered(
orderid NUMBER(5,0), 
custid NUMBER(5,0), 
itemid NUMBER(5,0), 
orderDate DATE, 
qty NUMBER, 
shippedDate DATE, 
shippingFee FLOAT,
PRIMARY KEY (orderid, custid, itemid));

CREATE TABLE Cart(
itemid NUMBER(5,0),
custid NUMBER(5,0),
qty NUMBER);

CREATE TABLE orderDetail(
orderid VARCHAR(20),
custid NUMBER(5,0),
itemid NUMBER(5,0),
orderDate DATE,
qty NUMBER,
shippedDate DATE,
price NUMBER(5,2),
title VARCHAR(50),
PRIMARY KEY (orderid, custid, itemid));

CREATE TABLE paymentDetail(
orderid VARCHAR(20),
custid NUMBER(5,0),
subtotal NUMBER(10,2),
grandtotal NUMBER(10,2),
tax NUMBER(10,2),
discount NUMBER(10,2),
shippingFee FLOAT,
PRIMARY KEY (orderid, custid));

CREATE TABLE custDetail(
custid NUMBER(5,0) PRIMARY KEY, 
name VARCHAR(50), 
phone_email VARCHAR(50) UNIQUE, 
street VARCHAR(20), 
city VARCHAR(20), 
state VARCHAR(2), 
zip NUMBER(5,0));




ALTER TABLE paymentDetail
ADD orderDate DATE;
FOREIGN KEY (custid) REFERENCES StoreCustomer(custid);

ALTER TABLE custDetail
ADD CONSTRAINT FK_hmDet
FOREIGN KEY (custid) REFERENCES StoreCustomer(custid);

ALTER TABLE orderDetail
ADD CONSTRAINT FK_ItemDet
FOREIGN KEY (itemid) REFERENCES StoreItem(itemid);

ALTER TABLE paymentDetail
ADD CONSTRAINT FK_CustPayDet
FOREIGN KEY (custid) REFERENCES StoreCustomer(custid);

ALTER TABLE Cart
ADD CONSTRAINT FK_CustRef
FOREIGN KEY (custid) REFERENCES StoreCustomer(custid);

ALTER TABLE Cart
ADD CONSTRAINT FK_ItemRef
FOREIGN KEY (itemid) REFERENCES StoreItem(itemid);


ALTER TABLE ItemOrdered
ADD CONSTRAINT FK_CustOrder
FOREIGN KEY (custid) REFERENCES StoreCustomer(custid);

ALTER TABLE ItemOrdered
ADD CONSTRAINT FK_Item
FOREIGN KEY (itemid) REFERENCES StoreItem(itemid);

ALTER TABLE ItemOrdered
MODIFY (orderid VARCHAR(20));

ALTER TABLE StoreItem
MODIFY (price NUMBER(5,2));



