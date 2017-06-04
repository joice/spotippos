# Province model description
class Province < ApplicationRecord
  validates :name, :area, presence: true
end
