module Api
  module V1
    # Defines properties CRUD logic
    class PropertiesController < ApplicationController
      resource_description do
        short 'Properties API'
      end

      extend Api::V1::ApipieDocs::PropertiesController

      before_action :set_property, only: %i[show update destroy]

      respond_to :json

      apipie_index
      def index
        @properties = Property.within_polygon(params)

        @total_pages = @properties.total_pages

        respond_with @properties
      end

      apipie_show
      def show
        respond_with @property
      end

      apipie_create
      def create
        @property = Property.create!(property_params)

        respond_with @property
      end

      apipie_update
      def update
        @property.update(property_params)
        head :no_content
      end

      apipie_destroy
      def destroy
        @property.destroy
        head :no_content
      end

      private

      def property_params
        params.require(:property).permit(:title, :price, :description, :x, :y, :beds, :baths, :square_meters)
      end

      def set_property
        @property = Property.find(params[:id])
      end
    end
  end
end
