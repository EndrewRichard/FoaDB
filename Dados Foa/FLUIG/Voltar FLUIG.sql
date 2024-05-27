--Trocar etapa
-- Primeiro ordenar por NUM_SEQ_MOVTO
-- Depois selecionar a ultima e procurar o campo NUM_SEQ_ESTADO
-- Copiar o valor de cima (do penultimo) para a linha que vc quer editar (a ultima)
-- Dar commit e executar o outro select
select * from HISTOR_PROCES where NUM_PROCES in ('201609');

--Trocar responsavel
-- Primeiro ordenar por NUM_SEQ_MOVTO
-- Depois selecionar a ultima e procurar o campo CD_MATRICULA
-- Copiar o valor de cima (do penultimo) para a linha que vc quer editar (a ultima)
-- Dar commit e ir la conferir
select * from TAR_PROCES where CD_MATRICULA in ('gwcaaprvltqkfpqm1544611587294');


select * from  FDN_USERTENANT where IDP_ID in ('gwcaaprvltqkfpqm1544611587294');


SELECT
    fdn_accesslog.ACCESSLOG_ID,
    fdn_accesslog.LOGIN,
    fdn_accesslog.ACCESS_DATE,
    fdn_usertenant.TENANT_ID,
    fdn_usertenant.USER_STATE
FROM (
         SELECT
             fdn_accesslog.*,
             ROW_NUMBER() OVER (PARTITION BY LOGIN ORDER BY ACCESS_DATE DESC) AS rn
         FROM
             fdn_accesslog
     ) fdn_accesslog
         JOIN FDN_USERTENANT fdn_usertenant ON fdn_accesslog.LOGIN = fdn_usertenant.LOGIN
WHERE fdn_accesslog.rn = 1;


select COD_DEF_PROCES, DES_DEF_PROCES from  DEF_PROCES;