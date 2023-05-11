<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>01-Basico.php </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<h1> Bienvenido a mi pagina </h1>
<?php
//
/*    */
for($c=1;$c<=30;$c++)
{
   echo "<h2>Bienvenido $c a mi pagina</h2>";
}
?>
<select id='edad' name='edad'>
<?php
	for($c=1;$c<=100;$c++)
	{
	   echo "<option value='$c'>$c";
	}
?>
</select>
<table border="1">
<tr>
  <?php
    for ($c=1;$c<=10;$c++)
	{
		echo "<td>$c</td>";
	}
   ?>
</tr>
</table>
<table border="1">
  <?php
    for ($c=1;$c<=10;$c++)
	{
		echo "<tr><td>$c</td></tr>";
	}
   ?>
</table>
<table border="1">
  <?php
    for ($f=1;$f<=4;$f++)
	{
		echo "<tr>";
		for($c=1;$c<=5;$c++)
		{
			echo "<td>$c</td>";
		}
		echo "</tr>";
	}
   ?>
</table>
<table>
<tr>
<?php
$imagenes=array();
$imagenes[0]="./imagenes/enero.jpg";
$imagenes[1]="./imagenes/febrero.jpg";
$imagenes[2]="./imagenes/marzo.jpg";
for ($c=0;$c<=2;$c++)
{
	echo "<td><a href='03-RecibeParametrosString.php?id=$c&nombre=$imagenes[$c]'><img src='$imagenes[$c]'></a></td>";
}
?>
</tr>
</table>
</BODY>
</HTML>
