<?php
include 'conn.php';

if($_SERVER['REQUEST_METHOD'] == 'GET'){
$queryResult=$connect->query("SELECT * FROM tb_item");

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}

echo json_encode($result);

} else{
	$response["msg"]=trim("Forbidden.");
	$response["code"]=404;
	$response["status"]=false;
	   echo json_encode($response);
}

?>
