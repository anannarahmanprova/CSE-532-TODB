SELECT CURRENT TIMESTAMP as time FROM SYSIBM.SYSDUMMY1;

WITH emergincyzipcode AS (

SELECT f.zipcode, f.GEOLOCATION,f.FACILITYID  FROM CSE532.FACILITY f 
WHERE f. FACILITYID IN ( SELECT f2.FACILITYID  FROM CSE532.FACILITYCERTIFICATION f2  WHERE f2.attributevalue='Emergency Department' ORDER BY FACILITYID)
ORDER BY f.FACILITYID

),
facilityus AS (
SELECT f. zipcode AS zipcode2,f.facilityid, u.ZCTA5CE10 AS zipcode, u.shape FROM CSE532.FACILITY f, CSE532.USZIP u where f.ZIPCODE LIKE CONCAT(u.ZCTA5CE10,'%') 


),
emergincyus as(
SELECT * FROM CSE532.USZIP u,emergincyzipcode e WHERE u.ZCTA5CE10 =e.zipcode
) 

, crosszipcode AS (

SELECT   f1.zipcode AS ZIPCODE1, f2.zipcode AS zipcode2  FROM facilityus f1 , emergincyus f2 where db2gse.st_intersects( f1.shape , f2.shape) 


) SELECT DISTINCT(zipcode) FROM facilityus WHERE zipcode NOT IN (SELECT zipcode1 FROM crosszipcode);


SELECT CURRENT TIMESTAMP as time FROM SYSIBM.SYSDUMMY1;
