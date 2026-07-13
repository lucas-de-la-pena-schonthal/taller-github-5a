-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-07-2026 a las 14:28:55
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mejora_tus_notas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credencial_usuario`
--

CREATE TABLE `credencial_usuario` (
  `id_estudiante` int(11) NOT NULL,
  `contrasenia_hash` varchar(255) NOT NULL,
  `ultimo_acceso` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estilo_aprendizaje`
--

CREATE TABLE `estilo_aprendizaje` (
  `id_estilo` int(11) NOT NULL,
  `VAK` varchar(50) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estilo_aprendizaje`
--

INSERT INTO `estilo_aprendizaje` (`id_estilo`, `VAK`, `tipo`) VALUES
(1, 'Visual', 'Mapas mentales, esquemas de colores, infografías.'),
(2, 'Auditivo', 'Grabaciones de audio, explicar en voz alta, debates.'),
(3, 'Kinestésico', 'Realizar ejercicios prácticos, utilizar objetos, estudiar con movimiento.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estilo_tecnica`
--

CREATE TABLE `estilo_tecnica` (
  `id_estilo` int(11) NOT NULL,
  `id_tecnica` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estilo_tecnica`
--

INSERT INTO `estilo_tecnica` (`id_estilo`, `id_tecnica`) VALUES
(1, 8),
(1, 9),
(1, 10),
(2, 4),
(2, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `id_estudiante` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante_materia`
--

CREATE TABLE `estudiante_materia` (
  `id_estudiante` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante_tecnica`
--

CREATE TABLE `estudiante_tecnica` (
  `id_estudiante` int(11) NOT NULL,
  `id_tecnica` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habito_organizacion`
--

CREATE TABLE `habito_organizacion` (
  `id_habito` int(11) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `frecuencia` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `id_materia` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `area` varchar(50) DEFAULT NULL,
  `tipo` enum('Teórico','Práctico') NOT NULL,
  `carga_horaria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`id_materia`, `nombre`, `area`, `tipo`, `carga_horaria`) VALUES
(1, 'Matemática I', 'Matematica, Fisica y Quimica', 'Práctico', 60),
(2, 'Física General', 'Matematica, Fisica y Quimica', 'Práctico', 60),
(3, 'Historia Argentina', 'Historia y Geografía', 'Teórico', 45),
(4, 'Geografía Mundial', 'Historia y Geografía', 'Teórico', 45),
(5, 'Lengua y Literatura', 'Lengua y Economia', 'Teórico', 40),
(6, 'Economía Política', 'Lengua y Economia', 'Teórico', 40);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodo_estudio`
--

CREATE TABLE `metodo_estudio` (
  `id_metodo` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `metodo_estudio`
--

INSERT INTO `metodo_estudio` (`id_metodo`, `nombre`, `descripcion`) VALUES
(1, 'Active Recall (Recuerdo Activo)', 'Forzar al cerebro a recordar información sin mirar los apuntes (ej. usar flashcards).'),
(2, 'Técnica Feynman', 'Explicar un concepto con tus propias palabras como si se lo enseñaras a alguien más, simplificando al máximo.'),
(3, 'Repetición Espaciada', 'Repasar el material en intervalos de tiempo crecientes para evitar el olvido.'),
(4, 'Método del Encadenamiento', 'Crear una historia absurda donde cada elemento que debés recordar se conecta con el siguiente mediante una acción.'),
(5, 'Método Cornell', 'Organizar apuntes dividiendo la hoja en secciones: notas de clase, ideas clave y resumen.'),
(6, 'Método 2L, 2S, 2R', 'Para textos complejos. 2L (Lecturas rápida/lenta), 2S (Subrayado y Síntesis), 2R (Repetir en voz alta y Repasar).');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodo_materia`
--

CREATE TABLE `metodo_materia` (
  `id_metodo` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `metodo_materia`
--

INSERT INTO `metodo_materia` (`id_metodo`, `id_materia`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 3),
(3, 4),
(4, 3),
(4, 4),
(5, 5),
(5, 6),
(6, 5),
(6, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica_especifica`
--

CREATE TABLE `tecnica_especifica` (
  `id_tecnica` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `recomendaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tecnica_especifica`
--

INSERT INTO `tecnica_especifica` (`id_tecnica`, `nombre`, `categoria`, `recomendaciones`) VALUES
(1, 'Cuadros Comparativos', 'Lectura y Comprensión', 'Ideal para cuando tenés que diferenciar conceptos parecidos (ej. leyes, teorías o épocas).'),
(2, 'Mnemotecnias', 'Memorización y Repaso', 'Crear frases, palabras o canciones cortas para recordar listas o datos áridos.'),
(3, 'Flashcards (Tarjetas de estudio)', 'Memorización y Repaso', 'Usar una cara para una pregunta y la otra para la respuesta. Base del Active Recall.'),
(4, 'Grabación y Escucha', 'Memorización y Repaso', 'Grabarte explicando un tema y escucharlo mientras hacés otras actividades.'),
(5, 'Enseñanza entre Pares', 'Memorización y Repaso', 'Estudiar en grupo donde cada integrante es dueño de un tema y debe dárselo a los demás.'),
(6, 'Técnica Pomodoro', 'Gestión del tiempo y energía', 'Estudiar con enfoque intenso durante 25 minutos, seguidos de 5 minutos de descanso.'),
(7, 'Eat the Frog', 'Gestión del tiempo y energía', 'Realizar la tarea más difícil o pesada apenas empezás el día para evitar la procrastinación.'),
(8, 'Mapas Conceptuales/Mentales', 'Mapas y líneas de tiempo', 'Diagramas para configurar ideas y conectar conceptos jerárquicamente.'),
(9, 'Líneas de Tiempo', 'Mapas y líneas de tiempo', 'Fundamentales para entender la causalidad y el orden de los eventos.'),
(10, 'Mapa Sistémico', 'Mapas y líneas de tiempo', 'Incluye entradas y salidas. Indica flujos de información o relaciones lógicas.'),
(11, 'Subrayado y Resúmenes', 'Técnicas de Síntesis', 'Identificar ideas clave y reescribir la información de manera sintética.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica_metodo`
--

CREATE TABLE `tecnica_metodo` (
  `id_tecnica` int(11) NOT NULL,
  `id_metodo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tecnica_metodo`
--

INSERT INTO `tecnica_metodo` (`id_tecnica`, `id_metodo`) VALUES
(3, 1),
(11, 6);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `credencial_usuario`
--
ALTER TABLE `credencial_usuario`
  ADD PRIMARY KEY (`id_estudiante`);

--
-- Indices de la tabla `estilo_aprendizaje`
--
ALTER TABLE `estilo_aprendizaje`
  ADD PRIMARY KEY (`id_estilo`);

--
-- Indices de la tabla `estilo_tecnica`
--
ALTER TABLE `estilo_tecnica`
  ADD PRIMARY KEY (`id_estilo`,`id_tecnica`),
  ADD KEY `id_tecnica` (`id_tecnica`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`id_estudiante`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `estudiante_materia`
--
ALTER TABLE `estudiante_materia`
  ADD PRIMARY KEY (`id_estudiante`,`id_materia`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `estudiante_tecnica`
--
ALTER TABLE `estudiante_tecnica`
  ADD PRIMARY KEY (`id_estudiante`,`id_tecnica`),
  ADD KEY `id_tecnica` (`id_tecnica`);

--
-- Indices de la tabla `habito_organizacion`
--
ALTER TABLE `habito_organizacion`
  ADD PRIMARY KEY (`id_habito`),
  ADD KEY `id_estudiante` (`id_estudiante`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`id_materia`);

--
-- Indices de la tabla `metodo_estudio`
--
ALTER TABLE `metodo_estudio`
  ADD PRIMARY KEY (`id_metodo`);

--
-- Indices de la tabla `metodo_materia`
--
ALTER TABLE `metodo_materia`
  ADD PRIMARY KEY (`id_metodo`,`id_materia`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `tecnica_especifica`
--
ALTER TABLE `tecnica_especifica`
  ADD PRIMARY KEY (`id_tecnica`);

--
-- Indices de la tabla `tecnica_metodo`
--
ALTER TABLE `tecnica_metodo`
  ADD PRIMARY KEY (`id_tecnica`,`id_metodo`),
  ADD KEY `id_metodo` (`id_metodo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `estilo_aprendizaje`
--
ALTER TABLE `estilo_aprendizaje`
  MODIFY `id_estilo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `id_estudiante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `habito_organizacion`
--
ALTER TABLE `habito_organizacion`
  MODIFY `id_habito` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `id_materia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `metodo_estudio`
--
ALTER TABLE `metodo_estudio`
  MODIFY `id_metodo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tecnica_especifica`
--
ALTER TABLE `tecnica_especifica`
  MODIFY `id_tecnica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `credencial_usuario`
--
ALTER TABLE `credencial_usuario`
  ADD CONSTRAINT `credencial_usuario_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`) ON DELETE CASCADE;

--
-- Filtros para la tabla `estilo_tecnica`
--
ALTER TABLE `estilo_tecnica`
  ADD CONSTRAINT `estilo_tecnica_ibfk_1` FOREIGN KEY (`id_estilo`) REFERENCES `estilo_aprendizaje` (`id_estilo`) ON DELETE CASCADE,
  ADD CONSTRAINT `estilo_tecnica_ibfk_2` FOREIGN KEY (`id_tecnica`) REFERENCES `tecnica_especifica` (`id_tecnica`) ON DELETE CASCADE;

--
-- Filtros para la tabla `estudiante_materia`
--
ALTER TABLE `estudiante_materia`
  ADD CONSTRAINT `estudiante_materia_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`) ON DELETE CASCADE,
  ADD CONSTRAINT `estudiante_materia_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`) ON DELETE CASCADE;

--
-- Filtros para la tabla `estudiante_tecnica`
--
ALTER TABLE `estudiante_tecnica`
  ADD CONSTRAINT `estudiante_tecnica_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`) ON DELETE CASCADE,
  ADD CONSTRAINT `estudiante_tecnica_ibfk_2` FOREIGN KEY (`id_tecnica`) REFERENCES `tecnica_especifica` (`id_tecnica`) ON DELETE CASCADE;

--
-- Filtros para la tabla `habito_organizacion`
--
ALTER TABLE `habito_organizacion`
  ADD CONSTRAINT `habito_organizacion_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`) ON DELETE CASCADE;

--
-- Filtros para la tabla `metodo_materia`
--
ALTER TABLE `metodo_materia`
  ADD CONSTRAINT `metodo_materia_ibfk_1` FOREIGN KEY (`id_metodo`) REFERENCES `metodo_estudio` (`id_metodo`) ON DELETE CASCADE,
  ADD CONSTRAINT `metodo_materia_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tecnica_metodo`
--
ALTER TABLE `tecnica_metodo`
  ADD CONSTRAINT `tecnica_metodo_ibfk_1` FOREIGN KEY (`id_tecnica`) REFERENCES `tecnica_especifica` (`id_tecnica`) ON DELETE CASCADE,
  ADD CONSTRAINT `tecnica_metodo_ibfk_2` FOREIGN KEY (`id_metodo`) REFERENCES `metodo_estudio` (`id_metodo`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
