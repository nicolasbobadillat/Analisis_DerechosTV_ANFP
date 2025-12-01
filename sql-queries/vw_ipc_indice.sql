-- Este código crea el índice IPC a partir de las tasas de inflación anuales.
SELECT
  Anio,
  -- Calculamos el índice IPC acumulativo usando funciones de ventana
  100 * EXP(SUM(LN(1 + (Valor_IPC / 100))) OVER (ORDER BY Anio)) AS Valor_IPC_Indice
FROM
  `proyecto-futbol-chileno.futbol_data.ipc_historico` -- Asegúrate que el nombre de la tabla sea correcto