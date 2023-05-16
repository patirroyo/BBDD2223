<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
  <TITLE> Formulario Insertar todos Pokemon</TITLE>
  <link rel="stylesheet" href="estilosFormularios.css" type="text/css">

</HEAD>

<BODY>
  <h1>Formulario Insertar Pokemon</h1>
  <?php
  include 'config.php';
  $sql = 'SELECT numero_pokedex FROM pokemon ORDER BY numero_pokedex DESC LIMIT 1';
  $result = mysqli_query($mysqli, $sql);
  $fila = mysqli_fetch_assoc($result);
  $siguienteNumero = $fila['numero_pokedex'] + 1;


  include "close.php";
  ?>
  <table>
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
            <img src="./imagenes/e.png" onclick="insertar.submit()">
          </td>
        </tr>
      </tfoot>
    </form>
  </table>
  </table>

</BODY>

</HTML>