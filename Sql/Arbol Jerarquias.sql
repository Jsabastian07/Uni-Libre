--TAR_CODI: DEL 1: AREAS 2:SUCURSALES 3: CECOS AL 4: PROYECTOS


--Proyectos
SELECT DISTINCT
    arb_cont        as arb_proy,
    Nivel1,
    Nivel2,
    arb_nomb        as Nivel3,
    a.arb_codi      as Cod_Proyecto
FROM GN_ARBOL a
Left Join ( SELECT DISTINCT
                arb_codi,
                arb_nomb    as Nivel2
            FROM GN_ARBOL
            WHERE 1=1
            AND emp_codi='231'
            AND tar_codi=4
            AND LENGTH(arb_codi)= 4) Prog
on SUBSTR(a.arb_codi,0,4) = Prog.arb_codi
Left Join ( SELECT DISTINCT
                arb_codi,
                arb_nomb    as Nivel1
            FROM GN_ARBOL
            WHERE 1=1
            AND emp_codi='231'
            AND tar_codi=4
            AND LENGTH(arb_codi)= 2) Tp
on SUBSTR(a.arb_codi,0,2) = Tp.arb_codi
WHERE 1=1
AND emp_codi='231'
AND tar_codi=4;

--Areas
SELECT DISTINCT
    arb_cont    as arb_area,
    arb_nomb    as Nivel1,
    arb_codi    as Cod_Area
FROM GN_ARBOL a
WHERE 1=1
AND emp_codi='231'
AND tar_codi=1;

--facultad
SELECT DISTINCT
    arb_cont,
    Fac.Nomb_Facultad,
    Mod.Nomb_Modalidad,
    a.arb_codi    as Cod_Programa,
    arb_nomb    as Nomb_Programa
FROM GN_ARBOL a
Left Join ( SELECT DISTINCT
                arb_codi,
                arb_nomb    as Nomb_Modalidad
            FROM GN_ARBOL
            WHERE 1=1
            AND emp_codi='231'
            AND tar_codi=3
            AND LENGTH(arb_codi)= 6) Mod
on SUBSTR(a.arb_codi,0,6) = Mod.arb_codi
Left Join ( SELECT DISTINCT
                arb_codi,
                arb_nomb    as Nomb_Facultad
            FROM GN_ARBOL
            WHERE 1=1
            AND emp_codi='231'
            AND tar_codi=3
            AND LENGTH(arb_codi)= 2) Fac
on SUBSTR(a.arb_codi,0,2) = Fac.arb_codi
WHERE 1=1
AND emp_codi='231'
AND tar_codi=3
AND a.arb_codi LIKE '05%'  
AND LENGTH(a.arb_codi)=8;

--cecos
SELECT DISTINCT
    arb_cont,
    n1.Nivel1,
    n2.Nivel2,
    a.arb_codi,
    arb_nomb    as Nivel3
FROM GN_ARBOL a
Left Join ( SELECT DISTINCT
                arb_codi,
                arb_nomb    as Nivel2
            FROM GN_ARBOL
            WHERE 1=1
            AND emp_codi='231'
            AND tar_codi=3
            AND LENGTH(arb_codi)= 6) n2
on SUBSTR(a.arb_codi,0,6) = n2.arb_codi
Left Join ( SELECT DISTINCT
                arb_codi,
                arb_nomb    as Nivel1
            FROM GN_ARBOL
            WHERE 1=1
            AND emp_codi='231'
            AND tar_codi=3
            AND LENGTH(arb_codi)= 2) n1
on SUBSTR(a.arb_codi,0,2) = n1.arb_codi
WHERE 1=1
AND emp_codi='231'
AND tar_codi=3;

