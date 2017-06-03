# Creates properties table
class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :title
      t.integer :price
      t.string :description
      t.integer :beds
      t.integer :baths
      t.integer :square_meters
      t.st_point :lonlat

      t.timestamps
    end
  end
end
