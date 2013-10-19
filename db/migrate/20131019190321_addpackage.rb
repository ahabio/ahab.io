class Addpackage < ActiveRecord::Migration
  def up
    create_table :package do |t|
      t.string :name
      t.string :versions
    end
  end

  def down
    drop_table :package
  end
end
