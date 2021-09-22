/* Procedimiento para llenar la tabla de cuenca con los datos de la tabla datos completos*/

CREATE OR REPLACE PROCEDURE llenar_cuenca
    IS
    v_id_cuenca cuenca.id_cuenca%TYPE:= 0;
BEGIN
    FOR i IN (SELECT DISTINCT(cuenca) FROM datoscompletos ORDER BY cuenca)
    LOOP
        SELECT MAX(id_cuenca) INTO v_id_cuenca
        FROM cuenca;
        IF v_id_cuenca IS NULL THEN
            v_id_cuenca:=1;
        ELSE
            v_id_cuenca:= v_id_cuenca + 1;
        END IF;
        INSERT INTO cuenca VALUES (v_id_cuenca, i.cuenca);
    END LOOP;
END llenar_cuenca;

execute llenar_cuenca;

--------------------------------------------------------------------------------------------------------------------
/* Procedimiento para llenar la tabla de municipio con los datos de la tabla datos completos*/

CREATE OR REPLACE PROCEDURE llenar_municipio
    IS
    v_id_municipio municipio.id_municipio%TYPE:=0;
    v_id_cuenca cuenca.id_cuenca%TYPE:=0;
BEGIN
    FOR i IN (SELECT DISTINCT(municipio), cuenca FROM datoscompletos ORDER BY municipio)
    LOOP
        SELECT obtener_cuenca(i.cuenca) INTO v_id_cuenca FROM dual;
        SELECT MAX(id_municipio) INTO v_id_municipio
        FROM municipio;
        IF v_id_municipio IS NULL THEN 
            v_id_municipio:= 1;
        ELSE
            v_id_municipio:= v_id_municipio + 1;
        END IF;
        INSERT INTO municipio VALUES (v_id_municipio, v_id_cuenca, i.municipio);
    END LOOP;
END llenar_municipio;

execute llenar_municipio;

--------------------------------------------------------------------------------------------------------------------

/* Procedimiento para llenar la tabla de estacion con los datos de la tabla datos completos*/

CREATE OR REPLACE PROCEDURE llenar_estacion
    IS
    v_id_estacion estacion.id_estacion%TYPE;
    v_id_municipio municipio.id_municipio%TYPE;
    v_id_cuenca cuenca.id_cuenca%TYPE;
BEGIN 
    FOR i  IN (SELECT DISTINCT(estacion), codigo, municipio ,cuenca, x_n , y_e FROM datoscompletos ORDER BY estacion) 
    LOOP
        v_id_cuenca:= obtener_cuenca(i.cuenca);
        v_id_estacion:= i.codigo;
        SELECT obtener_municipio(i.municipio, v_id_cuenca) INTO v_id_municipio FROM dual;
        INSERT INTO estacion VALUES (v_id_estacion, v_id_municipio, i.estacion, i.x_n, i.y_e);
    END LOOP;
END llenar_estacion;


execute llenar_estacion;
--------------------------------------------------------------------------------------------------------------------

/* Procedimiento para llenar la tabla mes con los meses del año*/

CREATE OR REPLACE PROCEDURE llenar_mes
    IS
BEGIN
    insert into mes values(1,'Enero');
    insert into mes values(2,'Febrero');
    insert into mes values(3,'Marzo');
    insert into mes values(4,'Abril');
    insert into mes values(5,'Mayo');
    insert into mes values(6,'Junio');
    insert into mes values(7,'Julio');
    insert into mes values(8,'Agosto');
    insert into mes values(9,'Septiembre');
    insert into mes values(10,'Octubre');
    insert into mes values(11,'Noviembre');
    insert into mes values(12,'Diciembre');
END llenar_mes;

execute llenar_mes;

-----------------------------------------------------------------------------------------------------------------------

/* Procedimiento para llenar la tabla de precipitacion con los datos de la tabla datos completos*/

CREATE OR REPLACE PROCEDURE llenar_precipitacion
    IS
    v_id_precipitacion precipitacion.id_precipitacion%TYPE;
    v_id_estacion estacion.id_estacion%TYPE;
    v_id_mes mes.id_mes%TYPE;
    v_id_municipio municipio.id_municipio%TYPE;
    v_id_cuenca cuenca.id_cuenca%TYPE;
    v_registro precipitacion.registro%TYPE;
BEGIN
    FOR i IN (SELECT * FROM datoscompletos ORDER BY estacion) LOOP 
        SELECT MAX(id_precipitacion) INTO v_id_precipitacion
        FROM precipitacion;
        IF v_id_precipitacion IS NULL THEN 
            v_id_precipitacion:= 1;
        ELSE
            v_id_precipitacion:= v_id_precipitacion +1;
        END IF;
        v_id_cuenca:= obtener_cuenca(i.cuenca);
        v_id_municipio:= obtener_municipio(i.municipio, v_id_cuenca);
        v_id_estacion:= obtener_estacion(i.codigo, v_id_municipio);
        
        
        
        SELECT obtener_mes('Enero') INTO v_id_mes FROM dual;
        IF i.enero != '0' THEN 
            v_registro:= i.enero;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Febrero') INTO v_id_mes FROM dual;
        IF i.febrero != '0' THEN
            v_registro:= i.febrero;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Marzo') INTO v_id_mes FROM dual;
        IF i.marzo != '0' THEN
            v_registro:= i.marzo;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Abril') INTO v_id_mes FROM dual;
        IF i.abril != '0' THEN
            v_registro:= i.abril;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Mayo') INTO v_id_mes FROM dual;
        IF i.mayo != '0' THEN
            v_registro:= i.mayo;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Junio') INTO v_id_mes FROM dual;
        IF i.junio != '0' THEN
            v_registro:= i.junio;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Julio') INTO v_id_mes FROM dual;
        IF i.julio != '0' THEN
            v_registro:= i.julio;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Agosto') INTO v_id_mes FROM dual;
        IF i.agosto != '0' THEN
            v_registro:= i.agosto;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Septiembre') INTO v_id_mes FROM dual;
        IF i.septiembre != '0' THEN
            v_registro:= i.septiembre;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Octubre') INTO v_id_mes FROM dual;
        IF i.octubre != '0' THEN
            v_registro:= i.octubre;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Noviembre') INTO v_id_mes FROM dual;
        IF i.noviembre != '0' THEN
            v_registro:= i.noviembre;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
        v_id_precipitacion:= v_id_precipitacion +1;
        SELECT obtener_mes('Diciembre') INTO v_id_mes FROM dual;
        IF i.diciembre != '0' THEN
            v_registro:= i.diciembre;
            INSERT INTO precipitacion VALUES (v_id_precipitacion, v_id_estacion, v_id_mes, i.anio,v_registro);
        END IF;
        
    END LOOP;
END llenar_precipitacion;

execute llenar_precipitacion;
