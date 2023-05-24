<?php
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
                    t.nombre as tipo,
                    tfa.tipo_aprendizaje as aprendizaje
            FROM pokemon p
            INNER JOIN pokemon_movimiento_forma pmf
                ON p.numero_pokedex = pmf.numero_pokedex
            INNER JOIN movimiento m
                ON pmf.id_movimiento = m.id_movimiento
            INNER JOIN tipo t on m.id_tipo = t.id_tipo
            INNER JOIN forma_aprendizaje fa
                on pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
            INNER JOIN tipo_forma_aprendizaje tfa
                on fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje
            WHERE p.numero_pokedex = " . $numero_pokedex;
    if (isset($orderfield) && $orderfield != "")
        $sql .= " ORDER BY " . $orderfield. " ";
    else 
        $sql .= " ORDER BY id ";
    
    if (isset($order) && $order != "")
        $sql .=  $order;
    else
        $sql .= " ASC";
    
    
    //echo '<br><br>' . $sql . '<br><br>';

    $result = mysqli_query($mysqli, $sql);



    $row = mysqli_fetch_assoc($result);

    $nombre = $row['pokemon'];
    $total = $result->num_rows;

    if (!$result) {
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
            <th>Aprendizaje<i onclick=ordenar('aprendizaje','".$order."')></i></th>
            <th>Descripción</th>
            <th>Eliminar</th>
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
        echo "<td>" . $row['aprendizaje'] . "</td>";
        echo '<td class="descripcion"><input type="checkbox" id="spoiler'.$row['id'].'"></input>
            <label for="spoiler'.$row['id'].'">Ver</label><div class="spoiler">
            ' . $row['descripcion'] . "</div></td>";
        echo "<td><input type='button' value='Eliminar' onclick='eliminarMov(" .$numero_pokedex . "," . $row['id'] . ")'></td>";
        echo "</tr>";
    }
    echo "</table>";
    ?>