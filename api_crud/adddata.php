<?php

	include 'conn.php';
	
	if($_SERVER['REQUEST_METHOD'] == 'POST'){
	$itemcode = $_POST['itemcode'];
	$itemname = $_POST['itemname'];
	$price = $_POST['price'];
	$stock= $_POST['stock'];

/*	$connect->query("INSERT INTO tb_item (item_code,item_name,price,stock) VALUES ('".$itemcode."','".$itemname."','".$price."','".$stock."')");
*/

$query=("INSERT INTO tb_item (item_code,item_name,price,stock) VALUES ('".$itemcode."','".$itemname."','".$price."','".$stock."')");
$exeQuery =mysqli_query($connect,$query);

	$response["msg"]=trim("Successfully insert.");
	$response["code"]=200;
	$response["status"]=true;
	echo json_encode($response);

} else{
	$response["msg"]=trim("Forbidden.");
	$response["code"]=404;
	$response["status"]=false;
	   echo json_encode($response);
}




?>