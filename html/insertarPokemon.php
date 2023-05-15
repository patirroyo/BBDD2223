<!DOCTYPE html>
<html>
	<head>
		<title>Insertar Pokemon</title>
		<link rel="stylesheet" href="estilosResultados.css"type="text/css">
	<body>
	<?php

include 'config.php';

$nombre = $_POST['nombre'];
$altura = $_POST['altura'];
$peso = $_POST['peso'];

$sql = 'INSERT INTO pokemon(nombre, altura, peso) VALUES ("'.$nombre.'", "'.$altura.'", "'.$peso.'")';

echo $sql;
mysqli_query($mysqli, $sql);

mysqli_close($mysqli);
echo "<p>Conexión cerrada<p>";
?>
    </body>
</html>