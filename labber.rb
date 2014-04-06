require 'warc'
require 'mocha/mini_test'
require 'minitest/autorun'

class WarcHtmlReader
  attr_reader :warc

  def initialize(warc)
    @warc = warc
  end

  def self.load_from(file_path)
    warc = Warc.open_stream(file_path)
    reader = self.new(warc)
  end
end

class WarcHtmlReaderTest < Minitest::Test
  @@warc_content = "
    ------=_FELib_41728.651400463
    Content-Type: text/html;
            charset=\"iso-8859-1\"
    Content-Transfer-Encoding: quoted-printable
    Content-Location: http://localhost/1.html

      =09<html>
      =09</html>
    ------
  "

  def test_load_from_loads_a_warm_from_the_given_file_path
    file_path = "data/1cy5.warc"
    warc = Warc::Record.new

    Warc.expects(:open_stream).with(file_path).returns(warc)

    warc_html_reader = WarcHtmlReader.load_from(file_path)

    assert_equal warc, warc_html_reader.warc
  end

  def test_find_returns_correct_html_elements_for_a_selection
    WarcHtmlReader.new()
  end
end

file_path = File.expand_path(File.join(File.dirname(__FILE__),"data/test.warc"))
puts "opening #{file_path}"
warc_reader = WarcHtmlReader.load_from(file_path)

puts "The Content:"
puts warc_reader.warc
puts warc_reader.warc.first
