# Creates properties_provinces table: many-to-many relationship
class CreateJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :properties, :provinces do |t|
      t.index %i[property_id province_id]
      t.index %i[province_id property_id]
    end
  end
end
