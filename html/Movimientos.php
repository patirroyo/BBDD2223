<html>
<head>
    <title>Movimientos</title>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
    <script>
        function limpiar(){
        document.location.href = window.location.href.split('?')[0];
    }
        <?php
        include 'funcionesMovimientos.php';
        ?>
    </script>
</head>
<body>
    <h1>Movimientos</h1>
    <h2>Buscador de descripciones</h2>
    <br>
    <br>
    <form action="Movimientos.php" method="get">
        <input class="boolean" type="text" name="buscador" id="buscador" placeholder="Buscar...">
        <input type="submit" value="Buscar">
        <input type="button" value="Limpiar" onclick="limpiar()">
    </form>
    <br>
    <h4>Para incluir una palabra en la busqueda, incluir el signo + delante de la palabra (+palabra)</h4>
    <br>
    <h4>Para excluir una palabra en la busqueda, incluir el signo - delante de la palabra (-palabra)</h4>
    <br>
    <h4>Para buscar una frase, incluir la frase entre comillas ("frase entre comillas")</h4>
    <br>
    <h4>Para buscar una palabra o otra, incluir la palabra o entre paréntesis(una (o) otra)</h4>
    <br>
    <h4>Para incluir varias palabras, separarlas por comas e incluir el signo antes(+palabra1, -palabra2)</h4>
    

    


    <?php
    include 'config.php';
    include 'iconos.php';
    
    $orderfield = htmlentities($_GET['orderfield']);
    $order = htmlentities($_GET['orderby']);
    $buscador = $_GET['buscador'];

    $sqlMovimientos = "SELECT DISTINCT 
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
            INNER JOIN forma_aprendizaje fa
                on pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje";
    if (isset($buscador) && $buscador != "")
        $sqlMovimientos .= " WHERE MATCH(m.descripcion) AGAINST ('" . $buscador . "' IN BOOLEAN MODE)";
    
    if (isset($orderfield) && $orderfield != "")
        $sqlMovimientos .= " ORDER BY " . $orderfield. " ";
    else 
        $sqlMovimientos .= " ORDER BY id ";
    
    if (isset($order) && $order != "")
        $sqlMovimientos .=  $order;
    else
        $sqlMovimientos .= " ASC;";
    
    
    

    $resultMovis = mysqli_query($mysqli, $sqlMovimientos);



    $row = mysqli_fetch_assoc($resultMovis);

    $nombre = $row['pokemon'];
    $total = $resultMovis->num_rows;

    if (!$resultMovis) {
        die('Invalid query: ' . mysqli_error($mysqli));
    }
    

    echo "<table class='movimientos' id='movimientos'>
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
    $resultMovis = mysqli_query($mysqli, $sqlMovimientos);
    while ($row = mysqli_fetch_assoc($resultMovis)) {
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
    include 'close.php';
    ?>
</body>
</html>