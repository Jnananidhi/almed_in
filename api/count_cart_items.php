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
  //$username = 'anu';
  $CartCount=0;
  
  $check1 = "SELECT COUNT(`username`) AS CartCount FROM cart WHERE `username`='$username';";
	$resultcheck1 = mysqli_query($conn, $check1) or die("query $check1 failed in count_cartItems". mysqli_error($conn));
	$recordcheck1 = mysqli_fetch_assoc($resultcheck1);
	if($recordcheck1)
	{
		$CartCount=$recordcheck1['CartCount'];
		
	} 
	$response = array('cartCount' => $CartCount);
	echo json_encode($response);
 
  $conn->close();
    
    return;
  
  ?>

  