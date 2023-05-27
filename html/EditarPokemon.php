<!DOCTYPE html>
<html>

<head>
    <title>Editar Pokemon</title>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <script type="text/javascript">
    </script>
</head>

<body >

    <?php

    include 'config.php';

    $numero_pokedex = htmlentities($_GET['numero_pokedex']);
    $nombre = htmlentities($_GET['nombre']);
    $altura = htmlentities($_GET['altura']);
    $peso = htmlentities($_GET['peso']);

    $tipo1 = htmlentities($_GET['tipo1']);
    $tipo2 = htmlentities($_GET['tipo2']);

    $ps = htmlentities($_GET['ps']);
    $ataque = htmlentities($_GET['ataque']);
    $defensa = htmlentities($_GET['defensa']);
    $especial = htmlentities($_GET['especial']);
    $velocidad = htmlentities($_GET['velocidad']);

    
    $sql = "UPDATE pokemon SET nombre = '" . $nombre . "', altura = " . $altura . ", peso = " . $peso . " WHERE numero_pokedex = " . $numero_pokedex . ";";

    $resultado = mysqli_query($mysqli, $sql);
    if ($resultado) {
		echo "<h2>Actualización tabla pokemon correcta</h2>";
        if($tipo2 == "null"){
            $sql2 = "DELETE FROM pokemon_tipo WHERE numero_pokedex = " . $numero_pokedex . ";";
            $resultado2 = mysqli_query($mysqli, $sql2);
            $sql3 = "INSERT INTO pokemon_tipo VALUES (" . $numero_pokedex . ", " . $tipo1 . ");";
            
        }else{
            $sql2 = "DELETE FROM pokemon_tipo WHERE numero_pokedex = " . $numero_pokedex . ";";
            $resultado2 = mysqli_query($mysqli, $sql2);
            $sql3 = "INSERT INTO pokemon_tipo VALUES (" . $numero_pokedex . ", " . $tipo1 . "), (" . $numero_pokedex . ", " . $tipo2 . ");";
        }
        $resultado3 = mysqli_query($mysqli, $sql3);
        if ($resultado3) {
            echo "<h2>Actualización tabla pokemon_tipo correcta</h2>";
            $sql4 = "DELETE FROM estadisticas_base WHERE numero_pokedex = " . $numero_pokedex . ";";
            $resultado4 = mysqli_query($mysqli, $sql4);
            $sql5 = "INSERT INTO estadisticas_base VALUES (" . $numero_pokedex . ", " . $ps . ", " . $ataque . ", " . $defensa . ", " . $especial . ", " . $velocidad . ");";
            $resultado5 = mysqli_query($mysqli, $sql5);
            if ($resultado5) {
                echo "<h2>Actualización tabla pokemon_estadisticas correcta</h2>
                        <img src='imagenes/gotcha.png'>
                        <h2>¡Pokemon actualizado!</h2>
                        <h3>Redirigiendo a tu pokemon actualizado...</h3>";
            } else {
                echo "<h2>Actualización tabla pokemon_estadisticas incorrecta</h2>";
            }
        } else {
            echo "<h2>Actualización tabla pokemon_tipo incorrecta</h2>";
        }
        header("refresh:5;url=FormularioEditar.php?numero_pokedex=" . $numero_pokedex);
	} else {
		echo "<h2>Actualización incorrecta</h2>";
	}

    include "close.php";
    ?>


</body>

</html>