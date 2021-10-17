##TODO

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;

import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.util.Bytes;

public class Create{

   public static void main(String[] args) throws IOException {

      Configuration con = HBaseConfiguration.create();
      HBaseAdmin admin = new HBaseAdmin(con);
      HTableDescriptor tableDescriptor = new
      HTableDescriptor(TableName.valueOf("foods"));
      tableDescriptor.addFamily(new HColumnDescriptor("personal"));
      tableDescriptor.addFamily(new HColumnDescriptor("professional"));
      admin.createTable(tableDescriptor);
      System.out.println("Table created ");
   }
}