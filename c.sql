Create or Replace Procedure setShippingDate(
l_orderid in ItemOrdered.orderid%TYPE)
AS

BEGIN 
--SELECT orderid INTO l_orderid FROM ItemOrdered WHERE orderid = l_orderid;

UPDATE ItemOrdered
SET shippedDate = orderDate+2
WHERE orderid = l_orderid;
 
END;
/
Show Errors;

