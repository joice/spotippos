namespace :properties do
  desc 'Create spotippos properties'
  task create: :environment do
    require 'json'
    file = File.read 'lib/fixtures/properties.json'
    data = JSON.parse(file)

    properties = data['properties'].inject([]) do |all_properties, property_attrs|
      property_attrs['x'] = property_attrs.delete :lat.to_s
      property_attrs['y'] = property_attrs.delete :long.to_s

      all_properties << Property.new(property_attrs.transform_keys { |key| key.to_s.underscore })
    end

    properties.each(&:save)
  end

  desc "Restart id sequences of properties tables"
  task :restart_id_seq => :environment do
    properties_max_id = Property.maximum(:id).to_i + 1
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE properties_id_seq RESTART #{properties_max_id}")
  end
end
