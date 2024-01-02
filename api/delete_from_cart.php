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
/*
$customer_username = "anushree";
$product_id = "80";
*/
// Check if the item is already in the cart
$checkStmt = $conn->prepare("SELECT * FROM cart WHERE username = ? AND product_id = ?");
$checkStmt->bind_param("ss", $customer_username, $product_id);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

$response = []; // Initialize an array to store the response data

if ($checkResult->num_rows > 0) {
  $insertStmt = $conn->prepare("DELETE  FROM cart WHERE username = ? AND product_id = ?;");
  $insertStmt->bind_param("si", $customer_username, $product_id);
  $insertStmt->execute();
  $insertStmt->close();

  $response['status'] = 'success';
  $response['message'] = 'Item sucessfully remove from cart';
  
} else {
  $response['status'] = 'error';
  $response['message'] = 'Item not in cart';
}

$checkStmt->close();
$conn->close();

// Send the JSON response back to Flutter
header('Content-Type: application/json');
echo json_encode($response);
?>




