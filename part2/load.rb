include Java
import org.apache.hadoop.hbase.client.HTable
import org.apache.hadoop.hbase.client.Put
import javax.xml.stream.XMLStreamConstants

def jbytes( *args )
  args.map { |arg| arg.to_s.to_java_bytes }
end

def parse_row(row)
  map = {}
  values = row.split(';')
  map['Survey_Food_Code'] = values[0]
  map['display_name'] = values[1]
  map['cond_1_code'] = values[2] ? values[2] : "Null"
  map['cond_1_name'] = values[3] ? values[3] : "Null"
  map['cond_2_code'] = values[4] ? values[4] : "Null"
  map['cond_2_name'] = values[5] ? values[5] : "Null"
  map['cond_3_code'] = values[6] ? values[6] : "Null"
  map['cond_3_name'] = values[7] ? values[7] : "Null"
  map['cond_4_code'] = values[8] ? values[8] : "Null"
  map['cond_4_name'] = values[9] ? values[9] : "Null"
  map['cond_5_code'] = values[10] ? values[10] : "Null"
  map['cond_5_name'] = values[11] ? values[11] : "Null"
  return map
end

def put_into_hbase(document, food_number)
  table = HTable.new(@hbase.configuration, 'condiments')
  table.setAutoFlush(false)
  document.each do |key, value|
    if !value.empty?
      rowkey = document['Survey_Food_Code'].to_java_bytes
      ts = food_number
      p = Put.new(rowkey, ts)      
      if key.eql?("Survey_Food_Code") or key.eql?("display_name")
        p.add(*jbytes("identifier", key, value))
      else
        p.add(*jbytes("condiment", key, value))
      end
      table.put(p)
      puts food_number.to_s + ":" + key.to_s + ":" + value.to_s
    end
  end
  table.flushCommits()
end

count = 1
seen_before = {}
File.open('/mnt/data/Foods_Needing_Condiments_Table.csv').each_line do |row|
  data = parse_row(row.strip!)
  if !seen_before.has_key?(data['Survey_Food_Code'])
    count = 1
    seen_before[data['Survey_Food_Code']] = true
  end
  put_into_hbase(data, count)
  count += 1
end
exit