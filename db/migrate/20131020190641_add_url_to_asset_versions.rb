class AddUrlToAssetVersions < ActiveRecord::Migration
  def up
    add_column :asset_versions, :url, :string, null: false
  end

  def down
    remove_column :asset_versions, :url
  end
end
