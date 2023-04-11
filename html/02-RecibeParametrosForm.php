<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> 02-RecibeParametrosForm.php</TITLE>
</HEAD>

<BODY>
<?php
$id=$_POST['id'];
$nom=$_POST['nombre'];
echo "<h1>Tu id es $id y tu nombre es $nom</h1>";
echo "<h1>Tu id es $_POST[id] y tu nombre es $_POST[nombre]</h1>";
echo "<h1>Tu id es ".$_POST['id']." y tu nombre es  ".$_POST['nombre']."</h1>";
?>
</BODY>
</HTML>
