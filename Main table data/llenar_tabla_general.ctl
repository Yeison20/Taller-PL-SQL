load data
infile 'Precipitaciones_Totales_Mensuales.csv'
append
into table DATOSCOMPLETOS
fields terminated by ';' optionally enclosed by '"'
TRAILING NULLCOLS 
(estacion,codigo,x_n,y_e,municipio,cuenca,anio,enero,febrero,marzo,abril,mayo,junio,julio,agosto,septiembre,octubre,noviembre,diciembre)
