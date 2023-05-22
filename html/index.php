<html>

<head>
    <title>UT8 Bases de datos y aplicaciones web</title>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
    <script type="text/javascript">
        function eliminar(numero_pokedex) {
            setTimeout(function() {
                var respuesta = confirm("¿Estás seguro de que quieres eliminar a " + document.getElementById('nombreEliminar').value + "?");
            if (respuesta) {
                document.location.href = "EliminarPokemon.php?numero_pokedex=" + numero_pokedex;
            } else {
                return false;
            }}, 500);
            
        }

        function editar(numero_pokedex) {
            document.location.href = "FormularioEditar.php?numero_pokedex=" + numero_pokedex;
        }
    </script>
</head>

<body>
    <h1>UT8 Bases de datos y aplicaciones web </h1>
    <?php
    include 'config.php';
    $sql = 'SELECT numero_pokedex FROM pokemon ORDER BY numero_pokedex DESC LIMIT 1';
    $result = mysqli_query($mysqli, $sql);
    $fila = mysqli_fetch_assoc($result);
    $siguienteNumero = $fila['numero_pokedex'] + 1;

    if (isset($_GET['numero_pokedexEliminar'])) {
        $numero_pokedexEliminar = htmlentities($_GET['numero_pokedexEliminar']);
        $sql = "SELECT nombre FROM pokemon WHERE numero_pokedex = $numero_pokedexEliminar";
        $result = mysqli_query($mysqli, $sql);
        $fila = mysqli_fetch_assoc($result);
        $nombreEliminar = $fila['nombre'];
    } else {
        $numero_pokedexEliminar = "";
        $nombreEliminar = "";
    }


    if (isset($_GET['numero_pokedex'])) {
        $numero_pokedex = htmlentities($_GET['numero_pokedex']);
        $sql = "SELECT * FROM pokemon WHERE numero_pokedex = $numero_pokedex";
        $result = mysqli_query($mysqli, $sql);
        $fila = mysqli_fetch_assoc($result);
        $nombre = $fila['nombre'];
        $peso = $fila['peso'];
        $altura = $fila['altura'];
    } else {
        $numero_pokedex = "";
        $nombre = "";
        $peso = "";
        $altura = "";
    }
    include "close.php";
    ?>
    <table class="card">
        <th colspan=2>Búsqueda</th>
        <form id="busqueda" name="busqueda" method="get" action="OrderPokemonBy.php">
            <tr>
                <td>Order field</td>
                <td class="content-select">
                    <select name="orderfield" id="orderfield" required>
                        <option value="numero_pokedex">Número pokedex</option>
                        <option value="nombre">Nombre</option>
                        <option value="peso">Peso</option>
                        <option value="altura">Altura</option>
                    </select><i></i>
                </td>
            </tr>
            <tr>
                <td>Order</td>
                <td class="content-select">
                    <select name="orderby" id="orderby" required>
                        <option value="ASC">Ascendente</option>
                        <option value="DESC">Descendente</option>
                    </select><i></i>
                </td>
            </tr>
            <tfoot>
                <tr>
                    <td colspan=2>
                        <img src="./imagenes/e.png" class='edicion' onclick="busqueda.submit()">
                    </td>
                </tr>
            </tfoot>
        </form>
    </table>



    <table class="card">
        <form id="insertar" name="insertar" method="get" action="insertarPokemon.php">
            <th colspan=2>Insertar Pokemon</th>
            <tr>
                <td>Número pokedex</td>
                <td><input type="number" name="numero_pokedex" id="numero_pokedex" value="<?php echo $siguienteNumero ?>"></td>
            <tr>
                <td>Nombre</td>
                <td><input type="text" name="nombre" id="nombre"></td>
            </tr>
            <tr>
                <td>Peso</td>
                <td><input type="number" name="peso" id="peso"></td>
            </tr>
            <tr>
                <td>Altura</td>
                <td><input type="number" name="altura" id="altura"></td>
            </tr>
            <tfoot>
                <tr>
                    <td colspan=2>
                        <img src="./imagenes/e.png" class='edicion' onclick="insertar.submit()">
                    </td>
                </tr>
            </tfoot>
        </form>
    </table>
    </table>


    <table class="card">
        <form id="eliminar_pokemon" name="eliminar_pokemon" method="get" action="index.php">
            <th colspan=2>Eliminar Pokemon</th>
            <tr>
                <td>Número pokedex</td>
                <td><input type="number" name="numero_pokedexEliminar" id="numero_pokedexEliminar" onchange="eliminar_pokemon.submit()" value="<?php echo $numero_pokedexEliminar ?>"></td>
            <tr>
                <td>Nombre</td>
                <td><input type="text" name="nombreEliminar" id="nombreEliminar" value="<?php echo $nombreEliminar ?>"></td>
            </tr>
            <tfoot>
                <tr>
                    <td colspan=2>
                        <img src="./imagenes/b.png" class='edicion' <?php echo "onclick=eliminar(" . $numero_pokedexEliminar . ")" ?>>
                    </td>
                </tr>
            </tfoot>
        </form>
    </table>
    </table>


    <table class="card">
        <form id="editar_pokemon" name="editar_pokemon" method="get" action="index.php">
            <th colspan=2>Editar Pokemon</th>
            <tr>
                <td>Número pokedex</td>
                <td><input type="number" name="numero_pokedex" id="numero_pokedex" onchange="editar_pokemon.submit()" value="<?php echo $numero_pokedex ?>"></td>
            <tr>
                <td>Nombre</td>
                <td><input type="text" name="nombre" id="nombre" value="<?php echo $nombre ?>"></td>
            </tr>
            <tr>
                <td>Peso</td>
                <td><input type="number" name="peso" id="peso" step="0.1" value="<?php echo $peso ?>"></td>
            </tr>
            <tr>
                <td>Altura</td>
                <td><input type="number" name="altura" id="altura" value="<?php echo $altura ?>"></td>
            </tr>
            <tfoot>
                <tr>
                <tr>
                    <td>
                        <img src="./imagenes/b.png" class='edicion' <?php echo "onclick=eliminar(" . $numero_pokedex . ")" ?>>
                    </td>
                    <td>
                        <img src="./imagenes/edit.png" class='edicion'  <?php echo "onclick=editar(" . $numero_pokedex . ")" ?>>
                    </td>
                </tr>
            </tfoot>
        </form>
    </table>



</body>

</html>