-- ========================================================
-- SCRIPT DE BASE DE DATOS DEFINITIVO: PC DOCTOR
-- Proyecto: Capstone 2026 (PTY4614)
-- Descripción: Estructura completa de tablas, llaves foráneas
--              y datos iniciales del catálogo.
-- ========================================================

CREATE DATABASE IF NOT EXISTS `pc_doctor_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `pc_doctor_db`;

-- 1. Tabla: SINTOMAS
DROP TABLE IF EXISTS `solicitudes_reparacion`;
DROP TABLE IF EXISTS `preguntas`;
DROP TABLE IF EXISTS `diagnosticos`;
DROP TABLE IF EXISTS `sintomas`;
DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `sintomas` (
  `id_sintoma` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tabla: DIAGNOSTICOS
CREATE TABLE `diagnosticos` (
  `id_diagnostico` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `titulo` VARCHAR(150) NOT NULL,
  `causa_probable` TEXT,
  `solucion_recomendada` TEXT,
  `precio_estimado` INT NOT NULL DEFAULT 25000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabla: PREGUNTAS (Árbol de Decisión - 21 Preguntas)
CREATE TABLE `preguntas` (
  `id_pregunta` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `id_sintoma` BIGINT NOT NULL,
  `texto_pregunta` TEXT NOT NULL,
  `id_siguiente_si` BIGINT DEFAULT NULL,
  `id_siguiente_no` BIGINT DEFAULT NULL,
  `id_diagnostico_si` BIGINT DEFAULT NULL,
  `id_diagnostico_no` BIGINT DEFAULT NULL,
  CONSTRAINT `fk_preguntas_sintoma` FOREIGN KEY (`id_sintoma`) REFERENCES `sintomas` (`id_sintoma`) ON DELETE CASCADE,
  CONSTRAINT `fk_preguntas_diag_si` FOREIGN KEY (`id_diagnostico_si`) REFERENCES `diagnosticos` (`id_diagnostico`),
  CONSTRAINT `fk_preguntas_diag_no` FOREIGN KEY (`id_diagnostico_no`) REFERENCES `diagnosticos` (`id_diagnostico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Tabla: CLIENTES
CREATE TABLE `clientes` (
  `id_cliente` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `credencial_rut` VARCHAR(20) NOT NULL UNIQUE,
  `nombre_completo` VARCHAR(150) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `fecha_registro` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Tabla: SOLICITUDES_REPARACION (Agendamientos & Panel Superusuario)
CREATE TABLE `solicitudes_reparacion` (
  `id_solicitud` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `id_cliente` BIGINT NOT NULL,
  `id_diagnostico` BIGINT NOT NULL,
  `fecha_solicitud` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `fecha_visita_agendada` DATE NOT NULL,
  `resumen_respuestas` TEXT DEFAULT NULL,
  `estado` VARCHAR(30) DEFAULT 'PENDIENTE',
  CONSTRAINT `fk_solicitudes_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE,
  CONSTRAINT `fk_solicitudes_diagnostico` FOREIGN KEY (`id_diagnostico`) REFERENCES `diagnosticos` (`id_diagnostico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ========================================================
-- INSERCIÓN DE DATOS INICIALES (CATÁLOGO)
-- ========================================================

-- Insertar Categorías Principales de Síntomas
INSERT INTO `sintomas` (`id_sintoma`, `nombre`, `descripcion`) VALUES
(1, 'Apagado repentino / Cuelgues', 'El equipo se apaga solo durante su uso o se congela completamente'),
(2, 'Pantalla Azul (BSOD) / Errores', 'Aparecen pantallas azules de error en Windows o reinicios inesperados'),
(3, 'Lentitud / Uso Alto de Disco', 'El computador tarda mucho en iniciar o responder al abrir aplicaciones');

-- Insertar Catálogo de Diagnósticos y Presupuestos CLP
INSERT INTO `diagnosticos` (`id_diagnostico`, `titulo`, `causa_probable`, `solucion_recomendada`, `precio_estimado`) VALUES
(1, 'Sobrecalentamiento del Procesador (CPU)', 'Pasta térmica seca o ventilación obstruida por acumulación de polvo.', 'Mantenimiento preventivo, limpieza general y cambio de pasta térmica.', 15000),
(2, 'Temperatura Elevada en Tarjeta de Video (GPU)', 'Ventiladores trabados o disipador saturado en la GPU.', 'Limpieza profunda de la GPU y reemplazo de pad térmico.', 25000),
(3, 'Falla o Inestabilidad en Fuente de Poder', 'Capacitores desgastados o caídas de voltaje que activan protección.', 'Reemplazo de la fuente de poder por una certificada.', 35000),
(4, 'Inestabilidad en Memorias RAM', 'Módulos RAM sucios o con sectores de memoria defectuosos.', 'Limpieza de contactos con alcohol isopropílico o reemplazo de módulo.', 20000),
(5, 'Falla de Controladores / Drivers de Video', 'Incompatibilidad o corrupción en los controladores gráficos.', 'Desinstalación limpia con DDU y reinstalación de controladores oficiales.', 10000),
(6, 'Desgaste / Falla de Unidad de Almacenamiento', 'Sectores defectuosos en el disco duro (HDD) o degradación del SSD.', 'Reemplazo por un SSD NVMe / SATA e instalación de Sistema Operativo.', 25000),
(7, 'Corrupción de Archivos del Sistema Operativo', 'Archivos de arranque o registros de Windows dañados tras apagados forzados.', 'Reparación de la imagen del sistema mediante SFC/DISM o formateo.', 15000),
(8, 'Presencia de Software Malicioso o Virus', 'Procesos no autorizados consumiendo memoria y procesador en segundo plano.', 'Desinfección integral, eliminación de malware y optimización de inicio.', 18000);

-- Insertar Preguntas Iniciales del Árbol de Decisión
INSERT INTO `preguntas` (`id_pregunta`, `id_sintoma`, `texto_pregunta`, `id_siguiente_si`, `id_siguiente_no`, `id_diagnostico_si`, `id_diagnostico_no`) VALUES
(1, 1, '¿El computador se apaga principalmente cuando ejecutas juegos o programas pesados?', 2, 3, NULL, NULL),
(2, 1, '¿Sientes que los ventiladores suenan muy fuerte o que la zona del equipo está muy caliente al tacto?', NULL, NULL, 1, 2),
(3, 1, '¿El equipo se apaga de golpe de forma instantánea sin mostrar ningún mensaje de error?', NULL, NULL, 3, 4);
