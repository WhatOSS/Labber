$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")
require 'warc'

file_path = File.expand_path(File.join(File.dirname(__FILE__),"../data/test.warc"))
warc = Warc.load_from_file(file_path)
tables = warc.find_in_html('table')
puts tables[0].content

