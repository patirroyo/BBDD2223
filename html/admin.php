<html>
    <head>
        <title>Administración</title>
        <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
        <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
        <link href="https://fonts.cdnfonts.com/css/pokemon-hollow" rel="stylesheet">
        <script>

        </script>
    </head>
    <body>
        <h1>Administración</h1>
        <?php
        include 'config.php';
        include 'iconos.php';
        $sql = 'SELECT * FROM Borrados;';
        $result = mysqli_query($mysqli, $sql);
        if (!$result) {
            die('Invalid query: ' . mysqli_error($mysqli));
        } else {
            echo "<table class='administracion'>
                    <tr>
                        <th colspan='50'>Pokémons Borrados</th>
                    </tr>
                    <tr>
                        <th>id</th>
                        <th>Fecha</th>
                        <th>Usuario</th>
                        <th>Numero Eliminado</th>
                        <th>Nombre Eliminado</th>
                        <th>IP</th>
                        <th class='userAgent'>User Agent</th>
                    </tr>
                    <tr>";
            while ($row = mysqli_fetch_assoc($result)) {
                echo "<tr>
                        <td><b>" . $row['id'] . "</b></td>".
                        "<td>" . $row['fecha'] . "</td>".
                        "<td>" . $row['usuario'] . "</td>".
                        "<td>" . $row['numero_eliminado'] . "</td>".
                        "<td>" . $row['nombre_eliminado'] . "</td>".
                        "<td>" . $row['ip_cliente'] . "</td>".
                        '<td class="descripcion"><input type="checkbox" id="spoiler'.$row['id'].'"></input>
            <label for="spoiler'.$row['id'].'">Ver</label><div class="spoiler">
            ' . $row['user_agent'] . "</div></td>";
            }
            echo "</table>";
        }
        echo "<br><br>";
        $sql = 'SELECT * FROM MovimientosBorrados;';
        $result = mysqli_query($mysqli, $sql);
        if(!$result){
            die('Invalid query: ' . mysqli_error($mysqli));
        } else {
            echo "<table class='administracion'
                    <tr>
                        <th colspan='50'>Movimientos Borrados</th>
                    </tr>
                    <tr>
                        <th>id</th>
                        <th>Fecha</th>
                        <th>Usuario</th>
                        <th>Nombre Pokemon</th>
                        <th>Id movimiento</th>
                        <th>Nombre movimiento</th>
                    </tr>
                    <tr>";
            while ($row = mysqli_fetch_assoc($result)) {
                echo "<tr>
                        <td><b>" . $row['id'] . "</b></td>".
                        "<td>" . $row['fecha'] . "</td>".
                        "<td>" . $row['usuario'] . "</td>".
                        "<td>" . $row['nombre_pokemon'] . "</td>".
                        "<td>" . $row['id_movimiento'] . "</td>".
                        "<td>" . $row['nombre_movimiento'] . "</td>";
            }
            echo "</table>";
        }
        echo "<br><br>";
        $sql = 'SELECT * FROM Creados;';
        $result = mysqli_query($mysqli, $sql);
        if (!$result) {
            die('Invalid query: ' . mysqli_error($mysqli));
        } else {
            echo "<table class='administracion'>
                    <tr>
                        <th colspan='50'>Pokemon Creados</th>
                    </tr>
                    <tr>
                        <th>id</th>
                        <th>Fecha</th>
                        <th>Usuario</th>
                        <th>Numero Creado</th>
                        <th>Nombre Creado</th>
                        <th>IP</th>
                        <th class='userAgent'>User Agent</th>
                    </tr>
                    <tr>";
            while ($row = mysqli_fetch_assoc($result)) {
                echo "<tr>
                        <td><b>" . $row['id'] . "</b></td>".
                        "<td>" . $row['fecha'] . "</td>".
                        "<td>" . $row['usuario'] . "</td>".
                        "<td>" . $row['numero_creado'] . "</td>".
                        "<td>" . $row['nombre'] . "</td>".
                        "<td>" . $row['ip_cliente'] . "</td>".
                        '<td class="descripcion"><input type="checkbox" id="spoiler'.$row['id'].'"></input>
                        <label for="spoiler'.$row['id'].'">Ver</label><div class="spoiler">
            ' . $row['user_agent'] . "</div></td>";
            }
            echo "</table>";
        }
        echo "<br><br>";
        $sql = 'SELECT * FROM Actualizados;';
        $result = mysqli_query($mysqli, $sql);
        if (!$result) {
            die('Invalid query: ' . mysqli_error($mysqli));
        } else {
            echo "<table class='administracion'>
                    <tr>
                        <th colspan='50'>Pokemon Actualizados</th>
                    </tr>
                    <tr>
                        <th>id</th>
                        <th>Fecha</th>
                        <th>Usuario</th>
                        <th>Numero Pokedex</th>
                        <th>Campo Actualizado</th>
                        <th>Valor anterior</th>
                        <th>Valor actualizado</th>
                    </tr>
                    <tr>";
            while ($row = mysqli_fetch_assoc($result)) {
                echo "<tr>
                        <td><b>" . $row['id'] . "</b></td>".
                        "<td>" . $row['fecha'] . "</td>".
                        "<td>" . $row['usuario'] . "</td>".
                        "<td>" . $row['numero_pokedex'] . "</td>".
                        "<td>" . $row['campo_actualizado'] . "</td>".
                        "<td>" . $row['valor_anterior'] . "</td>".
                        "<td>" . $row['valor_nuevo'] . "</td>";
            }
            echo "</table>";
        }

        

        ?>
    </body>
</html>