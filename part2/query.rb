include Java

import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.HConstants
import org.apache.hadoop.hbase.client.HBaseAdmin
import org.apache.hadoop.hbase.client.HTable
import org.apache.hadoop.hbase.client.Scan
import org.apache.hadoop.hbase.filter.SingleColumnValueFilter
import org.apache.hadoop.hbase.filter.CompareFilter
import org.apache.hadoop.hbase.util.Bytes
import org.apache.hadoop.hbase.filter.SubstringComparator

config = HBaseConfiguration.create
config.set 'fs.defaultFS', config.get(HConstants::HBASE_DIR)
scan = Scan.new()
filter = SingleColumnValueFilter.new(Bytes.toBytes("identifiers"), Bytes.toBytes("display_name"), CompareFilter::CompareOp.valueOf('EQUAL'), SubstringComparator.new('Chef salad'))
scan.setFilter(filter)
table = HTable.new config, Bytes.toBytes("condiments")
scanner = table.getScanner(scan)    

while (result = scanner.next())
    code = Bytes.toString(result.getRow())
    condiment_1 = Bytes.toString(result.getValue(Bytes.toBytes("condiment"), Bytes.toBytes("cond_1_code")))  
    condiment_2 = Bytes.toString(result.getValue(Bytes.toBytes("condiment"), Bytes.toBytes("cond_2_code")))
    condiment_3 = Bytes.toString(result.getValue(Bytes.toBytes("condiment"), Bytes.toBytes("cond_3_code")))
    condiment_4 = Bytes.toString(result.getValue(Bytes.toBytes("condiment"), Bytes.toBytes("cond_4_code")))  
    condiment_5 = Bytes.toString(result.getValue(Bytes.toBytes("condiment"), Bytes.toBytes("cond_5_code")))
end

scanner.close

get 'foods', code, {COLUMN => 'identifiers:Display_Name'} 
get 'foods', code, {COLUMN => 'macros'} 
if "condiment_1" != "Null"
    get 'foods', condiment_1, {COLUMN => 'identifiers:Display_Name'} 
    get 'foods', condiment_1, {COLUMN => 'macros'} 
end
if "condiment_2" != "Null"
    get 'foods', condiment_2, {COLUMN => 'identifiers:Display_Name'} 
    get 'foods', condiment_2, {COLUMN => 'macros'} 
end
if "condiment_2" != "Null"
    get 'foods', condiment_3, {COLUMN => 'identifiers:Display_Name'} 
    get 'foods', condiment_3, {COLUMN => 'macros'} 
end
if "condiment_2" != "Null"
    get 'foods', condiment_4, {COLUMN => 'identifiers:Display_Name'} 
    get 'foods', condiment_4, {COLUMN => 'macros'}
end
if "condiment_2" != "Null" 
    get 'foods', condiment_5, {COLUMN => 'identifiers:Display_Name'} 
    get 'foods', condiment_5, {COLUMN => 'macros'} 
end

