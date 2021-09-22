CREATE GLOBAL TEMPORARY TABLE reporte (
    cuenca VARCHAR2(40) NOT NULL,
    municipio VARCHAR2(40) NOT NULL,
    estacion_codigo VARCHAR2(40) NOT NULL,
    coord_x_y VARCHAR2(40) NOT NULL,
    prom1 VARCHAR2(40) NOT NULL,
    mesMax1 VARCHAR2(40) NOT NULL,
    valorMax1 VARCHAR2(40) NOT NULL,
    mesMin1 VARCHAR2(40) NOT NULL,
    valorMin1 VARCHAR2(40) NOT NULL,
    prom2 VARCHAR2(40) NOT NULL,
    mesMax2 VARCHAR2(40) NOT NULL,
    valorMax2 VARCHAR2(40) NOT NULL,
    mesMin2 VARCHAR2(40) NOT NULL,
    valorMin2 VARCHAR(40) NOT NULL
)ON COMMIT DELETE ROWS;
    
    