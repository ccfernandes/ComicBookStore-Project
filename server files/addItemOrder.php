<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // collect input data from the form

	//get store item info
	$itemid=$_POST['Itemid'];
	$qty=$_POST['qty'];


     if (!empty($itemid)){
		$itemid = prepareInput($itemid);
     }
     if (!empty($quantity)){
		$qty = prepareInput($qty);
     }
	 
	// Call the function to insert moviename and comments
	// into MovieReviews table

	insertBookIntoDB($itemid, $qty);
	
}

function prepareInput($inputData){
	$inputData = trim($inputData);
  	$inputData  = htmlspecialchars($inputData);
  	return $inputData;
}

function insertBookIntoDB($itemid, $qty){
	//connect to your database. Type in sd username, password and the DB path
	$conn = oci_connect('username', 'password', 'path to the server');
	
	if (!$conn) {
		$e = oci_error();
		trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
	} 
	if(!$conn) {
	     print "<br> connection failed:";
        exit;
	}

	// Query to get all info of every item 
	$query1 = oci_parse($conn, "SELECT itemid, price, title, quantity FROM StoreItem");
	$query2 = oci_parse($conn, "SELECT itemid, price, size FROM StoreItem");

	// Execute the query
	oci_execute($query1);
	oci_execute($query2);
	
	// Now access each row fetched in the loop
	while (($row = oci_fetch_array($query1, OCI_BOTH)) != false) {
		// We can use either numeric indexed starting at 0
		// or the column name as an associative array index to access the colum value
		// Use the uppercase column names for the associative array indices
		echo "<font color='black'>ItemID: </font>";
		echo "<font color='green'>  $row[0] </font>";
		echo "<font color='black'>Price: </font> <font color='red'> $row[1]</font></br>";
		echo "<font color='black'>Title: </font> <font color='red'> $row[2]</font></br>";
		echo "<font color='black'>Quantity: </font> <font color='blue'> $row[3]</font></br>";
	}

	while (($row = oci_fetch_array($query2, OCI_BOTH)) != false) {
		// We can use either numeric indexed starting at 0
		// or the column name as an associative array index to access the colum value
		// Use the uppercase column names for the associative array indices
		echo "<font color='black'>ItemID: </font>";
		echo "<font color='green'>  $row[0] </font>";
		echo "<font color='black'>Price: </font> <font color='red'> $row[1]</font></br>";
		echo "<font color='black'>Size: </font> <font color='red'> $row[2]</font></br>";
	}


	// Calling the PLSQL procedure, addNewCustomer
	$sql = oci_parse($conn, 'begin addNewCustomer(:itemid, :price, :numCopies, :publishedDate, :title, :ISBN); end;');	

	oci_bind_by_name($sql, ':itemid', $itemid);
    oci_bind_by_name($sql, ':price', $price);
    oci_bind_by_name($sql, ':numCopies', $numCopies);
    oci_bind_by_name($sql, ':publishedDate', $publishedDate);
    oci_bind_by_name($sql, ':title', $title);
    oci_bind_by_name($sql, ':isbn', $isbn);
	// Execute the query
	$res = oci_execute($sql);
	
	if ($res){
		echo '<br><br> <p style="color:green;font-size:20px">';
		echo "New Comic Book Inserted </p>";
	}
	else{
		$e = oci_error($query);
        	echo $e['message'];
	}
	oci_free_statement($sql);
	OCILogoff($conn);
}
?>