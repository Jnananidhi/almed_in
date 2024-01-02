<?php
$server = "localhost"; // Your MySQL server
$username = "root"; // Your MySQL username
$password = ""; // Your MySQL password
$database = "test"; // Your database name

$conn = new mysqli($server, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (isset($_FILES["file"])) {
    $file = $_FILES["file"];
    $fileName = $file["filename"];
    //$fileContent = file_get_contents($file["tmp_name"]);

    $sql = "INSERT INTO user (filename, dl1) VALUES (?,?);";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sb", $fileName, $fileContent);
    
    if ($stmt->execute()) {
        echo "File uploaded successfully.";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
} else {
    echo "No file received.";
}

$conn->close();
?>

