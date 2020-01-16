Create or Replace Procedure custDetails(l_orderid in ItemOrdered.orderid%TYPE)

AS
l_custid StoreCustomer.custid%TYPE;
l_name StoreCustomer.name%TYPE;
l_phone_email StoreCustomer.phone_email%TYPE;
l_street StoreCustomer.street%TYPE;
l_city StoreCustomer.city%TYPE;
l_state StoreCustomer.state%TYPE;
l_zip StoreCustomer.zip%TYPE;
temp number := 0;

CURSOR c1 IS
	SELECT custid FROM ItemOrdered 
	WHERE orderid = l_orderid;

BEGIN
	OPEN c1;
	
	--SELECT count(*) INTO temp FROM custDetail WHERE orderid = l_orderid;

	--dbms_output.put_line('Order Details of Order ' || l_orderid);
	LOOP
		FETCH c1 INTO l_custid;
		EXIT WHEN c1%NOTFOUND;
		SELECT count(*) INTO temp FROM custDetail WHERE custid = l_custid;
		SELECT name, phone_email, street, city, state, zip INTO l_name, l_phone_email, l_street, l_city, l_state, l_zip FROM StoreCustomer WHERE custid = l_custid;
		--dbms_output.put_line('Item ID: ' || l_itemid);
		--dbms_output.put_line('Name: ' || l_title);
		--dbms_output.put_line('Price: ' || l_price);
		--dbms_output.put_line('Quantity ordered: ' || l_qty);
		
		IF temp = 0 THEN
			INSERT INTO custDetail values (l_custid, l_name, l_phone_email, l_street, l_city, l_state, l_zip);
		END IF;

	END LOOP;


	CLOSE c1;
END;
/
Show Errors;
