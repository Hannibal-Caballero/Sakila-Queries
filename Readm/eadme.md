# Data Project: Lógica y Consultas SQL (BBDD Sakila)

Proyecto de análisis y extracción de datos sobre la base de datos relacional Sakila utilizando PostgreSQL y DBeaver.

---

## 🛠️ Tecnologías y Herramientas

* **Motor de Base de Datos:** PostgreSQL
* **Gestor / Cliente SQL:** DBeaver
* **Lenguaje:** SQL (DDL, DML, CTEs, Funciones de Ventana, Vistas y Tablas Temporales)
* **Control de Versiones:** Git & GitHub

---

## 🗄️ Modelo Relacional de la BBDD

A continuación se presenta el esquema entidad-relación de la base de datos Sakila:

![alt text](sakila_schema.png)

---
## ⚙️ Metodología y Buenas Prácticas SQL

Durante el desarrollo del proyecto se aplicaron los siguientes estándares de calidad de código:
- **Estandarización de Nombres:** Uso estricto de convención *snake_case* en minúsculas.
- **Idempotencia:** Implementación de instrucciones `DROP TABLE IF EXISTS` y `CREATE OR REPLACE VIEW` para garantizar que los scripts sean reejecutables sin generar errores de conflicto de objetos.
- **Modularidad:** Utilización de **CTEs (`WITH`)** en consultas complejas (como el filtrado de categorías específicas o cálculo de subconsultas temporales) para mejorar la legibilidad y el rendimiento.
- **Optimización de Filtros:** Empleo de `ILIKE` y desglose de condiciones lógicas (`WHERE first_name ... AND last_name ...`) para favorecer la lectura eficiente del motor de base de datos.

---

## 📋 Estructura del Repositorio

* **`README.md`**: Documentación principal, metodología e informe de análisis.
* **`sakila_queries.sql`**: Script SQL con la resolución de las 64 consultas planteadas.
* **`Enunciado : Base/`**: Archivos de origen del proyecto.
  * **`BBDD_Proyecto_shakila_sinuser.sql`**: Script para cargar la base de datos y esquema.
  * **`EnunciadoDataProject_SQL.Lógica.pdf`**: Documento con las consignas del proyecto.
* **`Imagenes/`**: Diagramas y recursos gráficos.
  * **`shakilaDiagrams.png`**: Esquema Entidad-Relación de Sakila.
* **`Readme/`**: Archivos auxiliares de la documentación.
  * **`sakila_schema.png`**: Diagrama de apoyo.

---

## 🔍 Informe y Conclusiones del Análisis

A partir de la ejecución del script analítico sobre el dataset de Sakila, se extraen las siguientes observaciones basadas estrictamente en los datos:

- **Volumen de Facturación Global:** El total ingresado por la empresa asciende a **$67.416,52** (Ejercicio 15).
- **Distribución de Gasto por Cliente:** El análisis del gasto acumulado revela una **distribución uniforme entre los clientes**. El cliente con mayor gasto acumulado supera por un margen muy reducido al resto de la tabla (Top 5 entre $194 y $221 aproximadamente), lo que indica la ausencia de un segmento dominante o de clientes "VIP" concentrados (Ejercicio 34).
- **Duración y Métricas de Películas:** La duración media de las películas varía según su clasificación por edades (`rating`), situándose el promedio general entre los 110 y 120 minutos por categoría (Ejercicios 13 y 20).
- **Seguimiento de Devoluciones:** La presencia de registros con fecha de retorno nula (`return_date IS NULL`) permite identificar alquileres activos y llevar el control de inventario en circulación por cliente (Ejercicio 53).

---

## 🚀 Cómo ejecutar el proyecto

1. Clonar el repositorio:
   ```bash
   git clone [https://github.com/Hannibal-Caballero/Sakila-Queries.git]
