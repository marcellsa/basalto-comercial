-- Diagnóstico 6: o que a query da TI mistura no mesmo resultado.
-- Pedidos cancelados (sem faturamento) e devoluções (valor negativo) vêm junto com as vendas.
SELECT STA_PED                  AS Status,
       TIP_MOV                  AS Movimento,
       COUNT(*)                 AS Linhas,
       ROUND(SUM(VLR_LIQ), 2)   AS Valor_Liquido,
       SUM(CASE WHEN DTA_FAT IS NULL THEN 1 ELSE 0 END) AS Sem_Data_Faturamento
FROM PEDITE
GROUP BY STA_PED, TIP_MOV;
