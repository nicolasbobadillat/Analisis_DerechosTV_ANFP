WITH rendimiento_parcial_y_completo AS (
  -- Agrupa los datos de TORNEOS CORTOS (2014-2017)
  SELECT
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) AS Anio,
    Club,
    SUM(Puntos_Totales) AS Puntos_Totales,
    SUM(G) AS G, SUM(E) AS E, SUM(P) AS P, SUM(GF) AS GF, SUM(GC) AS GC,
    -- =========== AQUÍ ESTÁ EL CAMBIO ============
    MIN(Posicion_Final) AS Mejor_Posicion_Anual,
    -- =============================================
    COUNT(Temporada) AS Torneos_Jugados_en_Anio
  FROM
    `proyecto-futbol-chileno.futbol_data.rendimiento_deportivo`
  WHERE
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) <= 2017 AND Division = 'Primera'
  GROUP BY
    Anio, Club
  
  UNION ALL

  -- Toma los datos de los TORNEOS LARGOS (2018 en adelante)
  SELECT
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) AS Anio,
    Club,
    Puntos_Totales,
    G, E, P, GF, GC,
    -- =========== AQUÍ TAMBIÉN CAMBIAMOS EL NOMBRE PARA QUE LA COLUMNA SEA CONSISTENTE ============
    Posicion_Final AS Mejor_Posicion_Anual,
    -- =========================================================================================
    1 AS Torneos_Jugados_en_Anio
  FROM
    `proyecto-futbol-chileno.futbol_data.rendimiento_deportivo`
  WHERE
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) > 2017 AND Division = 'Primera'
),
-- Bloque 2: CTE para obtener el IPC del año base
ipc_base AS (
  SELECT Valor_IPC_Indice
  FROM `proyecto-futbol-chileno.futbol_data.vw_ipc_indice`
  ORDER BY Anio DESC
  LIMIT 1
)

-- Bloque final: Unimos todo, calculamos el monto ajustado y aplicamos el filtro
SELECT
  r.*, -- r.* selecciona todas las columnas de la CTE rendimiento_parcial_y_completo
  f.Monto_Distribuido AS Monto_Distribuido_Nominal,
  ROUND(f.Monto_Distribuido * (ipc_base.Valor_IPC_Indice / ipc.Valor_IPC_Indice)) AS Monto_Ajustado,
  (r.GF - r.GC) AS Diferencia_Goles
FROM
  rendimiento_parcial_y_completo AS r
JOIN
  `proyecto-futbol-chileno.futbol_data.finanzas_clubes` AS f ON r.Anio = f.Temporada AND r.Club = f.Club
JOIN
  `proyecto-futbol-chileno.futbol_data.vw_ipc_indice` AS ipc ON r.Anio = ipc.Anio
CROSS JOIN
  ipc_base
WHERE
  -- Mantenemos la exclusión de los outliers estructurales de 2020
  NOT (r.Anio = 2020 AND r.Club IN ('Santiago Wanderers', 'Deportes La Serena'))