
SELECT CURRENT TIMESTAMP as time FROM SYSIBM.SYSDUMMY1;

SELECT f.FacilityName,f.Address1,f.ADDRESS2,f.City,f.State,f.ZipCode,f.County,db2gse.st_astext(f.GEOLOCATION) as location_wkt,DB2GSE.ST_DISTANCE(f.GEOLOCATION ,DB2GSE.ST_POINT(40.891720, -73.016479, 1), 'STATUTE MILE') AS Distance FROM cse532.facility AS f INNER JOIN cse532.FACILITYCERTIFICATION  AS fc ON fc.FacilityID = f.FacilityID WHERE fc.AttributeValue = 'Intensive Care'AND DB2GSE.ST_within(f.GEOLOCATION , DB2GSE.ST_BUFFER(DB2GSE.ST_POINT(40.891720, -73.016479, 1),0.25))ORDER BY Distance FETCH FIRST 1 ROW ONLY;

SELECT CURRENT TIMESTAMP as time FROM SYSIBM.SYSDUMMY1;