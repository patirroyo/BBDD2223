<!DOCTYPE html>
<html>
    <head>
        <title>OrderPokemonBy</title>
        <link rel="stylesheet" href="estilosResultados.css"type="text/css">
    </head>
    <script>
        <?php
        echo "var orderfield = '".$_GET['orderfield']."';";
        echo "var orderby = '".$_GET['orderby']."';";
        ?>
        
        
        function ordenar(field, order){
            if(field != orderfield)
                orderby = 'ASC';
            else if(order == 'ASC')
                orderby = 'DESC';
            else
                orderby = 'ASC';
            orderfield = field;
            //llamar a la página OrderPokemonBy.php con los parámetros orderfield y orderby por GET
            document.location.href = "OrderPokemonBy.php?orderfield=" + orderfield + "&orderby=" + orderby;
            
            
        }
        


        
    </script>
	<body>
	<?php

include 'config.php';

$orderfield = $_GET['orderfield'];
$order = $_GET['orderby'];



$sql = 'SELECT * FROM pokemon ORDER BY '. $orderfield .' '. $order;
echo '<br><br>'.$sql;

$result = mysqli_query($mysqli, $sql);


if(!$result){
    die('Invalid query: ' . mysql_error());
}else{ 
    echo "<p>Query correcto<p>";
    echo "<table>";
    echo "<tr><th>#<i onclick=ordenar("."'"."numero_pokedex','".$order."')></i></th>";
    echo "<th>Nombre<i onclick=ordenar("."'"."nombre','".$order."')"."></i></th>";
    echo "<th>Peso<i onclick=ordenar("."'"."peso','".$order."')"."></i></th>";
    echo "<th>Altura<i onclick=ordenar("."'"."altura','".$order."')"."></i></th>";
    echo "</tr>";
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