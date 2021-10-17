include Java

import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.HColumnDescriptor
import org.apache.hadoop.hbase.HConstants
import org.apache.hadoop.hbase.HTableDescriptor
import org.apache.hadoop.hbase.client.HBaseAdmin
import org.apache.hadoop.hbase.client.HTable
import org.apache.hadoop.io.Text

conf = HBaseConfiguration.new
tablename = "foods"
desc = HTableDescriptor.new(tablename)
desc.addFamily(HColumnDescriptor.new("fact"))
admin = HBaseAdmin.new(conf)
if admin.tableExists(tablename)
   admin.disableTable(tablename)
   admin.deleteTable(tablename)
end
admin.createTable(desc)
