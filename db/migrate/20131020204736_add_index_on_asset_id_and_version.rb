class AddIndexOnAssetIdAndVersion < ActiveRecord::Migration
  def up
    add_index :asset_versions, [ :asset_id, :value ], unique: true
  end

  def down
    remove_index :asset_versions, [ :asset_id, :value ]
  end
end
