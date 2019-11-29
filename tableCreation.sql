DROP TABLE IF EXISTS Border;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Province;
DROP TABLE IF EXISTS Country;


-- Create tables
CREATE TABLE Country (
    country_code CHAR(4) NOT NULL,
    country_name VARCHAR(30) NOT NULL,
    gdp DECIMAL(20,2) NOT NULL,
    inflation DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (country_code)
);

CREATE TABLE Province (
    province_name VARCHAR(30) NOT NULL,
    country_code CHAR(4) NOT NULL,
    area DOUBLE PRECISION(10,2) NOT NULL,
    PRIMARY KEY (province_name, country_code),
    FOREIGN KEY (country_code) REFERENCES Country(country_code)
);

CREATE TABLE City (
    city_name VARCHAR(30) NOT NULL,
    province_name VARCHAR(30) NOT NULL,
    country_code CHAR(4) NOT NULL,
    city_population INT(12) NOT NULL,
    PRIMARY KEY (city_name,province_name,country_code),
    FOREIGN KEY (province_name, country_code) REFERENCES Province(province_name, country_code)
);

CREATE TABLE Border (
    country_code1 CHAR(4) NOT NULL,
    country_code2 CHAR(4) NOT NULL,
    border_length DECIMAL (10,2),
    PRIMARY KEY(country_code1, country_code2),
    FOREIGN KEY (country_code1) REFERENCES Country(country_code),
    FOREIGN KEY (country_code2) REFERENCES Country(country_code)
);

-- Fill tables
-- code, name gdp, inflaiton
INSERT INTO Country VALUES 
    ('ARG', 'Argentina',20900, 25.7),
    ('BOL', 'Bolivia', 7600, 2.8),
    ('BRA', 'Brazil', 15600, 3.4),
    ('CHL', 'Chile', 24600, 2.2),
    ('COL', 'Colombia', 14400, 4.3),
    ('ECU', 'Ecuador', 11500, 0.4),
    ('GUY', 'Guyana', 8100, 2.0),
    ('PRY', 'Paraguay', 12800, 3.6),
    ('PER', 'Peru', 13500, 2.8),
    ('SUR', 'Suriname', 14900,22.0 ),
    ('URY', 'Urguay', 22400, 6.2),
    ('VEN', 'Venezuela', 12500, 1087.5);
;
-- pname, country code, area
INSERT INTO Province VALUES 
('Buenos Aires Province', 'ARG', 307571),
('Cordoba Province', 'ARG',165321),
('Santa Fe Province', 'ARG', 133007),
('Chuquisaca Province', 'BOL', 51524),
('La Paz Province','BOL', 133985),
('Sao Paulo Province', 'BRA',95834),
('Rio De Janeiro Province', 'BRA', 43696),
('Santiago Metropolitan Province', 'CHL', 2030),
('Cundinamarca Province', 'COL', 22623),
('Guayas Province', 'ECU', 15430),
('Demerara-Mahaica Province' , 'GUY',2232),
('Asuncion Province', 'PRY', 2456),
('Lima Province', 'PER', 2672),
('Paramaribo Province', 'SUR',182),
('Montevideo Province', 'URY', 530),
('Capital Province','VEN', 433),
('Maracaibo Province', 'VEN', 1621);

-- city name, p name, country code, city_pop
INSERT INTO City VALUES 
('Buenos Aires', 'Buenos Aires Province', 'ARG',15057000),
('Cordoba', 'Cordoba Province', 'ARG', 1560000),
('Rosario', 'Santa Fe Province','ARG', 1153000),
('Sucre', 'Chuquisaca Province', 'BOL', 278000),
('La Paz', 'Chuquisaca Province', 'BOL', 1835000),
('Sao Paulo', 'Sao Paulo Province', 'BRA', 21847000),
('Rio De Janeiro', 'Rio De Janeiro Province', 'BRA', 13374000),
('Santiago', 'Santiago Metropolitan Province', 'CHL',6724000),
('Bogota', 'Cundinamarca Province', 'COL', 10779000),
('Guayaquil', 'Guayas Province', 'ECU', 2946000),
('Georgetown','Demerara-Mahaica Province' , 'GUY', 110000),
('Asuncion','Asuncion Province', 'PRY', 3279000),
('Lima', 'Lima Province', 'PER', 10555000),
('Paramaribo', 'Paramaribo Province', 'SUR', 239000),
('Montevideo', 'Montevideo Province', 'URY', 1745000),
('Caracas', 'Capital Province','VEN', 2936000),
('Maracaibo', 'Maracaibo Province', 'VEN', 1885000);

-- country 1 code, country 2 code, length
INSERT INTO Border VALUES 
('ARG', 'BOL', 942.0),
('ARG', 'BRA', 1263.0),
('ARG', 'CHL', 6691.0),
('ARG', 'PRY' , 2531.0),
('ARG', 'URY' , 541.0),
('BOL', 'BRA', 3403.0),
('BOL', 'CHL', 942.0),
('BOL', 'PRY', 753.0),
('BOL', 'PER', 1212.0),
('BRA', 'COL', 1790.0),
('BRA', 'PRY', 1371.0),
('CHL', 'PER', 168.0),
('COL', 'ECU', 708.0),
('COL', 'PER', 1494.0),
('COL', 'VEN', 2341.0),
('ECU', 'PER', 1529.0),
('GUY', 'SUR', 836),
('GUY', 'VEN', 789);
