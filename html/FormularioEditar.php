<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
    <TITLE>Editar pokemon</TITLE>
    <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
    <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
    <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
    <script type="text/javascript">
        function eliminar(numero_pokedex) {
            var respuesta = confirm("¿Estás seguro de que quieres eliminar a " + document.getElementById('nombre').value + "?");
            if (respuesta) {
                document.location.href = "EliminarPokemon.php?numero_pokedex=" + numero_pokedex;
            } else {
                return false;
            }
        }
        <?php
        include 'funcionesMovimientos.php';
        ?>
    </script>

</HEAD>

<BODY>


    <?php
    include 'iconos.php';
    $numero_pokedex = htmlentities($_GET['numero_pokedex'], ENT_QUOTES);
    include "config.php";
    $sql = "SELECT p.*, eb.* FROM pokemon p
            LEFT JOIN estadisticas_base eb
                ON p.numero_pokedex = eb.numero_pokedex
            WHERE p.numero_pokedex= " . $numero_pokedex;


    $result = mysqli_query($mysqli, $sql);



    $fila = mysqli_fetch_assoc($result);

    $nombre = $fila['nombre'];
    $peso = $fila['peso'];
    $altura = $fila['altura'];

    $ps = $fila['ps'];
    $ataque = $fila['ataque'];
    $defensa = $fila['defensa'];
    $especial = $fila['especial'];
    $velocidad = $fila['velocidad'];


    if ($numero_pokedex < 10)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/00" . $numero_pokedex . ".png";
    else if ($numero_pokedex < 100)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/0" . $numero_pokedex . ".png";
    else
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/" . $numero_pokedex . ".png";

    echo "<div class='nombre'><h1>#" . $numero_pokedex . " " . $nombre . "</h1></div>";
    echo "<div class='pokemon'><img " . $imagen . "></div>";

    $sql = "CALL tiposDeUnPokemon(" . $numero_pokedex . ", @tipo1, @tipo2);";

    $result = mysqli_query($mysqli, $sql);
    $filaTipo = mysqli_fetch_assoc($result);
    $tipo1 = $filaTipo['tipo1'];
    $tipo2 = $filaTipo['tipo2'];
    
    include "close.php";
    ?>
    <table>
        <form id="editar_pokemon" name="editar_pokemon" method="get" action="EditarPokemon.php">
            <th colspan=10 style="text-align:center"># <?php echo $numero_pokedex . "    " . $nombre?>  </th>

            <tr>
                <td>Número:</td>
                <td><input required type="number" name="numero_pokedex" id="numero_pokedex" readonly="readonly" value="<?php echo $numero_pokedex ?>" ></td>
                <td>Nombre:</td>
                <td><input type="text" name="nombre" id="nombre" required value="<?php echo $nombre ?>"></td>
                <td>Peso:</td>
                <td><input required type="number" min="0" max="1000" step="0.1" name="peso" id="peso" value="<?php echo $peso ?>"></td>
                <td>Altura:</td>
                <td><input required type="number" name="altura" min="0" max="100" step="0.1" id="altura" value="<?php echo $altura ?>"></td>
                
            </tr>
            <tr>
                <th colspan=10 style="text-align:center">Tipos</th>
            <tr>
                
                <td></td>
                <td></td>
                <td>Tipo 1:</td>
                <td class="content-select"><select name="tipo1" id="tipo1" value="<?php echo $tipo1 ?>">
                    <option value="null">No tiene</option>
                    <?php
                        include "config.php";
                        $sqlTipo = 'SELECT id_tipo, nombre FROM tipo';
                        $resultTipo = mysqli_query($mysqli, $sqlTipo);
                        while ($row2 = mysqli_fetch_assoc($resultTipo)) {
                            if ($row2['nombre'] == $tipo1)
                                echo "<option value='" . $row2['id_tipo'] . "' selected>" . $row2['nombre'] . "</option>";
                            else
                                echo "<option value='" . $row2['id_tipo'] . "'>" . $row2['nombre'] . "</option>";
                        }
                    ?>
                    </select>
                </td>
                <td></td>
                
            
                <td>Tipo 2:</td>
                <td class="content-select"><select name="tipo2" id="tipo2" >
                <option name="tipo2" id="tipo2" value="null">No tiene</option>
                <?php
                $resultTipo = mysqli_query($mysqli, $sqlTipo);
                while ($row2 = mysqli_fetch_assoc($resultTipo)) {
                    if ($row2['nombre'] == $tipo2)
                        echo "<option value='" . $row2['id_tipo'] . "' selected>" . $row2['nombre'] . "</option>";
                    else
                        echo "<option value='" . $row2['id_tipo'] . "'>" . $row2['nombre'] . "</option>";
                }
                ?>
                </select>
                </td>
                <td></td>
                <td></td>
                <td></td>
            
            
            </tr>
            <tr>
                <th colspan=10 style="text-align:center">Estadísticas base</th>
            </tr>
            <tr>    
                <td>PS:</td>
                <td><input required type="number" name="ps" min="0" max="255" id="ps" value="<?php echo $ps ?>"></td>
                <td>Ataque:</td>
                <td><input required type="number" name="ataque" min="0" max="255" id="ataque" value="<?php echo $ataque ?>"></td>
                <td>Defensa:</td>
                <td><input required type="number" name="defensa" min="0" max="255" id="defensa" value="<?php echo $defensa ?>"></td>
                <td>Especial:</td>
                <td><input required type="number" name="especial" min="0" max="255" id="especial" value="<?php echo $especial ?>"></td>
                <td>Velocidad:</td>
                <td><input required type="number" name="velocidad" min="0" max="255" id="velocidad" value="<?php echo $velocidad ?>"></td>

            </tr>
            <tfoot>
                <tr>
                <tr>
                    <td colspan="3"></td>
                    <td colspan="2">
                        <img src="./imagenes/tumba.png" class='edicion' <?php echo "onclick=eliminar(" . $numero_pokedex . ")" ?>>
                    </td>
                    <td colspan="2">
                        <input type=image src="./imagenes/edit.png" class='submit' >
                    </td>
                    <td colspan="3"></td>
                </tr>
            </tfoot>
        </form>
    </table>
    <?php
    include 'bodyMovimientos.php';
    include "close.php";
    ?>
</BODY>

</HTML>