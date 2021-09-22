CREATE OR REPLACE PACKAGE creaSistema
IS
    PROCEDURE migrar_tablas;
END creaSistema;

CREATE OR REPLACE PACKAGE BODY creaSistema
IS
    PROCEDURE migrar_tablas
        AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('------- INICIANDO EL PROCESO DE MIGRACION DE TABLAS ---------');
        DBMS_OUTPUT.PUT_LINE('-- | -- PROCESO DE GUARDADO DE LOS DATOS EN LA TABLA CUENCA ........');
        llenar_cuenca;
        DBMS_OUTPUT.PUT_LINE('-- | -- PROCESO DE GUARDADO DE LOS DATOS EN LA TABLA MUNICIPIO ........');
        llenar_municipio;
        DBMS_OUTPUT.PUT_LINE('-- | -- PROCESO DE GUARDADO DE LOS DATOS EN LA TABLA ESTACION ........');
        llenar_estacion;
        DBMS_OUTPUT.PUT_LINE('-- | -- PROCESO DE GUARDADO DE LOS DATOS EN LA TABLA MES ........');
        llenar_mes;
        DBMS_OUTPUT.PUT_LINE('-- | -- PROCESO DE GUARDADO DE LOS DATOS EN LA TABLA PRECIPITACION ........');
        llenar_precipitacion;
        DBMS_OUTPUT.PUT_LINE('------- FINALIZADO EL PROCESO DE MIGRACION DE TABLAS ---------');
    END migrar_tablas;
END creaSistema;




execute creaSistema.migrar_tablas;


