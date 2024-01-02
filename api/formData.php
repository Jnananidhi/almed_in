<?php 
header("Access-Control-Allow-Origin: *");
include "almed_config.php";

// REGISTER USER

  
    $name = mysqli_real_escape_string($connect, $_POST['Name']);
    $email = mysqli_real_escape_string($connect, $_POST['Email']);
    $mobile = mysqli_real_escape_string($connect, $_POST['Message']);
  
 
        $query = "INSERT INTO form_data (Email, Message, Name)
  			  VALUES('$email','$mobile','$name')";
    $results = mysqli_query($connect, $query);
    if($results==true)
    {
				$result = array();
				array_push($result,array('msg'=>'Successful',
				));
				echo json_encode(array('status'=>$result));
    }
?>