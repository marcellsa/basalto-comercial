-- Diagnóstico 1: itens de pedido que aparecem mais de uma vez.
-- A chave natural de um item é pedido + sequência. Se ela repete, a receita soma duas vezes.
WITH repetidos AS (
    SELECT NUM_PED, SEQ_ITE, COD_CAN,
           COUNT(*)              AS QTD_OCORRENCIAS,
           MIN(VLR_LIQ)          AS VLR_LIQ_ITEM
    FROM PEDITE
    WHERE STA_PED = 'FATURADO'
    GROUP BY NUM_PED, SEQ_ITE, COD_CAN
    HAVING COUNT(*) > 1
)
SELECT COD_CAN                                        AS Canal,
       COUNT(*)                                       AS Itens_Duplicados,
       SUM(QTD_OCORRENCIAS - 1)                       AS Linhas_Excedentes,
       ROUND(SUM((QTD_OCORRENCIAS - 1) * VLR_LIQ_ITEM), 2) AS Receita_Inflada
FROM repetidos
GROUP BY COD_CAN;
