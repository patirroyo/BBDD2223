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
        $sql = 'SELECT * FROM Borrados;';
        $result = mysqli_query($mysqli, $sql);
        if (!$result) {
            die('Invalid query: ' . mysqli_error($mysqli));
        } else {
            echo "<table class='administracion'>
                    <tr>
                        <th colspan='5'>Borrados</th>
                    </tr>
                    <tr>
                        <th>id</th>
                        <th>Fecha</th>
                        <th>Usuario</th>
                        <th>Numero Eliminado</th>
                        <th>Nombre Eliminado</th>
                    </tr>
                    <tr>";
            while ($row = mysqli_fetch_assoc($result)) {
                foreach ($row as $col) 
                    echo "<td>$col</td>";
                echo "</tr>";
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
                        <th colspan='5'>Creados</th>
                    </tr>
                    <tr>
                        <th>id</th>
                        <th>Fecha</th>
                        <th>Usuario</th>
                        <th>Numero Creado</th>
                        <th>Nombre Creado</th>
                    </tr>
                    <tr>";
            while ($row = mysqli_fetch_assoc($result)) {
                foreach ($row as $col) 
                    echo "<td>$col</td>";
                echo "</tr>";
            }
            echo "</table>";
        }

        ?>
    </body>
</html>