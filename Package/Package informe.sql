CREATE OR REPLACE PACKAGE informe
IS
    v_nombreMesMaxP mes.nombre_mes%TYPE;
    v_nombreMesMinP mes.nombre_mes%TYPE;
    v_nombreMesMaxS mes.nombre_mes%TYPE;
    v_nombreMesMinS mes.nombre_mes%TYPE;
    v_valorMaxP precipitacion.registro%TYPE;
    v_valorMinP precipitacion.registro%TYPE;
    v_valorMaxS precipitacion.registro%TYPE;
    v_valorMinS precipitacion.registro%TYPE;
    v_promRegistroP precipitacion.registro%TYPE;
    v_promRegistroS precipitacion.registro%TYPE;
    PROCEDURE crear_informe(p_id_cuenca cuenca.id_cuenca%TYPE, p_anio precipitacion.anio%TYPE);
END informe;

CREATE OR REPLACE PACKAGE BODY informe
    IS
    
    PROCEDURE crear_registro(p_id_cuenca cuenca.id_cuenca%TYPE, p_anio precipitacion.anio%TYPE)
        IS
    BEGIN
        FOR i IN(SELECT DISTINCT(c.nombre_cuenca) as Cuenca, m.nombre_municipio as Municipio, e.nombre_estacion||' ('||e.id_estacion||')' as Estacion_Codigo, '('||e.x_n||','||e.y_e||')' as Coord_X_Y, e.id_estacion
            FROM cuenca c, estacion e, precipitacion p, municipio m
            WHERE c.id_cuenca = p_id_cuenca
            AND m.id_municipio=e.id_municipio
            AND c.id_cuenca=m.id_cuenca 
            AND e.id_estacion=p.id_estacion
            AND p.anio = p_anio) LOOP
            
            SELECT MAX(p.registro), AVG(p.registro) , MIN(p.registro) INTO v_valorMaxP, v_promRegistroP, v_valorMinP
            FROM cuenca c, municipio m, estacion e, precipitacion p, mes me
            WHERE c.id_cuenca = p_id_cuenca
            AND p.anio = p_anio
            AND c.id_cuenca = m.id_cuenca
            AND m.id_municipio = e.id_municipio
            AND e.id_estacion = i.id_estacion
            AND e.id_estacion = p.id_estacion
            AND p.id_mes = me.id_mes
            AND me.id_mes in (1,2,3,4,5,6);
        
            SELECT DISTINCT(me.nombre_mes) INTO  v_nombreMesMaxP
            FROM cuenca c, municipio m, estacion e, precipitacion p, mes me
            WHERE c.id_cuenca = p_id_cuenca 
            AND p.anio = p_anio
            AND c.id_cuenca = m.id_cuenca
            AND m.id_municipio = e.id_municipio
            AND e.id_estacion = i.id_estacion
            AND e.id_estacion = p.id_estacion
            AND p.id_mes = me.id_mes
            AND me.id_mes in (1,2,3,4,5,6)
            AND p.registro = v_valorMaxP;
        
        
            SELECT DISTINCT(me.nombre_mes) INTO  v_nombreMesMinP
            FROM cuenca c, municipio m, estacion e, precipitacion p, mes me
            WHERE c.id_cuenca = p_id_cuenca 
            AND p.anio = p_anio
            AND c.id_cuenca = m.id_cuenca
            AND m.id_municipio = e.id_municipio
            AND e.id_estacion = i.id_estacion
            AND e.id_estacion = p.id_estacion
            AND p.id_mes = me.id_mes
            AND me.id_mes in (1,2,3,4,5,6)
            AND p.registro = v_valorMinP;
            
        dbms_output.put_line(v_valorMaxP || '   ' || v_nombreMesMaxP || '    ' || v_promRegistroP || '  ' || v_valorMinP || '   ' || v_nombreMesMinP );
        
        
              SELECT MAX(p.registro), AVG(p.registro) , MIN(p.registro) INTO v_valorMaxS, v_promRegistroS, v_valorMinS
            FROM cuenca c, municipio m, estacion e, precipitacion p, mes me
            WHERE c.id_cuenca = p_id_cuenca
            AND p.anio = p_anio
            AND c.id_cuenca = m.id_cuenca
            AND m.id_municipio = e.id_municipio
            AND e.id_estacion = i.id_estacion
            AND e.id_estacion = p.id_estacion
            AND p.id_mes = me.id_mes
            AND me.id_mes IN (7,8,9,10,11,12);
    
            SELECT DISTINCT(me.nombre_mes) INTO  v_nombreMesMaxS
            FROM cuenca c, municipio m, estacion e, precipitacion p, mes me
            WHERE c.id_cuenca = p_id_cuenca 
            AND p.anio = p_anio
            AND c.id_cuenca = m.id_cuenca
            AND m.id_municipio = e.id_municipio
            AND e.id_estacion = i.id_estacion
            AND e.id_estacion = p.id_estacion
            AND p.id_mes = me.id_mes
            AND me.id_mes IN (7,8,9,10,11,12)
            AND p.registro = v_valorMaxS;
            
            
            SELECT distinct(me.nombre_mes) INTO  v_nombreMesMinS
            FROM cuenca c, municipio m, estacion e, precipitacion p, mes me
            WHERE c.id_cuenca = p_id_cuenca 
            AND p.anio = p_anio
            AND c.id_cuenca = m.id_cuenca
            AND m.id_municipio = e.id_municipio
            AND e.id_estacion = i.id_estacion
            AND e.id_estacion = p.id_estacion
            AND p.id_mes = me.id_mes
            AND me.id_mes IN (7,8,9,10,11,12)
            and p.registro = v_valorMinS;

         
    
        dbms_output.put_line(v_valorMaxS || '   ' || v_nombreMesMaxS || '    ' || v_promRegistroS || '  ' || v_valorMinS || '   ' || v_nombreMesMinS );
        insert into reporte values (i.Cuenca, i.Municipio, i.Estacion_Codigo, i.Coord_X_Y,
                                        v_promRegistroP, v_nombreMesMaxP, v_valorMaxP, v_nombreMesMinP , v_valorMinP,
                                        v_promRegistroS, v_nombreMesMaxS, v_valorMaxS, v_nombreMesMinS , v_valorMinS );
        END LOOP;
    END crear_registro;

    PROCEDURE crear_informe(p_id_cuenca cuenca.id_cuenca%TYPE, p_anio precipitacion.anio%TYPE)
        AS
    BEGIN
        crear_registro(p_id_cuenca, p_anio);
           
    END crear_informe;
    
   
END informe;

execute informe.crear_informe(18,'2012')


select * from reporte;