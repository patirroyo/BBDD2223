<!DOCTYPE html>
<html>
    <head>
        <title>OrderPokemonBy</title>
        <link rel="stylesheet" href="estilos.css"type="text/css">
    </head>
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
    echo "<table><tr><th>#</th><th>Nombre</th><th>Peso</th><th>Altura</th></tr>";
    //iterate all rows
    while($row = mysqli_fetch_assoc($result)){
        echo "<tr>";
        foreach($row as $col){
            echo "<td>". $col . "</td>";
        }
        echo "</tr>";
    }
    echo "</table>";
}

include 'close.php';
?>
    </body>
</html>