-- ============================================================
-- SCRIPT DE BASE DE DATOS: PC Doctor (MySQL)
-- Proyecto Capstone - Asignatura APT
-- ============================================================

CREATE DATABASE IF NOT EXISTS pc_doctor_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE pc_doctor_db;

-- ------------------------------------------------------------
-- 1. TABLA: sintomas
-- Registra las manifestaciones físicas o lógicas de fallas.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sintomas (
    id_sintoma INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    categoria ENUM('HARDWARE', 'SOFTWARE', 'RENDIMIENTO', 'TEMPERATURA') NOT NULL
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 2. TABLA: preguntas
-- Flujo interactivo de preguntas planteadas al usuario.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS preguntas (
    id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
    enunciado VARCHAR(255) NOT NULL,
    id_sintoma_asociado INT NULL,
    FOREIGN KEY (id_sintoma_asociado) REFERENCES sintomas(id_sintoma) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 3. TABLA: diagnosticos
-- Posibles causas identificadas con sus soluciones recomendadas.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS diagnosticos (
    id_diagnostico INT AUTO_INCREMENT PRIMARY KEY,
    nombre_falla VARCHAR(150) NOT NULL,
    nivel_probabilidad ENUM('ALTA', 'MEDIA', 'BAJA') NOT NULL,
    solucion_sugerida TEXT NOT NULL,
    tipo_falla ENUM('HARDWARE', 'SOFTWARE') NOT NULL
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 4. TABLA: reglas
-- Asocia preguntas y respuestas con un diagnóstico específico.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS reglas (
    id_regla INT AUTO_INCREMENT PRIMARY KEY,
    id_pregunta INT NOT NULL,
    respuesta_esperada BOOLEAN NOT NULL, -- TRUE: Sí, FALSE: No
    id_diagnostico INT NOT NULL,
    peso_ponderacion INT DEFAULT 1,
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta) ON DELETE CASCADE,
    FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos(id_diagnostico) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- INSERCIÓN DE DATOS INICIALES (POBLADO DE PRUEBA)
-- ============================================================

-- Inserción de Síntomas
INSERT INTO sintomas (nombre, descripcion, categoria) VALUES
('Apagado repentino', 'El sistema se apaga de golpe al estar bajo carga o jugando.', 'HARDWARE'),
('Cuelgue de sistema (BSOD)', 'Pantalla azul de la muerte o congelamiento completo del sistema.', 'SOFTWARE'),
('Lentitud general', 'Tiempos de carga elevados en el sistema operativo.', 'RENDIMIENTO');

-- Inserción de Preguntas
INSERT INTO preguntas (enunciado, id_sintoma_asociado) VALUES
('¿El computador se apaga completamente solo cuando juegas o ejecutas tareas pesadas?', 1),
('¿Has notado que los ventiladores suenan muy fuerte o el equipo está muy caliente al tacto?', 1),
('¿Aparece una pantalla azul con un código de error antes de reiniciarse?', 2),
('¿El problema empezó justo después de actualizar un driver de video o el sistema operativo?', 2);

-- Inserción de Diagnósticos
INSERT INTO diagnosticos (nombre_falla, nivel_probabilidad, solucion_sugerida, tipo_falla) VALUES
('Sobrecalentamiento de Procesador / GPU', 'ALTA', 'Revisar pasta térmica, verificar giro de ventiladores y limpiar polvo de los disipadores.', 'HARDWARE'),
('Fuente de Poder Incompatible o Defectuosa', 'MEDIA', 'Comprobar que el consumo de los componentes no supere el kilometraje/watts de la fuente.', 'HARDWARE'),
('Incompatibilidad / Corrupción de Driver de Video', 'ALTA', 'Realizar una instalación limpia de controladores usando DDU (Display Driver Uninstaller).', 'SOFTWARE');

-- Inserción de Reglas (Vinculación lógica)
INSERT INTO reglas (id_pregunta, respuesta_esperada, id_diagnostico, peso_ponderacion) VALUES
(1, TRUE, 1, 2),
(2, TRUE, 1, 3),
(1, TRUE, 2, 1),
(3, TRUE, 3, 2),
(4, TRUE, 3, 3);
