json.total_pages @total_pages

json.properties do |json|
  json.array! @properties, partial: 'api/v1/properties/property', as: :property
end
