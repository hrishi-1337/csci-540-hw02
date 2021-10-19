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
  map['Food_Code'] = values[0]
  map['Display_Name'] = values[1]
  map['Portion_Default'] = values[2]
  map['Portion_Amount'] = values[3]
  map['Portion_Display_Name'] = values[4]
  map['Factor'] = values[5]
  map['Increment'] = values[6]
  map['Multiplier'] = values[7]
  map['Grains'] = values[8]
  map['Whole_Grains'] = values[9]
  map['Vegetables'] = values[10]
  map['Orange_Vegetables'] = values[11]
  map['Drkgreen_Vegetables'] = values[12]
  map['Starchy_vegetables'] = values[13]
  map['Other_Vegetables'] = values[14]
  map['Fruits'] = values[15]
  map['Milk'] = values[16]
  map['Meats'] = values[17]
  map['Soy'] = values[18]
  map['Drybeans_Peas'] = values[19]
  map['Oils'] = values[20]
  map['Solid_Fats'] = values[21]
  map['Added_Sugars'] = values[22]
  map['Alcohol'] = values[23]
  map['Calories'] = values[24]
  map['Saturated_Fats'] = values[25]
  return map
end

def put_into_hbase(document, food_number)
  table = HTable.new(@hbase.configuration, 'foods')
  table.setAutoFlush(false)
  document.each do |key, value|
    if !value.empty?
      rowkey = document['Display_Name'].to_java_bytes
      ts = food_number
      p = Put.new(rowkey, ts)
      p.add(*jbytes("fact", key, value))
      table.put(p)
      puts food_number.to_s + ":" + key.to_s + ":" + value.to_s
    end
  end
  table.flushCommits()
end

count = 1
seen_before = {}
File.open('/mnt/data/Food_Display_Table.csv').each_line do |row|
  data = parse_row(row.strip!)
  if !seen_before.has_key?(data['Display_Name'])
    count = 1
    seen_before[data['Display_Name']] = true
  end
  put_into_hbase(data, count)
  count += 1
end
exit