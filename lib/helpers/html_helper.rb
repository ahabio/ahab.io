require 'htmlentities'

module HtmlHelper

  CODER = HTMLEntities.new

  def h(string)
    CODER.encode(string)
  end

end
