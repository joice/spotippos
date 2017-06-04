# Creates provinces table
class CreateProvinces < ActiveRecord::Migration[5.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.st_polygon :area

      t.timestamps
    end
  end
end
