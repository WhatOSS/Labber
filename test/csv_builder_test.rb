require 'minitest/autorun'
require 'mocha/mini_test'

require 'csv_builder'

class CsvBuilderTest < Minitest::Test
  @@csv_path = File.expand_path(File.join(File.dirname(__FILE__),"/test.csv"))

  def test_new_takes_a_file_path
    csv = CsvBuilder.new(@@csv_path)

    assert_equal csv.instance_variable_get(:@file_path), @@csv_path
  end

  def test_import_html_table_writes_the_rows_to_the_file
    csv = CsvBuilder.new(@@csv_path)

    document = Nokogiri::HTML("
      <table>
        <tr>
          <td>one</td>
          <td>1</td>
        </tr>
        <tr>
          <td>two</td>
          <td>2</td>
        </tr>
      </table>
    ")
    csv.import_html_table(document)

    row_count = 0
    expected_csv = [
      ['one', '1'],
      ['two', '2']
    ]

    begin
      CSV.foreach(@@csv_path) do |row|
        assert_equal row, expected_csv[row_count],
          "Expected row #{row_count} have the correct data"
        row_count += 1
      end

      assert_equal row_count, 2,
        "Expected the outputted CSV to have 2 rows"
    ensure
      File.delete(@@csv_path)
    end

  end
end
