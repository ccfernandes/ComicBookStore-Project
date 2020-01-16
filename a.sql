Create or Replace Procedure addItemOrder(l_custid in Cart.custid%TYPE)

AS

l_orderid ItemOrdered.orderid%TYPE;
l_itemid ItemOrdered.itemid%TYPE;
l_orderDate ItemOrdered.orderDate%TYPE;
l_qty ItemOrdered.qty%TYPE;
l_shippedDate  ItemOrdered.shippedDate%TYPE;
l_numCopies StoreItem.numCopies%TYPE;
l_isGold StoreCustomer.isGold%TYPE;
l_shippingfee INTEGER := 10;

ordernum INTEGER := 0;
str_custid VARCHAR(5);
str_orderDate VARCHAR(12);
str_ordernum VARCHAR(3);
temp NUMBER;

CURSOR c1 IS 
Select itemid, qty from Cart 
WHERE custid = l_custid;

BEGIN

	SELECT isGold INTO l_isGold FROM StoreCustomer WHERE custid = l_custid;

			IF (l_isGold = 1) THEN
				l_shippingfee := 0;
			END IF;
	
	l_orderDate := sysdate;

	SELECT TO_CHAR(l_custid) INTO str_custid FROM DUAL;
	SELECT TO_CHAR(l_orderDate) INTO str_orderDate FROM DUAL;
	
	LOOP
		SELECT TO_CHAR(ordernum) INTO str_ordernum FROM DUAL;	

		l_orderid := CONCAT(CONCAT(str_custid, str_orderDate), str_ordernum);
	
		SELECT count(*) INTO temp FROM ItemOrdered WHERE orderid = l_orderid;
	
		IF temp = 0 THEN
			EXIT;
		ELSE
			ordernum := ordernum+1;
		END IF;

	END LOOP;

	OPEN c1;
	
	LOOP
		FETCH c1 INTO l_itemid, l_qty;
		EXIT WHEN c1%NOTFOUND;
		
		SELECT numCopies INTO l_numCopies FROM StoreItem WHERE itemid = l_itemid;
		IF ((l_qty > l_numCopies) AND (l_numCopies >= 1)) THEN
			dbms_output.put_line('Error, you attempted to order' || l_qty || 'copies of ' || l_itemid || 'but only ' || l_numCopies || 'are available.');

		ELSIF (l_numCopies = 0) THEN
			dbms_output.put_line('The item is currently sold out!');
	
		ELSIF(l_qty <= l_numCopies) THEN

			INSERT INTO ItemOrdered VALUES(l_orderid, l_custid, l_itemid, l_orderDate, l_qty, l_shippedDate, l_shippingFee);

			UPDATE StoreItem
			SET numCopies = numCopies - l_qty
			WHERE itemid = l_itemid; 
		END IF;

	END LOOP;

	CLOSE c1;

	DELETE FROM Cart;

END;
/
Show Errors;

