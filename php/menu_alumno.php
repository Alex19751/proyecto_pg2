<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-AMS_HTML"></script>
    <link rel="stylesheet" type="text/css" href="../css/estilosMenu.css">
</head>
<body>
<div class="sidebar" id="sidebar">
    <?php
    require "conexion.php";
    $id_usuario=$_GET['id'];
    $grado="SELECT u.ID_Usuario, u.Nombre, cur.Grado, cur.Descripcion, cur.ID_Curso FROM usuarios u
INNER JOIN usuarios_cursos uc on uc.ID_Usuario=u.ID_Usuario
INNER JOIN cursos cur on cur.ID_Curso=uc.ID_Curso where u.ID_Usuario=$id_usuario";
$grado_resultado = mysqli_query($conexion, $grado);
$grado_fila = mysqli_fetch_array($grado_resultado);
$mostrar_grado=$grado_fila['Grado'];
$mostrar_id_curso=$grado_fila['ID_Curso'];
$OpcionesMenu="SELECT COUNT(DISTINCT Capitulo) AS Cantidad_Capitulos
FROM temas
WHERE ID_Curso = $mostrar_id_curso;";
$opciones = mysqli_query($conexion, $OpcionesMenu);
$filas_menu = mysqli_fetch_array($opciones);
$cantidad_filas=$filas_menu['Cantidad_Capitulos'];

$inicio=1;
while($inicio<=$cantidad_filas){
    echo ' <a data-toggle="collapse" data-target="#demo'.$inicio.'" href="#home"><i class="fa fa-fw fa-home"></i>Capitulo '.$inicio.'<span class="caret"></span></a>';
    $query = "SELECT t.Nombre_Tema, t.Descripcion, t.Contenido, t.Capitulo, uc.ID_Usuario, uc.ID_Curso FROM temas t
INNER JOIN cursos cu on cu.ID_Curso=t.ID_Curso
INNER JOIN usuarios_cursos uc on uc.ID_Curso=cu.ID_Curso where Capitulo=$inicio and ID_Usuario=$id_usuario and Grado='$mostrar_grado'";
//echo $query;
    $result = mysqli_query($conexion, $query);
    echo "<ul id='demo".$inicio."' class='collapse'>";
    while ($mostrar = mysqli_fetch_array($result)) {
        $nombre_tema = $mostrar["Nombre_Tema"];
        $descripcion = $mostrar["Descripcion"];
        $contenido = $mostrar["Contenido"];
        echo "<li><a href='#' class='tema' data-descripcion='".$descripcion."' data-contenido='".$contenido."'>".$nombre_tema."</a></li>";
    }
    echo "</ul>";
    $inicio++;
}

    ?>

   
    <a href="login.php"><i class="fa fa-fw fa-sign-out"></i> Cerrar sesión</a>
</div>

<div class="main" id="main">
    <button id="toggleSidebar" class="btn btn-primary mb-3">Mostrar/Ocultar Menú</button>
    <h2><p>Explicación</p></h2>
    <div class="text"></div> <!-- Aquí se mostrará el texto poco a poco -->

    <button class="voz" onclick="leerTexto()">Leer en voz alta</button>
    <button class="voz" onclick="pausar()">Pausar</button>
    <button class="voz" onclick="reanudar()">Reanudar</button>
    <button class="voz" onclick="detener()">Detener</button>
</div>

<script>
    // Función para mostrar y ocultar el sidebar
    document.getElementById("toggleSidebar").addEventListener("click", function() {
        var sidebar = document.getElementById("sidebar");
        var main = document.getElementById("main");

        // Alternamos la clase "collapsed" en el sidebar y el contenido principal
        sidebar.classList.toggle("collapsed");
        main.classList.toggle("collapsed");
    });

    // Añadir evento click a cada tema para mostrar su contenido y leer en voz alta
    document.querySelectorAll('.tema').forEach(function(tema) {
        tema.addEventListener('click', function(e) {
            e.preventDefault(); // Evita el comportamiento por defecto del enlace

            // Obtenemos la descripción y el contenido del tema desde los atributos data
            const descripcion = this.getAttribute('data-descripcion');
            const contenido = this.getAttribute('data-contenido');
            const textoCompleto = `${descripcion} ${contenido}`;

            // Limpiamos el contenido antes de escribir el nuevo texto
            const div = document.querySelector('.text');
            div.textContent = ''; // Limpiar el texto anterior

            // Función para mostrar el texto como si se estuviera escribiendo
            efectoTextTyping(div, textoCompleto);

            // Llamamos a la función para leer en voz alta el texto seleccionado
            leerTexto(textoCompleto);
        });
    });

    let voices = [];

    // Función para cargar las voces disponibles en el dropdown
    function cargarVoces() {
        voices = window.speechSynthesis.getVoices();
        const voiceSelect = document.getElementById('voices');

        voiceSelect.innerHTML = ''; // Limpiar el dropdown antes de llenarlo

        voices.forEach((voice, index) => {
            const option = document.createElement('option');
            option.value = index;
            option.textContent = `${voice.name} (${voice.lang})`;

            if (voice.default) {
                option.textContent += ' - Default';
            }

            voiceSelect.appendChild(option);
        });
    }

    // Escuchamos cuando las voces se carguen
    window.speechSynthesis.onvoiceschanged = cargarVoces;

    function leerTexto(texto) {
        const utterance = new SpeechSynthesisUtterance(texto);

        // Seleccionamos la voz elegida en el dropdown
        const selectedVoiceIndex = 5;
        utterance.voice = voices[selectedVoiceIndex];

        // Configuración opcional de la velocidad, tono y volumen
        utterance.rate = 1; // Velocidad normal
        utterance.pitch = 1; // Tono normal
        utterance.volume = 1; // Volumen máximo

        // Ejecutamos la voz seleccionada
        window.speechSynthesis.speak(utterance);
    }

    // Función para pausar la voz
    function pausar() {
        if (window.speechSynthesis.speaking && !window.speechSynthesis.paused) {
            window.speechSynthesis.pause();
        }
    }

    // Función para reanudar la voz
    function reanudar() {
        if (window.speechSynthesis.paused) {
            window.speechSynthesis.resume();
        }
    }

    // Función para detener la voz
    function detener() {
        if (window.speechSynthesis.speaking) {
            window.speechSynthesis.cancel();
        }
    }

    // Función para mostrar el texto poco a poco
    function efectoTextTyping(elemento, texto, i = 0) {
        elemento.textContent += texto[i];
        if (i < texto.length - 1) {
            setTimeout(() => efectoTextTyping(elemento, texto, i + 1), 50); // Ajusta la velocidad a 50ms por letra
        }
    }
</script>

</body>
</html>
