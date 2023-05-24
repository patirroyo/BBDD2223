<!DOCTYPE html>
<html>

<head>
	<title>Eliminar Movimiento</title>
	<link rel="stylesheet" href="estilosFormularios.css" type="text/css">
	<link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
</head>

<body>
	<?php

	include 'config.php';

	$numero_pokedex = htmlentities($_GET['numero_pokedex']);
	$id_movimiento = htmlentities($_GET['id_movimiento']);

	$sql = 'DELETE FROM pokemon_movimiento_forma
			WHERE numero_pokedex =' . $numero_pokedex . '
			AND id_movimiento =' . $id_movimiento . ';';

	$resultado = mysqli_query($mysqli, $sql);
	if ($resultado) {
		header("refresh:2;url=FormularioEditar.php?numero_pokedex=" . $numero_pokedex);
		echo "<h2>Eliminación correcta</h2>
			<h3>Redirigiendo a la página anterior...</h3>";
	} else {
		echo "<h2>Eliminación incorrecta</h2>";
	}

	include "close.php";

	?>


</body>

</html>