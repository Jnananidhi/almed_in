<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE"); 
header("Access-Control-Allow-Headers: Content-Type, X-Auth-Token, Origin, Authorization");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "test";

$conn  = new mysqli($servername,$username,$password,$dbname);
if(!$conn){
	echo "Database connection failed";
}
  
  $person = $conn->query("SELECT * FROM `products` ORDER BY `Name` ASC");
  $list  = array();
  
  while($rowdata = $person ->fetch_assoc()){
	  $list[]=$rowdata;
  }
  echo json_encode($list);
 
  
  $conn->close();
    
    return;
  
  ?>
  
  