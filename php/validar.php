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
    // Usuario encontrado
    /*$response['status'] = 'success';
    $response['message'] = 'Login exitoso';*/
    
        header("location:menu_alumno.php?id=$id_usuario");
    
    
} else {
    // Usuario no encontrado
    /*$response['status'] = 'error';
    $response['message'] = 'Usuario o contraseña incorrectos';*/
    header("location:login.php");
}

echo json_encode($response);
?>
