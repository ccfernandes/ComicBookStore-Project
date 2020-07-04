Create or Replace Function OrderTotal(l_orderid in ItemOrdered.orderid%TYPE)
return Number IS 

l_total NUMBER(10,2) := 0;
l_shippingFee ItemOrdered.shippingFee%TYPE := 10;
l_price StoreItem.price%TYPE;
l_itemid ItemOrdered.itemid%TYPE;
l_qty ItemOrdered.qty%TYPE;
l_custid ItemOrdered.custid%TYPE;
l_isGold StoreCustomer.isGold%TYPE;

CURSOR c1 IS 
Select itemid, qty, custid from ItemOrdered 
WHERE orderid = l_orderid;

BEGIN
	OPEN c1;

	LOOP
		FETCH c1 INTO l_itemid, l_qty, l_custid;
		EXIT WHEN c1%NOTFOUND;
		

		SELECT price INTO l_price FROM StoreItem WHERE itemid = l_itemid;
		l_total := l_total + (l_qty*l_price);
		
	END LOOP;
	
	SELECT isGold INTO l_isGold FROM StoreCustomer WHERE custid = l_custid;

	IF (l_total >= 100 AND l_isGold = 1) THEN
		l_total := l_total*0.90;
		l_shippingFee := 0;
	END IF;
		

	l_total := (l_total*1.05) + l_shippingFee;
	
	CLOSE c1;

return l_total;

END;
/
Show Errors;

