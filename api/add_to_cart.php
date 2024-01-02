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
$product_name = $_POST['product_name'];
$price = $_POST['price'];

// Check if the item is already in the cart
$checkStmt = $conn->prepare("SELECT * FROM cart WHERE username = ? AND product_id = ?");
$checkStmt->bind_param("si", $customer_username, $product_id);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

$response = []; // Initialize an array to store the response data

if ($checkResult->num_rows > 0) {
  // Item is already in the cart
  $response['status'] = 'error';
  $response['message'] = 'Item is already in the cart';
} else {
  // Item is not in the cart, proceed with insertion
  $insertStmt = $conn->prepare("INSERT INTO cart (`username`, `product_id`, `quantity`, `product_name`,`pprice`,`total_price`) VALUES (?, ?, ?, ?, ?, ?)");
  $insertStmt->bind_param("sissss", $customer_username, $product_id, $quantity, $product_name,$price, $price);
  $insertStmt->execute();
  $insertStmt->close();

  $response['status'] = 'success';
  $response['message'] = 'Item added to the cart';
}

$checkStmt->close();
$conn->close();

// Send the JSON response back to Flutter
header('Content-Type: application/json');
echo json_encode($response);
?>




