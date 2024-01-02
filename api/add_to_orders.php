<?php
// Assuming you have a database connection

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "almed";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


// Assuming you receive data from Flutter app
$order_date_time = date('Y-m-d H:i:s');

// Generate order ID (you can customize this logic as needed)
$order_id = uniqid('ORDER_');

$user_name = $_POST['username'];
$delivery_address = $_POST['delivery_address'];
$payment_method = $_POST['payment_method'];
$original_address = $_POST['original_address'];
$phone = $_POST['phone'];
$delivery_name = $_POST['delivery_name'];
$delivery_location = $_POST['LatLng'];

$user_name = 'anu';

// Check if there are items in the cart table for the user
$sql_check_cart = "SELECT * FROM cart WHERE username = '$user_name'";
$result = $conn->query($sql_check_cart);

if ($result->num_rows > 0) {
    // Fetch each cart item and insert it into the orders table
    while ($row = $result->fetch_assoc()) {
        $product_name = $row['product_name'];
        $quantity = $row['quantity'];
        $price = $row['total_price'];

        // Insert the cart item into the orders table
        $sql_insert_order = "INSERT INTO orders_almed (ORDER_ID,DATE,CUSTOMER_ID,NAME,ADDRESS,LAT_LONG,DELIVERY_ADDRESS,USER_PHONE,PAYMENT_MODE, PRODUCT_NAME, PRODUCT_QUANTITY, PRODUCT_PRICE) VALUES 
		('$order_id','$order_date_time','$user_name','$delivery_name','$original_address','$delivery_location','$delivery_address','$phone','$payment_method', '$product_name', '$quantity', '$price')";
        $conn->query($sql_insert_order);
    }

    // Clear the cart table after placing the order
    $sql_clear_cart = "DELETE FROM cart WHERE username = '$user_name'";
    $conn->query($sql_clear_cart);
	echo ($delivery_location);
    echo "Order placed successfully";
} else {
    echo "No items in the cart to place an order";
}

$conn->close();
?>
