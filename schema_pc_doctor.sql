-- ========================================================
-- BASE DE DATOS: pc_doctor_db
-- Proyecto: PC Doctor - Capstone 2026
-- ========================================================

CREATE DATABASE IF NOT EXISTS `pc_doctor_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `pc_doctor_db`;

-- 1. Tabla de Síntomas Generales
DROP TABLE IF EXISTS `solicitudes_reparacion`;
DROP TABLE IF EXISTS `clientes`;
DROP TABLE IF EXISTS `preguntas`;
DROP TABLE IF EXISTS `diagnosticos`;
DROP TABLE IF EXISTS `sintomas`;

CREATE TABLE `sintomas` (
  `id_sintoma` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sintomas` (`id_sintoma`, `nombre`) VALUES
(1, 'Hardware / Problemas de Encendido o Apagado Repentino'),
(2, 'Rendimiento / Lentitud y Bloqueos del Sistema'),
(3, 'Software / Pantallazos Azules o Errores de Windows');

-- 2. Tabla de Diagnósticos y Presupuestos
CREATE TABLE `diagnosticos` (
  `id_diagnostico` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `titulo` VARCHAR(150) NOT NULL,
  `nivel_probabilidad` VARCHAR(50) DEFAULT 'Alta',
  `causa_probable` TEXT NOT NULL,
  `solucion_recomendada` TEXT NOT NULL,
  `diagnostico_secundario` TEXT,
  `precio_estimado` DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `diagnosticos` (`id_diagnostico`, `titulo`, `nivel_probabilidad`, `causa_probable`, `solucion_recomendada`, `diagnostico_secundario`, `precio_estimado`) VALUES
(1, 'Sobrecalentamiento del Procesador (CPU)', 'Alta', 'La pasta térmica del procesador está resecada o la acumulación de polvo obstruye la disipación del calor.', 'Mantenimiento preventivo completo, limpieza de disipador y aplicación de nueva pasta térmica.', 'Posible desgaste del ventilador del cooler.', 15000.00),
(2, 'Temperatura Elevada en Tarjeta de Video (GPU)', 'Alta', 'Los ventiladores de la GPU están trabados o con suciedad acumulada, impidiendo el flujo de aire adecuado.', 'Mantenimiento del sistema de ventilación de la tarjeta de video y reemplazo de thermal pads.', 'Falla en curva de ventilación por software.', 25000.00),
(3, 'Falla o Inestabilidad en Fuente de Poder', 'Alta', 'Componentes capacitores de la fuente de alimentación desgastados que causan caídas de voltaje inesperadas.', 'Reemplazo de la fuente de poder por una unidad certificada.', 'Falla en la toma de corriente eléctrica o corte interno.', 35000.00),
(4, 'Inestabilidad en Memorias RAM', 'Media', 'Archivos corruptos en memoria o suciedad en las ranuras de conexión (slots) de la placa madre.', 'Limpieza de contactos con alcohol isopropílico y prueba de módulos de memoria.', 'Falla física de un módulo de memoria RAM.', 20000.00),
(5, 'Falla de Controladores / Drivers de Video', 'Alta', 'Conflicto de software o controladores corruptos tras una actualización del sistema operativo.', 'Reinstalación limpia de controladores con la herramienta DDU.', 'Incompatibilidad de la versión de Windows instalada.', 10000.00),
(6, 'Desgaste / Falla de Unidad de Almacenamiento', 'Alta', 'Sectores defectuosos en el disco duro o degradación de celdas en la unidad de estado sólido (SSD).', 'Respaldo preventivo de datos e instalación de un nuevo disco SSD.', 'Falla del cable SATA o bus de datos.', 25000.00),
(7, 'Corrupción de Archivos del Sistema Operativo', 'Media', 'Cortes imprevistos de energía o interrupción durante una actualización crítica de Windows.', 'Reparación de la imagen del sistema mediante SFC/DISM o reinstalación del SO.', 'Infección por malware a nivel de arranque.', 15000.00),
(8, 'Presencia de Software Malicioso o Virus', 'Alta', 'Procesos secundarios no autorizados consumiendo ciclos de procesamiento en segundo plano.', 'Desinfección profunda con herramientas anti-malware especializadas.', 'Conflicto con múltiples programas antivirus ejecutándose.', 18000.00);

-- 3. Tabla del Árbol de Preguntas
CREATE TABLE `preguntas` (
  `id_pregunta` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `id_sintoma` INT NOT NULL,
  `texto_pregunta` TEXT NOT NULL,
  `id_siguiente_si` BIGINT DEFAULT NULL,
  `id_siguiente_no` BIGINT DEFAULT NULL,
  `id_diagnostico_si` BIGINT DEFAULT NULL,
  `id_diagnostico_no` BIGINT DEFAULT NULL,
  FOREIGN KEY (`id_sintoma`) REFERENCES `sintomas`(`id_sintoma`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `preguntas` (`id_pregunta`, `id_sintoma`, `texto_pregunta`, `id_siguiente_si`, `id_siguiente_no`, `id_diagnostico_si`, `id_diagnostico_no`) VALUES
-- Rama Síntoma 1: Hardware
(1, 1, '¿El computador emite ruidos fuertes de ventiladores antes de apagarse?', 2, 3, NULL, NULL),
(2, 1, '¿El equipo se apaga principalmente al ejecutar juegos o tareas pesadas?', NULL, NULL, 1, 2),
(3, 1, '¿El computador se apaga de golpe sin ningún aviso previo ni pantalla azul?', 4, 5, NULL, NULL),
(4, 1, '¿Sientes olor a quemado o la zona trasera de la torre se siente muy caliente?', NULL, NULL, 3, 4),
(5, 1, '¿El equipo enciende las luces y ventiladores pero no da imagen en la pantalla?', NULL, NULL, 4, 3),
(6, 1, '¿Escuchas pitidos intermitentes al presionar el botón de encendido?', NULL, NULL, 4, 3),
(7, 1, '¿El equipo vuelve a encender inmediatamente tras apagarse solo?', NULL, NULL, 1, 3),

-- Rama Síntoma 2: Rendimiento / Lentitud
(8, 2, '¿El uso de disco en el Administrador de Tareas se mantiene cercano al 100%?', 9, 10, NULL, NULL),
(9, 2, '¿Escuchas chasquidos o ruidos mecánicos provenientes del interior del equipo?', NULL, NULL, 6, 7),
(10, 2, '¿El procesador muestra un consumo elevado aunque no tengas programas abiertos?', 11, 12, NULL, NULL),
(11, 2, '¿Se abren ventanas emergentes o publicidad sin que tú lo solicites?', NULL, NULL, 8, 1),
(12, 2, '¿El sistema tarda más de 3 minutos en iniciar completamente?', NULL, NULL, 6, 4),
(13, 2, '¿Los programas se congelan y aparece "No responde" con frecuencia?', NULL, NULL, 4, 6),
(14, 2, '¿Al mover el ratón el cursor se congela por lapsos de segundos?', NULL, NULL, 4, 6),

-- Rama Síntoma 3: Software / Errores de Windows
(15, 3, '¿Aparece una pantalla azul (BSOD) con un código de error específico?', 16, 17, NULL, NULL),
(16, 3, '¿La pantalla azul ocurre justo después de actualizar controladores o Windows?', NULL, NULL, 5, 7),
(17, 3, '¿El equipo se reinicia solo en bucle antes de cargar el escritorio?', 18, 19, NULL, NULL),
(18, 3, '¿Aparece un mensaje de reparación automática de Windows al iniciar?', NULL, NULL, 7, 6),
(19, 3, '¿Aparecen mensajes de error indicando archivos .dll faltantes?', NULL, NULL, 7, 5),
(20, 3, '¿Los juegos o programas de diseño se cierran repentinamente al escritorio?', NULL, NULL, 5, 4),
(21, 3, '¿Windows muestra alertas de que la licencia o el sistema está dañado?', NULL, NULL, 7, 8);

-- 4. Tabla de Clientes
CREATE TABLE `clientes` (
  `id_cliente` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `credencial_rut` VARCHAR(20) NOT NULL UNIQUE,
  `nombre_completo` VARCHAR(150) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Tabla de Solicitudes y Agendamiento de Reparaciones
CREATE TABLE `solicitudes_reparacion` (
  `id_solicitud` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `id_cliente` BIGINT NOT NULL,
  `id_diagnostico` BIGINT NOT NULL,
  `fecha_visita_agendada` DATE NOT NULL,
  `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`id_cliente`) REFERENCES `clientes`(`id_cliente`) ON DELETE CASCADE,
  FOREIGN KEY (`id_diagnostico`) REFERENCES `diagnosticos`(`id_diagnostico`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
