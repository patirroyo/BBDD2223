<!DOCTYPE html>
<html>

<head>
	<title>Eliminar Pokemon</title>
	<link rel="stylesheet" href="estilosFormularios.css" type="text/css">
</head>

<body>
	<?php

	include 'config.php';

	$numero_pokedex = $_GET['numero_pokedex'];
	$nombre = $_GET['nombre'];
	$altura = $_GET['altura'];
	$peso = $_GET['peso'];

	$sql = 'DELETE FROM pokemon WHERE numero_pokedex =' . $numero_pokedex;

	$resultado = mysqli_query($mysqli, $sql);
	if ($resultado) {
		echo "<h2>Eliminación correcta</h2>";
	} else {
		echo "<h2>Eliminación incorrecta</h2>";
	}

	include "close.php";
	?>


</body>

</html>