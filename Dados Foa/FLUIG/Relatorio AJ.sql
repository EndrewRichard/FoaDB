SELECT
    tp.NUM_PROCES AS Fluig,
    fu.FULL_NAME AS Nome,
    tp.START_DATE AS Inicio,
    tp.END_DATE AS Fim,
    dp.DES_DEF_PROCES AS Processo


FROM
    TAR_PROCES tp
        INNER JOIN
    FDN_USERTENANT fut ON tp.CD_MATRICULA = fut.IDP_ID
        INNER JOIN
    FDN_USER fu ON fut.USER_ID = fu.USER_ID
        INNER JOIN
    PROCES_WORKFLOW pw ON tp.NUM_PROCES = pw.NUM_PROCES
        INNER JOIN
    DEF_PROCES dp ON pw.COD_DEF_PROCES = dp.COD_DEF_PROCES
WHERE
    fut.EMAIL = 'marina.carvalho@foa.org.br';


select DES_DEF_PROCES from  DEF_PROCES;

select * from  ESTADO_PROCES_TRIGGER;