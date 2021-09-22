/* funcion para obtener el id de la cuenca*/

CREATE OR REPLACE FUNCTION obtener_cuenca (p_nombre_cuenca cuenca.nombre_cuenca%TYPE)
RETURN NUMBER IS
    v_id_cuenca cuenca.id_cuenca%TYPE;
BEGIN 
    SELECT id_cuenca INTO v_id_cuenca
    FROM cuenca
    WHERE RTRIM(UPPER(nombre_cuenca)) = RTRIM(UPPER(p_nombre_cuenca));
    return v_id_cuenca;
END obtener_cuenca;

-----------------------------------------------------------------------------------------------------------------------------
/* Funcion para obtener el id del municipio */
CREATE OR REPLACE FUNCTION obtener_municipio (p_nombre_municipio municipio.nombre_municipio%TYPE, p_id_cuenca cuenca.id_cuenca%TYPE)
RETURN NUMBER IS
    v_id_municipio municipio.id_municipio%TYPE;
BEGIN
    SELECT id_municipio INTO v_id_municipio
    FROM municipio
    WHERE nombre_municipio = p_nombre_municipio
    AND id_cuenca = p_id_cuenca;
    RETURN v_id_municipio;
END obtener_municipio;

-----------------------------------------------------------------------------------------------------------------------------

/* Funcion para obtener el id de la estacion */
CREATE OR REPLACE FUNCTION obtener_estacion (p_codigo estacion.id_estacion%TYPE, p_id_municipio municipio.id_municipio%TYPE)
RETURN NUMBER IS
    v_id_estacion estacion.id_estacion%TYPE;
BEGIN 
    SELECT id_estacion INTO v_id_estacion
    FROM estacion
    WHERE id_estacion = p_codigo
    AND id_municipio = p_id_municipio;
    RETURN v_id_estacion;
END obtener_estacion;


----------------------------------------------------------------------------------------------------------------------------
/* funcion para obtener el id del mes */
CREATE OR REPLACE FUNCTION obtener_mes (p_nombre_mes mes.nombre_mes%TYPE)
RETURN NUMBER IS
    v_id_mes mes.id_mes%TYPE;
BEGIN
    SELECT id_mes INTO v_id_mes
    FROM mes
    WHERE nombre_mes = p_nombre_mes;
    RETURN v_id_mes;
END obtener_mes;
