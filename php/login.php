<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link rel="stylesheet" type="text/css" href="../css/estilosLogin.css">
</head>
<body>
<div class="contenedor">
  <center><h1>Login</h1>
  
    <label>Usuario</label><br>
    <input class="info" id="usuario" type="text" name="usuario"><br>
    <label>Password</label><br>
    <input class="info" id="password" type="password" name="password"><br><br>
    <input class="botones" id="enviar" type="submit" value="Ingresar"></center>

    <script>
      $(document).ready(function() {
        $('#enviar').click(function() {
          var usuario = $('#usuario').val();
          var password = $('#password').val();
          
          $.ajax({
              url: 'validar.php',
              type: 'POST',
              data: { usuario: usuario, password: password }, // Datos a enviar al servidor
              success: function(response) {
                  var jsonData = JSON.parse(response);
                  
                  if (jsonData.status === 'success') {
                      // Redireccionar a la página del menú
                      window.location.assign('menu.php');
                  } else {
                      // Mostrar mensaje de error
                      alert(jsonData.message);
                  }
              },
              error: function(xhr, status, error) {
                  // Manejar errores
                  console.error(xhr, status, error);
              }
          });
        });
      });
    </script>
</div>
</body>
</html>
