<?php
require 'conexion.php';

$usuario = $_POST['usuario'];
$password = $_POST['password'];

$resultado = "SELECT * FROM `usuarios` WHERE Nombre='$usuario' and Contrasena='$password'"; 
$query = mysqli_query($conexion, $resultado);
$mostrar=mysqli_fetch_array($query);
$rol=$mostrar['Rol'];
$id_usuario=$mostrar['ID_Usuario'];
   
$response = array();

if (mysqli_num_rows($query)) { 
    
    if($rol==="admin"){
        //echo "hola";
    header("location:menu_admin.php");
}else{
    //echo $rol;
        header("location:menu_alumno.php?id=$id_usuario");
}
} else {
    header("location:login.php");
}


?>
