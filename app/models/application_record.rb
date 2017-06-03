# Defines a parent class to all record models.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
