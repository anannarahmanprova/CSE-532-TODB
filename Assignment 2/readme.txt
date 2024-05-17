--------------------------------------------------PROBLEM 1-------------------------------------------------------------

To run Problem 1 open terminal from the folder where gen_salary_histogram.sql is located.
connect to database and then run the script from terminal. 

sample database connection command:

	db2 connect to sample user db2inst1 using userdb 
	
	
[database name :sample; user; db2inst1, password: userdb ( change according to your environment)]

Script run command: 

	db2 -td@ -f gen_salary_histogram.sql
	
	
	
	
--------------------------------------------------PROBLEM 2-------------------------------------------------------------

To run Problem 2 open terminal from the folder where SalaryHistogram.java is located.
Compile and run the file.

command for compile:
   	javac SalaryHistogram.java
   
   
command for run:
	java SalaryHistogram sample DB2INST1 userdb 30000 170000 7
	
[database name: sample ; user: DB2INST1; password: userdb; lowerbound: 30000; upperbound: 170000 ; bin:7 ( change accordingly)]
make sure your db url is jdbc:db2://localhost:25000/ or change accordingly 

	
