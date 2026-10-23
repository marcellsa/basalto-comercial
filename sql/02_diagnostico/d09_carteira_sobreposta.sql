-- Diagnóstico 9: depois de unificar clientes por CNPJ, algum cliente fica com dois
-- vendedores de carteira ao mesmo tempo?
-- Efeito: ao cruzar venda x carteira por cliente e data, a linha de venda duplica.
WITH mestre AS (
    SELECT COD_CLI,
           FIRST_VALUE(COD_CLI) OVER (PARTITION BY COALESCE(NUM_CNPJ, COD_CLI)
                                      ORDER BY DTA_CAD, COD_CLI) AS COD_MESTRE
    FROM CADCLI
),
carteira AS (
    SELECT M.COD_MESTRE, C.COD_CLI, C.COD_VEN, C.DTA_INI, COALESCE(C.DTA_FIM, '9999-12-31') AS DTA_FIM
    FROM CARCLI C
    INNER JOIN mestre M ON M.COD_CLI = C.COD_CLI
)
SELECT A.COD_MESTRE        AS Cliente_Mestre,
       A.COD_CLI           AS Codigo_A, A.COD_VEN AS Vendedor_A, A.DTA_INI AS Inicio_A,
       B.COD_CLI           AS Codigo_B, B.COD_VEN AS Vendedor_B, B.DTA_INI AS Inicio_B
FROM carteira A
INNER JOIN carteira B
        ON B.COD_MESTRE = A.COD_MESTRE
       AND B.COD_CLI > A.COD_CLI                    -- pares de códigos diferentes
       AND B.DTA_INI <= A.DTA_FIM AND A.DTA_INI <= B.DTA_FIM;   -- períodos que se cruzam
