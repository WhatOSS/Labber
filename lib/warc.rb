require 'nokogiri'

class Warc
  def initialize(raw)
    @raw = raw
  end

  def self.load_from_file(file_path)
    self.new(File.read(file_path))
  end

  def get_html
    last_html_block = @raw.split(/Content-Type: text\/html;/).last
    last_html_block = last_html_block.split(/^$\n/).last
    last_html_block = last_html_block.gsub(/\n^------$/, "")
    last_html_block.gsub("=09", "")
  end

  def find_in_html matcher
    document = Nokogiri::HTML(self.get_html)
    
    return document.css(matcher)
  end
end
