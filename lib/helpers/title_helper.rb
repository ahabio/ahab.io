module TitleHelper

  attr_accessor :page_title

  def head_title
    content = '<title>ahab.io'
    content << ": #{page_title}" if page_title
    content << '</title>'
  end

end
