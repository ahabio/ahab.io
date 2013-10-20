class Changeversionstostring < ActiveRecord::Migration
  def up
    change_column :asset_versions, :value, :string
  end

  def down
    change_column :asset_versions, :value, :integer
  end
end
