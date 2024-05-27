-- 0 - ALTERE E EXECUTE A DECLARAÇÃO DAS VARIÁVEIS PRIMEIRO
DEFINE MATRICULA_BASE = "'05852'";

DEFINE USUARIO_BASE = "'endrew.ferreira'";

DEFINE MATRICULA_NOVA = "'05002'";

DEFINE USUARIO_NOVO = "'ariene.alves'";

-- 1 - Buscar informações do usuário base com permissões a se copiar
select
    * from TIMESHEET.TB_SYS_USUARIO_PERFIL;


SELECT
    USR.USER_ID        USUARIOID,
    PERF.PERF_ID       PERFIL,
    USR.USER_NICK      USUARIO,
    USR.USER_MATRICULA MATRICULA
FROM
    TIMESHEET.TB_SYS_USUARIO USR
     INNER JOIN TIMESHEET.TB_SYS_USUARIO_PERFIL PERF
     ON PERF.USER_ID = USR.USER_ID
WHERE
    USER_NICK = 'endrew.ferreira'
   OR USER_MATRICULA = '05852';

-- 2 - Inserir usuário novo (APENAS SE O USUÁRIO NOVO NÃO ESTIVER NA TABELA)
INSERT INTO TIMESHEET.TB_SYS_USUARIO(
    USER_ID,
    USER_NICK,
    USER_MATRICULA,
    USER_ATIVO
) VALUES(
            (SELECT MAX(USER_ID) + 1 FROM TIMESHEET.TB_SYS_USUARIO),
            LOWER(&USUARIO_NOVO),
            &MATRICULA_NOVA,
            'S'
        );

COMMIT;

-- 3 - Verifica usuário novo criado para obter o USER_ID
SELECT
    *
FROM
    TIMESHEET.TB_SYS_USUARIO
WHERE
    USER_NICK like 'endrew%';

-- 4 - Inserir usuário novo no perfil
INSERT INTO TIMESHEET.TB_SYS_USUARIO_PERFIL(
    USER_ID,
    PERF_ID
) VALUES(
            277, -- Altere aqui o ID do novo usuário de acordo com a query 3
            37 -- Altere aqui o ID do PERFIL conforme a query 1
        );

COMMIT;

SELECT
    *
FROM
    TIMESHEET.TB_SYS;

SELECT
    *
FROM
    TIMESHEET.TB_SYS_PERFIL;

SELECT
    *
FROM
    TIMESHEET.TB_SYS_PERMISSAO;

SELECT
    *
FROM
    TIMESHEET.TB_SYS_FUNCAO;

/*
Query de referência da checagem de permissões*/
select SYS_NOME, FUNC_NOME, SYS_ALIAS, USER_PERFIS, USER_NICK
from TIMESHEET.TB_SYS_FUNCAO func
join TIMESHEET.TB_SYS sis on sis.SYS_ID = func.FUNC_SYS_ID
join TIMESHEET.TB_SYS_PERMISSAO perm on perm.PERM_FUNC_ID = func.FUNC_ID
join TIMESHEET.TB_SYS_USUARIO usua on usua.USER_ID = perm.PERM_USER_ID
union
select SYS_NOME, FUNC_NOME, SYS_ALIAS, USER_PERFIS, USER_NICK
from TIMESHEET.TB_SYS_FUNCAO func
join TIMESHEET.TB_SYS sis on sis.SYS_ID = func.FUNC_SYS_ID
join TIMESHEET.TB_SYS_PERMISSAO perm on perm.PERM_FUNC_ID = func.FUNC_ID
join TIMESHEET.TB_SYS_PERFIL perf on perf.PERFIL_ID = perm.PERM_PERFIL_ID
join TIMESHEET.TB_SYS_USUARIO usua on USER_PERFIS like '%'|| PERFIL_COD||'%' or perm.PERM_USER_ID = USER_ID
where USER_NICK = 'luiz.claudio' and SYS_ALIAS = 'vestibular.online.gerenciador';
