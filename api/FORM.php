<?php

	$servername = "localhost";
$username = "root";
$password = "";
$dbname = "almed";

$conn  = new mysqli($servername,$username,$password,$dbname);
$farmer_data = array();
 $sql = "SELECT * FROM `form` ORDER BY `form`.`FORM` ASC";
//crete an statement with query
$stmt=$conn -> prepare($sql);

//executing that satatement
$stmt ->execute();

//binding result 
$stmt->bind_result($SL_NO,$FORM,$image);
while($stmt->fetch()){
    $temp=[
        'SL_NO'=>$SL_NO,
		'FORM'=>$FORM,
		'image'=>$image
        ];
    //pushing array into hero array
    array_push($farmer_data,$temp);
}
 
echo json_encode($farmer_data);
 
?>
        
 
 
 
 