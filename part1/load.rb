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
  column_families = ["identifiers", "portions", "contents", "macros"]
  document.each do |key, value|
    if !value.empty?
      rowkey = document['Food_Code'].to_java_bytes
      ts = food_number
      p = Put.new(rowkey, ts)
      if key.eql?("Food_Code") or key.eql?("Display_Name")
        p.add(*jbytes("identifiers", key, value))
      elsif key.eql?("Portion_Default") or key.eql?("Portion_Amount") or key.eql?("Portion_Display_Name") or key.eql?("Factor") or key.eql?("Increment") or key.eql?("Multiplier")
        p.add(*jbytes("portions", key, value))
      elsif key.eql?("Grains") or key.eql?("Whole_Grains") or key.eql?("Vegetables") or key.eql?("Orange_Vegetables") or key.eql?("Drkgreen_Vegetables") or key.eql?("Starchy_vegetables") or key.eql?("Other_Vegetables") or key.eql?("Fruits") or key.eql?("Milk") or key.eql?("Meats") or key.eql?("Soy") or key.eql?("Drybeans_Peas") or key.eql?("Oils")
        p.add(*jbytes("contents", key, value))
      else
        p.add(*jbytes("macros", key, value))
      end
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
  if !seen_before.has_key?(data['Food_Code'])
    count = 1
    seen_before[data['Food_Code']] = true
  end
  put_into_hbase(data, count)
  count += 1
end
exit