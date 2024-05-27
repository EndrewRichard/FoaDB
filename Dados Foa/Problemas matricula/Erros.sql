-- VERIFICAÇÃO DE LOGS----------------------------------------------
-- WARNINGS ATÉ O ÚLTIMO DIA
SELECT
    SIGA.B2C(LOG_MESSAGE),
    TO_CHAR(LOG_DATE, 'HH24:MI')
FROM
    "JADIR.ALVES".TB_SYS_LOG
WHERE
    LOG_TIPO = 'WARNING'
  AND LOG_DATE >= SYSDATE - 1;
-------------------------------------------------------------------
-- ERROS ATÉ O ÚLTIMO DIA
SELECT
    SIGA.B2C(LOG_MESSAGE),
    TO_CHAR(LOG_DATE, 'HH24:MI')
FROM
    "JADIR.ALVES".TB_SYS_LOG
WHERE
    LOG_TIPO = 'ERRO'
  AND LOG_DATE >= SYSDATE - 1;
-------------------------------------------------------------------
-- DEBUGS ATÉ O ÚLTIMO DIA
SELECT
    SIGA.B2C(LOG_MESSAGE),
    TO_CHAR(LOG_DATE, 'HH24:MI')
FROM
    "JADIR.ALVES".TB_SYS_LOG
WHERE
    LOG_TIPO = 'DEBUG'
  AND LOG_DATE >= SYSDATE - 1
-------------------------------------------------------------------
-- INFOS ATÉ O ÚLTIMO DIA
SELECT
    SIGA.B2C(LOG_MESSAGE),
    TO_CHAR(LOG_DATE, 'HH24:MI')
FROM
    "JADIR.ALVES".TB_SYS_LOG
WHERE
    LOG_TIPO = 'INFO'
  AND LOG_DATE >= SYSDATE - 1;
-------------------------------------------------------------------