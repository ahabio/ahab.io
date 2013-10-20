module IndexHelper
  include HtmlHelper

  METADATA_ASSET_LIST_TEMPLATE = <<EOT
<ul>
  <% asset_versions.each do |version| %>
    <li>
      <a href="<%= h version.url %>">
        <%= h version.asset.name %>
        <%= h version.value %>
      </a>
    </li>
  <% end %>
  <li>See more...</li>
</ul>
EOT

  def total_assets
    Asset.total_with_format
  end

  def metadata_asset_list(asset_versions)
    erb METADATA_ASSET_LIST_TEMPLATE, locals: { asset_versions: asset_versions }
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