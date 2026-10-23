-- Diagnóstico 3: códigos de produto da venda que não encontram o cadastro.
-- Num relacionamento exato, essas linhas ficam sem produto (categoria, coleção) nos relatórios.
-- Teste da correção: depois de UPPER(TRIM()), quantas passam a encontrar o cadastro?
SELECT P.COD_CAN                                         AS Canal,
       COUNT(*)                                          AS Linhas_Sem_Cadastro,
       COUNT(DISTINCT P.COD_PRO)                         AS Codigos_Distintos,
       ROUND(SUM(P.VLR_LIQ), 2)                          AS Receita_Sem_Produto,
       SUM(CASE WHEN C2.COD_PRO IS NOT NULL THEN 1 ELSE 0 END) AS Corrigidas_Com_Upper_Trim,
       MIN(P.COD_PRO)                                    AS Exemplo_Como_Veio
FROM PEDITE P
LEFT JOIN CADPRO C  ON C.COD_PRO  = P.COD_PRO
LEFT JOIN CADPRO C2 ON C2.COD_PRO = UPPER(TRIM(P.COD_PRO))
WHERE C.COD_PRO IS NULL
GROUP BY P.COD_CAN;
