-- Vista que consolida los datos anualizados SOLO para la Segunda División
WITH rendimiento_anual_segunda AS (
  -- Agrupa los datos de TORNEOS CORTOS (2014-2017)
  SELECT
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) AS Anio, Club, SUM(Puntos_Totales) AS Puntos_Totales,
    SUM(G) AS G, SUM(E) AS E, SUM(P) AS P, SUM(GF) AS GF, SUM(GC) AS GC,
    MIN(Posicion_Final) AS Mejor_Posicion_Anual
  FROM `proyecto-futbol-chileno.futbol_data.rendimiento_deportivo`
  -- ============ ¡AQUÍ ESTÁ EL CAMBIO! ============
  WHERE CAST(SUBSTR(Temporada, 1, 4) AS INT64) <= 2017 AND Division = 'Primera B' -- Reemplaza 'Primera B' con el nombre exacto que usaste
  -- =============================================
  GROUP BY Anio, Club
  HAVING COUNT(Temporada) = 2

  UNION ALL

  -- Toma los datos de los TORNEOS LARGOS (2018 en adelante)
  SELECT
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) AS Anio, Club, Puntos_Totales,
    G, E, P, GF, GC, Posicion_Final AS Mejor_Posicion_Anual
  FROM `proyecto-futbol-chileno.futbol_data.rendimiento_deportivo`
  -- ============ ¡AQUÍ ESTÁ EL CAMBIO! ============
  WHERE CAST(SUBSTR(Temporada, 1, 4) AS INT64) > 2017 AND Division = 'Segunda' -- Reemplaza 'Primera B' con el nombre exacto que usaste
  -- =============================================
),
ipc_base AS (
  SELECT Valor_IPC_Indice FROM `proyecto-futbol-chileno.futbol_data.vw_ipc_indice` ORDER BY Anio DESC LIMIT 1
)
SELECT
  ra.*,
  f.Monto_Distribuido AS Monto_Distribuido_Nominal,
  ROUND(f.Monto_Distribuido * (ipc_base.Valor_IPC_Indice / ipc.Valor_IPC_Indice)) AS Monto_Ajustado,
  (ra.GF - ra.GC) AS Diferencia_Goles,
  -- ============== ¡AQUÍ ESTÁ LA NUEVA LÍNEA! ==============
  ROUND(f.Monto_Distribuido * (ipc_base.Valor_IPC_Indice / ipc.Valor_IPC_Indice)) + (RAND() - 0.5) * 300000 AS Monto_Ajustado_Jitter
FROM
  rendimiento_anual_segunda AS ra
JOIN
  `proyecto-futbol-chileno.futbol_data.finanzas_clubes` AS f ON ra.Anio = f.Temporada AND ra.Club = f.Club
JOIN
  `proyecto-futbol-chileno.futbol_data.vw_ipc_indice` AS ipc ON ra.Anio = ipc.Anio
CROSS JOIN
  ipc_base;