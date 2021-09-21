SELECT DISTINCT
    A.CUE_CONT          AS CUE_CONT,
    A.EMP_CODI          AS EMP_CODI,
    A.CUE_CODI 		    AS CUE_CODI,
    A.CUE_MAPR          AS CUE_MAPR,
    A.CUE_NOMB          AS CONCEPTO,
    B.TCU_CODI		    AS COD_CLASE,
    CASE 
        when B.TCU_CODI >=1  and B.TCU_CODI <21 then 'Ingresos'
        when B.TCU_CODI >=21 and B.TCU_CODI <42 then 'Gastos'
        when B.TCU_CODI =42  then 'Inversiones'
        when B.TCU_CODI =43  then 'Pasivos'
    end                 AS CLASE,
    C.TCU_NOMB		    AS GRUPO
FROM CN_CUENT A 
    LEFT JOIN SEVEN.PF_DTCUE B
        ON A.CUE_CONT = B.CUE_CONT 
        AND A.EMP_CODI = B.EMP_CODI
    LEFT JOIN SEVEN.PF_TCUEN C
        ON B.TCU_CODI = C.TCU_CODI 
        AND C.EMP_CODI = C.EMP_CODI
WHERE B.TCU_CODI IS NOT NULL
