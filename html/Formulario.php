<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> 02-EnvioParametrosForm.html</TITLE>
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
<form id="datos" name="datos" method="post" action="database.php">
<table align="center" border="1">
   <tr><td>Order field</td>
       <td><input type="text" name="orderfield" id="orderfield"></td>
   </tr>
   <tr>
		<td colspan="2"><input type="submit" value="Enviar"></td>
   </tr>
</table>
</form>

</BODY>
</HTML>
