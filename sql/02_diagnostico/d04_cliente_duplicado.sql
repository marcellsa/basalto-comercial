-- Diagnóstico 4: o mesmo CNPJ cadastrado com mais de um código de cliente.
-- Efeito: o histórico do cliente fica dividido (ranking, curva ABC e inatividade erram).
SELECT NUM_CNPJ,
       COUNT(*)            AS Qtd_Codigos,
       MIN(COD_CLI)        AS Codigo_Mais_Antigo,
       MAX(COD_CLI)        AS Codigo_Mais_Novo,
       MIN(NOM_FAN)        AS Nome_1,
       MAX(NOM_FAN)        AS Nome_2
FROM CADCLI
WHERE NUM_CNPJ IS NOT NULL
GROUP BY NUM_CNPJ
HAVING COUNT(*) > 1;
