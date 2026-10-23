-- Query recebida da TI: itens de pedido.
-- Mantida exatamente como foi entregue (sem padronização, aliases inconsistentes,
-- sem o número da carga, sem filtro de status).
SELECT NUM_PED, SEQ_ITE, NUM_PEDORI, TIP_MOV, STA_PED, DTA_PED, DTA_FAT,
COD_CLI AS Cliente, COD_PRO, COD_VEN AS Vend, COD_CAN,
QTD_ITE, VLR_UNITAB, PCT_DESC, VLR_BRU, VLR_DESC, VLR_LIQ AS Valor, VLR_CUSTO
FROM PEDITE
