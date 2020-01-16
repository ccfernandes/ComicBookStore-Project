CREATE OR REPLACE TRIGGER custType_trig 
AFTER UPDATE OF isGold
ON StoreCustomer
FOR EACH ROW
--update datejoined to sysdate pls
DECLARE
	l_custid ItemOrdered.custid%type;

CURSOR l_curs IS 
	SELECT custid FROM ItemOrdered WHERE shippingFee = 10;

BEGIN
	OPEN l_curs;
	
	LOOP
		FETCH l_curs INTO l_custid;

		EXIT WHEN l_curs%NOTFOUND;
			IF :new.isGold <> :old.isGold THEN
				UPDATE ItemOrdered
				SET shippingFee = 0
				WHERE custid = l_custid AND (shippedDate > sysdate OR shippedDate is null);

				EXIT;
			END IF;
	END LOOP;

	CLOSE l_curs;

END;
/
Show Errors;

