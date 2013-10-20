class AssetDescriptionIsText < ActiveRecord::Migration
  def up
    change_column :assets, :description, :text
  end

  def down
    change_column :assets, :description, :string
  end
end
