<?php
// fetch_cart_price.php

header("Access-Control-Allow-Origin: *");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "almed";

$conn = new mysqli($servername, $username, $password, $dbname);

if (!$conn) {
  die("Database connection failed");
}

$customer_username = $_POST['username'];
//$customer_username = "anu";

$checkStmt = $conn->prepare("SELECT * FROM cart WHERE username = ?");
$checkStmt->bind_param("s", $customer_username);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

$response = [];

if ($checkResult->num_rows > 0) {
  $person = $conn->query("SELECT sum(`total_price`) as total FROM `cart` WHERE `username` = '$customer_username'");
  $list  = array();

  while($rowdata = $person ->fetch_assoc()){
    $list[]=$rowdata;
  }
  
  $response['status'] = 'success';
  $response['message'] = 'Item successfully updated';
  $response['data'] = $list;
} else {
  $response['status'] = 'error';
  $response['message'] = 'Failed to update the cart';
}

$checkStmt->close();
$conn->close();

header('Content-Type: application/json');
echo json_encode($response);
?>
