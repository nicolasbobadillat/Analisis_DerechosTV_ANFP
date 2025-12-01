-- Bloque 1: CTE para anualizar el rendimiento deportivo
WITH rendimiento_anual AS (
  -- Agrupa y suma los datos de los TORNEOS CORTOS (2014-2017)
  SELECT
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) AS Anio,
    Club,
    SUM(Puntos_Totales) AS Puntos_Totales,
    SUM(G) AS G,
    SUM(E) AS E,
    SUM(P) AS P,
    SUM(GF) AS GF,
    SUM(GC) AS GC,
    ROUND(AVG(Posicion_Final)) AS Posicion_Final_Promedio
  FROM
    `proyecto-futbol-chileno.futbol_data.rendimiento_deportivo`
  WHERE
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) <= 2017 AND Division = 'Primera'
  GROUP BY
    Anio, Club
  HAVING
    COUNT(Temporada) = 2 -- Solo incluye clubes que jugaron ambos torneos en el año

  UNION ALL

  -- Toma los datos de los TORNEOS LARGOS (2018 en adelante) tal como están
  SELECT
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) AS Anio,
    Club,
    Puntos_Totales,
    G, E, P, GF, GC,
    Posicion_Final AS Posicion_Final_Promedio
  FROM
    `proyecto-futbol-chileno.futbol_data.rendimiento_deportivo`
  WHERE
    CAST(SUBSTR(Temporada, 1, 4) AS INT64) > 2017 AND Division = 'Primera'
),
-- Bloque 2: CTE para obtener el IPC del año base usando nuestra vista de IPC
ipc_base AS (
  SELECT Valor_IPC_Indice
  FROM `proyecto-futbol-chileno.futbol_data.vw_ipc_indice` -- Usando tu vista con prefijo vw_
  ORDER BY Anio DESC
  LIMIT 1
)
-- Bloque final: Unimos todo, calculamos el monto ajustado y aplicamos el filtro final
SELECT
  ra.*,
  f.Monto_Distribuido AS Monto_Distribuido_Nominal,
  ROUND(f.Monto_Distribuido * (ipc_base.Valor_IPC_Indice / ipc.Valor_IPC_Indice)) AS Monto_Ajustado,
  (ra.GF - ra.GC) AS Diferencia_Goles
FROM
  rendimiento_anual AS ra
JOIN
  `proyecto-futbol-chileno.futbol_data.finanzas_clubes` AS f ON ra.Anio = f.Temporada AND ra.Club = f.Club
JOIN
  `proyecto-futbol-chileno.futbol_data.vw_ipc_indice` AS ipc ON ra.Anio = ipc.Anio -- Usando tu vista con prefijo vw_
CROSS JOIN
  ipc_base
WHERE
  -- Filtro para excluir los outliers estructurales de 2020
  NOT (ra.Anio = 2020 AND ra.Club IN ('Santiago Wanderers', 'Deportes La Serena'))