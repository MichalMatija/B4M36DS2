import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class MapReduce {

    public static class Mapper extends org.apache.hadoop.mapreduce.Mapper<Object, Text, Text, IntWritable> {

        @Override
        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
            String[] lines = value.toString().split("\n");
            LocalDateTime january = LocalDateTime.parse("2019-01-31T23:59:59");

            for (String line : lines) {
                String[] columns = line.split(";");

                LocalDateTime timestamp = LocalDateTime.parse(columns[3], DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                Integer quantity = Integer.valueOf(columns[4]);
                Integer price = Integer.valueOf(columns[5]);
                int totalPrice = price * quantity;

                String code = columns[1];
                String manufacturer = columns[2];

                if (timestamp.isAfter(january) && totalPrice > 130) {
                    context.write(new Text(manufacturer + ":" + code), new IntWritable(quantity));
                }
            }
        }
    }

    public static class Reducer extends org.apache.hadoop.mapreduce.Reducer<Text, IntWritable, Text, IntWritable> {

        @Override
        public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
            int count = 0;

            for (IntWritable value : values) {
                count += value.get();
            }

            if (count >= 2) {
                context.write(key, new IntWritable(count));
            }
        }
    }

    public static void main(String[] args) throws Exception {

        Configuration conf = new Configuration();

        Job job = Job.getInstance(conf, "Pharmacy");

        job.setJarByClass(MapReduce.class);
        job.setMapperClass(MapReduce.Mapper.class);
        job.setCombinerClass(MapReduce.Reducer.class);
        job.setReducerClass(MapReduce.Reducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }
}