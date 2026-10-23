-- Diagnóstico 5: linhas de venda sem vendedor, por canal.
-- Nos canais diretos (B2C) não existe vendedor; no Power BI isso vira "(Em branco)".
SELECT COD_CAN                                              AS Canal,
       COUNT(*)                                             AS Linhas,
       SUM(CASE WHEN COD_VEN IS NULL THEN 1 ELSE 0 END)     AS Linhas_Sem_Vendedor,
       ROUND(SUM(CASE WHEN COD_VEN IS NULL THEN VLR_LIQ ELSE 0 END), 2) AS Receita_Sem_Vendedor
FROM PEDITE
GROUP BY COD_CAN;
