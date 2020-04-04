Use Practica1;
/*Cuántos proyectos iniciaron en el 2011*/
Select count(*) As Numero_Proyectos_2011 
From Project
where transaction_start_year='2011';

/*Cuál fue el proyecto de mayor duración*/
select project_tittle as Nombre_Proyecto,
STR_TO_DATE(start_actual_isodate,'%d/%m/%Y') as Fecha_inicio,
STR_TO_DATE(end_actual_isodate,'%d/%m/%Y') as Fecha_fin,
(transaction_end_year-transaction_start_year) As Duracion_años  
From Project
where end_actual_isodate!=''
Order by Duracion_años desc,transaction_end_year desc limit 1;

/*Cuál fue el proyecto de menor duración*/
select project_tittle as Nombre_Proyecto,
STR_TO_DATE(start_actual_isodate,'%d/%m/%Y') as Fecha_inicio,
STR_TO_DATE(end_actual_isodate,'%d/%m/%Y') as Fecha_fin,
(STR_TO_DATE(end_actual_isodate,'%d/%m/%Y')-STR_TO_DATE(start_actual_isodate,'%d/%m/%Y')) As Duracion_dias
From Project
where end_actual_isodate!=''
Order by Duracion_dias asc limit 1;

/**/
