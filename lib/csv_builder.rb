require 'csv'

class CsvBuilder
  def initialize file_path
    @file_path = file_path
  end

  def import_html_table table
    CSV.open(@file_path, "wb") do |csv|

      table.css('tr').each do |table_row|
        row = []

        table_row.css('td').each do |cell|
          row << cell.content
        end

        csv << row
      end
    end
  end
end
