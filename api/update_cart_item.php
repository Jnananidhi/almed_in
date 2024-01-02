<?php
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
$product_id = $_POST['product_id'];
$quantity = $_POST['quantity'];
$total_price = $_POST['total_price'];
/*
$customer_username = "anu";
$product_id = "80";
$quantity = "3";
$total_price ="160";
*/
// Check if the item is already in the cart
$checkStmt = $conn->prepare("SELECT * FROM cart WHERE username = ? AND product_id = ?");
$checkStmt->bind_param("si", $customer_username, $product_id);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

$response = []; // Initialize an array to store the response data

if ($checkResult->num_rows > 0) {
  $insertStmt = $conn->prepare("UPDATE `cart` set quantity = ?,total_price = ? where username =? AND product_id = ?  ");
  $insertStmt->bind_param("sssi",$quantity,$total_price, $customer_username, $product_id);
  $insertStmt->execute();
  $insertStmt->close();

  $response['status'] = 'success';
  $response['message'] = 'Item sucessfully updated';
  
} else {
  $response['status'] = 'error';
  $response['message'] = 'Failed to update the cart';
}

$checkStmt->close();
$conn->close();

// Send the JSON response back to Flutter
header('Content-Type: application/json');
echo json_encode($response);
?>




