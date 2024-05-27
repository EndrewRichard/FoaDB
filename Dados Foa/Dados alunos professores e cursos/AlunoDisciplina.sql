select * from zb9

SELECT * FROM SIGA.ZB9010


SELECT *
FROM SIGA.ZB9010
WHERE D_E_L_E_T_ <> '*'


Select * from siga.zgk010 on ZGK_MAT = V_SRA010.RA_MAT where RA_SITFOLH <> 'D'
            AND V_SRA010.D_E_L_E_T_ <> '*' AND ZGK_TIPO ='SUP'  order by ZGK_NOME;