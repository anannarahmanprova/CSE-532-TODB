from pyspark.sql import SparkSession
import sys

def data_process(row):
    cell = row.split(",")
    admyr = int(cell[0])
    age = int(cell[20])
    return (age, admyr), 1

def main(input, output):
    session = SparkSession.builder.master("local[*]").appName("SparkAgeYearCount").getOrCreate()

    data = session.sparkContext.textFile(input)

    resultset = (
        data.filter(lambda row: row.split(",")[20] != "AGE" and row.split(",")[0] != "ADMYR")
        .map(data_process).reduceByKey(lambda a, b: a + b).sortByKey()  
    )


    results = resultset.collect()
    for res in results:print(f"{res[0][0]}\t{res[0][1]}\t{res[1]}")


    resultset.saveAsTextFile(output)

    session.stop()

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("please give the name of input and output")
        sys.exit(1)

    input = sys.argv[1]
    output= sys.argv[2]

    main(input, output)
