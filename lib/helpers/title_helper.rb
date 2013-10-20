module TitleHelper

  include AssetHelpers

  attr_accessor :page_title

  def head_title
    content = '<title>ahab.io'
    content << ": #{page_title}" if page_title
    content << '</title>'
  end

  def site_title
    if show_header_title?
      link = "<a href='/'>#{img 'moby2x.png'}</a>"
      "<h1 class='grid_2'>#{link}</h1>"
    else
      "<div class='grid_2'>&nbsp;</div>"
    end
  end

  def no_header_title!
    @no_header_title = true
  end

  private

  def show_header_title?
    !@no_header_title
  end

end
