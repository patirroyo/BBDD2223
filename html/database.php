<!DOCTYPE html>
<html>
	<body>
	<?php

echo "conectando a database";
$mysqli = mysqli_connect("172.17.0.2", "root", "adminadmin", "pokemondb");
echo "<p>conectado a database<p>";
if (!$mysqli) {
	echo "<p>Error: No se pudo conectar a MySQL." . PHP_EOL;
	echo "<p>error de depuración: " . mysqli_connect_error() . PHP_EOL;
	echo "<p>error de depuración: " . mysqli_connect_error() . PHP_EOL;
	exit;
    }
echo "<p>Éxito: Se realizó una conexión apropiada a MySQL! La base de datos mi_bd es genial." . PHP_EOL;
echo "<p>Información del host: " . mysqli_get_host_info($mysqli) . PHP_EOL;

$result = mysqli_query($mysqli, "SELECT * FROM pokemon");
if(!$result){
    die('Invalid query: ' . mysql_error());
}else{
    echo "<p>Query correcto<p>";
    //iterate all rows
    while($row = mysqli_fetch_array($result)){
        foreach($row as $col){
            echo $col . " ";
        }
        echo "<br>";
    }
}

    
    mysqli_close($mysqli);
    echo "<p>Conexión cerrada<p>";
?>
    </body>
</html>