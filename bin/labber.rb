$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")
require 'mht'

file_path = File.expand_path(File.join(File.dirname(__FILE__),"../data/test.mht"))
mht = Mht.load_from_file(file_path)
tables = mht.find_in_html('table')

csv_path = File.expand_path(File.join(File.dirname(__FILE__),"../data/test.csv"))
csv = CsvBuilder.new(csv_path)
csv.add_from_html_table(tables[0])
