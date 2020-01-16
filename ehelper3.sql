Create or Replace Procedure orderDetails(l_orderid in ItemOrdered.orderid%TYPE)

AS

l_custid ItemOrdered.custid%TYPE;
l_itemid ItemOrdered.itemid%TYPE;
l_orderDate ItemOrdered.orderDate%TYPE;
l_qty ItemOrdered.qty%TYPE;
l_shippedDate ItemOrdered.shippedDate%TYPE;
l_price StoreItem.price%TYPE;
l_title StoreItem.title%TYPE;
temp number := 0;

CURSOR c1 IS
	SELECT itemid, qty, orderDate, shippedDate, custid FROM ItemOrdered 
	WHERE orderid = l_orderid;

BEGIN
	OPEN c1;
	
	SELECT count(*) INTO temp FROM orderDetail WHERE orderid = l_orderid;

	dbms_output.put_line('Order Details of Order ' || l_orderid);
	LOOP
		FETCH c1 INTO l_itemid, l_qty, l_orderDate, l_shippedDate, l_custid;
		EXIT WHEN c1%NOTFOUND;
		
		SELECT price, title INTO l_price, l_title FROM StoreItem WHERE itemid = l_itemid;
		dbms_output.put_line('Item ID: ' || l_itemid);
		dbms_output.put_line('Name: ' || l_title);
		dbms_output.put_line('Price: ' || l_price);
		dbms_output.put_line('Quantity ordered: ' || l_qty);
		
		IF temp = 0 THEN
			INSERT INTO orderDetail values (l_orderid, l_custid, l_itemid, l_orderDate, l_qty, l_shippedDate, l_price, l_title);
		END IF;

	END LOOP;

	dbms_output.put_line('This was ordered on ' || l_orderDate);
	IF l_shippedDate is not null then
		dbms_output.put_line('Shipping date was scheduled for ' || l_shippedDate);
	ELSE
		dbms_output.put_line('Shipping Date has not been set yet');
	END IF;

	CLOSE c1;
END;
/
Show Errors;


