json.extract! property, :id, :title, :price, :description,
              :beds, :baths, :square_meters
json.x property.lonlat.x.to_i
json.y property.lonlat.y.to_i
json.provinces property.provinces.map(&:name)
