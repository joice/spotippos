# Province model description
class Province < ApplicationRecord
  validates :name, :area, presence: true

  has_many :properties_provinces, -> { distinct }
  has_many :properties, through: :properties_provinces
end
