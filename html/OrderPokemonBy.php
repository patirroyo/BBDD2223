<!DOCTYPE html>
<html>

<head>
    <title>OrderPokemonBy</title>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
</head>
<script>
    <?php
    echo "var orderfield = '" . htmlentities($_GET['orderfield']) . "';";
    echo "var orderby = '" . htmlentities($_GET['orderby']) . "';";
    ?>

    function ordenar(field, order) {
        if (field != orderfield)
            orderby = 'ASC';
        else if (order == 'ASC')
            orderby = 'DESC';
        else
            orderby = 'ASC';
        orderfield = field;
        //llamar a la página OrderPokemonBy.php con los parámetros orderfield y orderby por GET
        document.location.href = window.location.href.split('?')[0] + "?orderfield=" + orderfield + "&orderby=" + orderby;
    }

    function editar(numero) {
        document.location.href = "FormularioEditar.php?numero_pokedex=" + numero;
    }
</script>

<body>
    <img class='add' src="imagenes/add.png" onclick="document.location.href='FormularioInsertar.php'">
    
    <?php

    include 'config.php';
    

    $orderfield = htmlentities($_GET['orderfield']);
    $order = htmlentities($_GET['orderby']);

    echo "<h1>Pokedex </h1>";
    echo "<h3>Ordenar por: " . $orderfield . " " . $order . "</h3>";



    if (isset($_GET['tipo']))
        $sql = 'SELECT * FROM pokemon ORDER BY ' . $orderfield . ' ' . $order;
    else
        $sql = 'SELECT * FROM pokemon ORDER BY ' . $orderfield . ' ' . $order;


    $result = mysqli_query($mysqli, $sql);


    if (!$result) {
        die('Invalid query: ' . mysqli_error($mysqli));
    } else {
        echo "<p>Query correcto<p>";
        echo '<table>
        <th colspan=20>Filtro</th>
        <form id="filtro" name="filtro" method="get" action="OrderPokemonBy.php">
            <tr>
                <td>Tipo</td>
                <td class="content-select">
                    <select name="tipo" id="tipo" required>
                        <option value="numero_pokedex">Número pokedex</option>
                        <option value="nombre">Nombre</option>
                        <option value="peso">Peso</option>
                        <option value="altura">Altura</option>
                    </select><i></i>
                </td>

            
                <td>Order</td>
                <td class="content-select">
                    <select name="orderby" id="orderby" required>
                        <option value="ASC">Ascendente</option>
                        <option value="DESC">Descendente</option>
                    </select><i></i>
                </td>
            </tr>
            
        </form>
    </table>';
        //iterate all rows
        while ($row = mysqli_fetch_assoc($result)) {


            echo "<table class='card'>";
            echo "<tr>";
            echo "<th># " . $row['numero_pokedex'] . "<i onclick=ordenar('numero_pokedex','" . $order . "')></i></th>";
            echo "<th colspan= 2>" . " " . $row['nombre'] . "<i onclick=ordenar(" . "'" . "nombre','" . $order . "')" . "></i></th>";
            echo "</tr>";
            if ($row['numero_pokedex'] < 10)
                echo "<tr><td colspan=3><img class='portada' src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/00" . $row['numero_pokedex'] . ".png onclick=editar(" . $row['numero_pokedex'] . ")></img></td></tr>";
            else if ($row['numero_pokedex'] < 100)
                echo "<tr><td colspan=3><img class='portada' src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/0" . $row['numero_pokedex'] . ".png onclick=editar(" . $row['numero_pokedex'] . ")></img></td></tr>";
            else
                echo "<tr><td colspan=3><img class='portada' src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/" . $row['numero_pokedex'] . ".png onclick=editar(" . $row['numero_pokedex'] . ")></img></td></tr>";
            
            $sqlTipo = 'SELECT t.nombre as tipo
                    FROM pokemon p
                        INNER JOIN pokemon_tipo pt
                            on p.numero_pokedex = pt.numero_pokedex
                        INNER JOIN tipo t 
                            on pt.id_tipo = t.id_tipo
                        WHERE p.numero_pokedex = ' . $row['numero_pokedex'] . ';';
            $result2 = mysqli_query($mysqli, $sqlTipo);
            echo "<tr><td><b>Tipo:</b></td>";
            while ($row2 = mysqli_fetch_assoc($result2)) {
                foreach ($row2 as $col2) {
                    echo "<td><div class='tipo'>" . $col2 . "</div></td>";
                }
            }
            $sqlMovimientos = 'SELECT COUNT(m.id_movimiento) as movimientos
                                FROM pokemon p
                                INNER JOIN pokemon_movimiento_forma pmf
                                    ON p.numero_pokedex = pmf.numero_pokedex
                                INNER JOIN movimiento m
                                    ON pmf.id_movimiento = m.id_movimiento
                                WHERE p.numero_pokedex = ' . $row['numero_pokedex'] . ';';
            $result3 = mysqli_query($mysqli, $sqlMovimientos);
            echo "<tr><td><b>Movimientos:</b></td>";
            while ($row3 = mysqli_fetch_assoc($result3)) {
                echo "<td colspan= 2><div class='tipo'>" . $row3['movimientos'] . "</div></td>";
        
            }
            
            echo "</tr>";
            echo "</table>";
        }
        echo "</table>";
    }

    include 'close.php';
    ?>
</body>

</html>