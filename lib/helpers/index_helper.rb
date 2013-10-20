module IndexHelper
  def total_assets
    Asset.total_with_format
  end
end