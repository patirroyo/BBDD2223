<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
  <TITLE> Formulario Insertar </TITLE>
  <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
  <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
  <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">

</HEAD>

<BODY>
<a href='index.php'><img class='inicio' src="imagenes/e.png"></a>
  <h1>Formulario Insertar Pokemon</h1>
  <?php
  include 'config.php';
  $sql = 'SELECT numero_pokedex FROM pokemon ORDER BY numero_pokedex DESC LIMIT 1';
  $result = mysqli_query($mysqli, $sql);
  $fila = mysqli_fetch_assoc($result);
  $siguienteNumero = $fila['numero_pokedex'] + 1;


  include "close.php";
  ?>
  <table class="movimientos">
    <form id="insertar" name="insertar" method="get" action="insertarPokemon.php">
      <th colspan=2 style="text-align:center">Insertar Pokemon</th>
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
            <img class="edicion" src="./imagenes/add.png" onclick="insertar.submit()">
          </td>
        </tr>
      </tfoot>
    </form>
  </table>
  </table>

</BODY>

</HTML>