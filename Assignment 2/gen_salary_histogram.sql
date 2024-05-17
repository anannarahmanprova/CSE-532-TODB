CREATE TABLE IF NOT EXISTS RESULT_SALARY_HISTOGRAM (
        BINNUM INT,
        FREQUENCY INT,
        BINSTART DECIMAL(9, 2),
        BINEND DECIMAL(9, 2)
   );
@



CREATE OR REPLACE PROCEDURE gen_salary_histogram (IN START_SALARY DOUBLE, IN END_SALARY DOUBLE, IN BIN_NUMBER INT)
	LANGUAGE SQL
  	BEGIN
		DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
		DECLARE BIN_SIZE DOUBLE;
		DECLARE TARGET_BIN INT;
	    	DECLARE POINT_SALARY DOUBLE;
	    	DECLARE POINT int DEFAULT 0;
		DECLARE CURSOR_POINT CURSOR FOR SELECT SALARY FROM EMPLOYEE WHERE SALARY >= START_SALARY AND SALARY< END_SALARY;
	 	SET BIN_SIZE = (END_SALARY - START_SALARY) / BIN_NUMBER;
	   	DELETE FROM RESULT_SALARY_HISTOGRAM;
	   	SET POINT = 0;
		WHILE POINT!= BIN_NUMBER do
			INSERT INTO RESULT_SALARY_HISTOGRAM (BINNUM, FREQUENCY, BINSTART,BINEND) VALUES (POINT+1, 0,START_SALARY+(POINT*BIN_SIZE),START_SALARY+(POINT*BIN_SIZE)+BIN_SIZE);
			SET POINT = POINT +1;
		END WHILE ;
	  
	   

	   	OPEN CURSOR_POINT;
		FETCH CURSOR_POINT INTO POINT_SALARY;
	  	WHILE (SQLSTATE = '00000') DO
	     
		   	SET TARGET_BIN = CEIL((POINT_SALARY- START_SALARY) /BIN_SIZE);
			IF ((POINT_SALARY-START_SALARY) % BIN_SIZE )= 0 THEN
				SET TARGET_BIN = TARGET_BIN+1;
			END IF;

			UPDATE RESULT_SALARY_HISTOGRAM SET FREQUENCY = FREQUENCY+1 WHERE BINNUM = TARGET_BIN;


		FETCH CURSOR_POINT INTO POINT_SALARY;

	   	END WHILE;
		CLOSE CURSOR_POINT;
	  END@



CALL gen_salary_histogram (30000, 170000, 7)
@
SELECT  * FROM  RESULT_SALARY_HISTOGRAM ORDER BY BINNUM 
@

--db2 -td@ -f gen_salary_histogram.sql




