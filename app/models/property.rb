# Property model description
class Property < ApplicationRecord
  attr_accessor :x, :y

  validates :x, numericality: { only_integer: true, less_than_or_equal_to: 1400, greater_than_or_equal_to: 0 }
  validates :y, numericality: { only_integer: true, less_than_or_equal_to: 1000, greater_than_or_equal_to: 0 }

  validates :beds, numericality: { only_integer: true, less_than_or_equal_to: 5, greater_than_or_equal_to: 1 }
  validates :baths, numericality: { only_integer: true, less_than_or_equal_to: 4, greater_than_or_equal_to: 1 }
  validates :square_meters, numericality: { only_integer: true, less_than_or_equal_to: 240, greater_than_or_equal_to: 20 }

  validates :title, :description, :price, :x, :y, :beds, :baths, :square_meters, presence: true

  after_save  :search_provinces
  before_save :set_lonlat!

  has_and_belongs_to_many :provinces, -> { distinct }

  def self.find_by_polygon(params = {})
    query = <<-SQL
      SELECT id, title, price, description, beds, baths, square_meters, lonlat
      FROM (
          SELECT ST_GeometryFromText('POLYGON ((:ax :ay, :bx :ay, :bx :by, :ax :by, :ax :ay))') AS polygon
      ) AS query1, (
          SELECT id, title, price, description, beds, baths, square_meters, lonlat
          FROM properties
      ) AS query2
      WHERE ST_Contains(query1.polygon, query2.lonlat)
    SQL

    Property.paginate_by_sql([
                               query,
                               ax: params[:ax].to_i,
                               ay: params[:ay].to_i,
                               bx: params[:bx].to_i,
                               by: params[:by].to_i
                             ], page: params[:page], per_page: params[:per_page])
  end

  private

  def set_lonlat!
    self.lonlat = "POINT(#{x} #{y})"
  end

  def search_provinces
    ProvinceJob.perform_later(property_id: id)
  end
end
