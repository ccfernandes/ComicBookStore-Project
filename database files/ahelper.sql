Create or Replace Procedure addToCart(
l_itemid in ItemOrdered.itemid%TYPE,
l_custid in ItemOrdered.custid%TYPE,
l_qty in number)

AS

temp NUMBER := 0;

BEGIN
	select count(*) into temp from Cart where itemid = l_itemid;
	
	IF (temp > 0) THEN

		Update Cart
		Set qty = qty + l_qty
		where itemid = l_itemid;
	ELSE
		INSERT INTO Cart VALUES (l_itemid, l_custid, l_qty);
	
	END IF;

END;
/
Show Errors;
