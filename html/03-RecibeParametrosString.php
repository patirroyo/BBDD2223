<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> 03-RecibeParametrosString.php </TITLE>
</HEAD>

<BODY>
<?php
$id=$_GET['id'];
$nom=$_GET['nombre'];
echo "<h1>Tu id es $id y tu nombre es $nom</h1>";
echo "<h1>Tu id es $_GET[id] y tu nombre es $_GET[nombre]</h1>";
echo "<h1>Tu id es ".$_GET['id']." y tu nombre es  ".$_GET['nombre']."</h1>";
?>
</BODY>
</HTML>
