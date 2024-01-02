<?php
header("Access-Control-Allow-Origin: *");
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "almed";

$conn  = new mysqli($servername,$username,$password,$dbname);
if(!$conn){
	echo "Database connection failed";
}

 $username = $_POST['username'];
 $password = $_POST['password'];
 $sql = "SELECT * FROM `userr` WHERE `username`='$username' AND `password`='$password'";
 $result = mysqli_query($conn,$sql);
 $count = mysqli_num_rows($result);
 if($count == 1){
    echo json_encode("Success");
 } 
 else{
    echo json_encode("Error");
 }
?>