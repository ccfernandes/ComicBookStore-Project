Create or Replace Procedure OrderedAfter(l_custid IN NUMBER, l_date IN DATE)

AS

l_orderid ItemOrdered.orderid%TYPE;

--customer details DONE
l_name StoreCustomer.name%TYPE;
l_phone_email StoreCustomer.phone_email%TYPE;
l_street StoreCustomer.street%TYPE;
l_city StoreCustomer.city%TYPE;
l_state StoreCustomer.state%TYPE;
l_zip StoreCustomer.zip%TYPE;

temp ItemOrdered.orderid%TYPE := 'temp';


CURSOR l_curs IS
	SELECT orderid FROM ItemOrdered WHERE custid = l_custid AND orderDate >= l_date;

CURSOR c1 IS
	SELECT itemid, qty FROM ItemOrdered 
	WHERE custid = l_custid AND orderDate >= l_date;


BEGIN
	OPEN l_curs;

	DELETE FROM custDetail;
	DELETE FROM paymentDetail;
	DELETE FROM orderDetail;
	SELECT name, phone_email, street, city, state, zip INTO l_name, l_phone_email, l_street, l_city, l_state, l_zip FROM StoreCustomer WHERE custid = l_custid;
	dbms_output.put_line('Customer ID: ' || l_custid || ' Name: ' || l_name || ' Phone/Email: ' || l_phone_email || ' Address: ' || l_street || ', ' || l_city || ', ' || l_state || ' ' || l_zip);

	LOOP
		FETCH l_curs INTO  l_orderid;
		EXIT WHEN l_curs%NOTFOUND;

		IF temp <> l_orderid THEN
			custDetails(l_orderid);
			orderDetails(l_orderid);
			paymentDetails(l_orderid);
		END IF;

		temp := l_orderid;
	
	END LOOP;
	CLOSE l_curs;

END;
/
Show Errors;
