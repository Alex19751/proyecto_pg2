<?php
require 'conexion.php';

$usuario = $_POST['usuario'];
$password = $_POST['password'];

$resultado = "SELECT * FROM `usuarios` WHERE Nombre='$usuario' and Contrasena='$password'"; 
$query = mysqli_query($conexion, $resultado);

$response = array();

if (mysqli_num_rows($query) > 0) {
    // Usuario encontrado
    /*$response['status'] = 'success';
    $response['message'] = 'Login exitoso';*/
    header("location:menu.php");
} else {
    // Usuario no encontrado
    /*$response['status'] = 'error';
    $response['message'] = 'Usuario o contraseña incorrectos';*/
    header("location:login.php");
}

echo json_encode($response);
?>
