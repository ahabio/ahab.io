class Assetversions < ActiveRecord::Migration
  def up
    create_table :asset_versions do |t|
      t.integer :value,    :null => false
      t.belongs_to :asset, :null => false
    end
  end

  def down
    drop_table :asset_versions
  end
end
