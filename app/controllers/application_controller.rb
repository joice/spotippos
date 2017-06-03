# Defines all general controller methods
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
