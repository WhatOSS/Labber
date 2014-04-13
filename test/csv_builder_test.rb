require 'minitest/autorun'
require 'mocha/mini_test'

require 'csv_builder'

class CsvBuilderTest < Minitest::Test

  def test_new_takes_a_file_path
    csv_path = File.expand_path(File.join(File.dirname(__FILE__),"/test.csv"))
    csv = CsvBuilder.new(csv_path)

    assert_equal csv.instance_variable_get(:@file_path), csv_path
  end
end
