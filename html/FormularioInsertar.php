<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> FormularioInsertarPokemon</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script type="text/javascript">
function enviar()
{
  datos.action="01-Basico.php";
  datos.submit();
}
</script>

</HEAD>

<BODY>
<form id="datos" name="datos" method="post" action="insertarPokemon.php">
<table align="center" border="1">
    <tr><td>Nombre</td>
      <td><input type="text" name="nombre" id="nombre"></td>
    </tr>
    <tr><td>Peso</td>
      <td><input type="text" name="peso" id="peso"></td>
    </tr>
    <tr><td>Altura</td>
      <td><input type="text" name="altura" id="altura"></td>
    </tr>
   <tr>
		<td colspan="2"><input type="submit" value="Enviar"></td>
   </tr>
</table>
</form>

</BODY>
</HTML>
