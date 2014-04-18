require 'minitest/autorun'
require 'mocha/mini_test'

require 'mht'

class MhtTest < Minitest::Test
  @@mht_content = "
------=_FELib_41728.651400463
Content-Type: text/html;
        charset=\"iso-8859-1\"
Content-Transfer-Encoding: quoted-printable
Content-Location: http://localhost/1.html

  =09<html>
    <p>Hello world</p>
  =09</html>
------"

  def test_load_from_file_creates_a_new_instance_with_the_file_at_the_given_path
    file_path = "data/1cy5.mht"
    File.expects(:read).with(file_path).returns(@@mht_content)
    Mht.expects(:new).with(@@mht_content)

    Mht.load_from_file(file_path)
  end

  def test_find_in_html_returns_matching_dom_elements_in_html
    mht = Mht.new(@@mht_content)

    result = mht.find_in_html('p')
    assert_equal result.length, 1,
      "Only expected one result"

    assert_equal result[0].content, 'Hello world',
      "Expected the dom element to have the right text"
  end

  def test_find_in_html_returns_only_html_from_mht
    mht = Mht.new(@@mht_content)

    html = mht.get_html

    expected_html = "  <html>
    <p>Hello world</p>
  </html>"

    assert_equal html, expected_html
  end
end
