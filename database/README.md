# Módulo de Base de Datos — PC Doctor

Este directorio contiene el diseño y los scripts de persistencia relacional para el sistema PC Doctor, implementado en MySQL[cite: 1].

## Estructura del Modelo de Datos

La base de datos se encuentra normalizada para soportar la lógica de inferencia del motor de reglas de forma dinámica[cite: 1].

### Tablas Principales:
* `sintomas`: Registra las manifestaciones físicas, lógicas o de rendimiento reportadas en el equipo[cite: 1, 4].
* `preguntas`: Almacena el flujo de preguntas planteadas al usuario durante el diagnóstico[cite: 1, 4].
* `diagnosticos`: Contiene las fallas identificadas, su nivel de gravedad y las soluciones recomendadas[cite: 1, 4].
* `reglas`: Define la matriz de inferencia que asocia respuestas con diagnósticos específicos y sus ponderaciones[cite: 1, 4].

## Instrucciones de Ejecución

1. Verificar que se dispone de una instancia activa de MySQL Server (versión 8.0 o superior).
2. Ejecutar el script `schema_pc_doctor.sql` mediante MySQL Workbench, CLI o la herramienta de gestión de preferencia[cite: 4]:
   ```bash
   mysql -u root -p < schema_pc_doctor.sql
