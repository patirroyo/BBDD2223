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
<style>
 * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    color: #333;
    background: #f2f2f2;
    border-top: 4px solid #ed1c40;
}
h1 {
    text-align: center;
    margin: 100px 0;
}
table {
    text-align: left;
    line-height: 40px;
    border-collapse: separate;
    border-spacing: 0;
    border: 2px solid #ed1c40;
    width: 400px;
    margin: 50px auto;
    border-radius: .25rem;
}

th {
    background: #ed1c40;
    color: #fff;
    border: none;
}
th:last-child,
td:last-child{
    text-align: center;
}

th:first-child,
td:first-child {
    padding: 0 15px 0 20px;
}

th {
    font-weight: 500;
}


tbody tr:hover {
    background-color: #e3e1e1;
    cursor: default;
}

tbody td {
    border-bottom: 1px solid #ddd;
}

td:last-child {
    text-align: center;
    padding-right: 10px;
}
img{
  display: block;
  margin: 0 auto;
  width: 100;
  cursor: pointer;
}
img:hover{
  width: 110;
}
img:active{
  animation: shake 0.5s;
}
@keyframes shake {
  0% { transform: translate(1px, 1px) rotate(0deg); }
  10% { transform: translate(-1px, -2px) rotate(-1deg); }
  20% { transform: translate(-3px, 0px) rotate(1deg); }
  30% { transform: translate(3px, 2px) rotate(0deg); }
  40% { transform: translate(1px, -1px) rotate(1deg); }
  50% { transform: translate(-1px, 2px) rotate(-1deg); }
  60% { transform: translate(-3px, 1px) rotate(0deg); }
  70% { transform: translate(3px, 1px) rotate(-1deg); }
  80% { transform: translate(-1px, -1px) rotate(1deg); }
  90% { transform: translate(1px, 2px) rotate(0deg); }
  100% { transform: translate(1px, -2px) rotate(-1deg); }
}


</style>
</HEAD>

<BODY>
  <h1>Formulario Ordenar todos Pokemon</h1>
  <form id="datos" name="datos" method="post" action="OrderPokemonBy.php">
    <table align="center" border="1">
      <th>Parámetro</th><th>Valor</th>
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
      
      </tr>
    </table>
    <img src="./imagenes/e.png" onclick="datos.submit()">
  </form>

</BODY>
</HTML>
