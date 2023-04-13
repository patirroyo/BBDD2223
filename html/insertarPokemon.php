<!DOCTYPE html>
<html>
	<body>
	<?php

echo "conectando a database";
$mysqli = mysqli_connect("172.17.0.3", "root", "adminadmin", "pokemondb");
echo "<p>conectado a database<p>";
if (!$mysqli) {
	echo "<p>Error: No se pudo conectar a MySQL." . PHP_EOL;
	echo "<p>error de depuración: " . mysqli_connect_error() . PHP_EOL;
	echo "<p>error de depuración: " . mysqli_connect_error() . PHP_EOL;
	exit;
    }
echo "<p>Éxito: Se realizó una conexión apropiada a MySQL! La base de datos mi_bd es genial." . PHP_EOL;
echo "<p>Información del host: " . mysqli_get_host_info($mysqli) . PHP_EOL;

$nombre = $_POST['nombre'];
$altura = $_POST['altura'];
$peso = $_POST['peso'];

$sql = 'INSERT INTO pokemon(nombre, altura, peso) VALUES ("'.$nombre.'", "'.$altura.'", "'.$peso.'")';

$sql = 'Insert into pokemon(nombre,altura,peso) values("'.$nombre.'",'.$altura.','.$peso.' )';
echo $sql;
mysqli_query($mysqli, $sql);

    
    mysqli_close($mysqli);
    echo "<p>Conexión cerrada<p>";
?>
    </body>
</html>