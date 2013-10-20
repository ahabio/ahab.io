module HtmlHelper

  def h(text)
    Rack::Utils.escape_html(text)
  end

end
