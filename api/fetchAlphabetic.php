<?php
include 'almed_config.php';


// Replace these with your database connection details
$start = isset($_POST['start']) ? intval($_POST['start']) : 0;
$limit = isset($_POST['limit']) ? intval($_POST['limit']) : 10; // You can set a default limit if not provided
$letter = $_POST['letter'];
		

// Validate and sanitize input parameters to prevent SQL injection
$start = max(0, $start); // Ensure start is not negative
$limit = max(1, $limit);

$sql = "SELECT pname FROM product WHERE pname LIKE '$letter%'";
$result = $connect->query($sql);

if ($result->num_rows > 0) {
    $products = array();
    while ($row = $result->fetch_assoc()) {
        $products[] = $row['pname'];
    }
    echo json_encode($products);
} else {
    echo json_encode(array()); // Return an empty array for no products found
}



?>
