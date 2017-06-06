# PropertiesProvince model description
class PropertiesProvince < ApplicationRecord
  belongs_to :province
  belongs_to :property
end
