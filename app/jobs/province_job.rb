# This job performs find what province the property belongs
class ProvinceJob < ApplicationJob
  queue_as :provinces

  def perform(args)
    property = Property.find(args[:property_id])

    province_ids = Property.find_by_sql(['SELECT properties.id, array_agg(provinces.id order by provinces.id) as area_list from provinces, properties where st_contains(provinces.area, properties.lonlat) and properties.id = ? group by properties.id order by properties.id', property.id]).collect(&:area_list).flatten

    property.province_ids = province_ids
  end
end
