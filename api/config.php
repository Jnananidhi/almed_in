<?php
header("Access-Control-Allow-Origin: *");
$username="root";//change username 
$password=""; //change password
$host="localhost";
$db_name="test"; //change databasename

$connect=mysqli_connect($host,$username,$password,$db_name);



?>