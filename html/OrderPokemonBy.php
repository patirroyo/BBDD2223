<!DOCTYPE html>
<html>

<head>
    <title>Pokedex</title>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
</head>
<script>

    function ordenar(field, order, tipo, nombre, pesomin, pesomax, alturamin, alturamax) {
        if (order == 'ASC' || order == "")
            orderby = 'DESC';
        else
            orderby = 'ASC';
        orderfield = field;
        
        document.location.href = window.location.href.split('?')[0] + "?orderfield=" + orderfield + "&orderby=" + orderby + "&tipo="+ tipo + "&nombre="+ nombre + "&pesomin="+ pesomin + "&pesomax=" + pesomax + "&alturamin=" + alturamin + "&alturamax=" + alturamax;
    }

    function editar(numero) {
        document.location.href = "FormularioEditar.php?numero_pokedex=" + numero;
    }
    function filtrar(filtro){
        if (orderby == 'ASC')
            orderby = 'DESC';
        else
            orderby = 'ASC';
        
        ordenar(orderfield, orderby, filtro, nombre, pesomin, pesomax, alturamin, alturamax);
    }
    function limpiar(){
        document.location.href = window.location.href.split('?')[0];
    }
    
</script>

<body>
    
    <?php

    include 'config.php';
    include 'iconos.php';
    $pesomin = 0;
    $sql = 'SELECT p.peso FROM pokemon p ORDER BY p.peso DESC LIMIT 1';
    $result = mysqli_query($mysqli, $sql);
    $pesomaximo = mysqli_fetch_array($result)['peso'];
    $alturamin = 0;
    $sql = 'SELECT p.altura FROM pokemon p ORDER BY p.altura DESC LIMIT 1';
    $result = mysqli_query($mysqli, $sql);
    $alturamaxima = mysqli_fetch_array($result)['altura'];
    

    $orderfield = htmlentities($_GET['orderfield']);
    $order = htmlentities($_GET['orderby']);
    $tipo = $_GET['tipo'];
    $nombre = htmlentities($_GET['nombre']);
    if (isset($_GET['pesomin']))
        $pesomin = htmlentities($_GET['pesomin']);
    if (isset($_GET['pesomax']))
        $pesomax = htmlentities($_GET['pesomax']);
    else
        $pesomax = $pesomaximo;
    if (isset($_GET['alturamin']))
        $alturamin = htmlentities($_GET['alturamin']);
    if (isset($_GET['alturamax']))
        $alturamax = htmlentities($_GET['alturamax']);
    else
        $alturamax = $alturamaxima;

    
    echo "<h1>Pokedex </h1>";

    $sql = 'SELECT * FROM pokemon p ';
    if (isset($tipo)&& $tipo != ""){
        $sql = "SELECT p.*, t.nombre as tipo FROM pokemon p 
                INNER JOIN pokemon_tipo pt
                    on p.numero_pokedex = pt.numero_pokedex
                INNER JOIN tipo t on pt.id_tipo = t.id_tipo 
                WHERE t.nombre = '" .$tipo."' ";
        if (isset($nombre)&&$nombre != "")
            $sql = $sql . "AND p.nombre LIKE '%" . $nombre . "%' ";
        if (isset($pesomin)&&$pesomin != "")
            $sql = $sql . "AND p.peso >= " . $pesomin . " ";
        if (isset($pesomax)&&$pesomax != "")
            $sql = $sql . "AND p.peso <= " . $pesomax . " ";
        if (isset($alturamin)&&$alturamin != "")
            $sql = $sql . "AND p.altura >= " . $alturamin . " ";
        if (isset($alturamax)&&$alturamax != "")
            $sql = $sql . "AND p.altura <= " . $alturamax . " ";
    }
    else if (isset($nombre)&&$nombre != ""){
        $sql = $sql . "WHERE p.nombre LIKE '%" . $nombre . "%' ";
        if (isset($pesomin)&&$pesomin != "")
            $sql = $sql . "AND p.peso >= " . $pesomin . " ";
        if (isset($pesomax)&&$pesomax != "")
            $sql = $sql . "AND p.peso <= " . $pesomax . " ";
        if (isset($alturamin)&&$alturamin != "")
            $sql = $sql . "AND p.altura >= " . $alturamin . " ";
        if (isset($alturamax)&&$alturamax != "")
            $sql = $sql . "AND p.altura <= " . $alturamax . " ";
    }
    else if (isset($pesomin)&&$pesomin != ""){
        $sql = $sql . "WHERE p.peso >= " . $pesomin . " ";
        if (isset($pesomax)&&$pesomax != "")
            $sql = $sql . "AND p.peso <= " . $pesomax . " ";
        if (isset($alturamin)&&$alturamin != "")
            $sql = $sql . "AND p.altura >= " . $alturamin . " ";
        if (isset($alturamax)&&$alturamax != "")
            $sql = $sql . "AND p.altura <= " . $alturamax . " ";
    }
    else if (isset($pesomax)&&$pesomax != ""){
        $sql = $sql . "WHERE p.peso <= " . $pesomax . " ";
        if (isset($alturamin)&&$alturamin != "")
            $sql = $sql . "AND p.altura >= " . $alturamin . " ";
        if (isset($alturamax)&&$alturamax != "")
            $sql = $sql . "AND p.altura <= " . $alturamax . " ";
    }
    else if (isset($alturamin)&&$alturamin != ""){
        $sql = $sql . "WHERE p.altura >= " . $alturamin . " ";
        if (isset($alturamax)&&$alturamax != "")
            $sql = $sql . "AND p.altura <= " . $alturamax . " ";
    }
    else if (isset($alturamax)&&$alturamax != ""){
        $sql = $sql . "WHERE p.altura <= " . $alturamax . " ";
    }

    if (isset($orderfield)&& $orderfield != "")
        $sql = $sql . 'ORDER BY p.'. $orderfield;
    else
        $sql = $sql . 'ORDER BY p.numero_pokedex';
    
    if (isset($order)&& $order != "")
        $sql = $sql . " " .$order;
    else
        $sql = $sql . " ASC";
    
    //echo "<p>Query: " . $sql . "<p>";
    $result = mysqli_query($mysqli, $sql);
    $movisFiltrados = 0;

    if (!$result) {
        die('Invalid query: ' . mysqli_error($mysqli));
    } else {
       // echo "<p>Query correcto<p>";
        echo '  <br><br>
                <br><br><br>
                
                <table class="filtros">
                <th colspan=20>Filtro(s)</th>
                <form id="filtro" name="filtro" method="get" action="OrderPokemonBy.php" >
                    <tr>
                        
                        <td>Tipo</td>
                        <td class="content-select">
                            <select name="tipo" id="tipo" onchange=filtro.submit()>
                                <option value="">Todos</option>';
                                $sqlTipo = 'SELECT nombre FROM tipo';
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
                    <tr>
                        <td>Nombre</td>
                        <td class="content-select">
                            <input name="nombre" id="nombre" onchange=filtro.submit() value='.$nombre.'>
                        </td>
                    </tr>
                    <tr>
                        <td>Peso Mímino</td>
                        <td class="content-select">
                            <input type="number" min="0" max="'.$pesomaximo.'" name="pesomin" id="pesomin" onchange=filtro.submit() value='.$pesomin. '>
                        </td>
                    </tr>
                    <tr>
                        <td>Peso Máximo</td>
                        <td class="content-select">
                            <input type="number" min="0" max="'.$pesomaximo.'" name="pesomax" id="pesomax" onchange=filtro.submit() value='.$pesomax. '>
                        </td>
                    </tr>
                        <td>Altura Mínima</td>
                        <td class="content-select">
                            <input type="number" min="0" max="'.$alturamaxima.'" name="alturamin" id="alturamin" step=0.1 onchange=filtro.submit() value='.$alturamin. '>
                        </td>
                    </tr>
                    <tr>
                        <td>Altura Máxima</td>
                        <td class="content-select">
                            <input type="number" min="0" max="'.$alturamaxima.'" name="alturamax" id="alturamax" step=0.1 onchange=filtro.submit() value='.$alturamax. '>
                        </td>
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
                    
                        <br><br>
                            <input type="button" value="Limpiar" onclick=limpiar()></button>';

    //echo "<h3>Ordenar por: " . $sql. "</h3>";
        //iterate all rows
        
        echo "<br><br>";
    while ($row = mysqli_fetch_assoc($result)) {
        if ($row['numero_pokedex'] < 10)
            $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/00" . $row['numero_pokedex'] . ".png";
        else if ($row['numero_pokedex'] < 100)
            $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/0" . $row['numero_pokedex'] . ".png";
        else
            $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/" . $row['numero_pokedex'] . ".png";
        echo "<table class='card'>
                <tr>
                    <th># " . $row['numero_pokedex'] . "<i onclick=ordenar('numero_pokedex','" .$order. "','".$tipo . "','".$nombre."',".$pesomin ."," .$pesomax,"," .$alturamin ."," .$alturamax.")></i></th>
                    <th colspan= 2>" . " " . $row['nombre'] . "<i onclick=ordenar(" . "'" . "nombre','" .$order. "','".$tipo . "','".$nombre."',".$pesomin ."," .$pesomax,"," .$alturamin ."," .$alturamax.")></i></th>
                </tr>
                <tr>
                    <td colspan=3>
                        <img class='portada' $imagen onclick=editar(" . $row['numero_pokedex'] . ")>
                        </img>
                    </td>
                </tr>
                <tr>
                    <td><b>Peso:</b>
                        <i onclick=ordenar('peso','" .$order. "','".$tipo . "','".$nombre."',".$pesomin ."," .$pesomax,"," .$alturamin ."," .$alturamax.")></i>
                    </td>
                    <td colspan=2>" .
                        $row['peso'] . 
                    "</tr>
                <tr>
                    </td><td><b>Altura:</b>
                        <i onclick=ordenar('altura','" .$order. "','".$tipo . "','".$nombre."',".$pesomin ."," .$pesomax,"," .$alturamin ."," .$alturamax.")></i>
                    </td><td colspan=2>" . 
                        $row['altura'] . 
                    "</td>
                </tr>";


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
                echo "<td onclick=ordenar('".$orderfield ."','".$order. "','".$col2 . "','".$nombre."',".$pesomin ."," .$pesomax,"," .$alturamin ."," .$alturamax.")><div class='tipo'>" . $col2 . "</div></td>";
            }
        }
        $sqlMovimientos = 'SELECT DISTINCT m.id_movimiento as id,
                                p.nombre as pokemon,
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
                            WHERE p.numero_pokedex = ' . $row['numero_pokedex'] . ';';
        $result3 = mysqli_query($mysqli, $sqlMovimientos);
        $totalMovis = $result3->num_rows;
        
        echo "<tr><td><b>Movimientos:</b></td>";
        
        $row3 = mysqli_fetch_assoc($result3);
            
            echo "<td colspan= 2>
                    <a href='FormularioEditar.php?numero_pokedex=".$row['numero_pokedex']. "#movimientos'
                    <div class='tipo'>" . $totalMovis . 
                    "</div>
                </td>";
            $movisFiltrados += $totalMovis;
        
        
        echo "</tr>
        </table>";
    }
    echo "</table>";
    }
    $sqlTotal = 'SELECT COUNT(numero_pokedex) as total FROM pokemon p';
        $resultTotal = mysqli_query($mysqli, $sqlTotal);
        $total = mysqli_fetch_assoc($resultTotal);
    
        $sqlTotalMovis = 'SELECT totalMovimientos()';
        $resultTotalMovis = mysqli_query($mysqli, $sqlTotalMovis);
        $totalMovis = mysqli_fetch_assoc($resultTotalMovis);
    
        echo "<br><br>
                <table class='totales'>
                    <tr>
                        <th>Pokemons</th>
                        <th>Movimientos</th>
                    </tr>
                    <tr>
                        <td>" . $result->num_rows . "/<b>" . $total['total'] . "</b></td>
                        <td>". $movisFiltrados. "/<b>" . $totalMovis['totalMovimientos()'] . "</b></td>
                    </tr>
                </table>";
    include 'close.php';
    ?>
</body>

</html>