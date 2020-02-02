
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class InvertedIndex {
    
    public static class MyMapper
         extends Mapper<Object, Text, Text, Text>
    {
        
        @Override
        public void map(
            Object key,
            Text value,
            Context context
        ) throws IOException, InterruptedException {
            
            String fileName = ((FileSplit)context.getInputSplit()).
                getPath().getName();
            
            StringTokenizer i = new StringTokenizer(value.toString());
            while (i.hasMoreTokens()) {
                String word = i.nextToken();
                context.write(
                    new Text(word),
                    new Text(fileName)
                );
            }
            
        }
        
    }
    
    public static class MyReducer
        extends Reducer<Text, Text, Text, Text>
    {
        
        @Override
        public void reduce(
            Text key,
            Iterable<Text> values,
            Context context
        ) throws IOException, InterruptedException {
            
            Map<String, Integer> map = new HashMap<>();
            
            for (Text v : values) {
                String fileName = v.toString();
                Integer count = map.get(fileName);
                if (count == null) {
                    count = 0;
                }
                map.put(fileName, count + 1);
            }
            
            StringBuilder sb = new StringBuilder();
            for (Map.Entry<String, Integer> e : map.entrySet()) {
                sb.append(e.getKey());
                sb.append(":");
                sb.append(e.getValue());
                sb.append(" ");
            }
            
            context.write(
                key,
                new Text(sb.substring(0, sb.length() - 1))
            );
            
        }
        
    }
    
    public static void main(String[] args) throws Exception {
        
        Configuration conf = new Configuration();
        
        Job job = Job.getInstance(conf, "InvertedIndex");
        
        job.setJarByClass(InvertedIndex.class);
        job.setMapperClass(MyMapper.class);
        job.setReducerClass(MyReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        
        System.exit(job.waitForCompletion(true) ? 0 : 1);
        
    }
    
}
