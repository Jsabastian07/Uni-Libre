SELECT
    d.cod_unidad,
    sd.cod_seccional,
    b.cod_periodo,
    SUBSTR(a.nom_unidad,1,100) nom_unidad,
    j.cod_cen_costo,
    h.num_niv_cursa nivel,
    a.id_sede,
    a.id_dependencia,
    i.nom_dependencia,
    (SELECT nom_tabla FROM SRC_GENERICA aa WHERE aa.tip_tabla = 'TIPMOD' and aa.cod_tabla = a.cod_modalidad)nom_modalidad, 
    a.cod_modalidad,
    COUNT(1) total
FROM
    SRC_UNI_ACADEMICA a,
    SRC_EST_ALUMNO b,
    SRC_ALUM_PROGRAMA d,
    BAS_TERCERO e,
    SRC_ENC_LIQUIDACION f,
    SRC_ALUM_PERIODO h,
    BAS_DEPENDENCIA i,
    BAS_CEN_COSTO j,
    SRC_SEDE c,
    (select id_sede, cod_auxiliar1   as cod_seccional from SRC_SEDE LEFT JOIN src_generica ON cod_sede = cod_tabla where tip_tabla='SEVSUC') sd
WHERE 
    a.id_sede              = sd.id_sede
    AND a.cod_unidad       = d.cod_unidad
    AND b.cod_periodo      = f.cod_periodo
    AND b.id_tercero       = d.id_tercero
    AND b.id_alum_programa = d.id_alum_programa
    AND b.cod_unidad       = a.cod_unidad
    AND b.cod_pensum       = d.cod_pensum
    AND h.cod_periodo      = f.cod_periodo
    AND h.id_alum_programa = d.id_alum_programa
    AND d.id_alum_programa = f.id_alum_programa
    AND d.id_tercero       = e.id_tercero
    AND b.id_sede          = a.id_sede
    AND i.id_dependencia = a.id_dependencia
    AND a.cod_modalidad    = to_char(b.cod_modalidad)
    AND f.tip_liquidacion  = 1
    AND b.ind_mat_fin      = 1
    AND b.ind_mat_aca      = 1
    AND EXISTS (SELECT 1 FROM SRC_ENC_MATRICULA g WHERE g.cod_periodo    = '20211' AND g.id_alum_programa = d.id_alum_programa)
    AND b.cod_periodo       = h.cod_periodo
    AND h.cod_periodo       = '20211'
    AND j.id_cen_costo      = a.id_cen_costo
GROUP BY a.id_sede,a.cod_modalidad,a.id_dependencia,i.nom_dependencia,  j.cod_cen_costo, d.cod_unidad,b.cod_periodo,a.nom_unidad,h.num_niv_cursa, sd.cod_seccional;