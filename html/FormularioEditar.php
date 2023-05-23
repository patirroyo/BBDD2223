<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
    <TITLE>Editar pokemon</TITLE>
    <link rel="stylesheet" href="estilosResultados.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
    <script type="text/javascript">
        function eliminar(numero_pokedex) {
            var respuesta = confirm("¿Estás seguro de que quieres eliminar a " + document.getElementById('nombre').value + "?");
            if (respuesta) {
                document.location.href = "EliminarPokemon.php?numero_pokedex=" + numero_pokedex;
            } else {
                return false;
            }
        }
    </script>

</HEAD>

<BODY>
<a href='index.php'><img class='inicio' src="imagenes/e.png"></a>
    <h1>Editar Pokemon</h1>
    <?php
    $numero_pokedex = htmlentities($_GET['numero_pokedex'], ENT_QUOTES);
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
    if ($numero_pokedex < 10)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/00" . $numero_pokedex . ".png";
    else if ($numero_pokedex < 100)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/0" . $numero_pokedex . ".png";
    else
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/" . $numero_pokedex . ".png";
    
    //include "close.php";
    ?>
    <table>
        <form id="editar_pokemon" name="editar_pokemon" method="get" action="EditarPokemon.php">
            <th colspan=10 style="text-align:center"># <?php echo $numero_pokedex ?></th>
            <tr>
                <td rowspan="5"><img class="portada" <?php echo $imagen ?>></img></td>
            </tr>
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
                    <td></td>
                    <td>
                        <img src="./imagenes/b.png" class='edicion' <?php echo "onclick=eliminar(" . $numero_pokedex . ")" ?>>
                    </td>
                    <td>
                        <img src="./imagenes/edit.png" class='edicion' onclick="editar_pokemon.submit()">
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