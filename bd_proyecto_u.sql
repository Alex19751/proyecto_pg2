-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-09-2024 a las 06:17:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_proyecto_u`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `boletas`
--

CREATE TABLE `boletas` (
  `ID_Boleta` int(11) NOT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `ID_Examen` int(11) DEFAULT NULL,
  `Nota_Final` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `boletas`
--

INSERT INTO `boletas` (`ID_Boleta`, `ID_Usuario`, `ID_Examen`, `Nota_Final`) VALUES
(1, 2, 1, 5.00),
(2, 2, 2, 10.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `ID_Curso` int(11) NOT NULL,
  `Nombre_Curso` varchar(100) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Grado` enum('4to','5to') NOT NULL,
  `ID_Profesor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`ID_Curso`, `Nombre_Curso`, `Descripcion`, `Grado`, `ID_Profesor`) VALUES
(1, 'Matemáticas 4to Bachillerato', 'Curso de matemáticas para 4to bachillerato', '4to', 1),
(2, 'Física 5to Bachillerato', 'Curso de física para 5to bachillerato', '5to', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes`
--

CREATE TABLE `examenes` (
  `ID_Examen` int(11) NOT NULL,
  `Titulo` varchar(100) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Fecha_Creacion` date NOT NULL,
  `Fecha_Limite` date NOT NULL,
  `ID_Curso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `examenes`
--

INSERT INTO `examenes` (`ID_Examen`, `Titulo`, `Descripcion`, `Fecha_Creacion`, `Fecha_Limite`, `ID_Curso`) VALUES
(1, 'Examen de Matemáticas', 'Evaluación de funciones y ecuaciones', '2024-08-14', '2024-08-20', 1),
(2, 'Examen de Física', 'Evaluación de MRU y MRUA', '2024-08-14', '2024-08-21', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opciones_respuesta`
--

CREATE TABLE `opciones_respuesta` (
  `ID_Opcion` int(11) NOT NULL,
  `Texto_Opcion` text NOT NULL,
  `Es_Correcta` tinyint(1) NOT NULL,
  `ID_Pregunta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `opciones_respuesta`
--

INSERT INTO `opciones_respuesta` (`ID_Opcion`, `Texto_Opcion`, `Es_Correcta`, `ID_Pregunta`) VALUES
(1, '8', 1, 1),
(2, '6', 0, 1),
(3, 'v = d/t', 1, 2),
(4, 'v = m/a', 0, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `ID_Pregunta` int(11) NOT NULL,
  `Enunciado` text NOT NULL,
  `Tipo` enum('Seleccion Multiple','Verdadero/Falso','Respuesta Corta') NOT NULL,
  `Punteo` decimal(5,2) NOT NULL,
  `ID_Examen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`ID_Pregunta`, `Enunciado`, `Tipo`, `Punteo`, `ID_Examen`) VALUES
(1, '¿Cuál es el valor de f(x) = 2^x cuando x = 3?', 'Seleccion Multiple', 5.00, 1),
(2, 'En un MRU, ¿cómo se calcula la velocidad?', 'Respuesta Corta', 10.00, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `ID_Respuesta` int(11) NOT NULL,
  `ID_Pregunta` int(11) DEFAULT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `Respuesta_Estudiante` text DEFAULT NULL,
  `Es_Correcta` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`ID_Respuesta`, `ID_Pregunta`, `ID_Usuario`, `Respuesta_Estudiante`, `Es_Correcta`) VALUES
(1, 1, 2, '8', 1),
(2, 2, 2, 'v = d/t', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temas`
--

CREATE TABLE `temas` (
  `ID_Tema` int(11) NOT NULL,
  `Nombre_Tema` varchar(100) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Contenido` text DEFAULT NULL,
  `ID_Curso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `temas`
--

INSERT INTO `temas` (`ID_Tema`, `Nombre_Tema`, `Descripcion`, `Contenido`, `ID_Curso`) VALUES
(1, 'Funciones Exponenciales', 'Introducción a las funciones exponenciales', 'EJERCICIO \n1.3 proposiciones simples y compuestas \n23.Una traducción al lenguaje formal de \"Guayaquil mejora su imagen, si la \nMunicipalidad realiza obras o los ciudadanos colaboran en el aseo de las \ncalles\", siendo las proposiciones simples: \nm: La Municipalidad realiza Obras. \nn: LOS ciudadanos colaboran en el aseo de las calles. \np: Guayaquil mejora Su imagen. \nes: p (mv n) \na) Verdadero \nb) Falso \n24. Considere las proposiciones simples: \na: Utilizo mis habilidades matemáticas. \nb: Resuelvo bien los ejercicios. \nc: Hago un buen deber. \nLa traducción de la proposición compuesta \"Es necesario que utilice mis \nhabilidades matemáticas para que resuelva bien los ejercicios y haga un \nbuen deber\", es a (b A c). \na) Verdadero \nb) Falso \n25. una traducción al lenguaje formal de \"Mis padres me compran un carro sólo \nsi me porto bien y apruebo este curso\", siendo las proposiciones simples: \nm: Mis padres me compran un carro. \nn: Yo me porto bien. \np: Yo apruebo este curso. \na) Verdadero \nb) Falso \n26. Si la proposición —a A q A r) es falsa, entonces la proposición p (q A r) \na) Verdadera \nb) Falsa \n27. Si se consideran las siguientes proposiciones simples: \nm: Viajo al exterior. \nn: Apruebo el curso de nivel cero. \np: Obtengo una beca. \nuna traducción al lenguaje formal de la proposición compuesta \"Viajo al \nexterior sólo si apruebo el curso de nivel cero y obtengo una beca\", es: \nEJERCICIO \n1.3 proposiciones simples y compuestas \n23.Una traducción al lenguaje formal de \"Guayaquil mejora su imagen, si la \nMunicipalidad realiza obras o los ciudadanos colaboran en el aseo de las \ncalles\", siendo las proposiciones simples: \nm: La Municipalidad realiza Obras. \nn: LOS ciudadanos colaboran en el aseo de las calles. \np: Guayaquil mejora Su imagen. \nes: p (mv n) \na) Verdadero \nb) Falso \n24. Considere las proposiciones simples: \na: Utilizo mis habilidades matemáticas. \nb: Resuelvo bien los ejercicios. \nc: Hago un buen deber. \nLa traducción de la proposición compuesta \"Es necesario que utilice mis \nhabilidades matemáticas para que resuelva bien los ejercicios y haga un \nbuen deber\", es a (b A c). \na) Verdadero \nb) Falso \n25. una traducción al lenguaje formal de \"Mis padres me compran un carro sólo \nsi me porto bien y apruebo este curso\", siendo las proposiciones simples: \nm: Mis padres me compran un carro. \nn: Yo me porto bien. \np: Yo apruebo este curso. \na) Verdadero \nb) Falso \n26. Si la proposición —a A q A r) es falsa, entonces la proposición p (q A r) \na) Verdadera \nb) Falsa \n27. Si se consideran las siguientes proposiciones simples: \nm: Viajo al exterior. \nn: Apruebo el curso de nivel cero. \np: Obtengo una beca. \nuna traducción al lenguaje formal de la proposición compuesta \"Viajo al \nexterior sólo si apruebo el curso de nivel cero y obtengo una beca\", es: \nEJERCICIO \n1.3 proposiciones simples y compuestas \n23.Una traducción al lenguaje formal de \"Guayaquil mejora su imagen, si la \nMunicipalidad realiza obras o los ciudadanos colaboran en el aseo de las \ncalles\", siendo las proposiciones simples: \nm: La Municipalidad realiza Obras. \nn: LOS ciudadanos colaboran en el aseo de las calles. \np: Guayaquil mejora Su imagen. \nes: p (mv n) \na) Verdadero \nb) Falso \n24. Considere las proposiciones simples: \na: Utilizo mis habilidades matemáticas. \nb: Resuelvo bien los ejercicios. \nc: Hago un buen deber. \nLa traducción de la proposición compuesta \"Es necesario que utilice mis \nhabilidades matemáticas para que resuelva bien los ejercicios y haga un \nbuen deber\", es a (b A c). \na) Verdadero \nb) Falso \n25. una traducción al lenguaje formal de \"Mis padres me compran un carro sólo \nsi me porto bien y apruebo este curso\", siendo las proposiciones simples: \nm: Mis padres me compran un carro. \nn: Yo me porto bien. \np: Yo apruebo este curso. \na) Verdadero \nb) Falso \n26. Si la proposición —a A q A r) es falsa, entonces la proposición p (q A r) \na) Verdadera \nb) Falsa \n27. Si se consideran las siguientes proposiciones simples: \nm: Viajo al exterior. \nn: Apruebo el curso de nivel cero. \np: Obtengo una beca. \nuna traducción al lenguaje formal de la proposición compuesta \"Viajo al \nexterior sólo si apruebo el curso de nivel cero y obtengo una beca\", es: \nEJERCICIO \n1.3 proposiciones simples y compuestas \n23.Una traducción al lenguaje formal de \"Guayaquil mejora su imagen, si la \nMunicipalidad realiza obras o los ciudadanos colaboran en el aseo de las \ncalles\", siendo las proposiciones simples: \nm: La Municipalidad realiza Obras. \nn: LOS ciudadanos colaboran en el aseo de las calles. \np: Guayaquil mejora Su imagen. \nes: p (mv n) \na) Verdadero \nb) Falso \n24. Considere las proposiciones simples: \na: Utilizo mis habilidades matemáticas. \nb: Resuelvo bien los ejercicios. \nc: Hago un buen deber. \nLa traducción de la proposición compuesta \"Es necesario que utilice mis \nhabilidades matemáticas para que resuelva bien los ejercicios y haga un \nbuen deber\", es a (b A c). \na) Verdadero \nb) Falso \n25. una traducción al lenguaje formal de \"Mis padres me compran un carro sólo \nsi me porto bien y apruebo este curso\", siendo las proposiciones simples: \nm: Mis padres me compran un carro. \nn: Yo me porto bien. \np: Yo apruebo este curso. \na) Verdadero \nb) Falso \n26. Si la proposición —a A q A r) es falsa, entonces la proposición p (q A r) \na) Verdadera \nb) Falsa \n27. Si se consideran las siguientes proposiciones simples: \nm: Viajo al exterior. \nn: Apruebo el curso de nivel cero. \np: Obtengo una beca. \nuna traducción al lenguaje formal de la proposición compuesta \"Viajo al \nexterior sólo si apruebo el curso de nivel cero y obtengo una beca\", es: \n\n𝑥\n)\n=\n𝑎\n𝑥\nf(x)=a \nx\n \ndonde:\n\n𝑎\na es una constante positiva distinta de 1, llamada base.\n𝑥\nx es la variable.\nCaracterísticas principales:\nCrecimiento o decrecimiento exponencial:', 1),
(2, 'Movimiento Rectilíneo Uniforme', 'Estudio del MRU', 'Contenido detallado del tema', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID_Usuario` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Correo_Electronico` varchar(100) NOT NULL,
  `Rol` enum('Estudiante','Profesor') NOT NULL,
  `Contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID_Usuario`, `Nombre`, `Apellido`, `Correo_Electronico`, `Rol`, `Contrasena`) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', 'Profesor', '123'),
(2, 'María', 'García', 'maria.garcia@example.com', 'Estudiante', 'hashed_password2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_cursos`
--

CREATE TABLE `usuarios_cursos` (
  `ID_Usuario` int(11) NOT NULL,
  `ID_Curso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios_cursos`
--

INSERT INTO `usuarios_cursos` (`ID_Usuario`, `ID_Curso`) VALUES
(2, 1),
(2, 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `boletas`
--
ALTER TABLE `boletas`
  ADD PRIMARY KEY (`ID_Boleta`),
  ADD KEY `ID_Usuario` (`ID_Usuario`),
  ADD KEY `ID_Examen` (`ID_Examen`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`ID_Curso`),
  ADD KEY `ID_Profesor` (`ID_Profesor`);

--
-- Indices de la tabla `examenes`
--
ALTER TABLE `examenes`
  ADD PRIMARY KEY (`ID_Examen`),
  ADD KEY `ID_Curso` (`ID_Curso`);

--
-- Indices de la tabla `opciones_respuesta`
--
ALTER TABLE `opciones_respuesta`
  ADD PRIMARY KEY (`ID_Opcion`),
  ADD KEY `ID_Pregunta` (`ID_Pregunta`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`ID_Pregunta`),
  ADD KEY `ID_Examen` (`ID_Examen`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`ID_Respuesta`),
  ADD KEY `ID_Pregunta` (`ID_Pregunta`),
  ADD KEY `ID_Usuario` (`ID_Usuario`);

--
-- Indices de la tabla `temas`
--
ALTER TABLE `temas`
  ADD PRIMARY KEY (`ID_Tema`),
  ADD KEY `ID_Curso` (`ID_Curso`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID_Usuario`),
  ADD UNIQUE KEY `Correo_Electronico` (`Correo_Electronico`);

--
-- Indices de la tabla `usuarios_cursos`
--
ALTER TABLE `usuarios_cursos`
  ADD PRIMARY KEY (`ID_Usuario`,`ID_Curso`),
  ADD KEY `ID_Curso` (`ID_Curso`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `boletas`
--
ALTER TABLE `boletas`
  MODIFY `ID_Boleta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `ID_Curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `examenes`
--
ALTER TABLE `examenes`
  MODIFY `ID_Examen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `opciones_respuesta`
--
ALTER TABLE `opciones_respuesta`
  MODIFY `ID_Opcion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `ID_Pregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `ID_Respuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `temas`
--
ALTER TABLE `temas`
  MODIFY `ID_Tema` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `boletas`
--
ALTER TABLE `boletas`
  ADD CONSTRAINT `boletas_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuarios` (`ID_Usuario`),
  ADD CONSTRAINT `boletas_ibfk_2` FOREIGN KEY (`ID_Examen`) REFERENCES `examenes` (`ID_Examen`);

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`ID_Profesor`) REFERENCES `usuarios` (`ID_Usuario`);

--
-- Filtros para la tabla `examenes`
--
ALTER TABLE `examenes`
  ADD CONSTRAINT `examenes_ibfk_1` FOREIGN KEY (`ID_Curso`) REFERENCES `cursos` (`ID_Curso`);

--
-- Filtros para la tabla `opciones_respuesta`
--
ALTER TABLE `opciones_respuesta`
  ADD CONSTRAINT `opciones_respuesta_ibfk_1` FOREIGN KEY (`ID_Pregunta`) REFERENCES `preguntas` (`ID_Pregunta`);

--
-- Filtros para la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD CONSTRAINT `preguntas_ibfk_1` FOREIGN KEY (`ID_Examen`) REFERENCES `examenes` (`ID_Examen`);

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`ID_Pregunta`) REFERENCES `preguntas` (`ID_Pregunta`),
  ADD CONSTRAINT `respuestas_ibfk_2` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuarios` (`ID_Usuario`);

--
-- Filtros para la tabla `temas`
--
ALTER TABLE `temas`
  ADD CONSTRAINT `temas_ibfk_1` FOREIGN KEY (`ID_Curso`) REFERENCES `cursos` (`ID_Curso`);

--
-- Filtros para la tabla `usuarios_cursos`
--
ALTER TABLE `usuarios_cursos`
  ADD CONSTRAINT `usuarios_cursos_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuarios` (`ID_Usuario`),
  ADD CONSTRAINT `usuarios_cursos_ibfk_2` FOREIGN KEY (`ID_Curso`) REFERENCES `cursos` (`ID_Curso`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
