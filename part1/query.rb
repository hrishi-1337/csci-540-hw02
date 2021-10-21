include Java
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.hbase.filter.SingleColumnValueFilter;
import org.apache.hadoop.hbase.filter.BinaryComparator;
import org.apache.hadoop.hbase.filter.CompareFilter;
import org.apache.hadoop.hbase.filter.SubstringComparator;
import org.apache.hadoop.hbase.filter.Filter;


scan 'foods', {STARTROW => '12350000', ENDROW => '27510530', FILTER => SingleColumnValueFilter.new(Bytes.toBytes('identifiers'), Bytes.toBytes('Display_Name'),
    CompareFilter::CompareOp.valueOf('EQUAL'),SubstringComparator.new('Chef salad'))}


