<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // collect input data from the form

	//get store item info
	$itemid=$_POST['Itemid'];
	$price=$_POST['price'];

	//get comic book info 
	$numCopies=$_POST['numCopies'];
	$publishedDate=$_POST['publishedDate'];
	$title=$_POST['title'];
	$ISBN=$_POST['ISBN'];

     if (!empty($itemid)){
		$itemid = prepareInput($itemid);
     }
     if (!empty($price)){
		$price = prepareInput($price);
     }
     if (!empty($numCopies)){
		$numCopies = prepareInput($numCopies);
     }
     if (!empty($publishedDate)){
        $publishedDate = prepareInput($publishedDate);
     }
     if (!empty($title)){
		$title = prepareInput($title);
     }
     if (!empty($ISBN)){
		$ISBN = prepareInput($ISBN);
     }
	 
	// Call the function to insert moviename and comments
	// into MovieReviews table

	insertBookIntoDB($itemid, $price, $numCopies, $publishedDate, $title, $ISBN);
	
}

function prepareInput($inputData){
	$inputData = trim($inputData);
  	$inputData  = htmlspecialchars($inputData);
  	return $inputData;
}

function insertBookIntoDB($itemid, $price, $numCopies, $publishedDate, $title, $ISBN){
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