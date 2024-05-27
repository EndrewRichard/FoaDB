select c.z1_curso, cl.zac_turno, c.z1_nm_curs, cl.zac_loja, a.a1_academ, a.a1_nome, a.a1_prof, a.a1_cgc, a.a1_dtnasc, a.a1_raca, a.a1_rf_pare,
       a.a1_rf_nome, a.a1_rfecivi, a.a1_rfnacio, a.a1_rf_prof, a.a1_rf_iden, a.a1_rf_oemi, a.a1_rf_uf, a.a1_rf_cpf, a.a1_rf_end, a.a1_rf_num, a.a1_rf_apto,
       a.a1_rf_comp,a.a1_rf_bair,a.a1_rf_cid,a.a1_rf_est,a.a1_rf_cep,a.a1_rf_nasc,a.a1_rl_pare,a.a1_rl_nome,a.a1_rlecivi,
       a.a1_rlnacio, a.a1_rl_prof, a.a1_rl_iden, a.a1_rl_oemi, a.a1_rl_uf, a.a1_rl_cpf, a.a1_rl_end, a.a1_rl_num,
       a.a1_rl_apto,
       a.a1_rl_comp,
       a.a1_rl_bair,
       a.a1_rl_cid,
       a.a1_rl_est,
       a.a1_rl_cep,
       a.a1_rl_nasc,
       (case when cl.zac_pfies > 0 then 'S' else 'N' end) tem_fies,
       cl.zac_origem,
       cl.zac_fiesa,
       cl.zac_reprov,
       nvl(dp.qtd, 0)                                     qtd_doc_pendente,
       nvl(dp.qtd_militar, 0)                             bl_existe_pend_doc_militar,
       (case
            when (months_between(sysdate, to_date(a1_dtnasc, 'yyyymmdd')) / 12) < 18 then 'N'
            else 'S' end)                                 maior_de_idade
from siga.sa1010 a
         inner join siga.zac010 cl on cl.zac_codcli = a.a1_cod and cl.zac_loja = a.a1_loja
         inner join siga.sed010 n on cl.zac_loja = n.ed_loja and cl.zac_natcod = n.ed_codigo
         inner join siga.sz1010 c on c.z1_naturez = n.ed_codigo
         left join (select nu_matricula, count(*) qtd, sum(case when cd_documento = '406' then 1 else 0 end) qtd_militar
                    from timesheet.tb_doc_pendente
                    where dt_baixa is null
                    group by nu_matricula) dp on dp.nu_matricula = a.a1_academ
where n.ed_class = 'G'
  and c.z1_cd_nive <> 'M'
  and cl.zac_situac = 'N'
  and a.d_e_l_e_t_ <> '*'
  and c.d_e_l_e_t_ <> '*'
  and n.d_e_l_e_t_ <> '*'
  and cl.d_e_l_e_t_ <> '*'
  and a.a1_academ not in ('202210476')
  and a.a1_academ in ('202220343')
  and (nvl(trim(cl.zac_pfies), 0) = 0 or
       (nvl(trim(cl.zac_pfies), 0) > 0 and cl.zac_fiesa <> '1' and cl.zac_reprov <> '3'))
  and not exists(select distinct 1
                 from timesheet.tb_sac
                 where tp_modulo = '080'
                   and lower(tp_evento) = 'cancelamento'
                   and nu_matricula_solicitante = a.a1_academ
                   and extract(year from dt_solicitacao) = extract(year from sysdate)
                   and extract(month from dt_solicitacao) <=
                       (case when extract(month from sysdate) <= 6 then 6 else 12 end)
                   and dt_fim_sac is null)
  and a.a1_academ not in (select v.a1_academ from siga.vw_matdebfin v)
  and a.a1_academ not in
      (select nu_matricula from timesheet.tb_matricula_antiga where pse = 'JAN_2024' and nvl(d_e_l_e_t_, ' ') <> '*')
  and not exists(select 1
                 from siga.tb_controle_matricula
                 where id_proc_matricula = 'JAN_2024' and nu_matricula = a.a1_academ)
  and rownum < 201
order by c.z1_curso