USE Practica1;
/* Crear tablas temporales */
CREATE TEMPORARY TABLE Ubicacion (

	location_type_code varchar(255),
    location_type_name varchar(255)
);

CREATE TEMPORARY TABLE GeoNombres (

    geoname_id varchar(255),
    place_name varchar(255),
    latitude varchar(255),
    longitude varchar(255),
    location_type_code varchar(255),
    location_type_name varchar(255),
    gazetteer_adm_code varchar(255),
    gazetteer_adm_name varchar(255),
    location_class varchar(255),
    geographic_exactness varchar(255)
);

CREATE TEMPORARY TABLE Proyectos (

	project_id varchar(255),
    is_geocoded varchar(255),
    project_title varchar(255),
    start_actual_isodate varchar(255),
    end_actual_isodate varchar(255),
    donors varchar(255),
    donors_iso3 varchar(255),
    recipients varchar(255),
    recipients_iso3 varchar(255),
    ad_sector_codes varchar(255),
    ad_sector_names varchar(255),
    status_ varchar(255),
    transactions_start_year varchar(255),
    transactions_end_year varchar(255),
    total_commitments varchar(255),
    total_disbursements varchar(255)
);

CREATE TEMPORARY TABLE Nivel (

    project_id varchar(255),
    project_location_id varchar(255),
    geoname_id varchar(255),
    transactions_start_year varchar(255),
    transactions_end_year varchar(255),
    even_split_commitments varchar(255),
    even_split_disbursements varchar(255)
);

CREATE TEMPORARY TABLE Transacciones (

	transaction_id varchar(255),
    project_id varchar(255),
    transaction_isodate varchar(255),
    transaction_year varchar(255),
    transaction_value_code varchar(255),
    transaction_currency varchar(255),
    transaction_value varchar(255)
);

CREATE TEMPORARY TABLE CodigoPais (

	name_ varchar(255),
	iso2 varchar(255),	
    name_name varchar(255),
	name_aiddata_code varchar(255),
	name_aiddata_name varchar(255),
	name_cow_alpha varchar(255),
	name_cow_numeric varchar(255),
	name_fao_code varchar(255),	
    name_fips varchar(255),
	name_geonames_id varchar(255),
	name_imf_code varchar(255),
	name_iso2 varchar(255),
	name_iso3 varchar(255),
	name_iso_numeric varchar(255),
	name_oecd_code varchar(255),
	name_oecd_name varchar(255),
	name_un_code varchar(255),
    name_wb_code varchar(255)
);

LOAD DATA LOCAL INFILE '/home/davis/Descargas/ArchivosCSV/locations.csv'
INTO TABLE Ubicacion
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 rows;

LOAD DATA LOCAL INFILE '/home/davis/Descargas/ArchivosCSV/geonames.csv'
INTO TABLE GeoNombres
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 rows;

LOAD DATA LOCAL INFILE '/home/davis/Descargas/ArchivosCSV/projects.csv'
INTO TABLE Proyectos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 rows;

LOAD DATA LOCAL INFILE '/home/davis/Descargas/ArchivosCSV/level_1a.csv'
INTO TABLE Nivel
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 rows;

LOAD DATA LOCAL INFILE '/home/davis/Descargas/ArchivosCSV/transactions.csv'
INTO TABLE Transacciones
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 rows;

LOAD DATA LOCAL INFILE '/home/davis/Descargas/ArchivosCSV/country_codes.tsv'
INTO TABLE CodigoPais
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 rows;

select * from Ubicacion;
