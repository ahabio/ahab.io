class Addpackage < ActiveRecord::Migration
  def up
    create_table :assets do |t|
      t.string :name,       :null => false
      t.string :homepage
      t.string :description
    end
  end

  def down
    drop_table :assets
  end
end
