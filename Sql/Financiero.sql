/*Cambia el squema y conexion para la data historica a partir del 2017*/
SELECT 
    SAL_ANOP,
    SAL_MESP,
    CUE_CONT,
    ARB_CECO,
    ARB_PROY,
    ARB_AREA,
    ARB_SUCU,
    GN_CECOS.arb_codi       as codi_cecos,
    GN_PROYE.arb_codi       as codi_proy,
    GN_AREAS.arb_codi       as codi_area,
    GN_SUCUR.arb_codi       as codi_sucur,
    SUM(SCE_VADB)SCE_VADB,
    SUM(SCE_VACR)SCE_VACR,
    0 SAL_VPRE,
    0 SAL_MOVI,
    0 SAL_TRAS,
    0 SAL_VRES
FROM SEVEN.CN_SALGE, SEVEN.GN_ARBOL GN_CECOS, SEVEN.GN_ARBOL GN_PROYE, SEVEN.GN_ARBOL GN_AREAS, SEVEN.GN_ARBOL GN_SUCUR
WHERE 1=1
    AND CN_SALGE.EMP_CODI = 231
    AND CN_SALGE.SAL_ANOP IN (2021,2020,2019,2018)		--> AÑO 
    AND CN_SALGE.SAL_MESP BETWEEN 1 AND 12 	            --> RANGO DE MESES 
    
    AND CN_SALGE.EMP_CODI = GN_CECOS.EMP_CODI 	
	AND CN_SALGE.ARB_CECO = GN_CECOS.ARB_CONT 
       
    AND CN_SALGE.EMP_CODI = GN_PROYE.EMP_CODI 
    AND CN_SALGE.ARB_PROY = GN_PROYE.ARB_CONT 
   
    AND CN_SALGE.EMP_CODI = GN_AREAS.EMP_CODI 
    AND CN_SALGE.ARB_AREA = GN_AREAS.ARB_CONT 

    AND CN_SALGE.EMP_CODI = GN_SUCUR.EMP_CODI 
    AND CN_SALGE.ARB_SUCU = GN_SUCUR.ARB_CONT 
GROUP BY SAL_ANOP,SAL_MESP,CUE_CONT,ARB_CECO,ARB_PROY,ARB_AREA,ARB_SUCU, GN_CECOS.arb_codi, GN_PROYE.arb_codi, GN_AREAS.arb_codi, GN_SUCUR.arb_codi

UNION

SELECT 
    SAL_ANOP,
    SAL_MESP,
    CUE_CONT,
    ARB_CECO,
    ARB_PROY,
    ARB_AREA,
    ARB_SUCU,
    GN_CECOS.arb_codi       as codi_cecos,
    GN_PROYE.arb_codi       as codi_proy,
    GN_AREAS.arb_codi       as codi_area,
    GN_SUCUR.arb_codi       as codi_sucur,
    0 SCE_VADB,
    0 SCE_VACR,
    SUM(SAL_VPRE)SAL_VPRE,
    SUM(SAL_VADI-SAL_VRED) SAL_MOVI,
    SUM(SAL_VTRS-SAL_VTRR) SAL_TRAS,
    SUM(SAL_VRES) SAL_VRES
FROM SEVEN.PF_SALDO, SEVEN.GN_ARBOL GN_CECOS, SEVEN.GN_ARBOL GN_PROYE, SEVEN.GN_ARBOL GN_AREAS, SEVEN.GN_ARBOL GN_SUCUR
WHERE 1=1
    AND PF_SALDO.EMP_CODI = 231
    AND PF_SALDO.SAL_ANOP IN (2021,2020,2019,2018)		-->AÑO 
    AND PF_SALDO.SAL_MESP BETWEEN 1 AND 12 	            -->RANGO DE MESES 
    
    AND PF_SALDO.EMP_CODI = GN_CECOS.EMP_CODI 	
    AND PF_SALDO.ARB_CECO = GN_CECOS.ARB_CONT 
    
    AND PF_SALDO.EMP_CODI = GN_PROYE.EMP_CODI 
    AND PF_SALDO.ARB_PROY = GN_PROYE.ARB_CONT 
    
    AND PF_SALDO.EMP_CODI = GN_AREAS.EMP_CODI 
    AND PF_SALDO.ARB_AREA = GN_AREAS.ARB_CONT 
    
    AND PF_SALDO.EMP_CODI = GN_SUCUR.EMP_CODI 
    AND PF_SALDO.ARB_SUCU = GN_SUCUR.ARB_CONT 
GROUP BY SAL_ANOP,SAL_MESP,CUE_CONT,ARB_CECO,ARB_PROY,ARB_AREA,ARB_SUCU, GN_CECOS.arb_codi, GN_PROYE.arb_codi, GN_AREAS.arb_codi, GN_SUCUR.arb_codi;