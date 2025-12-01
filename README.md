# ⚽ La Gallina de los Huevos de Oro: Análisis del Reparto de Ingresos de la ANFP y su Impacto en la Competitividad (2015-2024)

![Portada del Dashboard](images/portada_dashboard.png) 


### 📊 [➡️ VER DASHBOARD INTERACTIVO EN TABLEAU PUBLIC](https://public.tableau.com/app/profile/nicolas.bobadilla/viz/AnlisisdeCompetitividaddelFtbolChileno/Dashboard5)

---

## Descripción del Proyecto
Análisis cuantitativo sobre la relación entre la distribución de ingresos por derechos de televisión (ANFP) y el rendimiento deportivo en el fútbol chileno. El estudio utiliza datos financieros y deportivos de la última década para determinar si existe una correlación estadística entre presupuesto y éxito, contrastando la Primera División con la Primera B.

## Stack Tecnológico
*   **Google BigQuery:** Procesamiento de datos, limpieza y lógica de negocio (SQL).
*   **Tableau:** Visualización de datos, parámetros y diseño de dashboard.
*   **GitHub:** Control de versiones y documentación.

## Metodología y Procesamiento de Datos
El flujo de trabajo se dividió en tres etapas principales:

### 1. Extracción y Normalización
Se consolidaron datos financieros de las Memorias Anuales de la ANFP y datos deportivos públicos. Se realizó un proceso de limpieza para estandarizar nombres de clubes (ej. fusión de registros históricos) y corregir inconsistencias en los reportes oficiales.

### 2. Transformación en SQL
Se implementó una arquitectura de vistas en BigQuery (disponibles en `/sql_queries`) para preparar los datos:
*   **Ajuste por Inflación:** Implementación de cálculo de valor presente utilizando datos del IPC del Banco Central para comparar montos monetarios a lo largo de 10 años.
*   **Estandarización Temporal:** Conversión de torneos cortos (Apertura/Clausura) a registros anuales para permitir la correlación con ejercicios financieros.
*   **Filtros de Calidad:** Exclusión de registros atípicos por motivos administrativos (ej. Wanderers 2020) para evitar sesgos en el modelo estadístico.

### 3. Visualización y Análisis
El dashboard en Tableau implementa:
*   **Sheet Swapping:** Lógica para ocultar gráficos vacíos dinámicamente según la disponibilidad de datos.
*   **Parámetros Globales:** Control unificado para filtrar múltiples fuentes de datos simultáneamente.
*   **Cálculos LOD:** Expresiones de Nivel de Detalle para comparar métricas de clubes específicos contra promedios globales.

## Conclusiones
El análisis arroja tres resultados principales:

1.  **Primera División:** Existe una correlación positiva estadísticamente significativa (R²=7.2%, p<0.001) entre ingresos y puntos.
2.  **Segunda División:** En un escenario de reparto equitativo, la correlación desaparece (p=0.17), indicando que la ventaja competitiva es producto del modelo de distribución.
3.  **Eficiencia:** Se identificaron clubes que logran alto rendimiento con bajo presupuesto (Outliers de eficiencia), desafiando la tendencia general.

## Estructura del Repositorio
*   `/sql_queries`: Scripts SQL utilizados en BigQuery.
*   `/images`: Recursos gráficos del proyecto.


## Recursos
*   **Datos:** Estados Financieros de la ANFP y Wikipedia.
*   **Portada:** Imagen generada por IA (NanoBanana)
*   **Iconos/Logos:** Logos oficiales de los clubes.
