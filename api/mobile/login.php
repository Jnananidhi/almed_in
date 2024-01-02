<?php
header("Access-Control-Allow-Origin: *");
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "almed";

$conn  = new mysqli($servername,$username,$password,$dbname);
 $username = $_POST['username'];
 $password = $_POST['password'];
 
//array for storing data
$data = array();
 $sql = "select name,username,designation, SL_NO from userr where username like '$username' and password = '$password'";
//crete an statement with query
$stmt=$conn -> prepare($sql);

//executing that satatement
$stmt ->execute();

//binding result 
$stmt->bind_result($NAME,$USER_NAME,$DESIGNATION,$EMP_ID);
while($stmt->fetch()){
    $temp=[
        'name'=>$NAME,
        'username'=>$USER_NAME,
		'designation'=>$DESIGNATION,
        'SL_NO'=>$EMP_ID,
        
        ];
    //pushing array into hero array
    array_push($data,$temp);
}
 
echo json_encode($data);

?>