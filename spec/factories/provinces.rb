FactoryGirl.define do
  upper_left_x = rand(0..1400)
  upper_left_y = rand(1..1000)
  bottom_right_x = rand(0..1400)
  bottom_right_y = rand(1..1000)

  factory :province do
    sequence(:name) { |n| "Province name #{n}" }
    area "POLYGON((#{upper_left_x} #{upper_left_y}, #{bottom_right_x} #{upper_left_y}, #{bottom_right_x} #{bottom_right_y}, #{upper_left_x} #{bottom_right_y}, #{upper_left_x} #{upper_left_y}))"
  end
end
