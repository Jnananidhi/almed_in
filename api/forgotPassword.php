<?php
require 'almed_config.php';

// Create a connection to the MySQL database

if ($conn->connect_error) {
    die('Connection failed: ' . $conn->connect_error);
}

// Handle the POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];

    // Check if the email exists in your database
    $stmt = $conn->prepare('SELECT id FROM users WHERE email = ?');
    $stmt->bind_param('s', $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        // Generate a random 6-digit code
        $verificationCode = mt_rand(100000, 999999);

        // Update the database with the code
        $stmt = $conn->prepare('UPDATE users SET verification_code = ? WHERE email = ?');
        $stmt->bind_param('is', $verificationCode, $email);
        $stmt->execute();

        // Send an email with the verification code
        $to = $email;
        $subject = 'Password Reset Verification Code';
        $message = 'Your verification code is: ' . $verificationCode;
        $headers = 'From: mjnananidhi35@gmail.com' . "\r\n" .
            'Reply-To: your_email@example.com' . "\r\n" .
            'X-Mailer: PHP/' . phpversion();

        if (mail($to, $subject, $message, $headers)) {
            echo json_encode(['message' => 'Password reset email sent']);
        } else {
            echo json_encode(['message' => 'Email sending failed']);
        }
    } else {
        echo json_encode(['message' => 'Email not found']);
    }
} else {
    echo json_encode(['message' => 'Invalid request']);
}

// Close the database connection
$conn->close();
?>
