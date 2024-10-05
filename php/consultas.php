<?php
require "conexion.php";
$consulta="select * from temas";
$resultado =mysqli_query($conexion, $consulta);
while($mostrar=mysqli_fetch_array($resultado)){
    $Nombre_Tema=$mostrar['Nombre_Tema'];
    $Descripcion=$mostrar['Descripcion'];
    $contenido=$mostrar['Contenido'];
    echo "<h1 id='titulo' style='display:none'>".$Nombre_Tema."</h1>";
    echo "<p style='display:none'>".$Descripcion."</p>";
    echo "<p id='contenido' style='display:none'>".$Descripcion." ".$contenido."</p>";
    echo "<h1 class='text2'></h1>";
    echo "<div class='text'></div>";
}
echo "<button onclick='leerTexto()'>Leer en voz alta</button>";
echo '<label for="voices">Selecciona una voz: </label>
    <select id="voices"></select>
    <br><br>

    <button onclick="leerTexto()">Leer en voz alta</button>';
echo '<button onclick="pausar()">Pausar</button>
    <button onclick="reanudar()">Reanudar</button>
    <button onclick="detener()">Detener</button>';
?>
<script>
    var contenido=document.getElementById("contenido").textContent
    //alert(contenido)
    let voices = [];

        // Cargamos las voces disponibles
        function cargarVoces() {
            voices = window.speechSynthesis.getVoices();
            const voiceSelect = document.getElementById('voices');

            // Limpiamos el dropdown de voces antes de llenarlo
            voiceSelect.innerHTML = '';

            // Llenamos el dropdown con las voces disponibles
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

        // Escuchamos cuando las voces se carguen (algunos navegadores cargan después de que la página se ha cargado)
        window.speechSynthesis.onvoiceschanged = cargarVoces;

        function leerTexto() {
            var contenido=document.getElementById("contenido").textContent
            const utterance = new SpeechSynthesisUtterance(contenido);

            // Seleccionamos la voz elegida en el dropdown
            //const selectedVoiceIndex = document.getElementById('voices').value;
            const selectedVoiceIndex = 5;
            utterance.voice = voices[selectedVoiceIndex];
            alert(selectedVoiceIndex)
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
        leerTexto()
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
        const div=document.querySelector(".text"),
        texto=document.getElementById("contenido").textContent
        function efectoTextTyping(elemento,texto,i=0){
            elemento.textContent+=texto[i];
            if(i===texto.length-1) return;
            setTimeout(()=>efectoTextTyping(div, texto, i+1),62)
        }
        efectoTextTyping(div, texto)

        const div1=document.querySelector(".text2"),
        titulo=document.getElementById("titulo").textContent
        function efectoTextTyping2(elemento,titulo,i=0){
            elemento.textContent+=titulo[i];
            if(i===titulo.length-1) return;
            setTimeout(()=>efectoTextTyping2(div1, titulo, i+1),100)
        }
        efectoTextTyping2(div1, titulo)
</script>