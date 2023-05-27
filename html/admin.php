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
                        <th colspan='50'>Borrados</th>
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

        $sql = 'SELECT * FROM Creados;';
        $result = mysqli_query($mysqli, $sql);
        if (!$result) {
            die('Invalid query: ' . mysqli_error($mysqli));
        } else {
            echo "<table class='administracion'>
                    <tr>
                        <th colspan='50'>Creados</th>
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

        ?>
    </body>
</html>