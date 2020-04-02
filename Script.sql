USE Practica1;

CREATE TABLE Currency (
  currency_id INT(11) NOT NULL AUTO_INCREMENT,
  currency_description INT(11) NULL,
  PRIMARY KEY (currency_id));

CREATE TABLE Type_Status (
  id_status INT(11) NOT NULL AUTO_INCREMENT,
  description VARCHAR(255) NULL,
  PRIMARY KEY (id_status));

CREATE TABLE Country_Code (
  country_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  iso2 VARCHAR(255) NULL,
  name_aiddata_code VARCHAR(255) NULL,
  name_cow_alpha VARCHAR(255) NULL,
  name_cow_numeric VARCHAR(255) NULL,
  name_fao_code VARCHAR(255) NULL,
  name_fips VARCHAR(255) NULL,
  name_geoname_id VARCHAR(255) NULL,
  name_imf_code VARCHAR(255) NULL,
  PRIMARY KEY (country_id));

CREATE TABLE Project (
  project_id INT(11) NOT NULL AUTO_INCREMENT,
  is_geocode INT(11) NULL,
  project_tittle VARCHAR(255) NULL,
  start_actual_isodate DATE NULL,
  end_actual_isodate DATE NULL,
  donors VARCHAR(255) NULL,
  donors_iso3 VARCHAR(255) NULL,
  ad_sector_codes VARCHAR(255) NULL,
  ad_sector_names VARCHAR(255) NULL,
  transaction_start_year INT(11) NULL,
  transaction_end_year INT(11) NULL,
  total_commitments FLOAT NULL,
  total_disbuments FLOAT NULL,
  project_code VARCHAR(255) NULL,
  Type_Status_id_status INT(11) NOT NULL,
  Country_Code_country_id INT(11) NOT NULL,
  PRIMARY KEY (project_id, Type_Status_id_status, Country_Code_country_id),
  INDEX fk_Project_Type_Status1_idx (Type_Status_id_status ASC),
  INDEX fk_Project_Country_Code1_idx (Country_Code_country_id ASC),
  CONSTRAINT fk_Project_Type_Status1
    FOREIGN KEY (Type_Status_id_status)
    REFERENCES Practica1.Type_Status (id_status)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Project_Country_Code1
    FOREIGN KEY (Country_Code_country_id)
    REFERENCES Practica1.Country_Code (country_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE Transaction (
  transaction_id INT(11) NOT NULL AUTO_INCREMENT,
  transaction_code VARCHAR(255) NULL,
  transaction_isodate DATE NULL,
  transaction_year INT(11) NULL,
  transaction_value_code VARCHAR(255) NULL,
  transaction_value INT(11) NULL,
  Currency_currency_id INT(11) NOT NULL,
  Project_project_id INT(11) NOT NULL,
  PRIMARY KEY (transaction_id, Currency_currency_id, Project_project_id),
  INDEX fk_Transaction_Currency_idx (Currency_currency_id ASC),
  INDEX fk_Transaction_Project1_idx (Project_project_id ASC),
  CONSTRAINT fk_Transaction_Currency
    FOREIGN KEY (Currency_currency_id)
    REFERENCES Practica1.Currency (currency_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Transaction_Project1
    FOREIGN KEY (Project_project_id)
    REFERENCES Practica1.Project (project_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE Location (
  location_id INT(11) NOT NULL AUTO_INCREMENT,
  location_type_code VARCHAR(255) NULL,
  location_type_name VARCHAR(255) NULL,
  PRIMARY KEY (location_id));

CREATE TABLE Geoname (
  geoname_id INT(11) NOT NULL,
  place_name VARCHAR(255) NULL,
  latitudes FLOAT NULL,
  longitude FLOAT NULL,
  gazetteer_adm_code VARCHAR(255) NULL,
  gazetteer_adm_name VARCHAR(255) NULL,
  location_class INT(11) NULL,
  geografic_exactness INT(11) NULL,
  Location_location_id INT(11) NOT NULL,
  PRIMARY KEY (geoname_id, Location_location_id),
  INDEX fk_Geoname_Location1_idx (Location_location_id ASC),
  CONSTRAINT fk_Geoname_Location1
    FOREIGN KEY (Location_location_id)
    REFERENCES Practica1.Location (location_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE Level_1A (
  level_id INT(11) NOT NULL AUTO_INCREMENT,
  project_geoname_id VARCHAR(255) NULL,
  transaction_start_year INT(11) NULL,
  transaction_end_year INT(11) NULL,
  even_split_commitments FLOAT NULL,
  even_split_disbursement FLOAT NULL,
  Geoname_geoname_id INT(11) NOT NULL,
  Project_project_id INT(11) NOT NULL,
  PRIMARY KEY (level_id, Geoname_geoname_id, Project_project_id),
  INDEX fk_Level_1A_Geoname1_idx (Geoname_geoname_id ASC),
  INDEX fk_Level_1A_Project1_idx (Project_project_id ASC),
  CONSTRAINT fk_Level_1A_Geoname1
    FOREIGN KEY (Geoname_geoname_id)
    REFERENCES Practica1.Geoname (geoname_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Level_1A_Project1
    FOREIGN KEY (Project_project_id)
    REFERENCES Practica1.Project (project_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
