module IndexHelper
  def total_assets
    Asset.total_with_format
  end

  def popular_assets
    Asset.where(name: %w{jquery 960gs handlebars base64 ember lodash.js zepto}).
      map do |asset|
        v = asset.optimistic_version
        AssetVersion.find_by asset_id: asset.id, value: v
      end.
      compact.
      slice(0, 5)
  end
end