# La Gallina de los Huevos de Oro: Análisis del Reparto de Ingresos de la ANFP y su Impacto en la Competitividad (2015-2024)

![Portada del Dashboard](images/portada_dashboard.png) 


### 📊 [➡️ VER DASHBOARD INTERACTIVO EN TABLEAU PUBLIC](https://public.tableau.com/app/profile/nicolas.bobadilla/viz/AnlisisdeCompetitividaddelFtbolChileno/Dashboard5)

---

## Descripción del Proyecto
Estudio cuantitativo sobre la relación entre la distribución de ingresos por derechos de televisión (ANFP) y el rendimiento deportivo en el fútbol chileno. Se analizan datos financieros y deportivos de la última década para determinar la correlación estadística entre presupuesto y puntos obtenidos, utilizando la Primera B como grupo de control.

## Stack Tecnológico
*   **Google BigQuery (SQL):** Limpieza, transformación y modelado de datos.
*   **Tableau:** Visualización, parámetros y diseño de dashboard.
*   **GitHub:** Documentación y control de versiones.

## Procesamiento y Limpieza de Datos (ETL)
El proyecto abordó desafíos de calidad de datos y consistencia histórica mediante las siguientes acciones:

### 1. Normalización de Entidades
*   **Corrección Histórica:** Se identificó una inconsistencia en los reportes financieros respecto a la entidad "Unión Temuco". Mediante SQL (`UPDATE`), se unificaron estos registros bajo **"Deportes Temuco"** tras su fusión en 2013, asegurando la integridad de la serie temporal.
*   **Disponibilidad de Datos:** El análisis de control (Segunda División) se acotó al periodo 2018-2024 debido a la falta de datos públicos consistentes en años anteriores.

### 2. Transformación en SQL
Se implementaron vistas en BigQuery (código disponible en `/sql_queries`):
*   **Ajuste por Inflación:** Cálculo de valor presente para todos los montos históricos utilizando datos del IPC del Banco Central.
*   **Estandarización:** Conversión de los torneos cortos (Apertura/Clausura) a registros anuales consolidados para permitir la comparación directa con los ejercicios financieros.

### 3. Tratamiento de Datos Atípicos (Outliers)
Se aplicaron reglas de negocio para evitar sesgos en el modelo estadístico:
*   **Registros Excluidos (Wanderers y La Serena, 2020):** Se eliminaron del cálculo de correlación. *Motivo:* La cancelación de descensos en 2019 generó una liga con más equipos en 2020, resultando en una asignación de ingresos reducida por decisión administrativa que no refleja la tendencia normal.
*   **Caso Especial (Deportes Melipilla, 2021):** Se mantuvo en el dataset. *Motivo:* El club completó la temporada deportiva, pero sus ingresos fueron retenidos por sanciones (dobles contratos). Se utiliza para visualizar el impacto de factores extra-deportivos en el rendimiento.

## Resultados del Análisis
1.  **Correlación en Primera División:** Se observa una relación positiva y estadísticamente significativa (**R²=7.2%, p<0.001**) entre ingresos y puntos. Existe una ventaja competitiva medible asociada al presupuesto.
2.  **Grupo de Control (Segunda División):** En un escenario de reparto equitativo de ingresos, la correlación es inexistente (**p=0.84**). Esto indica que la ventaja observada en Primera División es atribuible al modelo de distribución desigual.
3.  **Concentración de Ingresos:** Los tres clubes principales capturan el **18.1%** del total de ingresos, recibiendo en promedio 4 veces más recursos que un equipo de la división de ascenso.
4.  **Eficiencia:** El análisis de "Costo por Punto" identificó clubes como **Huachipato** y **Cobresal**, que lograron campeonatos con presupuestos inferiores al promedio, demostrando alta eficiencia en la gestión deportiva.

## Estructura del Repositorio
*   `/sql_queries`: Scripts SQL utilizados en BigQuery.
*   `/images`: Recursos gráficos del proyecto.


## Recursos
*   **Datos:** Estados Financieros de la ANFP y Wikipedia.
*   **Portada:** Imagen generada por IA (NanoBanana)
*   **Iconos/Logos:** Logos oficiales de los clubes.
