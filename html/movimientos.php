<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
    <TITLE>Movimientos</TITLE>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
    <script type="text/javascript">
    <?php
    echo "var orderfield = '" . htmlentities($_GET['orderfield']) . "';";
    echo "var orderby = '" . htmlentities($_GET['orderby']) . "';";
    echo "var numero_pokedex = '" . htmlentities($_GET['numero_pokedex']) . "';";
    ?>
        function ordenar(field, order) {
            if (field != orderfield)
                orderby = 'ASC';
            else if (order == 'ASC')
                orderby = 'DESC';
            else
                orderby = 'ASC';
            orderfield = field;
            document.location.href = window.location.href.split('?')[0] + "?numero_pokedex=" + numero_pokedex +"&orderfield=" + orderfield + "&orderby=" + orderby;
    }
    </script>

</HEAD>

<BODY>
    <a href='index.php'><img class='inicio' src="imagenes/e.png"></a>
    <h1>Movimientos</h1>
    <?php
    include "config.php";
    $numero_pokedex = htmlentities($_GET['numero_pokedex'], ENT_QUOTES);
    
    $orderfield = htmlentities($_GET['orderfield']);
    $order = htmlentities($_GET['orderby']);


    $sql = "SELECT DISTINCT p.nombre as pokemon,
                    m.id_movimiento as id,
                    m.nombre as nombre,
                    m.potencia as potencia,
                    m.precision_mov as preciso,
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
    if (isset($orderfield) && $orderfield != "")
        $sql .= " ORDER BY " . $orderfield. " ";
    else 
        $sql .= " ORDER BY id ";
    
    if (isset($order) && $order != "")
        $sql .=  $order;
    else
        $sql .= " ASC";
    
    
    echo '<br><br>' . $sql . '<br><br>';

    $result = mysqli_query($mysqli, $sql);



    $row = mysqli_fetch_assoc($result);

    $nombre = $row['pokemon'];
    $total = $result->num_rows;

    if (!$result) {
        die('Invalid query: ' . mysqli_error($mysqli));
    }
    if ($numero_pokedex < 10)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/00" . $numero_pokedex . ".png";
    else if ($numero_pokedex < 100)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/0" . $numero_pokedex . ".png";
    else
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/" . $numero_pokedex . ".png";
    echo "<div class='pokemon'><img " . $imagen . "></div>";
    echo "<div class='nombre'><h2>#".$numero_pokedex . " " . $nombre . "</h2></div>";

    echo "<table class='movimientos'>
            <tr>
            <th colspan=12>Movimientos: " . $total . "</th>
            </tr>
            <tr>
            <th>ID<i onclick=ordenar('id','".$order."')></i></th>
            <th>Nombre<i onclick=ordenar('nombre','".$order."')></i></th>
            <th>Potencia<i onclick=ordenar('potencia','".$order."')></i></th>
            <th>Precisión<i onclick=ordenar('preciso','".$order."')></i></th>
            <th>PP<i onclick=ordenar('pp','".$order."')></i></th>
            <th>Tipo<i onclick=ordenar('tipo','".$order."')></i></th>
            <th>Descripción</th>
    </tr>";
    $result = mysqli_query($mysqli, $sql);
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr>";
        echo "<td><b>" . $row['id'] . "</b></td>";
        echo "<td><b>" . $row['nombre'] . "</b></td>";
        echo "<td>" . $row['potencia'] . "</td>";
        echo "<td>" . $row['preciso'] . "</td>";
        echo "<td>" . $row['pp'] . "</td>";
        echo "<td>" . $row['tipo'] . "</td>";
        echo '<td class="descripcion">' . $row['descripcion'] . "</td>";
        echo "</tr>";
    }
    echo "</table>";
    

        //include "close.php";

    include "close.php";
    ?>
</BODY>

</HTML>