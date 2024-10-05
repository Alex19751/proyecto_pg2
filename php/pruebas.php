<?php
require '../vendor/autoload.php';

use PhpOffice\PhpWord\IOFactory;
use PhpOffice\PhpWord\Shared\ZipArchive;

try {
    // Usar una ruta absoluta para evitar problemas de rutas relativas
    $filePath = __DIR__ . '/4to_bachillerato.docx'; // Asegúrate de que la ruta sea correcta

    // Verificar si el archivo .docx existe
    if (!file_exists($filePath)) {
        die("Error: El archivo .docx no existe.");
    }

    // Intentar abrir el archivo .docx como un archivo ZIP
    $zip = new ZipArchive();
    if ($zip->open($filePath) !== true) {
        die("Error: No se pudo abrir el archivo .docx como un archivo zip.");
    }

    // Crear el directorio para guardar las imágenes si no existe
    $outputDir = '../extracted_images/';
    if (!is_dir($outputDir)) {
        mkdir($outputDir, 0777, true);
    }

    // Array para almacenar los nombres de las imágenes
    $imageFiles = [];

    // Recorrer el contenido del archivo ZIP y extraer las imágenes
    for ($i = 0; $i < $zip->numFiles; $i++) {
        $zipEntry = $zip->getNameIndex($i);
        // Buscar archivos de imágenes dentro de la carpeta 'word/media/'
        if (preg_match('/^word\/media\/(.*\.(jpeg|jpg|png|gif))$/i', $zipEntry, $matches)) {
            $imageName = $matches[1];

            // Extraer el archivo del ZIP y guardarlo en la carpeta de salida
            $fileContents = $zip->getFromName($zipEntry);
            if ($fileContents !== false) {
                $imagePath = $outputDir . $imageName;
                file_put_contents($imagePath, $fileContents);
                // Almacenar el nombre del archivo para ordenarlo después
                $imageFiles[] = $imageName;
            } else {
                echo "Error: No se pudo extraer la imagen $zipEntry<br>";
            }
        }
    }

    $zip->close();

    // Ordenar los nombres de las imágenes alfabéticamente
    sort($imageFiles);

    // Mostrar las imágenes en orden alfabético
    foreach ($imageFiles as $imageName) {
        echo "<img src='$outputDir$imageName' alt='Imagen extraída' width=300><br>";
    }

} catch (Exception $e) {
    echo 'Error al leer el archivo: ',  $e->getMessage();
}
