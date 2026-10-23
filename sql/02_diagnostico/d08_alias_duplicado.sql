-- Diagnóstico 8: a query de vendedores da TI devolve duas colunas chamadas "Nome"
-- (vendedor e supervisor). No Power Query a segunda vira "Nome.1" ou "Nome_1",
-- e ninguém sabe qual é qual. Não há query para rodar: o problema está no texto de
-- sql/01_ti_original/ti_vendedores.sql. A correção está em sql/03_staging/stg_vendedor.sql.
SELECT 'ti_vendedores.sql' AS Arquivo, 'Nome' AS Alias_Repetido, 2 AS Ocorrencias;
