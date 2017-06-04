namespace :properties do
  desc 'Create spotippos properties'
  task create: :environment do
    require 'open-uri'
    data = JSON.load(open("https://raw.githubusercontent.com/VivaReal/code-challenge/master/properties.json"))

    properties = data["properties"].inject([]) do |_properties, property_attrs|
      property_attrs['x'] = property_attrs.delete :lat.to_s
      property_attrs['y'] = property_attrs.delete :long.to_s

      _properties << Property.new(property_attrs.transform_keys{ |key| key.to_s.underscore })
    end

    properties.each(&:save)
  end
end
