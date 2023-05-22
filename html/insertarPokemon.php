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
<a href='index.php'><img class='inicio' src="imagenes/e.png"></a>
    <?php

    include 'config.php';

    $numero_pokedex = htmlentities($_GET['numero_pokedex']);
    $nombre = htmlentities($_GET['nombre']);
    $altura = htmlentities($_GET['altura']);
    $peso = htmlentities($_GET['peso']);

    $sql = 'INSERT INTO pokemon VALUES(' . $numero_pokedex . ', "' . $nombre . '", ' . $altura . ', ' . $peso . ')';

    $resultado = mysqli_query($mysqli, $sql);
    if ($resultado) {
        echo "<h2>Inserción correcta</h2>";
    } else {
        echo "<h2>Inserción incorrecta</h2>";
    }

    $sql = "SELECT * FROM pokemon WHERE numero_pokedex=" . $numero_pokedex;

    $result = mysqli_query($mysqli, $sql);

    if (!$result) {
        die('Invalid query: ' . mysqli_error($mysqli));
    }

    $fila = mysqli_fetch_assoc($result);

    $nombre = $fila['nombre'];
    $peso = $fila['peso'];
    $altura = $fila['altura'];

    $result = mysqli_query($mysqli, $sql);
    if (!$result) {
        die('Invalid query: ' . mysqli_error($mysqli));
    }

    //include "close.php";
    ?>

    <table>
        <form id="Editar" name="datos" method="get" action="EditarPokemon.php">
            <th colspan=2>Editar Pokemon</th>
            <tr>
                <td>Número pokedex</td>
                <td><input type="text" name="numero_pokedex" id="numero_pokedex" value="<?php echo $numero_pokedex ?>"></td>
            <tr>
                <td>Nombre</td>
                <td><input type="text" name="nombre" id="nombre" value="<?php echo $nombre ?>"></td>
            </tr>
            <tr>
                <td>Peso</td>
                <td><input type="text" name="peso" id="peso" value="<?php echo $peso ?>"></td>
            </tr>
            <tr>
                <td>Altura</td>
                <td><input type="text" name="altura" id="altura" value="<?php echo $altura ?>"></td>
            </tr>
            <tfoot>
                <tr>
                <tr>
                    <td>
                        <img src="./imagenes/b.png" class='edicion' <?php echo "onclick=eliminar(" . $numero_pokedex . ")" ?>>
                    </td>
                    <td>
                        <img src="./imagenes/edit.png" class='edicion' onclick="Editar.submit()">
                    </td>
                </tr>
            </tfoot>
        </form>
    </table>
    </table>
    <?php
    include "close.php";
    ?>


</body>

</html>