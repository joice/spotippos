# This job performs find what province the property belongs
class ProvinceJob < ApplicationJob
  def perform(args)
    property = Property.find(args[:property_id])

    query = <<-SQL
      SELECT properties.id, array_agg(provinces.id order by provinces.id) AS area_list
      FROM provinces, properties
      WHERE (st_contains(st_boundary(provinces.area), properties.lonlat) OR
             st_contains(provinces.area, properties.lonlat)) AND properties.id = ?
      GROUP BY properties.id
      ORDER BY properties.id
    SQL

    province_ids = Property.find_by_sql([query, property.id]).collect(&:area_list).flatten

    property.province_ids = province_ids
  end
end
