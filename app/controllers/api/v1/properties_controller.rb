module Api
  module V1
    # Defines properties CRUD logic
    class PropertiesController < ApplicationController
      before_action :set_property, only: %i[show update destroy]

      respond_to :json

      def index
        params[:q] ||= []

        @search = Property.search(params[:q])

        @properties = @search.result.paginate(page: params[:page])

        @total_pages = @properties.total_pages

        respond_with @properties
      end

      def show
        respond_with @property
      end

      def create
        @property = Property.create!(property_params)

        respond_with @property
      end

      def update
        @property.update(property_params)
        head :no_content
      end

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
