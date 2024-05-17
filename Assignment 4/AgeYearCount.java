package com.firstmapreduceproject.wc;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Partitioner;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class AgeYearCount {

    public static class AgeYearWritable implements WritableComparable<AgeYearWritable> {
        private IntWritable age;
        private IntWritable admyr;

        public AgeYearWritable() {
            this.age = new IntWritable();
            this.admyr = new IntWritable();
        }

        public AgeYearWritable(IntWritable age, IntWritable admyr) {
            this.age = age;
            this.admyr = admyr;
        }

        @Override
        public void write(DataOutput out) throws IOException {
            age.write(out);
            admyr.write(out);
        }

        @Override
        public void readFields(DataInput in) throws IOException {
            age.readFields(in);
            admyr.readFields(in);
        }

        @Override
        public int compareTo(AgeYearWritable other) {
            int comparison = age.compareTo(other.age);
            if (comparison == 0) {
                return admyr.compareTo(other.admyr);
            }
            return comparison;
        }
    }

    public static class AgeYearMapper extends Mapper<Object, Text, AgeYearWritable, IntWritable> {

        private final static IntWritable one = new IntWritable(1);
        private AgeYearWritable ageYear = new AgeYearWritable();

        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
          
            String[] data = value.toString().split(",");
            int age=0, year=0;
            if (!data[20].equals("AGE")) { age = Integer.parseInt(data[20]);} 
            if (!data[0].equals("ADMYR")) {year = Integer.parseInt(data[0]); }
            if (age != 0 && year != 0 ) {
                ageYear = new AgeYearWritable(new IntWritable(age), new IntWritable(year));
                context.write(ageYear, one);
            }
        }
    }

    public static class AgeYearReducer extends Reducer<AgeYearWritable, IntWritable, Text, IntWritable> {

        private IntWritable res = new IntWritable();

        public void reduce(AgeYearWritable key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
            int total = 0;
            for (IntWritable val : values) {
                total += val.get();
            }
            res.set(total);
            context.write(new Text(key.age + "\t" + key.admyr), res);
        }
    }

    public static class AgeYearCountPartitioner extends Partitioner<AgeYearWritable, IntWritable> {

        @Override
        public int getPartition(AgeYearWritable key, IntWritable value, int number) {
        	return Math.abs(key.age.hashCode() % number);
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "age year count");
        job.setJarByClass(AgeYearCount.class);
        job.setMapperClass(AgeYearMapper.class);
        job.setReducerClass(AgeYearReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        job.setMapOutputKeyClass(AgeYearWritable.class);
        job.setMapOutputValueClass(IntWritable.class);
        job.setPartitionerClass(AgeYearCountPartitioner.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        Path output = new Path(args[1]);
        output.getFileSystem(conf).delete(output, true);
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
