require 'application_responder'

# Defines all general controller methods
class ApplicationController < ActionController::API
  include ExceptionHandler

  respond_to :json
end
