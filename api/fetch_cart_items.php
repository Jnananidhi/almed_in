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
 // $username = 'anu';
  $person = $conn->query("SELECT * FROM `cart` WHERE username='$username' ORDER BY `id`;");
  $list  = array();
  
  while($rowdata = $person ->fetch_assoc()){
	  $list[]=$rowdata;
  }
  echo json_encode($list);
  
 
  
  $conn->close();
    
    return;
  
  ?>

  