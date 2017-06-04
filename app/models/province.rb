# Province model description
class Province < ApplicationRecord
  validates :name, :area, presence: true

  has_and_belongs_to_many :properties, -> { distinct }
end
