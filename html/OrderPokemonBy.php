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

    function ordenar(field, order, tipo) {
        if (field != orderfield)
            orderby = 'ASC';
        else if (order == 'ASC')
            orderby = 'DESC';
        else
            orderby = 'ASC';
        orderfield = field;
        //llamar a la página OrderPokemonBy.php con los parámetros orderfield y orderby por GET
        if(tipo == undefined)
            document.location.href = window.location.href.split('?')[0] + "?orderfield=" + orderfield + "&orderby=" + orderby;
        else
            document.location.href = window.location.href.split('?')[0] + "?orderfield=" + orderfield + "&orderby=" + orderby + "&tipo="+ tipo;
    }

    function editar(numero) {
        document.location.href = "FormularioEditar.php?numero_pokedex=" + numero;
    }
    function filtrar(filtro){
        if (orderby == 'ASC')
            orderby = 'DESC';
        else
            orderby = 'ASC';
        ordenar(orderfield, orderby, filtro);
    }
    function limpiar(){
        document.location.href = window.location.href.split('?')[0];
    }
</script>

<body>
    <a href='index.php'><img class='inicio' src="imagenes/e.png"></a>
    <a href='FormularioInsertar.php'><img class='add' src="imagenes/add.png"></a>
    
    <?php

    include 'config.php';
    

    $orderfield = htmlentities($_GET['orderfield']);
    $order = htmlentities($_GET['orderby']);
    $tipo = $_GET['tipo'];
    echo "<h1>Pokedex </h1>";
    

    $sql = 'SELECT * FROM pokemon p 
                ';
    if (isset($tipo)&& $tipo != "")
        $sql = "SELECT p.*, t.nombre as tipo FROM pokemon p 
                INNER JOIN pokemon_tipo pt
                    on p.numero_pokedex = pt.numero_pokedex
                INNER JOIN tipo t on pt.id_tipo = t.id_tipo 
                WHERE t.nombre = '" .$tipo."' ";
    if (isset($orderfield)&& $orderfield != "")
        $sql = $sql . 'ORDER BY p.'. $orderfield;
    
    if (isset($order)&& $order != "")
        $sql = $sql . " " .$order;
    
    echo "<p>Query: " . $sql . "<p>";
    $result = mysqli_query($mysqli, $sql);
    

    if (!$result) {
        die('Invalid query: ' . mysqli_error($mysqli));
    } else {
        echo "<p>Query correcto<p>";
        echo '<table class="filtros">
                <th colspan=20>Filtro</th>
                <form id="filtro" name="filtro" method="get" action="OrderPokemonBy.php" >
                    <tr>
                        
                        <td>Tipo</td>
                        <td class="content-select">
                            <select name="tipo" id="tipo" onchange=filtro.submit()>
                                <option value="">Todos</option>';
                                $sqlTipo = 'SELECT * FROM tipo';
                                $resultTipo = mysqli_query($mysqli, $sqlTipo);
                                while ($row2 = mysqli_fetch_assoc($resultTipo)) {
                                    if ($row2['nombre'] == $tipo)
                                        echo "<option value='" . $row2['nombre'] . "' selected>" . $row2['nombre'] . "</option>";
                                    else
                                    echo "<option value='" . $row2['nombre'] . "'>" . $row2['nombre'] . "</option>";
                                }
                            echo '
                            </select><i></i>
                        </td>
                    </tr>
                    </table>
                    <table class="filtros">
                    <th colspan=20>Ordenación</th>
                    <tr>
                        <td>Order field</td>
                        <td class="content-select">
                            <select name="orderfield" id="orderfield" required onchange=filtro.submit()>
                                <option value="numero_pokedex"';
                                if ($orderfield == "numero_pokedex")
                                    echo "selected";
                                echo'>Número pokedex</option>
                                <option value="nombre"';
                                if ($orderfield == "nombre")
                                    echo "selected";
                                echo '>Nombre</option>
                                <option value="peso"';
                                if ($orderfield == "peso")
                                    echo "selected";
                                echo '>Peso</option>
                                <option value="altura"';
                                if ($orderfield == "altura")
                                    echo "selected";
                                echo '>Altura</option>
                            </select><i></i>
                        </td>
                    </tr>
                    <tr>
                        <td>Orden</td>
                        <td class="content-select">
                            <select name="orderby" id="orderby" onchange=filtro.submit()>
                                <option value="ASC"';
                                if ($order == "ASC")
                                    echo "selected";
                                echo '>Ascendente</option>
                                <option value="DESC"';
                                if ($order == "DESC")
                                    echo "selected";
                                echo '>Descendente</option>
                            </select><i></i>
                        </td>
                    </tr>
                </form>
                </table>
                    
                        <br>
                            <input type="button" value="Limpiar" onclick=limpiar()></button>
                        <br><br>';

    echo "<h3>Ordenar por: " . $sql. "</h3>";
        //iterate all rows
        while ($row = mysqli_fetch_assoc($result)) {


            echo "<table class='card'>";
            echo "<tr>";
            echo "<th># " . $row['numero_pokedex'] . "<i onclick=ordenar('numero_pokedex','" . $order . "','".$tipo."')></i></th>";
            echo "<th colspan= 2>" . " " . $row['nombre'] . "<i onclick=ordenar(" . "'" . "nombre','" . $order . "','".$tipo."')></i></th>";
            echo "</tr>";
            if ($row['numero_pokedex'] < 10)
                echo "<tr><td colspan=3><img class='portada' src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/00" . $row['numero_pokedex'] . ".png onclick=editar(" . $row['numero_pokedex'] . ")></img></td></tr>";
            else if ($row['numero_pokedex'] < 100)
                echo "<tr><td colspan=3><img class='portada' src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/0" . $row['numero_pokedex'] . ".png onclick=editar(" . $row['numero_pokedex'] . ")></img></td></tr>";
            else
                echo "<tr><td colspan=3><img class='portada' src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/" . $row['numero_pokedex'] . ".png onclick=editar(" . $row['numero_pokedex'] . ")></img></td></tr>";
            echo "<tr><td><b>Peso:</b><i onclick=ordenar('peso','".$order. "','".$tipo . "')></i></td><td colspan=2>" . 
                    $row['peso'] . 
                "</tr><tr></td><td><b>Altura:</b><i onclick=ordenar('peso','".$order. "','".$tipo . "')></i></td><td colspan=2>" . 
                    $row['altura'] . 
                "</td></tr>";
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
                    echo "<td onclick=filtrar('". $col2. "')><div class='tipo'>" . $col2 . "</div></td>";
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