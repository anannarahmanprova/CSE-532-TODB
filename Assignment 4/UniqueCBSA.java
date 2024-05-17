package com.firstmapreduceproject.wc;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class UniqueCBSA {

    public static class CBSAMapper extends Mapper<Object, Text, Text, Text> {

        private Text cbsa = new Text();
        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
        	String[] data = value.toString().split(",");
            String cbsaValue = data[3]; 
            if ( !cbsaValue.equals("CBSA2010")) {
	            cbsa.set(cbsaValue);
	            context.write(cbsa, cbsa);
            }
        }
    }

    public static class CBSAReducer extends Reducer<Text, Text, Text, Text> {

        public void reduce(Text key, Iterable<Text> values,Context context ) throws IOException, InterruptedException {
          context.write(key, new Text());
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration config = new Configuration();
        Job job = Job.getInstance(config, "unique CBSA");
        job.setJarByClass(UniqueCBSA.class);
        job.setMapperClass(CBSAMapper.class);
        job.setCombinerClass(CBSAReducer.class);
        job.setReducerClass(CBSAReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        Path output = new Path(args[1]);
        output.getFileSystem(config).delete(output, true);
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
