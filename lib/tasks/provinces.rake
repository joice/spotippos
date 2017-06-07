namespace :provinces do
  desc 'Create spotippos provinces'
  task create: :environment do
    require 'json'
    file = File.read 'lib/fixtures/provinces.json'
    data = JSON.parse(file)

    data.each do |province_name, province_params|
      upper_left_x = province_params.fetch('boundaries', []).fetch('upperLeft', {}).fetch('x', 0)
      upper_left_y = province_params.fetch('boundaries', []).fetch('upperLeft', {}).fetch('y', 0)
      bottom_right_x = province_params.fetch('boundaries', []).fetch('bottomRight', {}).fetch('x', 0)
      bottom_right_y = province_params.fetch('boundaries', []).fetch('bottomRight', {}).fetch('y', 0)

      province = Province.new
      province.name = province_name
      province.area = "POLYGON((#{upper_left_x} #{upper_left_y}, #{bottom_right_x} #{upper_left_y}, #{bottom_right_x} #{bottom_right_y}, #{upper_left_x} #{bottom_right_y}, #{upper_left_x} #{upper_left_y}))"
      province.save!
    end
  end

  desc "Restart id sequences of provinces tables"
  task :restart_id_seq => :environment do
    provinces_max_id = Property.maximum(:id).to_i + 1
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE provinces_id_seq RESTART #{provinces_max_id}")
  end
end
