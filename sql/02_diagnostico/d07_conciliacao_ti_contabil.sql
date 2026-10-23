-- Diagnóstico 7: a receita da query da TI bate com a contabilidade?
-- Mês = 7 primeiros caracteres da data (as datas chegam como texto AAAA-MM-DD).
-- T-SQL equivalente: FORMAT(DTA_FAT, 'yyyy-MM').
WITH ti AS (
    SELECT SUBSTRING(DTA_FAT, 1, 7) AS Mes, COD_CAN, SUM(VLR_LIQ) AS Receita_TI
    FROM PEDITE
    WHERE STA_PED = 'FATURADO'
    GROUP BY SUBSTRING(DTA_FAT, 1, 7), COD_CAN
)
SELECT C.COD_CAN                                   AS Canal,
       COUNT(*)                                    AS Meses,
       SUM(CASE WHEN ROUND(T.Receita_TI - C.VLR_RECLIQ, 2) <> 0 THEN 1 ELSE 0 END) AS Meses_Divergentes,
       ROUND(SUM(T.Receita_TI), 2)                 AS Receita_TI,
       ROUND(SUM(C.VLR_RECLIQ), 2)                 AS Receita_Contabil,
       CASE WHEN ABS(SUM(T.Receita_TI - C.VLR_RECLIQ)) < 0.005 THEN 0
            ELSE ROUND(SUM(T.Receita_TI - C.VLR_RECLIQ), 2) END AS Diferenca
FROM CTBREC C
LEFT JOIN ti T ON T.Mes = SUBSTRING(C.DTA_MES, 1, 7) AND T.COD_CAN = C.COD_CAN
GROUP BY C.COD_CAN;
