-- Diagnóstico 2: as linhas repetidas são idênticas? O que as diferencia?
-- Resposta: só o número da carga (NUM_CARGA), campo que a query da TI não traz.
-- Conclusão: é reenvio da integração, não venda nova. Mantém-se a primeira carga.
SELECT P.NUM_CARGA, P.NUM_PED, P.SEQ_ITE, P.DTA_FAT, P.COD_PRO, P.QTD_ITE, P.VLR_LIQ
FROM PEDITE P
INNER JOIN (
    SELECT NUM_PED, SEQ_ITE
    FROM PEDITE
    WHERE TIP_MOV = 'VENDA'
    GROUP BY NUM_PED, SEQ_ITE
    HAVING COUNT(*) > 1
) D ON D.NUM_PED = P.NUM_PED AND D.SEQ_ITE = P.SEQ_ITE
ORDER BY P.NUM_PED, P.SEQ_ITE, P.NUM_CARGA
LIMIT 10;   -- T-SQL: SELECT TOP 10
