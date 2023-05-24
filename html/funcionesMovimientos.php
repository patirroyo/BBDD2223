<?php
    echo "var orderfield = '" . htmlentities($_GET['orderfield']) . "';";
    echo "var orderby = '" . htmlentities($_GET['orderby']) . "';";
    echo "var numero_pokedex = '" . htmlentities($_GET['numero_pokedex']) . "';";
    ?>
        function ordenar(field, order) {
            if (field != orderfield)
                orderby = 'ASC';
            else if (order == 'ASC')
                orderby = 'DESC';
            else
                orderby = 'ASC';
            orderfield = field;
            document.location.href = window.location.href.split('?')[0] + "?numero_pokedex=" + numero_pokedex +"&orderfield=" + orderfield + "&orderby=" + orderby;
        }
        function eliminarMov(pokemon, movimiento){
            var respuesta = confirm("¿Estás seguro de que quieres eliminar el movimiento " + movimiento +  "?");
            if (respuesta) {
                document.location.href = "EliminarMovimiento.php?numero_pokedex=" + numero_pokedex + "&id_movimiento=" + movimiento;
            } else {
                return false;
            }
        }