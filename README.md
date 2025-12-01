# ⚽ La Gallina de los Huevos de Oro: Análisis del Reparto de Ingresos de la ANFP y su Impacto en la Competitividad (2015-2024)

![Portada del Dashboard](images/portada_dashboard.png) 


### 📊 [➡️ VER DASHBOARD INTERACTIVO EN TABLEAU PUBLIC](https://public.tableau.com/app/profile/nicolas.bobadilla/viz/AnlisisdeCompetitividaddelFtbolChileno/Dashboard5)

---

## 📝 Resumen Ejecutivo

El fútbol chileno mueve miles de millones de pesos anuales, principalmente a través de los derechos de televisión (TNT Sports). Sin embargo, la distribución de esta riqueza no es equitativa.

Este proyecto es un análisis de datos *end-to-end* que investiga la relación entre el presupuesto asignado por la ANFP y el éxito deportivo durante la última década. El objetivo principal fue responder: **¿El dinero garantiza campeonatos en Chile?**

Para ello, se contrastó la **Primera División** (reparto desigual) con la **Primera B** (reparto equitativo), utilizándola como grupo de control estadístico.

---

## 💡 Hallazgos Principales (Insights)

1.  **El Modelo de Reparto Crea una Ventaja, No una Garantía:** En Primera División, existe una correlación positiva y estadísticamente significativa (**R²=7.2%, p<0.001**). Los clubes con más dinero tienen una ventaja medible, pero el 93% del éxito depende de otros factores.
2.  **La Equidad Anula el Efecto del Dinero:** En la Primera B, donde el reparto es igualitario, la correlación desaparece por completo (**p=0.84**). Esto demuestra que la influencia del dinero es una consecuencia directa del modelo de distribución desigual.
3.  **Brecha Estructural:** Los "Tres Grandes" (Colo-Colo, U. de Chile, UC) capturan el **18.1%** de los ingresos totales, mientras que un equipo promedio de la B recibe **4 veces menos** recursos que uno de la élite.
4.  **Eficiencia de Gestión:** Clubes como **Huachipato (Campeón 2023)** y **Cobresal (Campeón 2015)** demostraron ser "Outliers de Eficiencia", logrando títulos con presupuestos significativamente menores a los grandes.

---

## 🛠️ Stack Tecnológico

*   **Google BigQuery (SQL):** Almacenamiento, limpieza, transformación y cálculos complejos (Window Functions, CTEs).
*   **Tableau Desktop/Public:** Visualización avanzada, parámetros globales, cálculos LOD (Level of Detail) y diseño de interfaz (UI/UX).
*   **Excel/Google Sheets:** Recolección inicial de datos manual desde fuentes no estructuradas (PDFs de Estados Financieros).

---

## ⚙️ Ingeniería de Datos y Metodología (ETL)

El núcleo del proyecto fue la creación de una fuente de datos robusta a partir de información dispersa.

### 1. Recolección y Limpieza
*   Se extrajeron datos financieros de las **Memorias Anuales de la ANFP** y datos deportivos de fuentes públicas.
*   **Normalización de Entidades:** Se detectó y corrigió la inconsistencia histórica de **"Unión Temuco"**, unificando sus registros bajo **"Deportes Temuco"** tras su fusión en 2013, mediante sentencias `UPDATE` en SQL.

### 2. Transformación Avanzada en SQL (BigQuery)
Se crearon Vistas Materializadas para alimentar el dashboard:
*   **Ajuste por Inflación (IPC):** Se integró una tabla de índices económicos del Banco Central. Mediante SQL, se calculó el valor real de cada monto histórico traído a **Pesos de 2024**, permitiendo una comparación justa a lo largo de la década.
*   **Anualización de Datos:** Se desarrolló una lógica para consolidar los "Torneos Cortos" (Apertura/Clausura 2015-2017) en registros anuales únicos, sumando puntos y promediando posiciones para correlacionarlos con los ejercicios financieros anuales.

### 3. Manejo de Outliers y Casos Especiales
El análisis requirió decisiones críticas de negocio para mantener la integridad estadística:

*   **⛔ Exclusión Estructural (Wanderers y La Serena, 2020):** Se excluyeron estos registros del modelo de correlación. *Razón:* Debido a la cancelación de descensos en 2019, la liga tuvo más equipos en 2020, y estos clubes recibieron un monto de TV artificialmente reducido por decisión administrativa, lo que los convertía en outliers no representativos.
*   **✅ Inclusión Narrativa (Deportes Melipilla, 2021):** Se mantuvo en el dataset a pesar de ser un outlier extremo (bajo ingreso). *Razón:* El club completó la temporada deportivamente, pero sus ingresos fueron retenidos por sanciones administrativas (dobles contratos). Se utiliza en el dashboard como un caso de estudio sobre "Gestión vs. Sanción".
*   **⚠️ Limitación de Datos (Primera B 2015-2017):** El análisis de control de la Segunda División se centra en el periodo 2018-2024 debido a inconsistencias en la disponibilidad de datos públicos fidedignos para los años anteriores en esta categoría.

---

## 📊 Características del Dashboard

El producto final en Tableau implementa técnicas avanzadas de visualización:

1.  **Diseño "Landing Page":** Una portada de alto impacto visual con navegación oculta para mejorar la experiencia de usuario.
2.  **Interactividad Global:** Un **Parámetro de Año** controla todas las hojas simultáneamente, recalculando rankings y distribuciones al vuelo.
3.  **Sheet Swapping (Intercambio de Hojas):** Implementación de lógica condicional para mostrar mensajes de "Sin Datos Disponibles" o "Seleccione un Año" dinámicamente, ocultando los gráficos vacíos.
4.  **Gráficos Avanzados:**
    *   **Scatter Plots Comparativos:** Primera vs. Segunda División.
    *   **Gráfico Tornado:** Comparación de Inversión vs. Eficiencia (Costo por Punto).

---
*Proyecto desarrollado como parte de un portafolio de Data Analytics. Los datos son aproximaciones basadas en información pública y pueden tener márgenes de error respecto a la contabilidad interna de los clubes.*
