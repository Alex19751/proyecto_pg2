<?php

$host="Localhost";
$user="root";
$password="";
$bd="prueba_proyecto";

$conexion=mysqli_connect($host,$user,$password,$bd) or die("Error al conectar la base de datos");

/*if($conexion){
	echo "Conexión exitosa";
}else{
	echo "Error en la conexion";
}*/

return $conexion;




?>