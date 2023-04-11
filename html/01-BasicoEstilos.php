<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> 09-Bloques.html </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<link rel="stylesheet" type="text/css" href="bloques.css">
</HEAD>

<BODY>
<div class="general">
   <div class="titulo">     
	   <div class="logo1">
	      <img src="./imagenes/sz.jpg">
	   </div>
	   <div class="texto1">
	      <h1> XXIV Edición Premio Nacional Don Bosco </h1>
	   </div>
   </div>
   <div class="menu">
		<ul>
		<li><a href="#"> Opcion 1 </a></li>
		<li><a href="#"> Opcion 2 </a></li>
		<li><a href="#"> Opcion 3 </a></li>
		</ul>
   </div>
<!--    
    <div class="publicidad">
   
   </div>
 -->  
 <div class="principal">
		<?php

		$imagenes=array();
		$imagenes[0]="./imagenes/enero.jpg";
		$imagenes[1]="./imagenes/febrero.jpg";
		$imagenes[2]="./imagenes/marzo.jpg";
		$imagenes[3]="./imagenes/abril.jpg";
		$imagenes[4]="./imagenes/mayo.jpg";
		$imagenes[5]="./imagenes/junio.jpg";
		$imagenes[6]="./imagenes/julio.jpg";
		$imagenes[7]="./imagenes/agosto.jpg";
		$imagenes[8]="./imagenes/septiembre.jpg";
		$imagenes[9]="./imagenes/octubre.jpg";
		$imagenes[10]="./imagenes/noviembre.jpg";
		$imagenes[11]="./imagenes/diciembre.jpg";
		for ($c=0;$c<=11;$c++)
		{
			echo "<div class='product'><img src='$imagenes[$c]'></div>";
		}
		?>

   </div>
</div>

</BODY>
</HTML>
