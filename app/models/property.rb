# Property model description
class Property < ApplicationRecord
  attr_accessor :x, :y

  validates :x, numericality: { only_integer: true, less_than_or_equal_to: 1400, greater_than_or_equal_to: 0 }
  validates :y, numericality: { only_integer: true, less_than_or_equal_to: 1000, greater_than_or_equal_to: 0 }

  validates :beds, numericality: { only_integer: true, less_than_or_equal_to: 5, greater_than_or_equal_to: 1 }
  validates :baths, numericality: { only_integer: true, less_than_or_equal_to: 4, greater_than_or_equal_to: 1 }
  validates :square_meters, numericality: { only_integer: true, less_than_or_equal_to: 240, greater_than_or_equal_to: 20 }

  validates :title, :description, :price, :x, :y, :beds, :baths, :square_meters, presence: true

  before_save :set_lonlat!

  private

  def set_lonlat!
    self.lonlat = "POINT(#{x} #{y})"
  end
end
