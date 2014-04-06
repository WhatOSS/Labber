require 'mocha/mini_test'
require 'minitest/autorun'

class WarcHtmlReader
  attr_reader :warc

  def initialize(warc)
    @warc = warc
  end

  def self.load_from(file_path)
    reader = self.new(File.read(file_path))
  end
end

class WarcHtmlReaderTest < Minitest::Test
  def test_load_from_reads_in_the_given_file_path
    file_path = "data/1cy5.mht"

    warc_content = "
      ------=_FELib_41728.651400463
      Content-Type: text/html;
              charset=\"iso-8859-1\"
      Content-Transfer-Encoding: quoted-printable
      Content-Location: http://localhost/1.html

        =09<html>
        =09</html>
    "

    File.expects(:read).with(file_path).returns(warc_content)
    WarcHtmlReader.expects(:new).with(warc_content)

    warcHtmlReader = WarcHtmlReader.load_from(file_path)
  end
end
