<?php
header("Access-Control-Allow-Origin: *");
error_reporting(E_ALL);
ini_set('display_errors', 1);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Handle form data
     $shop = $_POST['shop'];
	 $owner = $_POST['owner'];
	 $GST = $_POST['GST'];
	 $DL = $_POST['DL'];
	 $DL2 = $_POST['DL2'];
	 $address = $_POST['address'];
	 $city = $_POST['city'];
	 $phone = $_POST['phone'];
	 $email = $_POST['email'];
	 
	 $almed_password = $_POST['password'];
	 $postcode = $_POST['postcode'];
    // Retrieve other form fields similarly
    
    // Create a directory to store uploaded files
    $uploadDirectory = 'uploads/'; // Directory path where files will be stored

    // Handle file uploads
    $file1 = $_FILES['file1']; // Retrieve file 1
    $file2 = $_FILES['file2'];
	$file3 = $_FILES['file3'];	// Retrieve file 2
    // Handle other files similarly

    // Store uploaded files in the server
    $file1Path = $uploadDirectory . basename($file1['name']);
    move_uploaded_file($file1['tmp_name'], $file1Path);

    $file2Path = $uploadDirectory . basename($file2['name']);
    move_uploaded_file($file2['tmp_name'], $file2Path);
	
	$file3Path = $uploadDirectory . basename($file3['name']);
    move_uploaded_file($file3['tmp_name'], $file3Path);
    // Store other files similarly
    
    // Insert data and file information into the database
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "almed";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // SQL query to insert data into database
    $sql = "INSERT INTO userr(`username`,`password`,`shop_name`,`owner`,`gst_no`,`dl1`,`dl2`,`adress`,`city`,`postcode`,`phone`,email,`dl1_file_name`,`dl1_file_path`,dl2_file_name,dl2_file_path,dl3_file_name,dl3_file_path) VALUES ('$email','$almed_password','$shop','$owner','$GST','$DL','$DL2','$address','$city','$postcode','$phone','$email', '$file1[name]', '$file1Path', '$file2[name]', '$file2Path','$file3[name]', '$file3Path')";

    if ($conn->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    $conn->close();
}
?>
