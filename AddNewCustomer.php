<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // collect input data from the form

	// Get the movie name
     $name = $_POST['name'];

	// Get the comment
     $phone_email = $_POST['phone_email'];

    //get Address
    $street = $_POST['street'];
    $city = $_POST['city'];
    $state = $_POST['state'];
    $zip = $_POST['zip'];

     if (!empty($name)){
		$name = prepareInput($name);
     }
     if (!empty($phone_email)){
		$phone_email = prepareInput($phone_email);
     }
     if (!empty($street)){
		$street = prepareInput($street);
     }
     if (!empty($city)){
        $city = prepareInput($city);
     }
     if (!empty($state)){
		$state = prepareInput($state);
     }
     if (!empty($zip)){
		$zip = prepareInput($zip);
     }
	 
	// Call the function to insert moviename and comments
	// into MovieReviews table

	insertMovieReviewIntoDB($name, $phone_email, $street, $city, $state, $zip);
	
}

function prepareInput($inputData){
	$inputData = trim($inputData);
  	$inputData  = htmlspecialchars($inputData);
  	return $inputData;
}

function insertCustomerIntoDB($name, $phone_email, $street, $city, $state, $zip){
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
	$sql = oci_parse($conn, 'begin addNewCustomer(:name, :phone_email, :street, :city, :state, :zip); end;');	

	oci_bind_by_name($sql, ':name', $name);
    oci_bind_by_name($sql, ':phone_email', $phone_email);
    oci_bind_by_name($sql, ':street', $street);
    oci_bind_by_name($sql, ':city', $city);
    oci_bind_by_name($sql, ':state', $state);
    oci_bind_by_name($sql, ':zip', $zip);

	// Execute the query
	$res = oci_execute($sql);
	
	if ($res){
		echo '<br><br> <p style="color:green;font-size:20px">';
		echo "New Customer Inserted </p>";
	}
	else{
		$e = oci_error($query);
        	echo $e['message'];
	}
	oci_free_statement($sql);
	OCILogoff($conn);
}
?>