<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
    <TITLE>Movimientos</TITLE>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
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
    <a href='index.php'><img class='inicio' src="imagenes/e.png"></a>
    <h1>Movimientos</h1>
    <?php
    $numero_pokedex = htmlentities($_GET['numero_pokedex'], ENT_QUOTES);
    include "config.php";
    $sql = "SELECT p.nombre as pokemon,
                    m.id_movimiento as id,
                    m.nombre as nombre,
                    m.potencia as potencia,
                    m.precision_mov as 'precision',
                    m.pp as pp,
                    m.descripcion as descripcion,
                    t.nombre as tipo
            FROM pokemon p
            INNER JOIN pokemon_movimiento_forma pmf
                ON p.numero_pokedex = pmf.numero_pokedex
            INNER JOIN movimiento m
                ON pmf.id_movimiento = m.id_movimiento
            INNER JOIN tipo t on m.id_tipo = t.id_tipo
            WHERE p.numero_pokedex = " . $numero_pokedex;
    echo '<br><br>' . $sql . '<br><br>';

    $result = mysqli_query($mysqli, $sql);



    $fila = mysqli_fetch_assoc($result);

    $nombre = $fila['pokemon'];


    if (!$result) {
        die('Invalid query: ' . mysqli_error($mysqli));
    }
    if ($numero_pokedex < 10)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/00" . $numero_pokedex . ".png";
    else if ($numero_pokedex < 100)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/0" . $numero_pokedex . ".png";
    else
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/" . $numero_pokedex . ".png";
  
    echo "<table class='movimientos'>
            <th colspan=12>Movimientos</th>
            <tr>
            <th>Nombre</th>
            <th>Potencia</th>
            <th>Precisión</th>
            <th>PP</th>
            <th>Tipo</th>
            <th>Descripción</th>
    </tr>";
    while ($fila = mysqli_fetch_assoc($result)) {
        echo "<tr>";
        echo "<td><b>" . $fila['nombre'] . "</b></td>";
        echo "<td>" . $fila['potencia'] . "</td>";
        echo "<td>" . $fila['precision'] . "</td>";
        echo "<td>" . $fila['pp'] . "</td>";
        echo "<td>" . $fila['tipo'] . "</td>";
        echo '<td class="descripcion">' . $fila['descripcion'] . "</td>";
        echo "</tr>";
    }
    echo "</table>";
    

        //include "close.php";

    include "close.php";
    ?>
</BODY>

</HTML>