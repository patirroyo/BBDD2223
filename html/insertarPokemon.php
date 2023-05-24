<!DOCTYPE html>
<html>

<head>
    <title>Insertar Pokemon</title>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <script type="text/javascript">
        function eliminar(numero_pokedex) {
            var respuesta = confirm("¿Estás seguro de que quieres eliminar este pokemon?");
            if (respuesta) {
                document.location.href = "EliminarPokemon.php?numero_pokedex=" + numero_pokedex;
            } else {
                return false;
            }
        }
    </script>
</head>

<body >

    <?php

    include 'config.php';

    $numero_pokedex = htmlentities($_GET['numero_pokedex']);
    $nombre = htmlentities($_GET['nombre']);
    $altura = htmlentities($_GET['altura']);
    $peso = htmlentities($_GET['peso']);

    $sql = 'INSERT INTO pokemon VALUES(' . $numero_pokedex . ', "' . $nombre . '", ' . $peso . ', ' . $altura . ')';

    $resultado = mysqli_query($mysqli, $sql);
    if ($resultado) {
		header("refresh:2;url=FormularioEditar.php?numero_pokedex=" . $numero_pokedex);
		echo "<h2>Creación correcta</h2>
			<h3>Redirigiendo a tu nuevo pokemon...</h3>";
	} else {
		echo "<h2>Creación incorrecta</h2>";
	}

    include "close.php";
    ?>


</body>

</html>