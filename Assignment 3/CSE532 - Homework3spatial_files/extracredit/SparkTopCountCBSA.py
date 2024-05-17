from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.window import Window
import sys
if len(sys.argv) != 3:
    print("Please give input and output path")
    sys.exit(1)

input_file_path = sys.argv[1]
output_path = sys.argv[2]

spark = SparkSession.builder.appName("TopCountCBSA").getOrCreate()
datafile = spark.read.csv(input_file_path, header=True, inferSchema=True)
top_five_cbsas = datafile.groupBy("cbsa2010").agg(F.count("admyr").alias("countadmissions")) .orderBy(F.desc("countadmissions")).limit(5)
cbsa_ad_yr = datafile.join(top_five_cbsas, "cbsa2010") .groupBy("cbsa2010", "admyr").agg(F.count("admyr").alias("yearly_admissions"))
window_spec = Window.partitionBy("cbsa2010").orderBy("yearly_admissions")
result = cbsa_ad_yr.withColumn("row_num", F.row_number().over(window_spec)) .filter(F.col("row_num") == 1) .select("cbsa2010", "admyr", "yearly_admissions")


result.write.csv(output_path, header=True)


spark.stop()
