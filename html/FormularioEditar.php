<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
    <TITLE> Formulario Ordenar todos Pokemon</TITLE>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
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

</HEAD>

<BODY>
    <h1>Formulario Editar Pokemon</h1>
    <?php
    $numero_pokedex = $_GET['numero_pokedex'];
    include "config.php";
    $sql = "SELECT * FROM pokemon WHERE numero_pokedex=" . $numero_pokedex;
    echo '<br><br>' . $sql . '<br><br>';

    $result = mysqli_query($mysqli, $sql);



    $fila = mysqli_fetch_assoc($result);

    $nombre = $fila['nombre'];
    $peso = $fila['peso'];
    $altura = $fila['altura'];


    if (!$result) {
        die('Invalid query: ' . mysqli_error($mysqli));
    }

    //include "close.php";
    ?>
    <table>
        <form id="editar_pokemon" name="editar_pokemon" method="get" action="EditarPokemon.php">
            <th colspan=2>Editar Pokemon</th>
            <tr>
                <td>Número pokedex</td>
                <td><input type="number" name="numero_pokedex" id="numero_pokedex" value="<?php echo $numero_pokedex ?>" readonly ></td>
            <tr>
                <td>Nombre</td>
                <td><input type="text" name="nombre" id="nombre" value="<?php echo $nombre ?>"></td>
            </tr>
            <tr>
                <td>Peso</td>
                <td><input type="number" name="peso" id="peso" step="0.1" value="<?php echo $peso ?>"></td>
            </tr>
            <tr>
                <td>Altura</td>
                <td><input type="number" name="altura" id="altura" value="<?php echo $altura ?>"></td>
            </tr>
            <tfoot>
                <tr>
                <tr>
                    <td>
                        <img src="./imagenes/b.png" <?php echo "onclick=eliminar(" . $numero_pokedex . ")" ?>>
                    </td>
                    <td>
                        <img src="./imagenes/edit.png" onclick="editar_pokemon.submit()">
                    </td>
                </tr>
            </tfoot>
        </form>
    </table>
    <?php
    include "close.php";
    ?>
</BODY>

</HTML>