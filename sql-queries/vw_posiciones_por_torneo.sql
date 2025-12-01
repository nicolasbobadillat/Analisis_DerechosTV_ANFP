SELECT
  -- Usamos una función para crear una etiqueta de torneo ordenada cronológicamente
  -- Ej: '2015 - Clausura', '2015 - Apertura'
  CASE
    WHEN Temporada LIKE '%Clausura%' THEN CONCAT(SUBSTR(Temporada, 1, 4), ' - 1. Clausura')
    WHEN Temporada LIKE '%Apertura%' THEN CONCAT(SUBSTR(Temporada, 1, 4), ' - 2. Apertura')
    ELSE Temporada
  END AS Torneo_Etiqueta,
  
  Club,
  Posicion_Final,
  Puntos_Totales,
  G, E, P, GF, GC,
  (GF - GC) AS Diferencia_Goles
FROM
  `proyecto-futbol-chileno.futbol_data.rendimiento_deportivo`
WHERE
  Division = 'Primera'
ORDER BY
  Torneo_Etiqueta;