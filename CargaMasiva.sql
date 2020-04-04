Use Practica1;

SET SQL_SAFE_UPDATES = 0;
/*Insertar a tablas relacionales*/

/*Se llenan los valores predeterminados*/
INSERT INTO Currency (currency_description) values ('USD');

INSERT INTO Type_Status (description) values ('Implementation');
INSERT INTO Type_Status (description) values ('Completion');

/*LLenar tablas*/

/*Location*/
INSERT INTO Location (location_type_code,location_type_name) SELECT * FROM Ubicacion;

/*Country_code*/
DELETE FROM CodigoPais WHERE name_='Unspecified';
/*------------------------*/
INSERT INTO Country_Code 
(name,iso2,name_aiddata_code,
name_aiddata_name,name_cow_alpha,
name_cow_numeric,name_fao_code,
name_fips,name_geonames_id,
name_imf_code,name_iso2,
name_iso3,name_iso_numeric,
name_oecd_code,name_oecd_name,name_un_code,name_wb_code) 
SELECT
name_,iso2,name_aiddata_code,
name_aiddata_name,name_cow_alpha,
name_cow_numeric,name_fao_code,
name_fips,name_geonames_id,
name_imf_code,name_iso2,
name_iso3,name_iso_numeric,
name_oecd_code,name_oecd_name,name_un_code,name_wb_code 
FROM CodigoPais;

/*Geo_name*/
INSERT INTO Geoname (geoname_int,place_name,latitudes,longitude,
gazetteer_adm_code,gazetteer_adm_name,location_class,
geografic_exactness,Location_location_id)
SELECT
geoname_id,place_name,latitude,
longitude,gazetteer_adm_code,gazetteer_adm_name,
location_class,geographic_exactness,Location.location_id 
FROM GeoNombres,Location
where GeoNombres.location_type_code = Location.location_type_code 
and GeoNombres.location_type_name = Location.location_type_name;

/*Project*/
update  Proyectos,Country_Code set Proyectos.relacion_id = Country_Code.country_id
where Proyectos.recipients_iso3 = Country_Code.name_iso3;

update  Proyectos,Country_Code set Proyectos.relacion_id = Country_Code.country_id
where Proyectos.recipients = Country_Code.name_aiddata_name;

update  Proyectos,Country_Code set Proyectos.relacion_id = Country_Code.country_id
where Proyectos.recipients = Country_Code.name;
/*--------------------------------------*/
INSERT INTO Project 
(is_geocode,project_tittle,start_actual_isodate,
end_actual_isodate,donors,donors_iso3,
ad_sector_codes,ad_sector_names,
transaction_start_year,transaction_end_year,
total_commitments,total_disbuments,project_code,
Type_Status_id_status,Country_Code_country_id)
SELECT 
is_geocoded,project_title,start_actual_isodate,
end_actual_isodate,donors,donors_iso3,
ad_sector_codes,ad_sector_names,
transactions_start_year,transactions_end_year,
total_commitments,total_disbursements,project_id,
Type_Status.id_status,relacion_id
FROM Proyectos,Type_Status
where Proyectos.status_ = Type_Status.description;

/*Transaction*/
INSERT INTO Transaction
(transaction_code,transaction_isodate,transaction_year,
transaction_value_code,transaction_value,
Currency_currency_id,Project_project_id)
SELECT
transaction_id,transaction_isodate,transaction_year,
transaction_value_code,transaction_value,
Currency.currency_id,Project.project_id
FROM Transacciones,Project,Currency
where Transacciones.project_id = Project.project_code 
and Transacciones.transaction_currency = Currency.currency_description;

/*Level_1a*/

/*update  Nivel,Project set Nivel.relacion_pro = Project.project_id
where Nivel.project_id = Project.project_code;

update  Nivel,Geoname set Nivel.relacion_geo = Geoname.geoname_id
where Nivel.geoname_id = Geoname.geoname_int;*/
/*--------------------------------------*/
INSERT INTO Level_1A
(project_geoname_id,transaction_start_year,transaction_end_year,
even_split_commitments,even_split_disbursement,
Geoname_geoname_id,Project_project_id)
SELECT
project_location_id,transactions_start_year,transactions_end_year,
even_split_commitments,even_split_disbursements,
relacion_geo,relacion_pro
FROM Nivel;

/*Crear vista*/
CREATE VIEW vista_nivel AS SELECT * FROM Level_1A; 
