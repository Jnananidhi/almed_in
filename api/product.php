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
  
  $person = $conn->query("SELECT * FROM `product` ORDER BY `pname` ASC");
  $list  = array();
  
  while($rowdata = $person ->fetch_assoc()){
	  $list[]=$rowdata;
  }
  echo json_encode($list);
 
  
  $conn->close();
    
    return;
  
  ?>
  
  