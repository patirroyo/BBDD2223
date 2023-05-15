<!DOCTYPE HTML PUBLIC>
<html>
<head>
<title> Formulario Ordenar todos Pokemon</title>
<link rel="stylesheet" href="estilosFormularios.css"type="text/css">
<script type="text/javascript">

</script>

</head>

<body>
  <h1>Formulario Ordenar todos Pokemon</h1>
  <form id="datos" name="datos" method="get" action="OrderPokemonBy.php">
    <table align="center" border="1">
      <th>Parámetro</th><th>Valor</th>
      <tr><td>Order field</td>
        <td class="content-select"><select name="orderfield" id="orderfield" required>
          <option value="numero_pokedex">Número pokedex</option>
          <option value="nombre">Nombre</option>
          <option value="peso">Peso</option>
          <option value="altura">Altura</option>
          </select>
          <i></i>
        </td>
      <tr><td>Order</td>
        <td class="content-select"><select name="orderby" id="orderby" required>
          <option value="ASC">Ascendente</option>
          <option value="DESC">Descendente</option>
          </select>
          <i></i>
        </td>
      </tr>
      
      </tr>
    </table>
    <img src="./imagenes/e.png" onclick="datos.submit()">
  </form>

</body>
</html>
