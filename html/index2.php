<html>

<head>
    <link rel="stylesheet" href="estilos.css" type="text/css">
</head>

<body>
    <h1>Estos son los archivos de la carpeta HTML</h1>
    <?php
    echo "<table>";
    $path = ".";
    $dh = opendir($path);
    $i = 1;
    while (($file = readdir($dh)) !== false) {
        if ($file != "." && $file != ".." && $file != "index.php" && $file != ".htaccess" && $file != "error_log" && $file != "cgi-bin") {
            echo "<tr><td><a href='$path/$file'>$file</a><td></tr>";
            $i++;
        }
    }
    closedir($dh);
    echo "</table>";
    ?>

</body>

</html>