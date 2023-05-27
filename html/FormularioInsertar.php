<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
  <TITLE> Formulario Insertar </TITLE>
  <link rel="stylesheet" href="estilosFormularios.css" type="text/css">
  <link rel="icon" type="image/x-icon" href="/imagenes/favicon.ico">
  <link href="https://fonts.cdnfonts.com/css/pokemon-solid" rel="stylesheet">

</HEAD>

<BODY>
  <h1>Crear Pokemon</h1>
  <?php
  include 'config.php';
  include 'iconos.php';
  $sql = 'SELECT numero_pokedex FROM pokemon ORDER BY numero_pokedex DESC LIMIT 1';
  $result = mysqli_query($mysqli, $sql);
  $fila = mysqli_fetch_assoc($result);
  $siguienteNumero = $fila['numero_pokedex'] + 1;


  include "close.php";
  ?>
  <table class="card">
    <form id="insertar" name="insertar" method="get" action="insertarPokemon.php">
      <th colspan=2 style="text-align:center">Crear Pokemon</th>
      <tr>
        <td>Número pokedex</td>
        <td><input required type="number" name="numero_pokedex" id="numero_pokedex" value="<?php echo $siguienteNumero ?>" ></td>
      <tr>
        <td>Nombre</td>
        <td><input required type="text" name="nombre" id="nombre" autofocus></td>
      </tr>
      <tr>
        <td>Peso</td>
        <td><input required type="number" min="0" max="1000" step="0.1" name="peso" id="peso"></td>
      </tr>
      <tr>
        <td>Altura</td>
        <td><input required type="number" name="altura" min="0" max="100" step="0.1" id="altura"></td>
      </tr>
      <tfoot>
        <tr>
          <td colspan=2>
            <input type=image class="submit" src="./imagenes/add.png">
          </td>
        </tr>
      </tfoot>
    </form>
  </table>
  

</BODY>

</HTML>