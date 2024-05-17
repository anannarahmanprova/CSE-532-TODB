DROP TABLE cse532.facilityoriginal;
DROP TABLE cse532.facility;


CREATE TABLE cse532.facilityoriginal(
FacilityID VARCHAR(16) NOT NULL PRIMARY KEY,
FacilityName VARCHAR(128),
Description VARCHAR(128),
Address1 VARCHAR(64),
Address2 VARCHAR(64),
City VARCHAR(32),
State VARCHAR(16),
ZipCode VARCHAR(16),
CountyCode VARCHAR(16),
County VARCHAR(16),
Latitude DOUBLE,
Longitude DOUBLE
);

CREATE TABLE cse532.facility(
FacilityID VARCHAR(16) NOT NULL PRIMARY KEY,
FacilityName VARCHAR(128),
Description VARCHAR(128),
Address1 VARCHAR(64),
Address2 VARCHAR(64),
City VARCHAR(32),
State VARCHAR(16),
ZipCode VARCHAR(16),
CountyCode VARCHAR(16),
County VARCHAR(16),
Geolocation DB2GSE.ST_POINT
);


!db2se register_spatial_column sample
-tableSchema      cse532
-tableName        facility
-columnName       Geolocation
-srsName          nad83_srs_1
;





