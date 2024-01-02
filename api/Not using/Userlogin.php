<?php

 if($_SERVER['REQUEST_METHOD']=='POST'){

include 'almed_config.php';
 
 //$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
 
 //$username = $_POST['username'];
 //$password = $_POST['password'];
 
//array for storing data
$data = array();
 $sql = "select id,name,shop_name,imei,email,gst_number,dl1_number,dl2_number, mobile, password  from user where email like '$email' and password = '$password'";
//crete an statement with query
$stmt=$conn -> prepare($sql);

//executing that satatement
$stmt ->execute();

//binding result 
$stmt->bind_result($id,$name,$shop_name,$imei,$email,$gst_number,$dl1_number,$dl2_number);
while($stmt->fetch()){
    $temp=[
		'id' =>$id,
        'name'=>$name,
        'shop_name'=>$shop_name,
        'imei'=>$imei,
        'email'=>$email,
        'gst_number'=>$gst_number,
        'dl1_number'=>$dl1_number,
		'dl2_number'=>$dl2_number,
		'mobile'=>$mobile,
		'password'=>$password
        ];
    //pushing array into hero array
    array_push($data,$temp);
}
 
echo json_encode($data);
 }
?>
        
 
 
 
 