require 'application_responder'

# Defines all general controller methods
class ApplicationController < ActionController::API

  respond_to :json
end
