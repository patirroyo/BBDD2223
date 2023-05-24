<html>

<head>
    <title>UT8 Bases de datos y aplicaciones web</title>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
    <script type="text/javascript">

    </script>
</head>

<body>
    <h1>UT8 Bases de datos y aplicaciones web </h1>

    <table class="card">
        <th colspan=2 style="text-align:center">Pokedex</th>
        <form id="busqueda" name="busqueda" method="get" action="OrderPokemonBy.php">
              <tfoot>
                <tr>
                    <td colspan=2>
                        <img src="./imagenes/pokedex.png" class='edicion' onclick="busqueda.submit()">
                    </td>
                </tr>
            </tfoot>
        </form>
    </table>

    <table class="card">
        <th colspan=2 style="text-align:center">Administración</th>
        <tfoot>
            <tr><td><img src="/imagenes/admin.png" class='edicion' onclick="document.location.href='admin.php'"></td></tr>
        </tfoot>
    </table>
    



</body>

</html>