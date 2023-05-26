<!DOCTYPE html>
<html>

<head>
    <title>Insertar Pokemon</title>
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
    
    if($numero_pokedex == "" || $numero_pokedex < 0 ){
        echo "<br><br><h2>El número pokedex no puede estar vacío ni ser negativo</h2>";
        header("refresh:2;url=FormularioInsertar.php");
        echo "<h3>Redirigiendo al formulario de creación...</h3>";
        exit;
    }

    if(!isset($nombre)){
        echo "<br><br><h2>El nombre no puede estar vacío</h2>";
        header("refresh:2;url=FormularioInsertar.php");
        echo "<h3>Redirigiendo al formulario de creación...</h3>";
        exit;
    }
    if($peso < 0 || $peso > 1000){
        echo "<br><br><h2>El peso debe estar entre 0 y 1000</h2>";
        header("refresh:2;url=FormularioInsertar.php");
        echo "<h3>Redirigiendo al formulario de creación...</h3>";
        exit;
    }
    if($altura < 0 || $altura > 100){
        echo "<br><br><h2>La altura debe estar entre 0 y 100</h2>";
        header("refresh:2;url=FormularioInsertar.php");
        echo "<h3>Redirigiendo al formulario de creación...</h3>";
        exit;
    }
    $sql = 'INSERT INTO pokemon VALUES(' . $numero_pokedex . ', "' . $nombre . '", ' . $peso . ', ' . $altura . ')';

    $resultado = mysqli_query($mysqli, $sql);
    if ($resultado) {
		echo "<h2>Creación correcta</h2>
                <img src='imagenes/gotcha.png'>
			<h3>Redirigiendo a tu nuevo pokemon...</h3>";
        $sql2 = 'SELECT MAX(id) FROM Creados;';
        $resultado2 = mysqli_query($mysqli, $sql2);
        $id = mysqli_fetch_array($resultado2);
        $sql3 = "UPDATE  Creados SET ip_cliente = '" . $_SERVER['REMOTE_ADDR'] . "',
                                        user_agent = '" . $_SERVER['HTTP_USER_AGENT'] . "'
                WHERE id =". $id[0] .';';
        $resultado3 = mysqli_query($mysqli, $sql3);
        if ($resultado3) {
            echo "<h3>Se ha registrado la IP del creador</h3>";
        } else {
            echo "<h3>No se ha registrado la IP del creador</h3>";
        }
        header("refresh:2;url=FormularioEditar.php?numero_pokedex=" . $numero_pokedex);
	} else {
		echo "<h2>Creación incorrecta</h2>";
	}

    include "close.php";
    ?>


</body>

</html>