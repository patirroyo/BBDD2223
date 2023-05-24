
<HTML>

<head>
  <TITLE> Formulario Eliminar </TITLE>
  <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
  <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
  <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">
  <script>
    function eliminar(numero_pokedex) {
      var respuesta = confirm("¿Estás seguro de que quieres eliminar a " + document.getElementById('nombreEliminar').value + "?");
      if (respuesta) {
        document.location.href = "EliminarPokemon.php?numero_pokedex=" + numero_pokedex;
      } else {
        return false;
      }
    }
    </script>
</head>

<BODY>
  <h1>Eliminar Pokemon</h1>
  <?php
  include 'config.php';
  
  if (isset($_GET['numero_pokedexEliminar'])){
    $numero_pokedexEliminar = $_GET['numero_pokedexEliminar'];
    $sql = 'SELECT * FROM pokemon 
            WHERE numero_pokedex=' . $numero_pokedexEliminar . ';';
    $result = mysqli_query($mysqli, $sql);
    $fila = mysqli_fetch_assoc($result);
    $nombreEliminar = $fila['nombre'];

    if ($numero_pokedexEliminar < 10)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/00" . $numero_pokedexEliminar . ".png";
      else if ($numero_pokedexEliminar < 100)
        $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/0" . $numero_pokedexEliminar . ".png";
        else
          $imagen = "src=https://assets.pokemon.com/assets/cms2/img/pokedex/full/" . $numero_pokedexEliminar . ".png";
    

  }


  include "close.php";
  ?>
  <table class="card">
        <form id="eliminar_pokemon" name="eliminar_pokemon" method="get" action="FormularioEliminar.php">
            <th colspan=2 style="text-align:center">Eliminar Pokemon</th>
            <tr>
                <td>Número pokedex</td>
                <td><input type="number" name="numero_pokedexEliminar" id="numero_pokedexEliminar" onchange="eliminar_pokemon.submit()" value="<?php echo $numero_pokedexEliminar ?>"></td>
            </tr>
            <tr>
                <td colspan=2>
                    <?php if (isset($imagen)){ echo "<img class='portada'" . $imagen . '>';} ?>
                </td>
            </tr>
            <tr>
                <td>Nombre</td>
                <td><input type="text" name="nombreEliminar" id="nombreEliminar" value="<?php echo $nombreEliminar ?>"></td>
            </tr>
            <tfoot>
                <tr>
                    <td colspan=2>
                        <img src="./imagenes/tumba.png" class='edicion' <?php echo "onclick=eliminar(" . $numero_pokedexEliminar . ")" ?>>
                    </td>
                </tr>
            </tfoot>
        </form>
    </table>
    

</BODY>

</HTML>