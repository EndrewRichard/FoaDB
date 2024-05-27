select distinct
    crr_id_curriculo,
    crr_st_modalidade_ensino,
    crs_id_tp_curso
from
    cpa_classes_pacote cpa
        inner join cla_classe cla
                   on cpa.cpa_id_classe = cla.cla_id_classe
        inner join pel_periodo_letivo pel
                   on cla.cla_id_periodo_letivo = pel.pel_id_periodo_letivo
        inner join pac_pacote pac
                   on pac.pac_id_pacote = cpa.cpa_id_pacote
        inner join crs_curso crs
                   on crs.crs_id_curso = pac.pac_id_curso
        inner join gcr_grade_curricular gcr
                   on gcr.gcr_id_atividade = cla.cla_id_atividade_curricular
        inner join crr_curriculo crr
                   on gcr.gcr_id_curriculo = crr.crr_id_curriculo
                       and crr.crr_id_curso = crs.crs_id_curso
        inner join pse_processo_seletivo pse
                   on pse.pse_id_periodo_letivo = pac.pac_id_periodo_letivo
        inner join pec_periodo_concurso pec
                   on pec.pec_id_periodo_concurso = pse.pse_id_periodo_concurso
        inner join con_concurso con
                   on con.con_id_concurso = pec.pec_id_concurso
        inner join PEL_periodo_letivo pel1
                   on pel1.pel_id_periodo_letivo = pse.pse_id_periodo_letivo
        left join temp_curriculo tcur on
        tcur.semestre = pel1.pel_ds_compacta and
        tcur.id_curso = pac.pac_id_curso
where
    con.con_id_concurso = '<ID_CONCURSO AQUI>'
  and pac.pac_id_curso = '<ID_CURSO AQUI>'
  and pac.pac_ds_pacote like '%1%'
  and substring(gcr.gcr_nu_periodo_curriculo, 2, 1) = 1
  and(
    crr.crr_id_periodo_letivo_fim is null or
    tcur.id_curso is not null
    )