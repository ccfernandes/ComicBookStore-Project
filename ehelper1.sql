Create or Replace Procedure paymentDetails(l_orderid in ItemOrdered.orderid%TYPE)

AS

l_subtotal NUMBER(10,2) := 0;
l_grandtotal NUMBER(10,2) := 0;
l_tax NUMBER(10,2) := 0;
l_discount NUMBER(10,2) := 0;
l_shippingFee ItemOrdered.shippingFee%TYPE;
l_price StoreItem.price%TYPE;
l_itemid ItemOrdered.itemid%TYPE;
l_qty ItemOrdered.qty%TYPE;
l_custid ItemOrdered.custid%TYPE;
l_orderDate ItemOrdered.orderDate%TYPE;
temp number := 0;

CURSOR c1 IS 
Select itemid, qty, shippingFee, custid, orderDate from ItemOrdered 
WHERE orderid = l_orderid;

BEGIN
	OPEN c1;
	SELECT count(*) INTO temp FROM paymentDetail WHERE orderid = l_orderid;
	LOOP
		FETCH c1 INTO l_itemid, l_qty, l_shippingFee, l_custid, l_orderDate;
		EXIT WHEN c1%NOTFOUND;
		

		SELECT price INTO l_price FROM StoreItem WHERE itemid = l_itemid;
		l_subtotal := l_subtotal + (l_qty*l_price);
		
	END LOOP;
	
	dbms_output.put_line('Payment Details of Order ' || l_orderid);
	dbms_output.put_line('Total of all items: $' || l_subtotal);
	IF (l_subtotal >= 100 AND l_shippingFee = 0) THEN
		l_discount := l_subtotal*0.10;
		l_subtotal := l_subtotal*0.90;
	END IF;
	
	l_tax := 0.05*l_subtotal;

	dbms_output.put_line('Total Discount: $' || l_discount);
	dbms_output.put_line('Tax: $' || l_tax);
		

	l_grandtotal := (l_subtotal*1.05) + l_shippingFee;
	dbms_output.put_line('Shipping Fee: $' || l_shippingFee);
	dbms_output.put_line('Grand Total: $' || l_grandtotal);
	dbms_output.put_line(' ');
	
	IF temp = 0 THEN
		INSERT INTO paymentDetail VALUES (l_orderid, l_custid, l_subtotal, l_grandtotal, l_tax, l_discount, l_shippingFee, l_orderDate);
	END IF;

	CLOSE c1;


END;
/
Show Errors;

