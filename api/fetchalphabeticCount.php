<?php
header("Access-Control-Allow-Origin: *");
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "almed";
$letter = $_POST['letter'];


$conn  = new mysqli($servername,$username,$password,$dbname);
if(!$conn){
	echo "Database connection failed";
}
  
  $TotalCount=0;

	$check1 = "SELECT COUNT(`id`) AS TotalCount FROM product WHERE `pname` LIKE 'A%';";
	$resultcheck1 = mysqli_query($conn, $check1) or die("query $check1 failed in Counting Products because". mysqli_error($conn));				
	$recordcheck1 = mysqli_fetch_assoc($resultcheck1);
	if($recordcheck1)
	{
		$TotalCount=$recordcheck1['TotalCount'];
		
	} 
	$response = array('TotalCount' => $TotalCount);
	echo json_encode($response);
 
  $conn->close();
    
    return;
  
  ?>

  