module AssetHelpers

  def js(name)
    "<script src='#{js_url(name)}' type='text/javascript'></script>"
  end

  def css(name)
    "<link href='#{css_url(name)}' rel='stylesheet' type='text/css'>"
  end

  def img(name)
    "<img src='#{image_url(name)}' />"
  end

  def js_url(name)
    asset_url "#{name}.js"
  end

  def css_url(name)
    asset_url "#{name}.css"
  end

  def asset_url(name)
    "#{asset_url_prefix}#{name}"
  end

  alias_method :image_url, :asset_url

  private

  def asset_url_prefix
    @asset_url_prefix ||= ( ENV['RACK_ENV'] == 'production' ? '//assets.ahab.io/' : '/' )
  end

end
