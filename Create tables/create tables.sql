CREATE TABLE DATOSCOMPLETOS (
	estacion VARCHAR2(40) NOT NULL,
	codigo NUMBER NOT NULL,
	x_n NUMBER NOT NULL,
	y_e NUMBER NOT NULL,
	municipio VARCHAR2(40) NOT NULL,
	cuenca VARCHAR2(40) NOT NULL,
	anio VARCHAR2(4) NOT NULL,
	enero FLOAT NOT NULL,
	febrero FLOAT NOT NULL,
	marzo FLOAT NOT NULL,
	abril FLOAT NOT NULL,
	mayo FLOAT NOT NULL,
	junio FLOAT NOT NULL,
	julio FLOAT NOT NULL,
	agosto FLOAT NOT NULL,
	septiembre FLOAT NOT NULL,
	octubre FLOAT NOT NULL,
	noviembre FLOAT NOT NULL,
	diciembre FLOAT NOT NULL
);

CREATE TABLE CUENCA (
    id_cuenca INTEGER NOT NULL,
    nombre_cuenca VARCHAR2(40)NOT NULL,
    CONSTRAINT pk_id_cueca PRIMARY KEY (id_cuenca)
);

CREATE TABLE MUNICIPIO (
    id_municipio INTEGER NOT NULL,
    id_cuenca INTEGER NOT NULL,
    nombre_municipio VARCHAR2(40) NOT NULL,
    CONSTRAINT pk_id_municipio PRIMARY KEY (id_municipio),
    CONSTRAINT fk_id_cuenca FOREIGN KEY (id_cuenca) REFERENCES CUENCA(id_cuenca)
);

CREATE TABLE ESTACION (
    id_estacion INTEGER NOT NULL,
    id_municipio INTEGER NOT NULL,
    nombre_estacion VARCHAR2(40) NOT NULL,
    x_n NUMBER(8) NOT NULL,
    y_e NUMBER(8) NOT NULL,
    CONSTRAINT pk_id_estacion PRIMARY KEY (id_estacion),
    CONSTRAINT fk_id_municipio FOREIGN KEY (id_municipio) REFERENCES MUNICIPIO(id_municipio)
);

CREATE TABLE MES (
    id_mes INTEGER NOT NULL,
    nombre_mes VARCHAR(20) NOT NULL,
    CONSTRAINT pk_id_mes PRIMARY KEY (id_mes)
);

CREATE TABLE PRECIPITACION (
    id_precipitacion INTEGER NOT NULL,
    id_estacion INTEGER NOT NULL,
    id_mes INTEGER NOT NULL,
    anio VARCHAR2(4) NOT NULL,
    registro FLOAT NOT NULL,
    CONSTRAINT pk_id_precipitacion PRIMARY KEY (id_precipitacion),
    CONSTRAINT fk_id_estacion FOREIGN KEY (id_estacion) REFERENCES ESTACION(id_estacion),
    CONSTRAINT fk_id_mes FOREIGN KEY (id_mes) REFERENCES MES(id_mes)
);

