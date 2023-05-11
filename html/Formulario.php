<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> Formulario Ordenar todos Pokemon</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script type="text/javascript">

</script>

</HEAD>

<BODY>
  <form id="datos" name="datos" method="post" action="OrderPokemonBy.php">
    <table align="center" border="1">
      <tr><td>Order field</td>
        <td><select name="orderfield" id="orderfield" required>
          <option value="numero_pokedex">Número pokedex</option>
          <option value="nombre">Nombre</option>
          <option value="peso">Peso</option>
          <option value="altura">Altura</option>
        </td>
      <tr><td>Order</td>
        <td><select name="orderby" id="orderby" required>
          <option value="ASC">Ascendente</option>
          <option value="DESC">Descendente</option>
        </td>
      </tr>
      <tr><td colspan="2"><input type="submit" value="Enviar"></td>
      </tr>
    </table>
  </form>

</BODY>
</HTML>
