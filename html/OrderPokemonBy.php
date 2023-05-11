<!DOCTYPE html>
<html>
	<body>
	<?php

include 'config.php';

$orderfield = $_POST['orderfield'];
$order = $_POST['orderby'];
$sql = 'SELECT * FROM pokemon ORDER BY '. $orderfield .' '. $order;
echo '<br><br>'.$sql;

$result = mysqli_query($mysqli, $sql);



if(!$result){
    die('Invalid query: ' . mysql_error());
}else{
    echo "<p>Query correcto<p>";
    //iterate all rows
    while($row = mysqli_fetch_assoc($result)){
        foreach($row as $col){
            echo $col . " ";
        }
        echo "<br>";
    }
}

include 'close.php';
?>
    </body>
</html>